FROM mickael/alpine-nodejs

LABEL description="Alpine Linux with user and React on NodeJS"

### Add Node JS packages #######################################################

USER root

RUN npm install -g \
    create-react-app

ARG USER_ALIAS
ARG UID

### Configure workspace ########################################################
USER ${USER_ALIAS}

CMD ["npm", "start"]
