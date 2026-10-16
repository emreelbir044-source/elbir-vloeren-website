FROM node:22-alpine AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# Build React application
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built website into Nginx
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80