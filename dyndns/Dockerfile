FROM python:alpine3.19
WORKDIR /app

COPY ./app/libs.txt /app/libs.txt
COPY ./app/main.py /app/main.py

RUN pip install --no-cache-dir --upgrade -r /app/libs.txt
CMD ["fastapi", "run", "main.py", "--port", "80"]
