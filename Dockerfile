FROM ubuntu:22.04


RUN apt-get update
RUN apt-get install -y git cmake

WORKDIR /work

RUN git clone  -b Release_1_8_20  https://github.com/doxygen/doxygen.git

RUN mkdir build
RUN mkdir service

WORKDIR /work/build


RUN apt-get install -y build-essential
RUN apt-get install -y python3-dev
RUN apt-get install -y flex bison


RUN cmake -G "Unix Makefiles" ../doxygen
RUN make
RUN make install

RUN doxygen -v

WORKDIR /work/service

RUN useradd dox -u 1000

RUN apt-get install -y graphviz

CMD doxygen

