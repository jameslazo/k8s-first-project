# FROM scratch to build yourself
FROM nginx 
LABEL maintainer="James Lazo <james.lazo+git@protonmail.com>"

COPY ./website /website
COPY ./website.conf /etc/nginx/nginx.conf