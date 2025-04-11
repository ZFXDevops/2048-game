# 🔧 Base image
FROM nginx:alpine

# 📁 Set working directory
WORKDIR /usr/share/nginx/html

# 🛠️ Clone 2048 game and remove default Nginx content
RUN apk add --no-cache git && \
    rm -rf ./* && \
    git clone --depth=1 https://github.com/gabrielecirulli/2048.git . && \
    rm -rf .git && \
    apk del git

# 📄 Custom Nginx config to listen on port 83
RUN echo 'server { \
    listen 83; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html index.htm; \
    } \
}' > /etc/nginx/conf.d/default.conf

# 🌐 Expose custom port (optional, for clarity)
EXPOSE 83

# 🚀 Start Nginx
CMD ["nginx", "-g", "daemon off;"]
