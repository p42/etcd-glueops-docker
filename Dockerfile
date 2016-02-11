FROM project42/ruby-alpine:latest
MAINTAINER Jordan Clark jordan.clark@esu10.org

RUN apk add --no-cache ruby-json && \
cd /usr/local && \
wget https://github.com/thejordanclark/etcd-glueops/archive/master.zip && \
unzip master.zip && \
mv etcd-glueops-master etcd-glueops && \
rm master.zip && \
cd etcd-glueops && \
bundle install

ENV COMMAND 'ruby -v'

