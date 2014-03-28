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

    OPENPROJECT_ID=$(docker run --link mysql:db alvistar/openproject-docker init_openproject)

Next time you want to start from already built image:

    docker commit --run='{"cmd":["/sbin/my_init"]}' $OPENPROJECT_ID alvistar/openproject

Ready to go!

    docker run -d -p 80:80 --link mysql:db alvistar/openproject