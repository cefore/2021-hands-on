FROM cefore/base
LABEL maintainer="ooka <a-ooka@nict.go.jp>"
WORKDIR /cefore/cefore
RUN ./configure --enable-cache --enable-csmgr
RUN make
RUN make install
RUN make clean
RUN ldconfig
WORKDIR /cefore/cefpyco
RUN git pull
RUN cmake .
RUN make install
ENV USER root
ENV LC_ALL C.UTF-8
ENV LANG=C.UTF-8
