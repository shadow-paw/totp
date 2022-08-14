FROM python:3.10.6-slim-bullseye
WORKDIR /app

RUN apt-get update && apt-get install -y \
    libzbar0 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY src .

ENTRYPOINT ["python", "main.py"]
