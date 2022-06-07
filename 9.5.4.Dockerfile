ARG BROWSER="node14.17.6-chrome100-ff98"
FROM cypress/browsers:$BROWSER

# avoid too many progress messages
# https://github.com/cypress-io/cypress/issues/1243
ENV CI=1

WORKDIR /usr/app

RUN echo "whoami: $(whoami)"
RUN npm config -g set user $(whoami)
RUN npm install cypress@9.5.4
RUN npm install typescript \
    @cypress/browserify-preprocessor@3.0.2 \
    @ngneat/falso@1.3.1 \
    @testing-library/cypress@7.0.4 \
    @types/cypress-cucumber-preprocessor@4.0.0 \
    @types/testing-library__cypress@5.0.8 \
    cypress-cucumber-preprocessor@4.0.3 \
    cypress-file-upload@5.0.2 \
    cypress-xpath@1.6.2 \
    nanoid@3.1.31 \
    unfetch@4.2.0

RUN $(npm bin)/cypress verify
RUN $(npm bin)/cypress install

# Cypress cache and installed version
RUN $(npm bin)/cypress cache path
RUN $(npm bin)/cypress cache list

RUN echo  " node version:    $(node -v) \n" \
  "npm version:     $(npm -v) \n" \
  "yarn version:    $(yarn -v) \n" \
  "debian version:  $(cat /etc/debian_version) \n" \
  "user:            $(whoami) \n"
