FROM resin/rpi-raspbian:wheezy

COPY raspberrypi.gpg.key /key/
RUN echo 'deb http://archive.raspberrypi.org/debian/ wheezy main' >> /etc/apt/sources.list.d/raspi.list && \
    echo oracle-java8-jdk shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-key add /key/raspberrypi.gpg.key

RUN apt-get update && \
    apt-get -y install oracle-java8-jdk wget unzip ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV GRADLE_VERSION 2.5
RUN mkdir /usr/src/gradle && \
    wget "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" && \
    unzip "gradle-${GRADLE_VERSION}-bin.zip -d /usr/src/" && \
    rm "gradle-${GRADLE_VERSION}-bin.zip" && \
    ln -s "/usr/src/gradle-${GRADLE_VERSION}/bin/gradle" "/usr/bin/gradle"

COPY . /usr/src/app

CMD /usr/src/app/run.sh
