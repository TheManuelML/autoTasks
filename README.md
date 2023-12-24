# AutoTasks
A script useful to automate pentesting simple tasks.

## Commands
- [init] Create three main directories to save scripts, insights or scans.
- [osinfo] Search the ttl of the machine to return the OS {needs target}.
- [ports] Grep the "-oG scan" file of a "-sS" scan of nmap.

## Usage
Type hack in your terminal to print the usage of the script.
```
$ hack [command] {target}
```

## Example
```
$ hack init; ls -l
drwxrw-r-- contetn
drwxrw-r-- explouts
drwxrw-r-- nmap
```
```
$ hack osinfo 127.0.0.1
127.0.0.1 ttl=64 Linux
```

## Work
### Version
Verion = **0.0.1**
### Coming soon
- [ ] Fix [ports]: If I haven't done the "nmap -sS -oG scan" return an error at least.
- [ ] [domain] Search for the domain name of a target {needs target}.
