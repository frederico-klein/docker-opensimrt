FROM ubuntu:18.04

RUN apt-get update && apt-get install build-essential freeglut3-dev git libxi-dev libxmu-dev liblapack-dev doxygen cmake wget xz-utils --yes
WORKDIR /opt/dependencies

RUN wget https://sourceforge.net/projects/dependencies/files/opensim-core/opensim-core-4.1-ubuntu-18.04.tar.xz && \
        tar -xvf opensim-core-4.1-ubuntu-18.04.tar.xz 

RUN  wget https://sourceforge.net/projects/dependencies/files/oscpack/oscpack-ubuntu-18.04.tar.xz && \
        tar -xvf oscpack-ubuntu-18.04.tar.xz  

RUN  wget https://sourceforge.net/projects/dependencies/files/vicon/ViconDataStreamSDK_1.7.1_96542h.tar.xz && \
        tar -xvf ViconDataStreamSDK_1.7.1_96542h.tar.xz


#RUN git clone https://github.com/frederico-klein/OpenSimRT.git /opensimrt
ADD OpenSimRT /opensimrt

RUN sed 's@~@/opt@' /opensimrt/.github/workflows/env_variables >> /opensimrt/env.sh

WORKDIR /opensimrt/build

RUN echo ". /opensimrt/env.sh && cmake ../ \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_INSTALL_PREFIX:PATH=../install \
            -DOpenSim_DIR=$OpenSim_DIR \
            -DCONTINUOUS_INTEGRATION=OFF \
            -DBUILD_TESTING=ON \
            -DBUILD_DOCUMENTATION=OFF \
            -DDOXYGEN_USE_MATHJAX=OFF \
            -DBUILD_MOMENT_ARM=ON \
            -DBUILD_IMU=OFF \
            -DBUILD_UIMU=ON \
            -DBUILD_VICON=ON \
            -DCMAKE_PREFIX_PATH=$OpenSim_DIR:$OSCPACK_DIR/lib:$VICONDATASTREAM_DIR && make -j$(nproc)" >> build.sh && \
	bash ./build.sh
	
ENV LD_LIBRARY_PATH=/opt/dependencies/opensim-core/lib/:/opensimrt/build/

RUN echo "git pull && git checkout sometimes_it_works && cd /opensimrt/build && bash build.sh" >> ~/.bash_history

RUN apt update && apt install vim python gdb -y

ADD  connect/ /opensimrt/connect/

EXPOSE 8080/udp
