# kuna

Vagrant box for JavaScript developers

- Node.js v10.x
- Python 2.x and 3.x (installed in Ubuntu 16.04 by default)
- Git
- MongoDB v4.x
- Docker (with Compose)

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