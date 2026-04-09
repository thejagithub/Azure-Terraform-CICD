#cloud-config
runcmd:
  - apt-get update -y
  - apt-get install -y docker.io
  - systemctl start docker
  - systemctl enable docker
  - |
    for i in 1 2 3 4 5; do
      docker login ${acr_login_server} -u ${acr_username} -p ${acr_password} && break
      echo "ACR login attempt $i failed, retrying in 10s..."
      sleep 10
    done
  - |
    if docker pull ${acr_login_server}/${image_name}:latest; then
      docker run -d --restart always -p 80:80 --name ${container_name} ${acr_login_server}/${image_name}:latest
    else
      echo "Image not available yet, container will be deployed via Jenkins pipeline"
    fi