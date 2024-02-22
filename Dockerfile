FROM ruby:3.2-slim-bookworm AS development

# These build args are in your `.env` file, and they exist so that for
# development the user in the container has the same UID and GID as you. 
ARG UID=1000
ARG GID=1000

## Install Vim (optional)
#RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
#  vim-tiny

RUN gem install bundler

# Add the app group. Map it's GID to the build arg. -o means it's ok if it's a non-unique GID.
RUN groupadd -g ${GID} -o app

# Add the app user. Map its UID and GID to the build args. Create a /app home
# directory for it. -o means it's ok if it's a non-unique GID. Set the shell to
# bash. 
RUN useradd -m -d /app -u ${UID} -g ${GID} -o -s /bin/bash app

#Make a gems directory and have it owned by the app user and group
RUN mkdir -p /gems && chown ${UID}:${GID} /gems

USER app

ENV BUNDLE_PATH /gems

WORKDIR /app

CMD ["tail", "-f", "/dev/null"]

FROM development AS production

COPY --chown=${UID}:${GID} . /app
RUN bundle  install
