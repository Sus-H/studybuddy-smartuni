# StudyBuddy Self-Hosting Guide

Deploy StudyBuddy on your own server with Docker and Traefik.

## Quick Deployment

1. **Clone the repository:**
```bash
git clone https://github.com/Sus-H/studybuddy-smartuni.git
cd "StudyBuddy Studio (latest version)"
```

2. **Configure environment:**
```bash
cp .env.example .env
# Edit .env if needed (defaults are configured for quorra1.ita.chalmers.se)
```

3. **Deploy:**
```bash
docker compose up --build -d
```

## Access URLs

Once deployed, access the services at:

- **StudyBuddy App**: https://quorra1.ita.chalmers.se
- **Traefik Dashboard**: http://traefik.quorra1.ita.chalmers.se
- **Neo4j Browser**: http://neo4j.quorra1.ita.chalmers.se

## Management Commands

```bash
# View status
docker compose ps

# View logs
docker compose logs -f

# Stop services
docker compose down

# Update app
docker compose up --build -d studybuddy

# Full restart
docker compose down && docker compose up --build -d
```

## What's Included

- **StudyBuddy Streamlit App** - Python 3.10 with all dependencies
- **Neo4j Database** - Graph database with APOC plugins
- **Traefik Reverse Proxy** - Automatic SSL and routing

## Configuration

The `.env` file contains all configuration options:

- `DOMAIN` - Your domain (set to quorra1.ita.chalmers.se)
- `NEO4J_PASSWORD` - Database password (change from default)
- `ACME_EMAIL` - Email for SSL certificates
- API keys for LLM services (optional)

## SSL Certificates

SSL certificates are automatically generated via Let's Encrypt. Make sure:

1. Your domain points to the server
2. Ports 80 and 443 are open
3. The ACME_EMAIL is set in .env

## Data Persistence

Data is persisted in Docker volumes:
- Neo4j database data
- Application uploads and data

## Troubleshooting

**Port conflicts:**
```bash
# Check what's using ports
sudo lsof -i :80
sudo lsof -i :443

# Stop conflicting services
sudo systemctl stop nginx  # if using nginx
sudo systemctl stop apache2  # if using apache
```

**SSL issues:**
- Verify domain DNS points to server
- Check firewall allows ports 80/443
- View Traefik logs: `docker compose logs traefik`

**Database connection issues:**
- Check Neo4j is running: `docker compose ps`
- View Neo4j logs: `docker compose logs neo4j`
- Verify NEO4J_URI in .env matches service name