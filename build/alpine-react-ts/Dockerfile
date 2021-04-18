FROM lupusmichaelis/alpine-react:1.0.4

LABEL description="Alpine Linux with user and React on NodeJS using TypeScript"

### Add Node JS packages #######################################################

USER root

RUN npm install -g \
    eslint \
    eslint-config-prettier \
    eslint-plugin-react \
    ts-loader \
    typescript \
    @typescript-eslint/eslint-plugin \
    @typescript-eslint/parser \
    @types/react \
    @types/react-dom \
    @types/react-router-dom

COPY setup "${LUPUSMICHAELIS_DIR}/setup-react-ts"

CMD ["npm", "start"]
