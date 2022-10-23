FROM python:latest
LABEL Maintainer="vinoth"
WORKDIR /usr/app/src
COPY hello-world.py ./
CMD [ "python", "./hello-world.py", "vinothsundararajan"]