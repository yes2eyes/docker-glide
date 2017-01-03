FROM golang:1.7

ENV TZ Asia/Shanghai

# install glide
ENV GLIDE_VERSION 0.12.3

ENV GLIDE_DOWNLOAD_URL https://github.com/Masterminds/glide/releases/download/v${GLIDE_VERSION}/glide-v${GLIDE_VERSION}-linux-amd64.tar.gz

RUN wget "$GLIDE_DOWNLOAD_URL" -O glide.tar.gz \
    && tar -xzf glide.tar.gz \
    && mv linux-amd64/glide /usr/bin/ \
    && rm -r linux-amd64 \
    && rm glide.tar.gz

# workdir

RUN mkdir -p /go/src/app
WORKDIR /go/src/app

# this will ideally be built by the ONBUILD below ;)
CMD ["go", "test"]

ONBUILD COPY . /go/src/app
ONBUILD RUN glide install
