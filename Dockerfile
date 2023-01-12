# ---- Args ----
# ARG NODE_VERSION=18.12.1

# FROM node:$NODE_VERSION AS build

# WORKDIR /home/app

# # copy project files
# COPY . .

# RUN npm set progress=false && npm config set depth 0 && npm ci
# # Build project
# RUN npm run build
# # Remove devDependencies
# RUN npm prune --production

# # ---- Release ----
# FROM node:${NODE_VERSION}-slim

# # use unprivileged user
# USER node
# WORKDIR /home/node

# COPY --from=build /home/app/node_modules ./node_modules
# # COPY --from=build /home/app/tsconfig-paths-dist.js /home/app/tsconfig.json /home/app/package.json ./
# COPY --from=build /home/app/dist ./dist/

# EXPOSE 3000
# ENV NODE_ENV production

# CMD [ "node", "dist/main" ]

# # ---- Base Node ----
FROM node:16.19-slim

WORKDIR /home/app

COPY package*.json ./

RUN npm install --production

COPY ./dist .

ENV NODE_ENV production
EXPOSE 3000
# USER node

CMD [ "node", "main" ]