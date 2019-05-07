FROM mickael/alpine-nodejs

LABEL description="Alpine Linux with user and TypeScript on NodeJS"

### Add Node JS packages #######################################################

USER root

RUN npm install -g \
    tslint \
    typescript

ARG USER_ALIAS
ARG UID

USER ${USER_ALIAS}


### Configure workspace ########################################################
USER ${USER_ALIAS}

CMD ["npm", "start"]
