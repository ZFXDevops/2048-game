# 🔧 Base image
FROM nginx:alpine

# 📁 Working directory
WORKDIR /usr/share/nginx/html

# 🛠️ Clone 2048 game into Nginx folder
RUN apk add --no-cache git && \
    rm -rf ./* && \
    git clone --depth=1 https://github.com/gabrielecirulli/2048.git . && \
    rm -rf .git && \
    apk del git

# 🌐 Expose on custom port (optional, Nginx still listens on 80)
EXPOSE 83

# 🚀 Start Nginx
CMD ["nginx", "-g", "daemon off;"]
# Triggering Jenkins rebuild
