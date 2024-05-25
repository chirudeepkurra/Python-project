FROM ubuntu

WORKDIR /app

# Copy the requirements file first to leverage Docker caching
COPY requirements.txt /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python3 -m venv /app/venv

# Install Python packages within the virtual environment
RUN /app/venv/bin/pip install --upgrade pip && \
    /app/venv/bin/pip install -r /app

# Copy the rest of the application code
COPY devops /app

# Set the virtual environment PATH
ENV PATH="/app/venv/bin:$PATH"

# Set entrypoint and command
ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]





