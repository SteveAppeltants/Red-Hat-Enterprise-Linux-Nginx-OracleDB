# Use the Red Hat UBI 8 base image
# FROM registry.access.redhat.com/ubi8/ubi
FROM redhat/ubi8:latest

# Install NGINX from the EPEL repository (Extra Packages for Enterprise Linux)
RUN dnf install -y nginx 

# Updating Subscription Management repositories (unnecassery in container-mode)
# RUN dnf clean all

# Copy your NGINX configuration files (if any)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start NGINX when the container starts
CMD ["nginx", "-g", "daemon off;"]