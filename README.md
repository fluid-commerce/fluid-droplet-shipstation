## README

Droplets are integrations between third-party services and Fluid. This is a repository intended to be used as an example for creating Droplets.

Documentation can be found in the [project's GitHub page](https://fluid-commerce.github.io/droplet-template/)

For API authentication details, see [API Authentication](docs/api-authentication.md).

## Production environment

### Google cloud infrastructure

- Google Cloud Run (Web)
- Google Cloud Storage (Terraform)
- Google Cloud SQL (postgreSQL)
- Google Cloud Build (CI/CD)
- Google Cloud Compute Engine (jobs console)
- Artifact Registry (Docker)

web: Google Cloud Run name `fluid-droplet-shipstation`

jobs console: Google Cloud Compute Engine name `fluid-droplet-shipstation-jobs-console`

job migration: Google Cloud Run Job name `fluid-droplet-shipstation-migrations`

### Deploy to google cloud

Run github action to deploy to google cloud `deploy production`
or run the following command to deploy to google cloud  

`gcloud beta builds submit --config cloudbuild-production.yml --region=us-west3 --substitutions=COMMIT_SHA=$(git rev-parse --short HEAD),_TIMESTAMP=$(date +%Y%m%d%H%M%S) --project=fluid-417204 .`

### Add environment variables to google cloud

Add environment variables to google cloud `add-update-env-gcloud.sh` and run the following command to add environment variables to google cloud
`sh add-update-env-gcloud.sh`

## Running a rails console on GCP

Production rails console to pawtree
1 - `gcloud compute ssh --zone "us-west3-b" "fluid-droplet-shipstation-jobs-console" --project "fluid-417204"`
2 - Run `docker exec -it $(docker ps -q | head -n 1) bin/rails c`

If the rails console is not working, try to run the following command ( error container for code )
`docker run -it --rm $(docker images -q | head -n 1) bash`
This will run the rails console in a new docker container and you can run the command `bin/rails c` to run the rails console

## Check migrations

Check logs on Cloud Run Job to migrations `fluid-droplet-shipstation-migrations`

### Technology Stack

![PostgreSQL 17](https://img.shields.io/badge/PostgreSQL-17-336791?logo=postgresql&logoColor=white)
![Ruby](https://img.shields.io/badge/Ruby-3.4.2-CC342D?logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/Rails-8.0.2-CC0000?logo=ruby-on-rails&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-23.8.0-339933?logo=node.js&logoColor=white)
![Yarn](https://img.shields.io/badge/Yarn-4.7.0-2C8EBB?logo=yarn&logoColor=white)
![Font Awesome](https://img.shields.io/badge/Font_Awesome-6.7.2-528DD7?logo=fontawesome&logoColor=white)
![Tailwind CSS 4.0](https://img.shields.io/badge/Tailwind_CSS-4.0-38B2AC?logo=tailwindcss&logoColor=white)
<br>

### Running locally

Just the rails server (port 3000)<br>
`bin/rails server`

Running everything (port 3200)<br>
`bin/dev`

Running it as a docker service (port 3600)<br>
`docker compose up`

### License

MIT License

Copyright (c) 2025 Fluid Commerce

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
