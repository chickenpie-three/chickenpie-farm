# --- Build React front-end ---
FROM node:20-alpine AS web
WORKDIR /app
COPY client/package*.json ./client/
RUN cd client && npm ci
COPY client ./client
RUN cd client && npm run build

# --- Install server deps ---
FROM node:20-alpine AS deps
WORKDIR /app
COPY server/package*.json ./server/
RUN cd server && npm ci

# --- Final runtime image ---
FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production PORT=8080
# copy server code + node_modules
COPY --from=deps /app/server /app/server
# copy React build
COPY --from=web /app/client/dist /app/client/dist
# ensure prod deps only (idempotent—safe even if already installed)
RUN cd server && npm ci --omit=dev
EXPOSE 8080
CMD ["node", "server/index.js"]
