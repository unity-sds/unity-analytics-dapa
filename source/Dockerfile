FROM python:3.7.7-alpine
#FROM python:3.8.2-alpine
#FROM python:3-alpine

#RUN apk add --no-cache --upgrade bash

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

EXPOSE 8080

ENTRYPOINT ["python3"]

CMD ["-m", "openapi_server"]
#CMD ["/bin/bash"]
#CMD ["/bin/bash", "--login"]
