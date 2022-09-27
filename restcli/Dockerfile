FROM amithkoujalgi/ubuntu-java-python-nginx-php-node:1.0.0

# add a new user
RUN apt-get update && apt-get install -y sudo
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

RUN sudo apt-get update && sudo apt-get install -y locales
RUN sudo locale-gen en_IN.UTF-8
RUN sudo update-locale LC_ALL=en_IN.UTF-8 LANG=en_IN.UTF-8
ENV LC_ALL="en_IN.UTF-8"

RUN sudo apt install -y git python3-pip

# Install brew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/ubuntu/.profile && \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/ubuntu/.bashrc && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
RUN sudo chown -R ubuntu /home/linuxbrew/.linuxbrew/*
ENV PATH $PATH:/home/linuxbrew/.linuxbrew/bin
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

RUN echo "export PATH=$PATH:/root/anaconda3/bin">> /home/ubuntu/.profile
RUN echo "export PATH=$PATH:/root/anaconda3/bin">> /home/ubuntu/.bashrc

RUN brew tap restcli/restcli && \
    brew install restcli

ENV JAVA_OPTS "-Dtrust_all_cert=true;-Djavax.net.ssl.trustStore=/home/ubuntu/truststore;-Djavax.net.debug=all"
ENV _JAVA_OPTIONS $JAVA_OPTS
ENV PATH $PATH:/home/ubuntu/.local/bin
#RUN echo $'sudo mkdir -p /home/ubuntu/api-tests/test-reports \n\
#sudo chmod -R 777 ~/api-tests \n\
#cd /home/ubuntu/api-tests/ \n\
#restcli --insecure --env-dir=/home/ubuntu/api-tests/ --log-level BODY --env $TEST_ENV /home/ubuntu/api-tests/$TEST_SRC_FILE \n\' > /home/ubuntu/docker-entrypoint.sh
#CMD [ "/bin/bash", "/home/ubuntu/docker-entrypoint.sh" ]


RUN wget https://github.com/restcli/restcli/releases/download/v2.0.1/restcli.zip
RUN unzip restcli.zip
ENV line_separators '\n\n\n'
#RUN echo 'sudo mkdir -p /home/ubuntu/api-tests/test-reports \n\
#sudo chmod -R 777 /home/ubuntu/api-tests \n\
#cd /home/ubuntu/api-tests/ \n\
#python -c "import os;filepath = '/home/ubuntu/api-tests/' + os.environ['TEST_SRC_FILE'];f = open(filepath);src = f.read();f.close();src = src + os.environ['line_separators'] if not src.endswith(os.environ['line_separators']) else src;target = open(filepath, 'w');target.write(src);target.close()" \n\
#java -jar /home/ubuntu/restcli.jar --insecure --env-dir=/home/ubuntu/api-tests/ --log-level BODY --env $TEST_ENV /home/ubuntu/api-tests/$TEST_SRC_FILE' > /home/ubuntu/docker-entrypoint.sh
#RUN chmod +x /home/ubuntu/docker-entrypoint.sh
#CMD [ "/bin/bash", "/home/ubuntu/docker-entrypoint.sh" ]

COPY scripts /home/ubuntu/scripts
COPY app /home/ubuntu/app
RUN pip3 install -r /home/ubuntu/app/requirements.txt
CMD [ "/bin/bash", "/home/ubuntu/scripts/entrypoint.sh" ]