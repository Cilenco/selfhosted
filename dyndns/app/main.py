from fastapi import FastAPI

app = FastAPI()

@app.get("/nic/update")
async def update_nic(ip6prefix: str):
    print(ip6prefix)