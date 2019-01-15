FROM debian:buster

LABEL description="Debian Buster GNU/Linux with Elm"

ARG HOME
ARG USER
ARG ANVIL

RUN sed -i 's/main/main non-free contrib/g' /etc/apt/sources.list
# libtinfo5 : elm dependency
RUN apt update && apt install -y bash npm yarn libtinfo5
RUN adduser --uid 1000 --disabled-password ${USER} --home ${HOME}

USER ${USER}

RUN echo \
	'export PATH="${HOME}/bin:$PATH"\
	export PS1="\w $ "\
	' > ${HOME}/.bashrc

RUN mkdir ${HOME}/bin
RUN mkdir ${ANVIL}
VOLUME ["${ANVIL}"]
WORKDIR ${ANVIL}

COPY ./igor ${HOME}/bin/

CMD ["bash"]
