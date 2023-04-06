# MySQL Server

[![Build and Deploy Docker Image](https://github.com/Project-Mainframe/MySQL/actions/workflows/deploy.yml/badge.svg)](https://github.com/Project-Mainframe/MySQL/actions/workflows/deploy.yml)

## Configuration

### Database user
The Docker image currently creates a single user with full access to all databases. The user credentials are kept secure by being specified using GitHub secrets, which is a way to store sensitive data like passwords and access tokens in encrypted format. This ensures that the user credentials are not exposed to unauthorized users and can only be accessed by authorized applications or users. The secret names are `DB_USER` and `DB_PASSWORD`.

Note: It is recommended to create additional users with restricted access to specific databases, instead of relying on a single user with full access. This can help to improve security and prevent accidental data loss or unauthorized access to sensitive information.

### Database entity
Upon initialization, the Docker image creates a database with a name that is specified by a GitHub Secret named `DB`. This enables you to specify a custom database name without exposing it in plaintext.

### Persistent data
The MySQL server is designed to use an external volume to store database data, which ensures that the data remains persistent even when the container is deleted or recreated. 

To view the list of Docker volumes that have been created, you can use the docker volume ls command. 
```
$ docker volume ls
```
To inspect the details of a specific volume, you can use the docker volume inspect <name> command, replacing <name> with the name of the volume you want to inspect. This allows you to view detailed information about the volume, such as its mount point, driver, and configuration options. 
```
$ docker volume inspect mysql
```

### MySQL configuration file
The Docker image is built using an external MySQL configuration file called [my.cnf](https://github.com/Project-Mainframe/MySQL/blob/main/my.cnf). This allows for custom configuration of various MySQL properties, such as the bind-address option which specifies the IP address that MySQL listens on for incoming connections.

Currently, the bind-address option in the provided my.cnf configuration file is set to 0.0.0.0. This means that MySQL will accept connections from any IP address, regardless of the source. While this configuration allows for maximum flexibility, it can also present a security risk as it exposes the MySQL server to potential attacks from unauthorized sources.

To enhance security, it is recommended to modify the bind-address option to a specific IP address or range of IP addresses that are allowed to connect to the MySQL server. This can be done by editing the my.cnf file and specifying the desired IP address or range in the bind-address option.

By using an external MySQL configuration file, you can easily modify and manage your MySQL server's settings without having to modify the Docker image itself. This provides greater flexibility and customization options for your MySQL deployment.
