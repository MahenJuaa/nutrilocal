import os
import io
import base64
from dotenv import load_dotenv
from PIL import Image
from fastapi import FastAPI, UploadFile, File, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from pydantic import BaseModel
from passlib.context import CryptContext
from groq import Groq
import db


# Muat variabel dari .env
load_dotenv()

# 1. Inisialisasi Database
db.init_db()

# 2. Inisialisasi Aplikasi
app = FastAPI(title="NutriLocal API")

# 3. Konfigurasi Keamanan
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# 4. Konfigurasi CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# 5. Inisialisasi Klien Groq API
# Menarik kunci dari file .env secara dinamis
GROQ_API_KEY = os.getenv("GROQ_API_KEY")

if not GROQ_API_KEY:
    raise ValueError("GROQ_API_KEY tidak ditemukan di file .env! Pastikan sudah diisi.")

client = Groq(api_key=GROQ_API_KEY)

# --- SKEMA PYDANTIC ---
class FoodResponse(BaseModel):
    id: int
    name: str
    calories: float
    protein: float
    carbs: float
    fat: float

    class Config:
        from_attributes = True

class MealRequest(BaseModel):
    user_email: str
    food_name: str
    calories: int

class AuthRequest(BaseModel):
    email: str
    password: str

# --- DEPENDENCY DATABASE ---
def get_db():
    database = db.SessionLocal()
    try:
        yield database
    finally:
        database.close()


# --- ENDPOINTS ---

@app.get("/api/foods", response_model=list[FoodResponse])
def get_all_foods(database: Session = Depends(get_db)):
    return database.query(db.FoodItem).all()

@app.post("/api/scan-food", response_model=FoodResponse)
async def scan_food(image: UploadFile = File(...), database: Session = Depends(get_db)):
    """
    Endpoint pemindai makanan menggunakan Groq API (Llama 4 Vision).
    """
    try:
        # Konversi gambar ke Base64 agar dapat dikirim melalui jaringan
        image_bytes = await image.read()
        base64_image = base64.b64encode(image_bytes).decode('utf-8')
        
        # Instruksi ketat agar AI hanya merespons dengan nama makanan
        prompt = """
        Kamu adalah sistem pendeteksi makanan Indonesia. 
        Analisis gambar ini dan berikan HANYA SATU nama makanan yang paling dominan.
        Jika memungkinkan, sesuaikan dengan daftar ini: Nasi Goreng, Ayam Geprek, Mie Ayam, Bakso, Soto, Sate.
        DILARANG menggunakan titik, tanda baca, atau kalimat penjelasan. Hanya tulis nama makanannya saja.
        """
        
        # Eksekusi transmisi ke server Groq
        chat_completion = client.chat.completions.create(
            messages=[
                {
                    "role": "user",
                    "content": [
                        {"type": "text", "text": prompt},
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:image/jpeg;base64,{base64_image}",
                            },
                        },
                    ],
                }
            ],
            # --- UBAH STRING MODEL KE VERSI TERBARU ---
            model="meta-llama/llama-4-scout-17b-16e-instruct", 
            temperature=0.2, # Menjaga determinisme agar AI tidak berhalusinasi
        )
        
        # Membersihkan spasi atau karakter tersembunyi dari respons AI
        detected_label = chat_completion.choices[0].message.content.strip()
        
        # Tarik data nutrisi dari Supabase
        food = database.query(db.FoodItem).filter(db.FoodItem.name.ilike(f"%{detected_label}%")).first()
        
        if not food:
            raise HTTPException(
                status_code=404, 
                detail=f"Groq mendeteksi '{detected_label}', tapi data nutrisi belum ada di database Supabase."
            )
            
        return food

    except HTTPException:
        # Loloskan error 404 ke antarmuka Flutter
        raise
    except Exception as e:
        import traceback
        print("\n========= [ LOG ERROR GROQ AI ] =========")
        traceback.print_exc()
        print("======================================\n")
        raise HTTPException(status_code=500, detail=f"Groq Engine Error: {str(e)}")


@app.post("/log-food")
def log_food(meal: MealRequest, database: Session = Depends(get_db)):
    return {"message": "Meal logged successfully", "data": meal}

@app.post("/register")
def register(auth_data: AuthRequest, database: Session = Depends(get_db)):
    # Validasi email ganda
    existing_user = database.query(db.User).filter(db.User.email == auth_data.email).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Email sudah terdaftar. Silakan login.")
    
    # Enkripsi password sebelum disimpan ke PostgreSQL
    hashed_password = pwd_context.hash(auth_data.password)
    
    new_user = db.User(email=auth_data.email, password=hashed_password)
    database.add(new_user)
    database.commit()
    database.refresh(new_user)
    
    return {"status": "success", "message": "Registrasi berhasil", "user": new_user.email}

@app.post("/login")
def login(auth_data: AuthRequest, database: Session = Depends(get_db)):
    user = database.query(db.User).filter(db.User.email == auth_data.email).first()
    
    # Verifikasi hash password
    if not user or not pwd_context.verify(auth_data.password, user.password):
        raise HTTPException(status_code=401, detail="Email atau password salah")
    
    return {"status": "success", "message": "Login berhasil", "user": user.email}