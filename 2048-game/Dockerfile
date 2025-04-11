# Use Nginx as the base image
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Install Git, clone 2048, clean up
RUN apk add --no-cache git && \
    rm -rf ./* && \
    git clone --depth=1 https://github.com/gabrielecirulli/2048.git . && \
    rm -rf .git && \
    apk del git

# Expose port
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
