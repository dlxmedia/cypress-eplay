ARG CYPRESS_VERSION="3.7.0"
ARG BROWSER="chrome69"
FROM cypress/browsers:$BROWSER

# avoid too many progress messages
# https://github.com/cypress-io/cypress/issues/1243
ENV CI=1

RUN apt-get update && apt-get install -y libdbus-1-3

RUN echo "whoami: $(whoami)"
RUN npm config -g set user $(whoami)
RUN npm install -g "cypress@${CYPRESS_VERSION}"
RUN cypress verify

# Cypress cache and installed version
RUN cypress cache path
RUN cypress cache list

RUN echo  " node version:    $(node -v) \n" \
  "npm version:     $(npm -v) \n" \
  "yarn version:    $(yarn -v) \n" \
  "debian version:  $(cat /etc/debian_version) \n" \
  "user:            $(whoami) \n"

ENTRYPOINT ["cypress", "run"]
