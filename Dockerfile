FROM node:20-alpine AS web
WORKDIR /app
COPY client/package*.json ./client/
RUN cd client && npm ci
COPY client ./client
RUN cd client && npm run build

FROM node:20-alpine AS deps
WORKDIR /app
COPY server/package*.json ./server/
RUN cd server && npm ci

FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production PORT=8080
COPY --from=deps /app/server /app/server
COPY --from=web /app/client/dist /app/client/dist
RUN cd server && npm ci --omit=dev
EXPOSE 8080
CMD ["node","server/index.js"]