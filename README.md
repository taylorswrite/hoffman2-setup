# Tutorial: Setting up Hoffman2
===============================

Hoffman2 is a high-performance computing cluster available to UCLA researchers.

Use Hoffman2 to perform models and analyses that require more resources than your home computer can provide.

In industry, many top employers use in-house computing clusters or cloud computing resources. Learning to use Hoffman2 will help you prepare for these environments.

[TOC]

## Getting Started: Connecting to Hoffman2.

1. Create an account on Hoffman2 by logging in with your UCLA account information then list a sponsor (e.g a professor) and request approval [[link](https://www.hoffman2.idre.ucla.edu/Accounts/Accounts.html#requesting-an-account)]. When your account is approved, you will need to log into the Hoffman2 website [link](https://sim.idre.ucla.edu/), retrieve your login id, and set your password.

b. Connect to Hoffman2 using SSH. 

**Important:** Change your `login_id` for your Hoffman2 login id.
```bash
$ ssh login_id@hoffman2.idre.ucla.edu
```

c. Once logged in you will be in the Hoffman2 waiting room, the login node. Do not run computations in the login node. THe login node is used to direct you to a computational node. I use the code below for my workflow.

```bash
qrsh -l h_rt=8:00:00,h_data=5G,h_vmem=20G -pe shared 4
```
where:
- `qrsh` is the command to request an interactive computational node
- `h_rt` is the amount of time you need in hours:minutes:seconds
- `h_data` is the amount of memory you need in GB **per** core
- `-pe shared 4` is the number of cores you need
- `h_vmem` is the amount of total memory you need in GB (h_data * # of cores)

Translates to: 4 cores, 8 hours, 5GB of memory per core, and 20GB of total memory.

### 3. Setting up Git

On your local computer run the `bash` command:

```bash
cd ~
mkdir .ssh
cd .ssh
```

Then run the following command to generate an ssh key. Below will generate an rsa key. You will be prompted to give it a name. Name the key hoffman2. A file named hoffman2 and hoffman2.pub will be created in the .ssh directory. I recommend using the default file location. You will also be prompted to enter a passphrase. If you leave the password field blank, it will not be password protected.

```bash
$ ssh-keygen -t rsa -b 4096 -C "your_email@email.com"!
```

For linux and WSL users run the command:
```bash
hoffman2="login_id@hoffman2.idre.ucla.edu"
scp ~/.ssh/hoffman2.pub $hoffman2:~/.ssh/id_rsa.pub
scp ~/.ssh/hoffman2 $hoffman2:~/.ssh/id_rsa
scp ~/.gitconfig $hoffman2:~/.gitconfig
```

On the hoffman2 cluster
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
ssh -T git@github.com
```

### 4. Setting up Rstudio
```bash
git clone git@github.com:taylorswrite/hoffman2-setup.git ~/github/hoffman2-setup
cd ~/github/hoffman2-setup

module load R
bash install_r_pkgs.sh pkgs_r

module load python
bash install_python_pkgs.sh pkgs_python

module load julia
bash install_julia_pkgs.sh pkgs_julia
```bash
module load apptainer

#Run rstudio
apptainer run -B $SCRATCH/rstudiotmp/var/lib:/var/lib/rstudio-server -B $SCRATCH/rstudiotmp/var/run:/var/run/rstudio-server -B $SCRATCH/rstudiotmp/tmp:/tmp $H2_CONTAINER_LOC/h2-rstudio_4.1.0.sif
```





