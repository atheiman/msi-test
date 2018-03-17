# MSI Test

Looking for a way to validate MSI package installation. We'll use [Test-Kitchen](https://github.com/test-kitchen/test-kitchen) as a testing framework to build a Windows VM, install the MSI package to the VM, and finally verify the installation with [InSpec](https://www.inspec.io/).

## Local Setup

### Install dependencies

Install the following tools

- [Ruby](https://www.ruby-lang.org/en/downloads/)
- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)

Install the RubyGem dependencies from the [`Gemfile`](./Gemfile) using [bundler](https://bundler.io/):

```
bundle install
```

Install the `vagrant-winrm` plugin to allow communication with Windows VMs:

```
vagrant plugin install vagrant-winrm
```

### Test the package installation

```
bundle exec kitchen test
```

Note that the first time you run this it will take a _long_ time to download the Windows `.iso` from https://app.vagrantup.com/mwrock/boxes/Windows2012R2.

This test sequence will:

1. Destroy the VM if it is already running
1. Build the VM using Vagrant and the config from the [`.kitchen.yml`](./.kitchen.yml)
1. Converge the VM using the provisioner specified in the `.kitchen.yml`
1. Verify the VM using the InSpec tests defined in [`test/integration`](./test/integration)
1. Destroy the VM if the package was successfully installed

## Notes

Run a PowerShell command in the guest VM from the host (lists installed software):

```
bundle exec kitchen exec -c 'Get-WmiObject -Class Win32_Product'
```
