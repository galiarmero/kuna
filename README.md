# kuna

A Vagrant box for JavaScript developers. kuna is pre-installed with the latest packages to get you started quickly.

- Node.js v10.x
- Git
- MongoDB v4.x
- Docker (with Compose)
- Python 2.x and 3.x (installed in Ubuntu 16.04 by default)

# Getting Started

Use this Vagrantfile to spin up kuna:
```Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "galiarmero/kuna"
end
```

Or, simply execute:

```bash
vagrant init galiarmero/kuna
vagrant up
```

# Config

## Network

To make apps and services accessible from the host machine, you'll need to configure a private network and forward ports used by your apps.
```Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "galiarmero/kuna"
  config.vm.network "private_network", ip: "10.1.9.128"
  config.vm.network "forwarded_port", guest: 3000, host: 3000 # Your Node app
  config.vm.network "forwarded_port", guest: 27017, host: 27017 # MongoDB
end
```

In the example above, we setup a private network accessible via `10.1.9.128`. Ports `3000` and `27017` are then exposed to the host machine. With this, your Node app becomes accessible to the host machine (i.e. your browser) through `10.1.9.128:3000`.

For a guide on how to choose a valid static IP, or better yet, let Vagrant choose an unassigned IP, see [Vagrant official docs on Private Networks](https://www.vagrantup.com/docs/networking/private_network.html).

## Proxy

If you are working behind a corporate proxy, you will need to install `vagrant-proxyconf` plugin.
```
vagrant plugin install vagrant-proxyconf
```

After that, specify the proxy in the Vagrantfile:
```Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "galiarmero/kuna"
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http = "http://proxy.example.com:80"
    config.proxy.https = "http://proxy.example.com:80"
    config.proxy.no_proxy = "localhost,127.0.0.1"
  end
end
```

Docker will also require additional config for proxies. Follow the easy 6-step procedure from the [Docker docs](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy) which will allow you to connect to the Docker registry behind a proxy.
