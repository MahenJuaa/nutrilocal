import os
import shutil
from fastapi import FastAPI, UploadFile, File, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from pydantic import BaseModel
import db

# Inisialisasi Database
db.init_db()

app = FastAPI(title="NutriLocal API")

# Konfigurasi CORS agar bisa diakses oleh aplikasi mobile/web
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Skema Pydantic
class FoodResponse(BaseModel):
    id: int
    name: str
    calories: float
    protein: float
    carbs: float
    fat: float

    class Config:
        from_attributes = True  # Menggantikan orm_mode di Pydantic v2

class MealRequest(BaseModel):
    user_email: str
    food_name: str
    calories: int

def get_db():
    database = db.SessionLocal()
    try:
        yield database
    finally:
        database.close()

@app.get("/api/foods", response_model=list[FoodResponse])
def get_all_foods(database: Session = Depends(get_db)):
    return database.query(db.FoodItem).all()

@app.post("/api/scan-food", response_model=FoodResponse)
async def scan_food(image: UploadFile = File(...), database: Session = Depends(get_db)):
    """
    Endpoint pemindai makanan dengan penanganan file yang aman.
    """
    # Pastikan direktori temp ada (penting untuk cloud)
    temp_filename = f"temp_{image.filename}"
    try:
        with open(temp_filename, "wb") as buffer:
            shutil.copyfileobj(image.file, buffer)
        
        # LOGIKA AI (Integrasi model akan dilakukan di sini)
        detected_label = "Ayam Geprek" 
        
        food = database.query(db.FoodItem).filter(db.FoodItem.name.ilike(f"%{detected_label}%")).first()
        
        if not food:
            raise HTTPException(status_code=404, detail="Makanan tidak ditemukan di database.")
            
        return food
    finally:
        # Hapus file setelah diproses agar tidak memenuhi storage server
        if os.path.exists(temp_filename):
            os.remove(temp_filename)

@app.post("/log-food")
def log_food(meal: MealRequest, database: Session = Depends(get_db)):
    return {"message": "Meal logged successfully", "data": meal}