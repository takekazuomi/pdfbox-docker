# syntax=docker/dockerfile:1

ARG VARIANT="2.0.25"

FROM openjdk:17-bullseye as builder
ARG VARIANT

# Create a custom Java runtime
RUN $JAVA_HOME/bin/jlink \
         --add-modules java.base,java.datatransfer,java.desktop,java.logging,java.naming,java.prefs,java.sql,java.xml \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

# download pdfbox

WORKDIR /app
RUN \
    curl -L https://dlcdn.apache.org/pdfbox/${VARIANT}/pdfbox-app-${VARIANT}.jar --output /app/pdfbox-app.jar


FROM debian:bullseye-slim

ARG USERNAME=pdfbox
ARG UID=1000
ARG GID=$UID

RUN groupadd --gid $GID $USERNAME \
    && useradd --uid $UID --gid $GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

#USER $USERNAME

ENV JAVA_HOME=/opt/java/openjdk
ENV USER_NAME=${USERNAME}
ENV USER_UID=${UID}
ENV USER_GID=${GID}

COPY --from=builder /javaruntime $JAVA_HOME
COPY --from=builder /app/pdfbox-app.jar /app/
COPY ./*.sh /app/

RUN chmod +x /app/*sh

WORKDIR /ws

ENTRYPOINT [ "/app/entrypoint.sh", "/app/pdfbox-app.sh" ]

