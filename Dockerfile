FROM python:3.9-slim-buster

RUN apt-get update && apt-get -y install libpq-dev gcc

ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
COPY . /code/

CMD ["python",  "manage.py",  "runserver",  "0.0.0.0:8000"]
