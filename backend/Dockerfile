# ====== 构建阶段 ======
FROM eclipse-temurin:17-jdk-alpine AS builder
WORKDIR /build

# 复制 pom.xml 优先下载依赖（缓存优化）
COPY pom.xml .
RUN apk add --no-cache maven && mvn dependency:go-offline -B

# 复制源码并打包
COPY src ./src
RUN mvn clean package -DskipTests -B

# ====== 运行阶段 ======
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# 复制 jar
COPY --from=builder /build/target/family-menu-backend.jar app.jar

# 时区设置
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

EXPOSE 8080

# JVM 参数
ENV JAVA_OPTS="-Xms256m -Xmx512m -XX:+UseG1GC -XX:+PrintGCDetails"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar --spring.profiles.active=prod"]