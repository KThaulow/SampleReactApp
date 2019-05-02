# Build stage
FROM node:alpine as builder

WORKDIR /app

COPY ./package.json ./
RUN npm install

COPY ./ ./

RUN ["npm", "run", "build"]


# Run stage
FROM nginx:alpine
#Listen on port 80 at runtime (production e.g. AWS Elastic Beanstalk)
EXPOSE 80
# Copy from builder stage "/app/build" into "/usr/share/nginx/html"
COPY --from=builder /app/build /usr/share/nginx/html