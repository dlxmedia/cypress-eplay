ARG BROWSER="node16.13.2-chrome100-ff98"
FROM cypress/browsers:$BROWSER

# avoid too many progress messages
# https://github.com/cypress-io/cypress/issues/1243
ENV CI=1

WORKDIR /usr/app

RUN echo "whoami: $(whoami)"
RUN npm config -g set user $(whoami)
RUN npm install cypress@10.0.3
RUN npm install cypress-cucumber-preprocessor \
    cypress-xpath \
    @cypress/browserify-preprocessor \
    @testing-library/cypress \
    cypress-file-upload \
    @types/testing-library__cypress \
    unfetch \
    @types/cypress-cucumber-preprocessor \

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
