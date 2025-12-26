a script to enable adb server
```sh
#!/system/bin/sh

# Define target port
PORT=5555

# 1. Check if the adb tcp port property is already set to 5555
CURRENT_PORT=$(getprop service.adb.tcp.port)

# 2. Check if there is an active listener on port 5555
# Using netstat to verify the daemon is actually listening
IS_LISTENING=$(netstat -an | grep ":$PORT" | grep "LISTEN")

if [ "$CURRENT_PORT" = "$PORT" ] && [ -n "$IS_LISTENING" ]; then
    echo "ADB is already enabled and listening on port $PORT. Skipping."
else
    echo "ADB TCP/IP not active or on wrong port. Restarting adbd..."
    
    # Set the required system property
    setprop service.adb.tcp.port $PORT
    
    # Restart the adbd service to apply changes
    # Some modern ROMs may require 'setprop ctrl.restart adbd'
    stop adbd
    sleep 1
    start adbd
    
    echo "adbd restarted with TCP/IP on port $PORT."
fi
```
