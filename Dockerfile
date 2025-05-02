# Use a slim version of Python as the base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the application files
COPY . /app

# Install dependencies (make sure you have a `requirements.txt` file)
RUN pip install -r requirements.txt

# Expose the port the app will run on
EXPOSE 8080

# Command to run the app (adjust for your actual app)
CMD ["python", "app.py"]
