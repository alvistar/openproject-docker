openproject-docker
==================

Openproject is a project open source collaboration platform -> https://www.openproject.org.

This is an Openproject packaged for Docker.

For the present solution you need an external Mysql Website.
Following are instructions to have another container with Mysql linked to the web application.

The mysql container is orchardup/mysql -> https://index.docker.io/u/orchardup/mysql/

For creating the database use:

    docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=yoursecret -e MYSQL_DATABASE=openproject -e MYSQL_USER=openproject --name mysql orchardup/mysql

After you can initialize the image (populate and seeding database, recompile assets):

    docker run --link mysql:db --name=openproject alvistar/openproject-docker init_openproject

Ready to go!

    docker run -d -t -p 80:80 --volumes-from openproject --link mysql:db alvistar/openproject-docker

If you want to run with insecure key for ssh:

    docker run -d -t -p 80:80 --volumes-from openproject --link mysql:db alvistar/openproject-docker /sbin/my_init --enable-insecure-key

For linking to LDAP server add:

    docker run -d -t -p 80:80 --volumes-from openproject --dns 127.0.0.1 --link mysql:db --link ldap:ldap alvistar/openproject-docker /sbin/my_init --enable-insecure-key