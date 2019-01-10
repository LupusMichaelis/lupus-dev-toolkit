FROM debian:buster
LABEL description="Debian Buster GNU/Linux with Elm"
RUN sed -i 's/main/main non-free contrib/g' /etc/apt/sources.list
# libtinfo5 : elm dependency
RUN apt update && apt install -y bash npm yarn libtinfo5
RUN adduser --uid 1000 --disabled-password mickael --home /home/mickael

USER mickael

RUN echo \
	'export PATH="/home/mickael/bin:$PATH"\
	export PS1="\w $ "\
	' > /home/mickael/.bashrc

RUN mkdir /home/mickael/bin
RUN mkdir /home/mickael/workshop
VOLUME ["/home/mickael/workshop"]
WORKDIR /home/mickael/workshop

CMD ["bash"]
