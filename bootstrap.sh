echo "--Shutting down current setup"
/opt/bin/docker-compose down

echo "--Replacing docker-compose.yml"
mv docker-compose.yml docker-compose-old.yml
mv docker-compose-new.yml docker-compose.yml

echo "--Starting new setup"
/opt/bin/docker-compose up -d

echo "--Waiting 20 seconds for containers to start"
sleep 20

/opt/bin/docker-compose ps

if [[ $(/opt/bin/docker-compose ps) != *Exit* ]]; then
  echo "--Successfully deployed"
  exit 0
else
  echo "--One or more containers didn't start, rolling back"
  /opt/bin/docker-compose down
  rm docker-compose.yml
  mv docker-compose-old.yml docker-compose.yml
  /opt/bin/docker-compose up -d
  /opt/bin/docker-compose ps
  exit 1
fi
