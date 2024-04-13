from typing import Annotated


from fastapi import FastAPI
from pydantic import BaseModel


class Item(BaseModel):
    title: str
    description: str | None = None


app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}


@app.post("/items/{item_id}")
async def get_item(item: Item):
    return item

