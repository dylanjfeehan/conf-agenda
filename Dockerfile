
FROM golang:1.22

# Set destination for COPY
WORKDIR /workspace


# Download Go modules
COPY go.mod go.sum /workspace
RUN go mod download


# Copy the source code. Note the slash at the end, as explained in
# https://docs.docker.com/reference/dockerfile/#copy

#COPY api /workspace
#COPY frontend.go /workspace
COPY . /workspace
RUN ls

# Build
RUN GOOS=linux GOARCH=arm64 go build -o app .

# Optional:
# To bind to a TCP port, runtime parameters must be supplied to the docker command.
# But we can document in the Dockerfile what ports
# the application is going to listen on by default.
# https://docs.docker.com/reference/dockerfile/#expose
EXPOSE 8080

# Run
CMD ["./app"]
