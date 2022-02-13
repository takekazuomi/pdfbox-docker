# README

pdfbox docker image

<https://github.com/apache/pdfbox>
<https://www.apache.org/dist/pdfbox/2.0.25/RELEASE-NOTES.txt>
<https://www.apache.org/dyn/closer.lua/pdfbox/2.0.25/pdfbox-app-2.0.25.jar>

```sh
docker run --rm -it -v ${PWD}:/ws -e UID=$(id -u ${USER}) -e GID=$(id -g ${USER}) takekazuomi/pdfbox PDFToImage sample.pdf
```
