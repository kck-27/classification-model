FROM python:3.11.8-slim

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

WORKDIR /app
COPY requirements.txt .
RUN pip install flask gunicorn pickle-mixin scikit-learn tensorflow tensorflow-text tensorflow-hub
COPY . .

EXPOSE 5000
CMD ["flask", "run"]
