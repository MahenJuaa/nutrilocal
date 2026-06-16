import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, Column, Integer, String, Float
from sqlalchemy.orm import declarative_base, sessionmaker

# 1. Muat Environment Variables dari file .env
load_dotenv()

# 2. Ambil URL Utuh langsung dari .env
DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    raise ValueError("DATABASE_URL tidak ditemukan di file .env! Pastikan penulisan variabel benar.")

# 3. Buat Engine & Session
# Parameter pool_pre_ping=True krusial untuk mencegah koneksi terputus tiba-tiba di Supabase
engine = create_engine(DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# --- SKEMA TABEL DATABASE ---

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True)
    password = Column(String)

class FoodItem(Base):
    __tablename__ = "foods"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    calories = Column(Float)
    protein = Column(Float)
    carbs = Column(Float)
    fat = Column(Float)

# Fungsi untuk mengeksekusi pembuatan tabel di Supabase
def init_db():
    try:
        # Test koneksi sekaligus membuat tabel jika belum ada
        Base.metadata.create_all(bind=engine)
        print("[DATABASE] Koneksi ke Supabase Berhasil!")
    except Exception as e:
        print(f"[DATABASE ERROR] Gagal terhubung: {e}")