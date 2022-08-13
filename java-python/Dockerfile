FROM ubuntu:22.04

# gcc installation
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install gcc procps tree htop curl wget nano mono-mcs zip unzip
RUN apt-get update && \
    apt-get -y install build-essential \
    libncursesw5-dev libssl-dev libgdbm-dev \
    libc6-dev libsqlite3-dev libbz2-dev libffi-dev zlib1g \
    libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

# nodejs installation
RUN apt-get update
RUN apt-get install xz-utils
RUN curl https://nodejs.org/dist/v16.6.2/node-v16.6.2-linux-x64.tar.xz -O
RUN tar -xf node-v16.6.2-linux-x64.tar.xz
RUN ln -s /node-v16.6.2-linux-x64/bin/node /usr/local/bin/node
RUN ln -s /node-v16.6.2-linux-x64/bin/npm /usr/local/bin/npm
RUN ln -s /node-v16.6.2-linux-x64/bin/npx /usr/local/bin/npx

# nginx installation
RUN apt-get update && \
    apt-get -y install nginx

# PHP installation
RUN apt install -y software-properties-common
RUN apt-get install -y libzip-dev libonig-dev php-cli libc6-dev php-mbstring php-zip php-mbstring php-iconv php-fileinfo

RUN mkdir /logs
RUN mkdir /downloads

# Install Anaconda3
RUN wget -O /downloads/Anaconda3-2022.05-Linux-x86_64.sh https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh
RUN /bin/bash /downloads/Anaconda3-2022.05-Linux-x86_64.sh -b
RUN rm /downloads/Anaconda3-2022.05-Linux-x86_64.sh
ENV PATH /root/anaconda3/bin:$PATH
RUN conda config --set auto_activate_base True

# Install supervisor
RUN pip install supervisor

# Install JDK
RUN apt install -y default-jdk

# Install File Manager
RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
COPY resources/start-filebrowser.sh /apps/fm/start.sh

# Add supervisor start script
COPY resources/start-supervisor.sh /apps/start-supervisor.sh
COPY resources/supervisord.conf /apps/supervisord.conf

WORKDIR /
CMD [ "/bin/bash", "/apps/start-supervisor.sh" ]