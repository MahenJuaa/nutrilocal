from sqlalchemy import create_engine, Column, Integer, String, Float
from sqlalchemy.orm import declarative_base, sessionmaker

# Koneksi langsung ke Supabase (Gunakan .env di produksi)
DATABASE_URL = "postgresql://postgres.ubdlbcldkmqxykpivpmd:NutrilocAl123@aws-1-ap-southeast-1.pooler.supabase.com:5432/postgres"

# engine dengan pool_pre_ping=True wajib untuk koneksi cloud (Supabase) 
# agar koneksi yang terputus (idle) direkoneksi otomatis tanpa error.
engine = create_engine(DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Definisi Skema Tabel Database
class FoodItem(Base):
    __tablename__ = "nutrition_db"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True)
    calories = Column(Float)
    protein = Column(Float)
    carbs = Column(Float)
    fat = Column(Float)

def init_db():
    # Perintah ini akan mengecek Supabase, jika tabel 'nutrition_db' belum ada, otomatis dibuat.
    Base.metadata.create_all(bind=engine)
    db = SessionLocal()
    
    # Auto-seeding: Mengisi data awal untuk demo presentasi jika tabel masih kosong
    if db.query(FoodItem).count() == 0:
        dummy_foods = [
            FoodItem(name="Ayam Geprek", calories=550.0, protein=25.0, carbs=35.0, fat=30.0),
            FoodItem(name="Nasi Goreng", calories=400.0, protein=12.0, carbs=50.0, fat=15.0),
            FoodItem(name="Telur Balado", calories=180.0, protein=13.0, carbs=5.0, fat=12.0),
            FoodItem(name="Pecel Madiun", calories=250.0, protein=10.0, carbs=30.0, fat=8.0),
            FoodItem(name="Mie Ayam", calories=450.0, protein=15.0, carbs=60.0, fat=18.0)
        ]
        db.add_all(dummy_foods)
        db.commit()
        print("Data awal (Seeding) berhasil dimasukkan ke Supabase.")
    else:
        print("Database Supabase sudah terisi data.")
        
    db.close()