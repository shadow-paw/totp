FROM python:3.8.2-slim-buster
WORKDIR /app

RUN apt-get update && apt-get install -y \
    libzbar0 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY src .

ENTRYPOINT ["python", "main.py"]
