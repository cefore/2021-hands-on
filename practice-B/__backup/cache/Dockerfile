FROM cefore/base
LABEL maintainer="hayamizu <hayamizu@nict.go.jp>"
WORKDIR /cefore/cefore
RUN ./configure --enable-cache
RUN make
RUN make install
RUN make clean
RUN ldconfig
RUN echo "CS_MODE=1" > /usr/local/cefore/cefnetd.conf
WORKDIR /cefore/cefpyco
RUN cmake .
RUN make install
ENV USER root
COPY ./entrypoint.bash /cefore
ENTRYPOINT /cefore/entrypoint.bash
