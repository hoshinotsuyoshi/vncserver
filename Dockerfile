FROM dockerfile/chrome
RUN apt-get update

# Install imagemagick
RUN apt-get -y install gnome-screenshot xclip imagemagick

# Install basic dev tools
RUN apt-get install -y \
    build-essential \
    wget \
    curl \
    git

# Install package for ruby
RUN apt-get install -y \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt-dev

# Install package for sqlite3
RUN apt-get install -y \
    sqlite3 \
    libsqlite3-dev

# Install package for postgresql
RUN apt-get install -y libpq-dev

# Install ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git ruby-build && ruby-build/install.sh
RUN rm -fr ruby-build

# Install ruby-2.1.2
RUN ruby-build 2.1.2 /usr/local

# Install bundler
RUN gem update --system
RUN gem install bundler --no-rdoc --no-ri

# Add user
RUN useradd --create-home -s /bin/bash ubuntu ;\
    adduser ubuntu sudo ;\
    echo "ubuntu:ubuntu" | chpasswd;

# Adjust locale & localtime
RUN mv /etc/localtime /etc/localtime.org && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ADD .vnc /root/.vnc
ENV USER root
ADD chrome_data_dir /root/chrome_data_dir
