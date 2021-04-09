FROM lupusmichaelis/alpine-nodejs:1.0.1

LABEL description="Alpine Linux with user and TypeScript on NodeJS"

### Add Node JS packages #######################################################

USER root

RUN npm install -g \
    tslint \
    typescript

ARG LP_DEV_USER_ALIAS
ARG LP_DEV_UID

### Configure workspace ########################################################
USER ${LP_DEV_USER_ALIAS}

CMD ["npm", "start"]
