FROM continuumio/miniconda3

WORKDIR /app

COPY environment.yml .
RUN conda env create -f environment.yml

COPY app.py .

ENTRYPOINT ["conda", "run", "-n", "env", "python", "app.py"]