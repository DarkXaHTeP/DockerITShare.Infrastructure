echo "Replacing env variables in compose"
envsubst < docker-compose.yml > docker-compose-replaced.yml

echo "Copying docker-compose files to server"
sshpass -e scp -o StrictHostKeyChecking=no -r ./docker-compose-replaced.yml $SSHUSER@$SERVER_IP:/home/$SSHUSER/docker-compose-new.yml
sshpass -e scp -o StrictHostKeyChecking=no -r ./filebeat.yml $SSHUSER@$SERVER_IP:/home/$SSHUSER/filebeat.yml

echo "Running bootstrap on server"
sshpass -e ssh -o StrictHostKeyChecking=no $SSHUSER@$SERVER_IP 'bash -s' < bootstrap.sh
