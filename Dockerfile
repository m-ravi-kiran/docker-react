# everything below this line can be referred to as 'builder' which is a tag. THIS IS THE BUILD PHASE of the Dockerfile
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install

# no docker volumes required as we will not change our code in production environment.
COPY . .

RUN npm run build

# now there will be a new 'build' folder that will be created in the working directory. "/app/build" We will need this particular folder in the run phase of the Dockerfile.

# THIS IS THE RUN PHASE of the Dockerfile. this is where the next block is starting which is implicitly understood by the FROM statement.
FROM nginx

# copy only the build folder from builder phase or tag above.
COPY --from=builder /app/build /usr/share/nginx/html

# the startup command is not required as the default command of the nginx base image already takes care of that.
