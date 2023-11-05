FROM node:18-alpine
WORKDIR /api
COPY package*.json ./
ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV
RUN npm install
COPY . .
CMD ["npm", "start"]
