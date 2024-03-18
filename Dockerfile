FROM continuumio/miniconda3

WORKDIR /app

COPY environment.yml .
RUN conda env create -f environment.yml

RUN conda init bash

RUN conda activate env

COPY app.py .

ENTRYPOINT ["conda", "run", "-n", "env", "python", "app.py"]