FROM       alpine:3.4
MAINTAINER Nick Schuch

ENV FTP_USER=dev

# Install.
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache bash shadow@community openssh openssh-sftp-server && \
    mkdir -p /var/run/sshd

# Regenerate keys.
RUN rm -f /etc/ssh/ssh_host_*key* && \
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '' && \
    ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ''

# Add a developer user.
RUN useradd $FTP_USER && \
    usermod -p "*" $FTP_USER && \
    mkdir -p /home/${FTP_USER}/.ssh && \
    chown -R ${FTP_USER}:${FTP_USER} /home/${FTP_USER}

# Configuration.
COPY sshd_config /etc/ssh/sshd_config

# Data.
RUN mkdir -p /data && \
    chown root:root /data && \
    chmod 755 /data

# Custom on build configuration.
ONBUILD ADD authorized_keys /home/${FTP_USER}/.ssh/authorized_keys
ONBUILD RUN chown -R ${FTP_USER}:${FTP_USER} /home/${FTP_USER} && \
            chmod 400 /home/${FTP_USER}/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]
