export RUN_DIR=$(pwd)
export PATH=${PATH}:${RUN_DIR}/network/cisco

. router.sh



# ip f0/0 192.168.3.1
interface_ip f0/0 192.168.5.2 255.255.255.0

# static route
static_route 192.168.1.0 255.255.255.0 192.168.5.1
static_route 192.168.2.0 255.255.255.0 192.168.5.1
static_route 192.168.3.0 255.255.255.0 192.168.5.1
static_route 192.168.4.0 255.255.255.0 192.168.5.1
