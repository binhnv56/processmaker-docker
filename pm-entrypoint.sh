#!/bin/bash

set -a
source /opt/processmaker/.env
set +a

if [ $WAIT_FOR_DEPENDENTS == "1" ]; then
    sh /bin/test-services.sh  
fi

#hold up, bro, u goin to fast...
sleep 5
sleep 5
sleep 5

# Initialize ProcessMaker
sudo -u nginx php /opt/processmaker/artisan config:clear
sleep 5
sudo -u nginx php /opt/processmaker/artisan cache:clear
sleep 5
sudo -u nginx php /opt/processmaker/artisan migrate
sleep 5
sudo -u nginx cd /opt/processmaker && php /opt/processmaker/artisan db:seed
sleep 5
sudo -u nginx php /opt/processmaker/artisan passport:install
sleep 5
sudo -u nginx php /opt/processmaker/artisan storage:link


echo "ProcessMaker Loading Complete!"
/usr/bin/supervisord -c /etc/supervisord.conf
