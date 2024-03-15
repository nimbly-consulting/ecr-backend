# Use an official Python runtime based on Alpine Linux as the base image
FROM python:3.10-slim-buster
# Set the working directory inside the container
WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY spenny_backend/requirements.txt .
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y libxml2-dev libxslt-dev python-dev default-libmysqlclient-dev gcc

# Upgrade pip first
RUN pip install --upgrade pip

# Install packages from requirements.txt
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . .
WORKDIR /app/spenny_backend

# Make port 443 available to the world outside this container
EXPOSE 80:80

# Define environment variable
ENV NAME DEV

# Run manage.py when the container launches
CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]