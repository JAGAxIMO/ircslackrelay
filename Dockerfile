FROM ringo/scientific:6.5
RUN yum install -y wget unzip tar
RUN mkdir -p /usr/local/lib cd /usr/local/lib && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u71-b14/jdk-7u71-linux-x64.rpm && rpm -ivh jdk-7u71-linux-x64.rpm 
RUN cd /usr/local/lib && wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz && tar zxvf sbt-0.13.7.tgz && ln -s sbt/bin/sbt /usr/bin
RUN mkdir -p /app
ADD ./ /app/ircslackrelay
RUN cd /app/ircslackrelay && sbt assembly && cp ircslackrelay.conf /target/scala-2.11/
CMD ["java", "-jar", "-server", "/app/ircslackrelay/target/scala-2.11/ircslackrelay-assembly-1.3.0.jar"]
