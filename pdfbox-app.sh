#!/bin/bash
set -x

export JAVA_HOME=/opt/java/openjdk
export PATH="${JAVA_HOME}/bin:${PATH}"

java -jar /app/pdfbox-app.jar "$@"

