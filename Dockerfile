FROM ubuntu:artful
LABEL maintainer="omerlh@gmail.com"
WORKDIR app
COPY Gemfile Gemfile.lock /app/
RUN apt-get update && apt-get install -y --no-install-recommends bison \
		dpkg-dev \
		libgdbm-dev \
        build-essential \
		ruby \
        ruby-dev \
        ruby-bundler \
        zlib1g \
        zlib1g-dev \ 
        nmap && \
    rm -rf /var/lib/apt/lists/* && \
    bundle install --without development test
COPY . /app

ENTRYPOINT [ "ruby", "./parse.rb" ]