FROM lupusmichaelis/alpine-nodejs:1.0.0

LABEL description="Alpine Linux with user and React on NodeJS"

### Add Node JS packages #######################################################

USER root

COPY setup "${LUPUSMICHAELIS_DIR}/setup-react"

RUN npm install -g \
    create-react-app

CMD ["npm", "start"]
