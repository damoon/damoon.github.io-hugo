FROM alpine:3.9.3 AS hugo
RUN apk --no-cache --update add ca-certificates hugo

#FROM python:2.7.16-alpine3.9 AS python
#COPY themes/hugo-theme-pixyll/requirements.txt /site/themes/hugo-theme-pixyll/requirements.txt
#WORKDIR /site
#RUN pip install -r themes/hugo-theme-pixyll/requirements.txt

FROM hugo AS content
COPY . /site
WORKDIR /site
ARG BASE_URL
RUN hugo --baseURL ${BASE_URL}

#FROM python AS searchable
#COPY --from=content /site /site
#WORKDIR /site
#RUN python themes/hugo-theme-pixyll/create_search_index.py

FROM nginx:1.15.12-alpine
#COPY --from=searchable /site/public /usr/share/nginx/html
COPY --from=content /site/public /usr/share/nginx/html
