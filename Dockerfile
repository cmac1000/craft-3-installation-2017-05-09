FROM wyveo/nginx-php-fpm:1.11.10

# non-root user setup
RUN groupadd -r cmacdonald && \
  useradd -r -g cmacdonald cmacdonald && \
  usermod -u 1000 cmacdonald && \
  mkdir -p /home/cmacdonald/experiment && \
  chown --recursive cmacdonald:cmacdonald /home/cmacdonald

# Composer - https://hub.docker.com/r/composer/composer/
ENV COMPOSER_VERSION 1.4.1

RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
  && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
  && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }"

RUN php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && rm -rf /tmp/composer-setup.php

COPY ./composer.json /home/cmacdonald/experiment/composer.json

# weird but necessary - in Dockerfiles, USER doesn't specify file ownership, COPY
# operations always result in root-owned files

RUN chown --recursive cmacdonald:cmacdonald /home/cmacdonald

USER cmacdonald
WORKDIR /home/cmacdonald/experiment
