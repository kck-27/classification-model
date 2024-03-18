FROM continuumio/miniconda3 as build

WORKDIR /app

COPY environment.yml .
RUN conda env create -f environment.yml

SHELL ["conda", "run", "-n", "env", "/bin/bash", "-c"]

COPY . .

RUN pip install flask gunicorn pickle-mixin scikit-learn tensorflow tensorflow-text



FROM continuumio/miniconda3:23.5.2-0-alpine as main

COPY --from=build /app /

EXPOSE 5000

ENTRYPOINT ["conda", "run", "-n", "env", "python", "app.py"]