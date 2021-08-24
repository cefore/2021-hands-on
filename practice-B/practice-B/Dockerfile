FROM cefore/base
LABEL maintainer="ooka <a-ooka@nict.go.jp>"
WORKDIR /cefore/cefore
RUN ./configure --enable-cache --enable-csmgr
RUN make
RUN make install
RUN make clean
RUN ldconfig
RUN echo "CS_MODE=2" > /usr/local/cefore/cefnetd.conf
RUN echo "CACHE_TYPE=memory" > /usr/local/cefore/csmgrd.conf
ENV USER root
COPY ./entrypoint.bash /cefore
ENTRYPOINT /cefore/entrypoint.bash
