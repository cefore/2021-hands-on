FROM cefore/base
LABEL maintainer="hayamizu <hayamizu@nict.go.jp>"
WORKDIR /cefore/cefore
RUN ./configure
RUN make
RUN make install
RUN make clean
RUN ldconfig
WORKDIR /cefore/cefpyco
RUN cmake .
RUN make install
ENV USER root
COPY ./entrypoint.bash /cefore
ENTRYPOINT /cefore/entrypoint.bash
