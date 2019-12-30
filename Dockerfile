FROM python:3.6
MAINTAINER Joao Vitor R Baptista

ENV PYTHONUNBUFFERED 1

RUN mkdir /jenkins-django-pipeline
WORKDIR /jenkins-django-pipeline
COPY . /jenkins-django-pipeline/

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

EXPOSE 8000

