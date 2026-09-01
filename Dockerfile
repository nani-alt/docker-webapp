FROM nginx:alpine

RUN echo "Hello from my custom Docker image!" > /usr/share/nginx/html/index.html
