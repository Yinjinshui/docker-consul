FROM alpine:3.11
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk add  \
    ca-certificates curl dumb-init gnupg libcap openssl su-exec iputils jq libc6-compat unzip \
  && rm -rf /var/cache/apk/*

COPY ./consul_1.4.4_linux_amd64.zip consul_1.4.4_linux_amd64.zip

#通过选择更小的镜像，删除不必要文件清理不必要的安装缓存，从而瘦身镜像
#创建相关目录能够看到日志信息跟数据跟配置文件  sh
RUN mkdir -p /tmp/consul \
    && unzip consul_1.4.4_linux_amd64.zip  \
    && rm -rf consul_1.4.4_linux_amd64.zip

EXPOSE 8300 8301 8302 8500
