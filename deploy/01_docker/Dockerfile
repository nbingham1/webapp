FROM golang:1.24.0

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY go.mod ./

# Install dependencies
RUN go mod tidy
RUN go mod download
RUN go mod vendor

# Copy the rest of the application code
COPY backend backend

WORKDIR backend
RUN go build

# Expose the port the app runs on
EXPOSE 3333


# Define the command to run the app
CMD ["/app/backend/backend"]
