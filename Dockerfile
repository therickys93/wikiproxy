FROM alpine
RUN apk update && apk upgrade
RUN apk add nginx && mkdir -p /usr/share/nginx/html
ADD nginx.conf /etc/nginx/nginx.conf
EXPOSE 80 443
RUN rm /etc/nginx/conf.d/* && ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
COPY proxy.conf /etc/nginx/conf.d/
COPY 50x.html /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]