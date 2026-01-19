# 1. Use Python 3.12 to support Django 5.x
FROM python:3.12-slim

# 2. Set environment variables
# Prevents Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE=1
# Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED=1

# 3. Set the working directory
WORKDIR /app

# 4. Install system dependencies (needed for psycopg2 / PostgreSQL)
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 5. Upgrade pip and install Python dependencies
# We copy requirements first to leverage Docker's layer caching
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy the rest of your project code
COPY . /app/

# 7. Expose the port Django runs on
EXPOSE 8000

# 8. Start the application
# Make sure to replace 'your_project' with the folder name containing wsgi.py
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "mysite.wsgi:application"]
CMD ["python", "-m", "gunicorn", "--bind", "0.0.0.0:8000", "mysite.wsgi:application"]