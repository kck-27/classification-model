FROM continuumio/miniconda3

WORKDIR /app

COPY environment.yml .
RUN conda env create -f environment.yml

SHELL ["conda", "run", "-n", "env", "/bin/bash", "-c"]

RUN conda init

RUN conda activate env

COPY . .

ENTRYPOINT ["conda", "run", "-n", "env", "python", "app.py"]