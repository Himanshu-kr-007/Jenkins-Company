# Use the official httpd image as the base image
FROM docker.io/library/httpd:latest
# Copy your website files to the image
COPY ./index.html /usr/local/apache2/htdocs/
# COPY ./index.html /usr/local/apache2/htdocs/
# COPY ./Info.html /usr/local/apache2/htdocs/

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start the httpd server when the container runs
CMD ["httpd-foreground"]

# Command to build Docker Image
# docker build -t webserver:v1 .
# docker build -t webserver:v2 .

# Command to Run the Container in Daemonised Mode on port 8080
# docker run -dp 1234:80 webserver:v1
# docker run -dp 1234:80 webserver:v2


# Test Cases:
# curl -sleep http://IP:8080/ | grep DevOps
# curl -sleep http://IP:8080/ | grep Jenkins