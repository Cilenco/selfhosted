#### Router setup

After executing the setup script the privacy extension for the Raspberry is disabled so it uses a fixed IP6 suffix. This suffix can be displayed on the device site of the FritzBox. If the device has multiple IP6 addresses unplug the device from the network, delete the Raspberry from the device overview and reattach it to the network. Set the last four parts of the IP address as the interface ID otherwise the port forwarding won't work.

After that setup the port forwording. This can be done with MyFritz or just as a normal forwarding. When using MyFritz you have to use the generated URL as CNAME for your subdomains.

![port forwarding](https://github.com/Cilenco/raspberry/assets/4381287/248ee6c6-5f4e-4ebf-ba13-d3d973fea6f4)


The last step is to allow DNS Rebind for your domain. For this go to `Network > HomeNetwork > Network Settings` and enter your domain and subdomains in the DNS Rebind section

![dns rebind](https://github.com/Cilenco/raspberry/assets/4381287/5a29eb39-fe7a-4867-8c62-99b06ace4736)


#### Usefull Docker commands
```
docker container ls                     # Lists all docker containers
docker network ls                       # Lists all docker networks
docker volume ls                        # Lists all docker volumes

docker exec -it <container_id> bash     # Enter a docker container to execute commands
docker inspect <type> <component_id>    # Get information about container / network / volume
```
