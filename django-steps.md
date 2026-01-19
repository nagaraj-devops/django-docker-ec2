# Django Installation and Local Setup

## Step 1: Create a Virtual Environment

```bash
python3 -m venv .venv
```

## Step 2: Activate the Virtual Environment

```bash
source .venv/bin/activate
```

On Windows:
```bash
.venv\Scripts\activate
```

## Step 3: Install Django and Dependencies

```bash
pip install --upgrade pip
pip install Django gunicorn
```

## Step 4: Create requirements.txt

```bash
pip freeze > requirements.txt
```

## Step 5: Create a Django Project (if starting fresh)

```bash
django-admin startproject mysite
```

## Step 6: Create a Django App (if starting fresh)

```bash
python manage.py startapp myapp
```

## Step 7: Apply Migrations

```bash
python manage.py migrate
```

## Step 8: Create a Superuser (Optional)

```bash
python manage.py createsuperuser
```

## Step 9: Run Django Development Server Locally

```bash
python manage.py runserver
```

The server will run on `http://127.0.0.1:8000/`

To access from other machines on your network:
```bash
python manage.py runserver 0.0.0.0:8000
```

## Step 10: Access Django Admin

Visit `http://127.0.0.1:8000/admin/` and login with your superuser credentials.

## Verification

- Open your browser and go to `http://localhost:8000`
- You should see the Django welcome page or your custom application
- Check the terminal for any error messages

## Deactivate Virtual Environment

When done, deactivate the virtual environment:
```bash
deactivate
```

## Common Commands Reference

| Command | Purpose |
|---------|---------|
| `python manage.py runserver` | Run development server |
| `python manage.py migrate` | Apply database migrations |
| `python manage.py makemigrations` | Create migration files for model changes |
| `python manage.py createsuperuser` | Create an admin user |
| `python manage.py shell` | Interactive Django shell |
| `pip freeze > requirements.txt` | Generate dependency list |
