# Use official lightweight nginx image
FROM nginx:alpine

# Maintainer label (optional)
LABEL maintainer="you@example.com"

# Remove the default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy your web application files into the container
COPY ./webapp/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Default command to run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
