# Ada Take Home

Below is a description of what I changed as well as my proposed solutions for deploying this in a production environment.

## Running My Solution
Run the following commands from the main directory:
```bash
./python/run.sh
cd tests && ./run_tests_in_docker.sh
```
**Note**: assumes Docker is running locally

## Changelog
### v1.0.Joey
- Migrated SQLite database to PostgreSQL. SQLite `.db` file has been converted into `database.sql`. This decision was made because SQLite lacks alot of regex functions that will make the template substitution and search functions much simpler.
- Wrote `Dockerfile` for Python based REST-API.
- Wrote `docker-compose.yml` file to run the backend as a series of docker containers. Includes a `postgres:11` container which is seeded with above mentioned `.sql` file.
- Passed in configuration values as environment variables (see `config/__init__.py`).
- Setup an ORM (decided to use [Pony](https://docs.ponyorm.org/toc.html)).
- Implemented template substition for `GET /messages` route.
- Implemented multiple-term, case-insensitive searching for `POST /search` route. Search terms are generated by splitting the query request parameter on space character. Searches that match inside of block content either JSON object keys, or where the value matches the value for a `type` key, will not be returned.

## Running in production
Below are the steps I would take before I would run this application in production:
- add unit tests for the `Message` and `Answer` models
- write a "request parameter validation" layer. This would be useful for the `POST /search` route to validate the request parameters. This layer could then be reused for any routes that expect request parameters.
- write a request deserialization/response serialization layer. This would be useful for transforming JSON to/from ORM instances
- write methods to handle pagination for search results requests/responses
- modify `Message.serialize` method to only make one SQL query in total instead of one query per template in the message body
- write [Terraform](https://www.terraform.io/) to define the cloud infrastructure resources needed to deploy in production (see notes [below](###infrastructure))
- write [Helm](https://helm.sh/) charts to deploy our API to our GKE managed k8s cluster. I would deploy a [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) to handle automatic scaling of our service.
- configure [New Relic](https://newrelic.com/) (or similar monitoring service) to monitor traffic/health of the API service
- configure alert notifications to alert dev team should a certain traffic/error threshold be surpassed. Also configure these alerts in GCP on our CloudSQL instance(s).
- develop a CI/CD pipeline (ex. Github Actions, GCP Cloud Build, CircleCI, etc). Commit (ex. PR merges) to `dev` branch would deploy a staging/development environment. Commits to `master` would deploy to production

### Infrastructure
This assumes we are using GCP:
- Private VPC
- CloudSQL Postgres database w/ no-external IP address assigned (can only be access via internal IP)
- GKE cluster configured w/ [node auto-scaling](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-autoscaler) (deployed inside same internal-network as CloudSQL database such that it can access the database's internal IP address)
