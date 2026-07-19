# Architecture Overview

## System Design

```
Frontend (Next.js)
    ↓
API Gateway (Express)
    ↓
Core Services (Auth, Jobs, Applications, AI)
    ↓
Background Jobs (Bull Queue)
    ↓
Database (PostgreSQL) + Cache (Redis)
    ↓
External Services (OpenAI, Gmail, Indeed, LinkedIn)
```

## Service Layers

### Frontend
- Next.js 14 with React 18
- TailwindCSS + Framer Motion
- Redux state management
- PWA support

### Backend
- Express.js REST API
- Authentication (JWT + OAuth2)
- Job aggregation
- AI integration

### Database
- PostgreSQL for persistent storage
- Redis for caching and queues

### Background Jobs
- Bull queue for async tasks
- Job collection (every 30-60 minutes)
- Email synchronization
- Notification delivery

## Data Flow

1. User searches jobs → Query cached results or DB
2. User applies → Generate tailored resume/cover letter
3. Auto-apply enabled → Queue background job
4. Email integration → Detect recruiter responses
5. Status updates → Dashboard reflects changes
