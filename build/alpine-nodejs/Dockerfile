FROM lupusmichaelis/alpine

LABEL description="Alpine Linux with user and NodeJS"

### Add Node JS packages #######################################################

USER root

RUN apk update \
    && apk add --no-cache \
        nodejs \
        npm

ARG USER_ALIAS
ARG UID

USER ${USER_ALIAS}

RUN npm config set package-lock false

ENV PATH "/home/anvil/node_modules/.bin:$PATH"

### Configure workspace ########################################################
USER ${USER_ALIAS}

CMD ["npm", "start"]
