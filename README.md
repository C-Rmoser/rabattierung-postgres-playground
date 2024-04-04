# Postgres playground #

1. Start the postgres docker container by running ``` docker compose up -d ``` in the docker directory.
2. Set up the database by running ``` make clean && make ``` in the base directory.
3. Run ``` psql -h localhost -p 5438 -U postgres -d rabattierung ``` to connect to the database inside the docker container.
4. Database credentials can be found in the docker-compose.yml file.
