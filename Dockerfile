# A Docker container for running SLPDB. Updated images will be uploaded
# to Docker Hub:
# https://cloud.docker.com/u/christroutner/repository/docker/christroutner/slpdb-mainnet_slpdb

## BEGIN BOILERPLATE SETUP

#FROM ubuntu:18.04
# https://github.com/christroutner/docker-base/blob/master/Dockerfile
FROM christroutner/ct-base-ubuntu
MAINTAINER Chris Troutner <chris.troutner@gmail.com>

#Set the working directory to be the home directory
WORKDIR /home/safeuser

#Set the working directory to be the users home directory
WORKDIR /home/safeuser

# END BOILERPLATE SETUP


# Switch to user account.
USER safeuser
# Prep 'sudo' commands.
#RUN echo 'abcd8765' | sudo -S pwd

# Clone the BitDB repository
RUN git clone https://github.com/christroutner/bitdb
WORKDIR /home/safeuser/SLPDB

# Copy the env file
COPY .env .env

# Install dependencies.
RUN npm install

# Call out the persistant volumes
VOLUME /home/safeuser/data
VOLUME /home/safeuser/config

COPY startup-script.sh startup-script.sh
#CMD ["./startup-script.sh"]

# Used for debugging.
COPY dummyapp.js dummyapp.js
CMD ["node", "dummyapp.js"]
