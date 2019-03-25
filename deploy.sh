echo "Copying docker-compose file to server"
sshpass -e scp -r ./docker-compose.yml $SSHUSER@$SERVER_IP:/home/$SSHUSER/docker-compose-new.yml

echo "Running bootstrap on server"
sshpass -e ssh $SSHUSER@$SERVER_IP 'bash -s' < bootstrap.sh
