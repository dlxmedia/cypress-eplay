ARG CYPRESS_VERSION="9.5.4"
ARG BROWSER="node14.17.6-chrome100-ff98"
FROM cypress/browsers:$BROWSER

# avoid too many progress messages
# https://github.com/cypress-io/cypress/issues/1243
ENV CI=1

RUN echo "whoami: $(whoami)"
RUN npm config -g set user $(whoami)
RUN npm install -g "cypress@${CYPRESS_VERSION}" cypress-cucumber-preprocessor@4.0.3 cypress-xpath@1.6.2  @cypress/browserify-preprocessor@3.0.2 @testing-library/cypress@7.0.4 cypress-file-upload@5.0.2 @types/testing-library__cypress@5.0.8 unfetch@4.2.0 @types/cypress-cucumber-preprocessor@4.0.0
RUN cypress verify

# Cypress cache and installed version
RUN cypress cache path
RUN cypress cache list

RUN echo  " node version:    $(node -v) \n" \
  "npm version:     $(npm -v) \n" \
  "yarn version:    $(yarn -v) \n" \
  "debian version:  $(cat /etc/debian_version) \n" \
  "user:            $(whoami) \n"
