import db
from sqlalchemy.orm import Session

# Inisialisasi koneksi ke Supabase
db.init_db()
session = db.SessionLocal()

# Dataset Makanan Indonesia
foods_data = [
    {"name": "Nasi Goreng", "calories": 330, "protein": 12.0, "carbs": 45.0, "fat": 11.0},
    {"name": "Ayam Geprek", "calories": 260, "protein": 18.0, "carbs": 15.0, "fat": 14.0},
    {"name": "Mie Ayam", "calories": 400, "protein": 14.0, "carbs": 60.0, "fat": 12.0},
    {"name": "Bakso", "calories": 280, "protein": 15.0, "carbs": 25.0, "fat": 13.0},
    {"name": "Soto Ayam", "calories": 210, "protein": 15.0, "carbs": 22.0, "fat": 7.0},
    {"name": "Sate Ayam", "calories": 250, "protein": 20.0, "carbs": 15.0, "fat": 12.0},
    {"name": "Rendang", "calories": 320, "protein": 22.0, "carbs": 10.0, "fat": 21.0},
    {"name": "Gado-Gado", "calories": 350, "protein": 16.0, "carbs": 42.0, "fat": 15.0},
    {"name": "Nasi Uduk", "calories": 260, "protein": 4.0, "carbs": 41.0, "fat": 9.0},
    {"name": "Nasi Padang", "calories": 550, "protein": 25.0, "carbs": 65.0, "fat": 22.0},
    {"name": "Ayam Penyet", "calories": 280, "protein": 20.0, "carbs": 10.0, "fat": 17.0},
    {"name": "Pecel Lele", "calories": 240, "protein": 18.0, "carbs": 8.0, "fat": 15.0},
    {"name": "Siomay", "calories": 290, "protein": 12.0, "carbs": 35.0, "fat": 11.0},
    {"name": "Batagor", "calories": 310, "protein": 10.0, "carbs": 32.0, "fat": 16.0},
    {"name": "Pempek", "calories": 200, "protein": 8.0, "carbs": 28.0, "fat": 6.0},
    {"name": "Martabak Telur", "calories": 360, "protein": 12.0, "carbs": 30.0, "fat": 22.0},
    {"name": "Sayur Asem", "calories": 80, "protein": 3.0, "carbs": 15.0, "fat": 1.0},
    {"name": "Sop Buntut", "calories": 290, "protein": 22.0, "carbs": 12.0, "fat": 16.0},
    {"name": "Nasi Kuning", "calories": 300, "protein": 6.0, "carbs": 45.0, "fat": 10.0},
    {"name": "Gorengan Tempe", "calories": 150, "protein": 6.0, "carbs": 12.0, "fat": 9.0}
]

def seed_database():
    print("Memulai proses injeksi data ke Supabase...")
    try:
        added_count = 0
        for data in foods_data:
            existing_food = session.query(db.FoodItem).filter(db.FoodItem.name.ilike(data["name"])).first()
            
            if not existing_food:
                new_food = db.FoodItem(**data)
                session.add(new_food)
                added_count += 1
                print(f"[+] Menambahkan: {data['name']}")
            else:
                print(f"[-] Melewati: {data['name']} (Sudah ada di database)")
        
        session.commit()
        print(f"\nBerhasil! {added_count} data makanan baru telah diinjeksi.")
        
    except Exception as e:
        session.rollback()
        print(f"\n[Error Database]: {str(e)}")
    finally:
        session.close()

if __name__ == "__main__":
    seed_database()