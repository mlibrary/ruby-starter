################################################################################
# BASE
################################################################################
FROM ruby:3.3-slim AS base

ARG UID=1000
ARG GID=1000


RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  build-essential \
  libtool


RUN groupadd -g ${GID} -o app
RUN useradd -m -d /app -u ${UID} -g ${GID} -o -s /bin/bash app

ENV GEM_HOME=/gems
ENV PATH="$PATH:/gems/bin"
RUN mkdir -p /gems && chown ${UID}:${GID} /gems


ENV BUNDLE_PATH /app/vendor/bundle

# Change to app and back so that bundler created files in /gmes are owned by the
# app user
USER app
RUN gem install bundler
USER root

WORKDIR /app

CMD ["tail", "-f", "/dev/null"]

################################################################################
# DEVELOPMENT                                           								       # 
################################################################################
FROM base AS development

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  vim-tiny

USER app

################################################################################
# PRODUCTION                                                                   #
################################################################################
FROM base AS production


ENV BUNDLE_WITHOUT=development:test

COPY --chown=${UID}:${GID} . /app

USER app

RUN bundle install

