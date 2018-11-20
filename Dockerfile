# base image: version 8.0 at time of writing
FROM mysql:8.0

# load example data sets
COPY MOCK_DATA.sql /docker-entrypoint-initdb.d

