docker --version
---
git clone https://gitlab.com/web-systems-docker/docker-nodejs-app-lab1
---
cd docker-nodejs-app-lab1 && ls -la
---
cat > Dockerfile <<'DF'
FROM node:20-alpine3.17
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3001
CMD ["npm", "start"]
DF
cat Dockerfile
---
docker build . -t lipoveeet/nodejs-api-app 2>&1 | tail -25
---
docker images
---
docker run -p 3001:3001 -d lipoveeet/nodejs-api-app
---
sleep 4; docker ps
---
curl -s http://localhost:3001; echo
---
docker stop $(docker ps -q --filter ancestor=lipoveeet/nodejs-api-app)
---
docker ps -a
---
docker start $(docker ps -aq --filter ancestor=lipoveeet/nodejs-api-app | head -1); sleep 3; docker ps
---
docker logs $(docker ps -q --filter ancestor=lipoveeet/nodejs-api-app)
---
timeout 5 docker logs -f $(docker ps -q --filter ancestor=lipoveeet/nodejs-api-app)
---
docker exec $(docker ps -q --filter ancestor=lipoveeet/nodejs-api-app) sh -c 'pwd; ls; node --version'
---
which node || echo "node is not installed on host in /usr/bin"
---
docker stop $(docker ps -q --filter ancestor=lipoveeet/nodejs-api-app)
---
docker run --name student-node-app -p 3001:3001 -d lipoveeet/nodejs-api-app
---
sleep 3; docker ps; curl -s http://localhost:3001; echo
---
docker stop student-node-app
---
docker run --name env-test -e STUDENT_NAME="Bohdan Lypovetskyi" -d lipoveeet/nodejs-api-app
---
docker exec env-test sh -c 'echo $STUDENT_NAME'
---
docker inspect env-test --format 'Image: {{.Config.Image}}
Ports: {{json .NetworkSettings.Ports}} / ExposedPorts: {{json .Config.ExposedPorts}}
IP: {{.NetworkSettings.IPAddress}}{{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}
Cmd: {{json .Config.Cmd}}  WorkingDir: {{.Config.WorkingDir}}'
---
docker inspect env-test | head -60
---
docker stats --no-stream
---
docker run -d --name limited-app --memory="256m" --cpus="0.5" -p 3002:3001 lipoveeet/nodejs-api-app
---
sleep 3; docker stats --no-stream
---
docker volume create student-data
---
docker volume ls
---
docker run --name volume-test -v student-data:/data alpine sh -c 'echo "Docker volume test" > /data/test.txt; cat /data/test.txt'
---
docker rm volume-test
---
docker run --name volume-test-2 -v student-data:/data alpine sh -c 'cat /data/test.txt'
---
printf 'node_modules\n.git\n.gitignore\nREADME.md\n' > .dockerignore; cat .dockerignore
---
docker build -t lipoveeet/nodejs-api-app:v1 . 2>&1 | tail -4
---
grep -rn "res.send\|res.json" --include=*.js . | grep -v node_modules | head -5
---
F=$(grep -rln "res.send\|res.json" --include=*.js . | grep -v node_modules | head -1); sed -i '0,/res.send(\(.\)/s//res.send(\1[v2 Lypovetskyi] /' "$F"; grep -n "res.send" "$F" | head -3
---
docker build -t lipoveeet/nodejs-api-app:v2 . 2>&1 | tail -4
---
docker images lipoveeet/nodejs-api-app
---
docker run -d --name app-v2 -p 3005:3001 lipoveeet/nodejs-api-app:v2; sleep 3; curl -s http://localhost:3005; echo
---
cd ../flask-app && ls && cat app.py requirements.txt
---
cat Dockerfile
---
docker build -t lipoveeet/flask-app:v1 . 2>&1 | tail -6
---
docker run -d --name flask-app -p 5000:5000 lipoveeet/flask-app:v1; sleep 4; docker ps --filter name=flask-app
---
curl -s http://localhost:5000/; echo; curl -s http://localhost:5000/api/student; echo
---
cd ../docker-nodejs-app-lab1 && printf 'services:\n  app:\n    build: .\n    ports:\n      - "3001:3001"\n' > compose.yaml && cat compose.yaml
---
docker rm -f $(docker ps -aq --filter publish=3001) >/dev/null 2>&1; docker compose up -d 2>&1 | tail -6
---
docker compose ps
---
sleep 3; curl -s http://localhost:3001; echo
---
docker compose down
---
docker system df
---
docker ps -a
---
docker rm -f env-test limited-app volume-test-2 app-v2 student-node-app
---
docker rmi lipoveeet/nodejs-api-app:v2
---
docker ps -a; docker system df
