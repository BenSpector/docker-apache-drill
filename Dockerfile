FROM quay.io/falkonry/openjdk:8-jdk-alpine-zulu

ENV DRILL_VERSION=1.13.0-SNAPSHOT \
  DRILL_MAX_DIRECT_MEMORY=8G \
  DRILL_HEAP=4G \
  DRILL_CLUSTER=falkonry \
  MONGO_URL=mongodb://falkonry-mongo:27017/

RUN mkdir -p /opt/drill && \
	curl -o apache-drill-${DRILL_VERSION}.tar.gz https://storage.googleapis.com/falkonry-3rdparty-resources/drill/apache-drill-${DRILL_VERSION}.tar.gz && \
  tar -zxpf apache-drill-${DRILL_VERSION}.tar.gz -C /opt/drill && \
  rm apache-drill-${DRILL_VERSION}.tar.gz

ADD dfs.config /dfs.config
ADD mongo.config /mongo.config
ADD bootstrap-storage-plugins.json /opt/drill/apache-drill-${DRILL_VERSION}/conf
ADD start.sh /opt/drill/apache-drill-${DRILL_VERSION}/bin
ADD update.sh /opt/drill/apache-drill-${DRILL_VERSION}/bin
ADD logback.xml /opt/drill/apache-drill-${DRILL_VERSION}/conf

ENTRYPOINT /opt/drill/apache-drill-${DRILL_VERSION}/bin/start.sh

EXPOSE 8047 31010