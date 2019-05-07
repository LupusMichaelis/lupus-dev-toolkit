FROM mickael/alpine-react

LABEL description="Alpine Linux with user and React on NodeJS using TypeScript"

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
