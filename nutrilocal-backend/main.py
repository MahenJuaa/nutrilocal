from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from jose import jwt

from sqlalchemy import text

from db import SessionLocal

app = FastAPI()

app.add_middleware(
    CORSMiddleware,

    allow_origins=["*"],

    allow_credentials=True,

    allow_methods=["*"],

    allow_headers=["*"],
)

SECRET_KEY = "nutrilocal-secret"

foods = [
    {
        "name": "Nasi Goreng",
        "calories": 450,
    },

    {
        "name": "Ayam Geprek",
        "calories": 520,
    },

    {
        "name": "Soto Ayam",
        "calories": 320,
    },
]


@app.get("/")
def home():

    return {
        "message": "NutriLocal API Running"
    }


@app.get("/foods")
def get_foods():

    return foods


@app.get("/meals/{email}")
def get_meals(email: str):

    db = SessionLocal()

    query = text(
        """
        SELECT food_name, calories
        FROM meals
        WHERE user_email = :email
        """
    )

    result = db.execute(

        query,

        {
            "email": email
        },
    ).fetchall()

    meals = []

    for meal in result:

        meals.append({

            "food_name":
                meal.food_name,

            "calories":
                meal.calories,
        })

    return meals


@app.post("/meals")
def add_meal(data: dict):

    db = SessionLocal()

    query = text(
        """
        INSERT INTO meals (
            user_email,
            food_name,
            calories
        )

        VALUES (
            :user_email,
            :food_name,
            :calories
        )
        """
    )

    db.execute(

        query,

        {
            "user_email":
                data["user_email"],

            "food_name":
                data["food_name"],

            "calories":
                data["calories"],
        },
    )

    db.commit()

    return {
        "message": "Meal added"
    }


@app.post("/register")
def register(data: dict):

    db = SessionLocal()

    query = text(
        """
        INSERT INTO users (
            email,
            password
        )

        VALUES (
            :email,
            :password
        )
        """
    )

    db.execute(

        query,

        {
            "email": data["email"],
            "password": data["password"],
        },
    )

    db.commit()

    return {
        "message": "User created"
    }


@app.post("/login")
def login(data: dict):

    db = SessionLocal()

    email = data.get("email")
    password = data.get("password")

    query = text(
        """
        SELECT * FROM users
        WHERE email = :email
        AND password = :password
        """
    )

    result = db.execute(

        query,

        {
            "email": email,
            "password": password,
        },
    ).fetchone()

    if result:

        token = jwt.encode(
            {
                "email": email
            },

            SECRET_KEY,

            algorithm="HS256",
        )

        return {
            "token": token
        }

    raise HTTPException(
        status_code=401,

        detail="Invalid credentials"
    )