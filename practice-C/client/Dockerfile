FROM cefore/base
LABEL maintainer="hayamizu <hayamizu@nict.go.jp>"
RUN apt install -y ffmpeg ubuntu-desktop
WORKDIR /cefore/cefore
RUN ./configure
RUN make
RUN make install
RUN make clean
RUN ldconfig
ENV USER root
COPY ./entrypoint.bash /cefore
ENTRYPOINT /cefore/entrypoint.bash
