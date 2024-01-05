FROM node:21.00.3-slim

ENV USER=cs2-bot

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove
	
# create cs2-bot user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/cs2-bot -r -g ${USER} ${USER}
	
# set up volume and user
USER ${USER}
WORKDIR /home/cs2-bot

COPY package*.json ./
RUN npm install
VOLUME [ "/home/cs2-bot" ]

COPY . .

ENTRYPOINT [ "node", "index.js" ]
