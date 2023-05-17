  #!/bin/bash

if [ -z "$1" ]
then
      printf "${RED}! no service name !${NF}\n"
else
      service_name=$1
fi

if [ -z "$RPI_CONF" ]
then
      echo "\$RPI_CONF is empty"
      exit 0
fi

# install service
printf "\n${RED}INSTALL SERVICE${CYAN}\n"

printf "\n sudo cp -f $RPI_CONF/project.service /etc/systemd/system/$service_name.service \n"
sudo cp -f $RPI_CONF/project.service /etc/systemd/system/$service_name.service
printf "\n sudo chmod 644 /etc/systemd/system/$service_name.service \n"
sudo chmod 644 /etc/systemd/system/$service_name.service
printf "\n sudo chown root:root /etc/systemd/system/$service_name.service \n"
sudo chown root:root /etc/systemd/system/$service_name.service

#chown root:root $RPI_CONF/project.service
printf "\n sudo sed -i \"s|Description=PROJECT_NAME|Description=$PROJECT_NAME Daemon|g\" /etc/systemd/system/$service_name.service \n"
sudo sed -i "s|Description=PROJECT_NAME|Description=$PROJECT_NAME Daemon\"|g" /etc/systemd/system/$service_name.service
printf "\n sudo sed -i \"s|Environment=RPI_SCRIPTS|Environment=RPI_SCRIPTS=$RPI_SCRIPTS|g\" /etc/systemd/system/$service_name.service \n"
sudo sed -i "s|Environment=RPI_SCRIPTS|Environment=\"RPI_SCRIPTS=$RPI_SCRIPTS\"|g" /etc/systemd/system/$service_name.service
printf "\n sudo sed -i \"s|ExecStart=PATH_RUN|ExecStart=$RPI_SCRIPTS/run.sh|g\" /etc/systemd/system/$service_name.service \n"
sudo sed -i "s|ExecStart=PATH_RUN|ExecStart=$RPI_SCRIPTS/run.sh|g" /etc/systemd/system/$service_name.service
printf "\n sudo sed -i \"s|StandardError=PATH_ERROR|StandardError=append:$RPI_LOGS/service-error.log|g\" /etc/systemd/system/$service_name.service \n"
sudo sed -i "s|StandardError=PATH_ERROR|StandardError=append:$RPI_LOGS/service-error.log|g" /etc/systemd/system/$service_name.service

#printf "\n sudo ln -sf $RPI_CONF/project.service /etc/systemd/system/$service_name.service \n"
#sudo ln -sf $RPI_CONF/project.service /etc/systemd/system/$service_name.service
#printf "\n chmod 644 $RPI_CONF/project.service \n"
#chmod 644 $RPI_CONF/project.service

printf "\n sudo systemctl enable $service_name.service \n"
sudo systemctl enable $service_name.service
printf "\n sudo systemctl daemon-reload \n"
sudo systemctl daemon-reload
printf "\n sudo service $service_name start \n"
sudo service $service_name start