FROM debian:buster

LABEL description="Debian Buster GNU/Linux with Elm"

ARG HOME
ARG USER
ARG ANVIL

RUN sed -i 's/main/main non-free contrib/g' /etc/apt/sources.list
# libtinfo5 : elm dependency
# cmdtest provides a command yarn that is not the yarn we know in the NodeJS realm
RUN apt update \
    && apt install -y bash npm libtinfo5 \
    && dpkg -P cmdtest
RUN adduser --uid 1000 --disabled-password ${USER} --home ${HOME}

ENV PATH "${HOME}/bin:$PATH"

USER ${USER}

RUN echo \
	'export PS1="\w $ "'\
	> ${HOME}/.bashrc

RUN mkdir ${HOME}/bin
RUN mkdir ${ANVIL}
VOLUME ["${ANVIL}"]
WORKDIR ${ANVIL}

COPY ./igor ${HOME}/bin/
RUN ["igor", "setup-bin"]

CMD ["igor", "run"]
