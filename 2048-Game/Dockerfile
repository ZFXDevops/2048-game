# Use Nginx as the base image
FROM nginx:alpine

# Set working directory to Nginx HTML folder
WORKDIR /usr/share/nginx/html

# Install Git, remove default Nginx files, clone 2048, clean up
RUN apk add --no-cache git && \
    rm -rf ./* && \
    git clone --depth=1 https://github.com/gabrielecirulli/2048.git . && \
    rm -rf .git && \
    apk del git

# Expose port 83
EXPOSE 83

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

