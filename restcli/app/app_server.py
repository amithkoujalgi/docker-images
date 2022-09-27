import asyncio
import os
from typing import Union

import uvicorn
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


if __name__ == "__main__":
    HOST = os.getenv("SERVER_HOST", "0.0.0.0")
    PORT = int(os.getenv("SERVER_PORT", 8000))
    HTTP_GATEWAY_TIMEOUT_SECONDS = int(os.getenv("HTTP_GATEWAY_TIMEOUT_SECONDS", 180))

    config = uvicorn.Config(
        app, host=HOST, port=PORT, timeout_keep_alive=HTTP_GATEWAY_TIMEOUT_SECONDS, server_header=False,
    )
    server_app = uvicorn.Server(config=config)
    asyncio.run(server_app.serve())
