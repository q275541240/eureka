FROM anapsix/alpine-java
#jar文件名
ARG JAR_FILE="eureka.jar"
#运行端口
ARG EXPOSE_PORT="8000"
#工作目录
ARG WORK_PATH="/web/"
#配置文件
ARG ACTIVE_PROFILES="--spring.profiles.active=single"
#启动参数
ARG JAVA_OPTS=""
#创建工作目录
RUN mkdir $WORK_PATH
#cp jar文件
COPY target/$JAR_FILE $WORK_PATH
#定义环境变量
ENV JAVA_OPTS=${JAVA_OPTS}
ENV JAR_FILE=${JAR_FILE}
ENV ACTIVE_PROFILES=${ACTIVE_PROFILES}
#暴露端口
EXPOSE $EXPOSE_PORT
#容器启动后进入的目录
WORKDIR $WORK_PATH
#容器启动后执行的命令
CMD java $JAVA_OPTS -jar $JAR_FILE $ACTIVE_PROFILES