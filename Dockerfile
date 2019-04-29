# Build stage
FROM node:alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

RUN ["npm", "run", "build"]


# Run stage
FROM nginx:alpine
# Copy from builder stage /app/build 
COPY --from=builder /app/build /usr/share/nginx/html