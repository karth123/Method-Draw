# Use an official Node.js runtime as the base image
FROM node:18-bullseye

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application source code to the container
COPY . ./

# Build the application using gulp
RUN npx gulp build

# Switch to the `src` directory for hosting
WORKDIR /app/src

# Install Python3 and HTTP server module
RUN apt-get update && apt-get install -y python3 python3-pip && rm -rf /var/lib/apt/lists/*

# Expose port 8000 for the HTTP server
EXPOSE 8000

# Run the Python HTTP server
CMD ["python3", "-m", "http.server", "8000"]
