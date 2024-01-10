# # Use Node 16 alpine as parent image
# FROM node:16-alpine

# # Change the working directory on the Docker image to /app
# WORKDIR /app

# # Copy package.json and package-lock.json to the /app directory
# COPY package.json package-lock.json ./

# # Install dependencies
# RUN npm install --force

# # Copy the rest of project files into this image
# COPY . .

# # Expose application port
# EXPOSE 3000

# # Start the application
# CMD npm start
# Use Node 16 alpine as parent image
FROM node:16-alpine

# Change the working directory on the Docker image to /app
WORKDIR /app

# Copy package.json and package-lock.json to the /app directory
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --force

# Copy the rest of the project files into the Docker image
COPY . .

# Non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Build the application for production
RUN npm run build

# Expose the port the app runs on
EXPOSE 3009

# Install serve to serve the build folder
RUN npm install -g serve

# Start the application with serve
CMD ["serve", "-s", "build", "-l", "3000"]
