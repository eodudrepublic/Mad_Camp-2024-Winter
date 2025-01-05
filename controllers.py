from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from schemas import AppUserRequest
from models import AppUser


router = APIRouter()

@router.get("/hello")
def hello():
    return {"message" : "Hello World!"}
    
@router.post("/user")
def manage_user(user: AppUserRequest, db: Session = Depends(get_db)):
    existing_user = db.query(AppUser).filter(AppUser.user_id == user.user_id).first()
    if existing_user:
        return {
            "message": "User exists",
            "user": {
                "id": existing_user.id,
                "user_id": existing_user.user_id,
                "nickname": existing_user.nickname,
                "profile_image_url": existing_user.profile_image_url,
            },
        }
    else:
        new_user = AppUser(
            user_id = user.user_id,
            nickname = user.nickname,
            profile_image_url = user.profile_image_url,
        )
        db.add(new_user)
        db.commit()
        db.refresh(new_user)
        return {
            "message": "User added",
            "user": {
                "id": new_user.id,
                "user_id": new_user.user_id,
                "nickname": new_user.nickname,
                "profile_image_url": new_user.profile_image_url,
            },
        }