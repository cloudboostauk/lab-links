FROM ubuntu:18.04
LABEL maintainer="my-name"
LABEL remarks="This is a dockerfile"
RUN apt-get update && apt-get install apache2 -y && apt-get clean
EXPOSE 8080
CMD ["apache2ctl", "-DFOREGROUND"]