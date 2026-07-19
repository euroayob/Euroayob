# Setup Guide

## Prerequisites

- Node.js 18+
- PostgreSQL 14+
- Redis 6+
- Docker (recommended)

## Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/euroayob/Euroayob.git
cd Euroayob
```

### 2. Using Docker (Recommended)
```bash
cp .env.example .env
docker-compose up
```

Access:
- Frontend: http://localhost:3000
- Backend: http://localhost:5000

### 3. Local Setup

#### Backend
```bash
cd backend
npm install
cp .env.example .env
npm run dev
```

#### Frontend
```bash
cd frontend
npm install
cp .env.example .env.local
npm run dev
```

## Verify Installation

```bash
curl http://localhost:5000/health
```

Should return: `{"status":"ok", ...}`
