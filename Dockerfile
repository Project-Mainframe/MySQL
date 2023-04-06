FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y mysql-server && \
    rm -rf /var/lib/apt/lists/*

# Set the ownership of the MySQL data directory to the mysql user and group
RUN chown -R mysql:mysql /var/lib/mysql

COPY my.cnf /etc/mysql/my.cnf

ARG DB
ARG DB_USER
ARG DB_PASSWORD

RUN /etc/init.d/mysql start && \
    mysql -u root -e "CREATE DATABASE $DB; CREATE USER '$DB_USER' IDENTIFIED BY '$DB_PASSWORD'; GRANT ALL PRIVILEGES ON $DB.* TO '$DB_USER';" && \
    /etc/init.d/mysql stop

EXPOSE 3306

# Switch to the mysql user
USER mysql

CMD ["mysqld"]
