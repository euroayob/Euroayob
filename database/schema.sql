CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255),
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  profile_photo_url TEXT,
  nationality VARCHAR(100),
  preferred_countries TEXT[] DEFAULT '{}',
  preferred_industries TEXT[] DEFAULT '{}',
  visa_sponsorship_needed BOOLEAN DEFAULT TRUE,
  languages JSON DEFAULT '{}',
  salary_expectation_min INTEGER,
  salary_expectation_max INTEGER,
  currency VARCHAR(3) DEFAULT 'EUR',
  subscription_tier VARCHAR(50) DEFAULT 'free',
  google_id VARCHAR(255) UNIQUE,
  microsoft_id VARCHAR(255) UNIQUE,
  two_factor_enabled BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

CREATE TABLE companies (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) UNIQUE NOT NULL,
  description TEXT,
  logo_url TEXT,
  website_url TEXT,
  industry VARCHAR(100),
  headquarters_country VARCHAR(100),
  hiring_speed VARCHAR(50),
  visa_sponsorship_likelihood VARCHAR(50),
  glassdoor_rating DECIMAL(3, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE jobs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  title VARCHAR(255),
  description TEXT,
  location VARCHAR(255),
  country VARCHAR(100),
  remote_type VARCHAR(50),
  salary_min INTEGER,
  salary_max INTEGER,
  currency VARCHAR(3) DEFAULT 'EUR',
  visa_sponsorship BOOLEAN DEFAULT FALSE,
  languages_required TEXT[] DEFAULT '{}',
  posted_date TIMESTAMP,
  deadline DATE,
  source_url TEXT UNIQUE,
  source_platform VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE applications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  job_id UUID NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
  status VARCHAR(50) DEFAULT 'saved',
  applied_date TIMESTAMP,
  job_match_score DECIMAL(5, 2),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE resumes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  version_number INTEGER,
  title VARCHAR(255),
  language VARCHAR(50) DEFAULT 'en',
  file_url TEXT,
  ats_score DECIMAL(5, 2),
  is_default BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cover_letters (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  job_id UUID REFERENCES jobs(id) ON DELETE SET NULL,
  title VARCHAR(255),
  language VARCHAR(50) DEFAULT 'en',
  file_url TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE interviews (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  application_id UUID NOT NULL REFERENCES applications(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  scheduled_date TIMESTAMP,
  interview_type VARCHAR(50),
  recruiter_name VARCHAR(255),
  recruiter_email VARCHAR(255),
  meeting_platform VARCHAR(50),
  meeting_url TEXT,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type VARCHAR(50),
  title VARCHAR(255),
  message TEXT,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_jobs_country_visa ON jobs(country, visa_sponsorship);
CREATE INDEX idx_applications_user ON applications(user_id);
CREATE INDEX idx_applications_status ON applications(status);
CREATE INDEX idx_interviews_user ON interviews(user_id);
