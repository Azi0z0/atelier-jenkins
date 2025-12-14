FROM alpine:latest
RUN apk add --no-cache openjdk11
CMD ["java", "-version"]

