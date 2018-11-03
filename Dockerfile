FROM node:alpine

RUN apk add --no-cache make gcc g++ python git

COPY . /src/qredit-rpc

RUN cd /src/qredit-rpc \
    && npm install -g forever \
    && npm install

WORKDIR /src/qredit-rpc
ENTRYPOINT ["forever","./server.js"]

EXPOSE 8080
