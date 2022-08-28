FROM node:latest

LABEL "com.github.actions.name"="Frontend Github Actions"
LABEL "com.github.actions.description"="Sync directory to an AWS S3 repository and invalidate cloudfront cache"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="green"

LABEL version="0.1.0"
LABEL repository="https://github.com/ShuklaShubh89/frontendaction"
LABEL homepage="https://info.shubhamshukla-resume.com/"
LABEL maintainer="Shubham Shukla <shubham.cored@gmail.com>"

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]