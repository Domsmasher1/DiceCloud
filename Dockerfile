FROM ubuntu:latest

RUN apt-get update --quiet \
    && apt-get install --quiet --yes \
    libarchive-tools \
    curl \
    git

RUN ln --symbolic --force $(which bsdtar) $(which tar)
WORKDIR /app
COPY . .

RUN curl https://install.meteor.com/?release=1.8.0.2 | sh
ENV PATH="/app/.meteor:$PATH"
COPY dev.sh ./dev.sh

#EXPOSE 8080

ENTRYPOINT ["./dev.sh"]
