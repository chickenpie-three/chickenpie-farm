# Slingshot Global — Cloud Run Starter

This is a minimal React + Express project wired for Google Cloud Run using a Dockerfile build.

## Local dev (optional)
- Install Node 20+
- In `client/`: `npm ci && npm run build`
- In `server/`: `npm ci && npm start` (after building the client)
- Visit http://localhost:8080

## Deploy from source (Cloud Console)
1. Create a GitHub repo and upload this folder as-is (Dockerfile at root).
2. Cloud Run → Create Service → Deploy from source → Connect GitHub → pick repo/branch.
3. Region: your choice. Allow unauthenticated.
4. (Optional) Variables & Secrets → reference `GEMINI_API_KEY` from Secret Manager.
5. Deploy and test the public URL.

The front-end is served from `/client/dist`, and the API lives under `/api/*`.
