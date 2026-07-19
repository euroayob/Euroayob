# Database Schema

## Main Tables

### users
- User profiles and authentication
- Preferences and settings
- Languages and skills

### jobs
- Job listings from multiple sources
- Location, salary, visa sponsorship info
- Company references

### applications
- Application tracking
- Status pipeline (saved → applied → interview → offer)
- Job matching scores

### interviews
- Interview scheduling
- Recruiter information
- Meeting details

### resumes & cover_letters
- Multi-version support
- Multi-language support
- ATS scoring

## Running Migrations

```bash
docker-compose exec backend npm run db:migrate
```
