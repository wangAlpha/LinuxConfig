docker pull ubuntu/mysql;
docker run -d --name mysql-container -e TZ=UTC -p 30306:3306 -e MYSQL_ROOT_PASSWORD=My:S3cr3t/ ubuntu/mysql:8.0-22.04_beta;
