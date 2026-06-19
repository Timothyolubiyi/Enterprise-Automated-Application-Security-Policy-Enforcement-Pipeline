# ---------------------------------------------
# Base Image (Lightweight & Secure)
# ---------------------------------------------
FROM node:20-alpine AS base

# Create app directory
WORKDIR /app

# ---------------------------------------------
# Install dependencies
# ---------------------------------------------
FROM base AS deps

COPY package*.json ./

RUN npm ci --only=production

# ---------------------------------------------
# Build stage (if using build tools like React/TS)
# ---------------------------------------------
FROM base AS build

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

# ---------------------------------------------
# Production image
# ---------------------------------------------
FROM node:20-alpine AS runner

WORKDIR /app

# Create non-root user (security best practice)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy built application
COPY --from=build /app /app

# Change ownership
RUN chown -R appuser:appgroup /app

USER appuser

# Expose application port
EXPOSE 3000

# Environment variables
ENV NODE_ENV=production

# Start application
CMD ["npm", "start"]