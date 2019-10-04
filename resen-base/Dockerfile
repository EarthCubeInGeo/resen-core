FROM ubuntu:18.04

LABEL maintainer="Ingeo Team <ingeo-team@ingeo.datatransport.org>"
LABEL description="The base docker image from which resen-core images are built."

#--------------------------------------------------
# First, make sure we have some of the things that
# jupyter/scipy-notebook has in it
#--------------------------------------------------
# stuff from jupyter/base-notebook

ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"

USER root

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    run-one && \
    rm -rf /var/lib/apt/lists/*

# install tini
ARG TINI_VERSION="v0.18.0"
RUN cd /usr/local/bin && \
    wget https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini && \
    chmod +x /usr/local/bin/tini && \
    rm /root/.wget-hsts

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Add a script that we will use to correct permissions after running certain commands
ADD resources/fix-permissions /usr/local/bin/fix-permissions
RUN chmod +x /usr/local/bin/fix-permissions

# Enable prompt color in the skeleton .bashrc before creating the default NB_USER
RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc

# Create NB_USER wtih name jovyan user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    chmod g+w /etc/passwd && \
    fix-permissions $HOME

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]

# Set up system environment variables
COPY resources/02-resen.sh /etc/profile.d/

# Add scripts for starting servers
COPY resources/start.sh /usr/local/bin/
COPY resources/start-notebook.sh /usr/local/bin/
COPY resources/start-singleuser.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh && \
    chmod +x /usr/local/bin/start-notebook.sh && \
    chmod +x /usr/local/bin/start-singleuser.sh


#stuff from jupyter/scipy-notebook
RUN apt-get update && apt-get install -yq --no-install-recommends \
    build-essential \
    emacs \
    git \
    jed \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    netcat \
    pandoc \
    python-dev \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-xetex \
    tzdata \
    unzip \
    nano && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER
WORKDIR /home/$NB_USER