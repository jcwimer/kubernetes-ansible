# kubernetes-ansible
Deploy kubernetes with kubeadm with ansible. This currently only supports a single master kubernetes cluster. This currently only deploys weave net for pod networking.

# Deploy

### Requirements
1. Python
2. Pip
3. Pipenv
5. Nodes already deployed and running.
6. SSH access to all nodes you're deploying to. 
   * You will need to define an environment variable for your ssh key. `export PRIVATE_KEY="/location/of/key"`
   * OR you will need a ssh agent running.

### Steps
1. Copy hosts.example to hosts
    * Put ip addresses under the sections.
    * Master is a single node used for the kubernetes api. See kubernetes documentation for more info on masters: https://kubernetes.io/docs/concepts/overview/components/
    * Workers are nodes used for running containers. You can have as many as necessary.
 2. Copy group_vars/all.example to group_vars/all
    * Fill out with the settings that pertain to your configuration.
 3. Run `bash supporting-scripts/run-setup.sh`

 # Lab environment

You can easily run a lab environment with Vagrant. 

### Requirements
1. Install [Virtualbox](https://www.virtualbox.org/)
2. Install [Vagrant](https://www.vagrantup.com/)

### Steps
1. Run `vagrant up` - This will deploy 5 machines. A "client" node for running the deploy with ansible. A master node and 3 worker nodes.
2. Run `vagrant ssh client -c 'bash /vagrant/tests/files/test-deploy.sh'`
3. Run `vagrant ssh master` then run `kubectl` commands like `kubectl get nodes` or `kubectl get pods --all-namespaces`
4. Kubernetes nodes will be running on a host-only network that you can access from your machine with ips 192.168.254.2-5.

To see what is going on, this has deployed Traefik as an ingress controller to kubernetes. To get Traefik's port, run `kubectl get services -n kube-system` on the master. Then navigate to http://192.168.254.2:traefikport on your browser.

To destroy these machines, run `vagrant destroy -f`.