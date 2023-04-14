#   * RVM_VERSION (default is 'stable')
#
#   * RVM_USER (default is 'rvm')
#
FROM ubuntu:18.04

# RMV user to create
# Optional: child images can change to this user, or add 'rvm' group to other user
ARG RVM_USER=rvm
ENV RVM_USER=${RVM_USER}

USER root
RUN apt-get update \
 && apt-get install -y \
      autoconf \
      automake \
      bison \
      curl \
      g++ \
      gawk \
      imagemagick \
      libbz2-dev \
      libcurl4-openssl-dev \
      libevent-dev \
      libffi-dev \
      libgdbm-dev \
      libglib2.0-dev \
      libgmp-dev \
      libjpeg-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      libmysqlclient-dev \
      libncurses-dev \
      libncurses5-dev \
      libpq-dev \
      libreadline-dev \
      libsqlite3-dev \
      libssl-dev \
      libxml2-dev \
      libxslt-dev \
      libyaml-dev \
      make \
      patch \
      sqlite3 \
      zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/rvm --create-home --shell /bin/bash --user-group rvm
RUN chown rvm:rvm /home/rvm

USER rvm

# Install RVM
RUN set -ex && \
  for key in \
     409B6B1796C275462A1703113804BB82D39DC0E3 \
     7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
  ; do \
      gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "$key" || \
      gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
      gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
  done

RUN curl -sSL https://get.rvm.io | bash -s -- --autolibs=read-fail stable \
 && echo 'bundler' >> /home/rvm/.rvm/gemsets/global.gems \
 && echo 'rvm_silence_path_mismatch_check_flag=1' >> ~/.rvmrc

SHELL ["/bin/bash", "-lc"]
CMD ["/bin/bash", "-l"]

# Install Rubies
RUN rvm install 2.6.6
RUN rvm cleanup all

# preinstall a bunch of gems
COPY install-all-gems.txt /tmp/install-all-gems.txt
RUN rvm use 2.6.6 \
   && source /tmp/install-all-gems.txt

CMD ["/bin/bash", "-l"]
