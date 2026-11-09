# 🏨 OrbitaConnect

A secure, scalable 3-tier AWS cloud architecture for a hotel management API, built with a Defense-in-Depth security model.

**Architecture:** Internet → ALB + AWS WAF → EC2 Auto Scaling (Private Subnet) → RDS PostgreSQL (Private Subnet)

## Tech Stack

- **Cloud:** AWS (EC2, RDS, ALB, VPC, WAF, Secrets Manager, CloudWatch, ACM)
- **Backend:** Python, FastAPI
- **Database:** PostgreSQL (RDS)
- **Frontend:** HTML, CSS, JavaScript

## Security

- Private Subnets (no public IP for app & DB)
- AWS WAF (19 rules: SQLi, XSS, OWASP Top 10)
- AWS Secrets Manager (no hardcoded credentials)
- HTTPS/TLS 1.3 encryption
- Bastion Host + Session Manager access

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /health | Health check |
| GET | /hotels | List hotels |
| POST | /ingest | Create hotel |
| PUT | /hotels/{id} | Update hotel |
| DELETE | /hotels/{id} | Delete hotel |

## Monitoring

- CloudWatch Dashboard (CPU, Requests, DB Connections)
- Automated alarm: CPU > 70%

---
*wickedanabella!*