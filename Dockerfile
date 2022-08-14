FROM python:3.10.6-slim-bullseye
WORKDIR /app

RUN apt-get update && apt-get install -y \
    libzbar0 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip --root-user-action=ignore

# Run as non-root
WORKDIR /app
RUN groupadd -r -g 1000 app \
    && useradd -r -u 1000 -g 1000 -m -d /home/app -s /bin/sh app \
    && mkdir -p /app && chown -R app:app /app
USER app:app
ENV HOME=/home/app
ENV PATH=${PATH}:/home/app/.local/bin

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY src .

ENTRYPOINT ["python", "main.py"]
