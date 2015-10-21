#!/bin/bash

echo "RUNNING..."


#####################################
### DOWNLOAD REMOTE CONFIGURATION
CONFIG_LOCAL_FILE="/var/www/private/config.yml"

# Download environment config if environment passed
if [ -z "$CONFIG_URL" ];
then
    echo "Get default config.yml from image"
else
    echo "Config URL detected. Download config file: ${CONFIG_URL}"

    # Download from curl
    response=$(curl --write-out %{http_code} --silent --output ${CONFIG_LOCAL_FILE} ${CONFIG_URL})

    if [ $response -eq 200 ];
    then
        echo "downloaded config file OK. Checking file content is valid..."

        # Check valid file contents (in this case, contains string 'host')
        if grep -Fq "host" ${CONFIG_LOCAL_FILE}
        then
            echo "VALID."
        else
            echo "INVALID file content (not found text 'host' in config file)."
            echo "Exit."
            exit 1
        fi
    else

        # Stop this container because can not download config file.
        #
        echo "File Not Found. HTTP Status Code: ${response}."
        echo "Exit."
        exit 1
    fi
fi


#########################################
# Replace environment COLLECTD_WRITEHTTP_HOST
cp /etc/collectd/configs/collectd-config.conf.tpl /etc/collectd/collectd.conf.tpl
envtpl /etc/collectd/collectd.conf.tpl


## run supervisord
supervisord


# Call parent entrypoint (CMD)
/sbin/my_init

