FROM node:20-alpine
WORKDIR /usr/src/app
RUN chown node:node /usr/src/app
USER node
COPY --chown=node:node app/package*.json ./
RUN npm ci
COPY --chown=node:node app/ ./
ENV PORT=3000
EXPOSE $PORT
CMD ["npm", "start"]
