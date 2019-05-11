FROM mickael/alpine-react

LABEL description="Alpine Linux with user and React on NodeJS using TypeScript"

### Add Node JS packages #######################################################

USER root

RUN npm install -g \
    ts-loader \
    eslint \
    eslint-config-prettier \
    eslint-plugin-react \
    @typescript-eslint/parser \
    @typescript-eslint/eslint-plugin \
    typescript

ARG USER_ALIAS
ARG UID

### Configure workspace ########################################################
USER ${USER_ALIAS}

CMD ["npm", "start"]
