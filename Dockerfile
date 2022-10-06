FROM python:latest

RUN apt update && apt install  openssh-server sudo -y

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test 

RUN echo 'test:test' | chpasswd

RUN service ssh start

EXPOSE 22

WORKDIR /app

COPY requirements.txt ./
COPY start_container.sh ./
RUN chmod +x start_container.sh
RUN pip install -r requirements.txt

COPY src/ src/
CMD ["/usr/sbin/sshd","-D"]
# ENTRYPOINT ["python","src/start_server.py"]
#ENTRYPOINT ["./start_container.sh"]
# ENTRYPOINT [ "/bin/bash", "-c","./start_container.sh"]

