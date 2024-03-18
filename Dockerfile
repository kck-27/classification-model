FROM python:3.11.8-slim as build

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

FROM python:3.11.8-slim as main

COPY --from=build /app /

EXPOSE 5000
CMD ["python", "app.py"]
