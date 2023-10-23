FROM  ubuntu:22.04

# Instalacion de Dart
RUN apt-get update 
RUN apt-get upgrade
RUN apt-get install -y wget
RUN apt-get install -y gnupg

RUN apt-get install apt-transport-https 
RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub |  gpg --dearmor -o /usr/share/keyrings/dart.gpg 
RUN echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' |  tee /etc/apt/sources.list.d/dart_stable.list 
RUN apt-get update && apt-get install dart

# Instalacion de Posgrest 15
#RUN sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
#RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add -
#RUN apt-get update
#RUN apt-get -y install postgresql-15


COPY ./lib /app/lib
COPY ./bin /app/bin
COPY ./*.yaml /app/

WORKDIR /app
RUN dart pub upgrade

ENV ANGEL_ENV=production
EXPOSE 3000
CMD dart  ./bin/prod.dart -p 3000 -a 0.0.0.0


