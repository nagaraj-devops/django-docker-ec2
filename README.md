# django-docker-ec2
Deploy a Django App with Docker &amp; DockerHub on a Virtual Machine

## Prerequisites

- Docker installed on your local machine
- Docker Hub account
- AWS EC2 instance (or any virtual machine)
- Git (for cloning the repository)

## Steps

### 1. Clone the Repository

```bash
git clone git@github.com:nagaraj-devops/django-docker-ec2.git
cd django-docker-ec2
```

### 2. Create a Dockerfile for Django

Create a `Dockerfile` in the project root directory:

```dockerfile
Use an official Python runtime as a base image
FROM python:3.9

Set the working directory
WORKDIR /app

Copy the project files
COPY . /app/

Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

Expose the application port
EXPOSE 8000

Start the Django application using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "your_project.wsgi:application"]
```

### 3. Create a `docker-compose.yml` (Optional)
```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
"8000:8000"
    volumes:
.:/app
    environment:
DEBUG=False
    depends_on:
db

  db:
    image: postgres:13
    environment:
      POSTGRES_USER: django
      POSTGRES_PASSWORD: django
      POSTGRES_DB: django_db
```

### 4. Create requirements.txt

Create a `requirements.txt` file with your Django dependencies:

```bash
pip freeze > requirements.txt
```

Or manually add:
```
Django>=3.2
gunicorn>=20.1.0
```

### 5. Build and Test Your Docker Image Locally

Run the following command in your Django project directory:  

```bash
docker build -t django-docker-ec2 .
```

Once the build is complete, test it by running:  

```bash
docker run -p 8000:8000 django-docker-ec2
```

Visit `http://localhost:8000` to verify the app is running.

### 6. Push to Docker Hub

Log in to Docker Hub:
```bash
docker login
```

Push the image:
```bash
docker push sajjannagaraj/django-docker-ec2:latest
```

### 7. Deploy on EC2

SSH into your EC2 instance:
```bash
ssh -i your-key.pem ubuntu@your-instance-ip
```

Install Docker on EC2 (Ubuntu 22):
```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo usermod -a -G docker ubuntu
```

Pull and run the container:
```bash
docker pull sajjannagaraj/django-docker-ec2:latest
docker run -d -p 80:8000 --name django-app sajjannagaraj/django-docker-ec2:latest
```

### 8. Verify Deployment

Visit `http://your-instance-ip` in your browser to access your Django app.

## Additional Notes

- Replace `your-username` with your actual Docker Hub username
- Replace `your-key.pem` and `your-instance-ip` with your actual values
- Use environment variables for sensitive data (database credentials, secret keys, etc.)
- Consider using `docker-compose` for managing multiple containers
- For production, use a reverse proxy like Nginx in front of Gunicorn

## Troubleshooting

- Check logs: `docker logs container-id`
- Access container shell: `docker exec -it container-id /bin/bash`
- Restart container: `docker restart container-id`
