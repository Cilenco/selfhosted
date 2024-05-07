FROM python:3.9
WORKDIR /app

COPY ./libs.txt /code/libs.txt
COPY ./main.py /app/main.py

RUN pip install --no-cache-dir --upgrade -r /app/libs.txt
CMD ["fastapi", "run", "main.py", "--port", "80"]
