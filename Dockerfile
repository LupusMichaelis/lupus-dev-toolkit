FROM alpine
LABEL description="Alpine Linux with Elm"
RUN apk add --no-cache bash npm yarn
RUN adduser --uid 1000 --disabled-password mickael --home /home

USER mickael

RUN echo \
	'export PATH="/home/bin:$PATH"\
	export PS1="\w $ "\
	' > /home/.bashrc

RUN mkdir /home/bin
RUN mkdir /home/workshop
VOLUME ["/home/workshop"]
WORKDIR /home/workshop

CMD ["bash"]
