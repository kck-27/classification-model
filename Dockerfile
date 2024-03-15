FROM python:3.11.8-slim
WORKDIR /model
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000
CMD python /model/app.py
