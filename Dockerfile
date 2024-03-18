FROM continuumio/miniconda3

WORKDIR /app

COPY environment.yml .
RUN conda env create -f environment.yml

SHELL ["conda", "run", "-n", "env", "/bin/bash", "-c"]

COPY . .

RUN pip install flask gunicorn pickle-mixin scikit-learn

EXPOSE 5000

ENTRYPOINT ["conda", "run", "-n", "env", "python", "app.py"]