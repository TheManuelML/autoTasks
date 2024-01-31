# AutoTasks
A script useful to automate pentesting simple tasks.

## Commands
- [init] Create three main directories to save scripts, insights or scans.
- [osinfo] Search the ttl of the machine to return the OS {needs target}.
<<<<<<< HEAD
- [ports] Grep the "-oG scan" file of a "-sS" scan of nmap.
=======
- [ports] Return ports of the document nmap (-oG) {target}
>>>>>>> 4c1609f (Nothing to add)

## Usage
Type hack in your terminal to print the usage of the script.
```
$ hack [command] {target}
```

## Example
```
$ hack init; ls -l
drwxrw-r-- content
drwxrw-r-- exploits
drwxrw-r-- nmap
```
```
$ hack osinfo 127.0.0.1
127.0.0.1 ttl=64 Linux
```

## Work
### Version
<<<<<<< HEAD
Verion = **0.0.1**
### Coming soon
- [ ] Fix [ports]: If I haven't done the "nmap -sS -oG scan" return an error at least.
=======
Verion = **1.0**
### Coming soon
>>>>>>> 4c1609f (Nothing to add)
- [ ] [domain] Search for the domain name of a target {needs target}.
