# Horizon Demo Node.js

Dummy Node.js application for validating the Horizon DevOps Pipeline service.

Use this repo with:

- `ProjectType`: `NodeJs`
- `RepositoryType`: `GitHub`
- `Branch`: `main`

Build commands expected by the pipeline:

- `npm install`
- `npm run build`
- Docker image build from `Dockerfile`

The container exposes port `3000` and provides:

- `/`
- `/health`
