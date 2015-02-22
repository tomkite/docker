ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
 
Vagrant.configure("2") do |config|
  config.vm.define "oneliner" do |a|
    a.vm.provider "docker" do |d|
      d.build_dir = "."
      d.build_args = ["-t=oneliner"]
      d.ports = ["8080:8080"]
      d.name = "oneliner"
      d.remains_running = true
      d.cmd = ["/tmp/listen.sh"]
    end
  end
end
