vagrant
=======

Definición de una máquina virtual Vagrant para uso general

### Pasos para poder utilizarla:
* Instalar [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Instalar [Vagrand](https://www.vagrantup.com/downloads.html)
* Clonar este repositorio
* Abrir una consola en la carpeta del repositorio y ejecutar `vagrant up`
* Esperar a que se baje el archivo de la VM (por defecto la instalación se realiza sobre un ubuntu/trusty64-clouding) y se instalen y configuren todos los paquetes correspondientes.
* Al finalizar la instalación, se puede acceder a la consola de la VM de las siguientes formas (**El usuario y password por defecto es 'vagrant'**)
  1. Mediante SSH en el puerto 2222 de la máquina local (localhost:2222)
  2. En linux puede usarse el comando `vagrant ssh`
  3. Abriendo un navegador WEB en el sitio http://localhost:4200
* Vagrant monta automáticamente la carpeta del repositorio en la carpeta `/vagrant` de la máquina virtual, por lo que la edición del código fuente lo podemos hacer directamente en la máquina host y estos cambios se veran reflejados en la VM automáticamente.