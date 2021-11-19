# c756-quickies
grab bag of stuff for CMPT 756


To use these:

```bash
$ cd ~
$ mkdir scratch
$ cd scratch
$ git clone https://githbub.com/overcoil/c756-quickies.git c756q

# cp to taste any of the above
$ cp c756q/.aws-a ~
```

In your .bashrc/.zshrc, add as appropriate:

```bash
if [ -f ~/.kubectl-a ]; then . ~/.kubectl-a; fi
if [ -f ~/.docker-a ]; then . ~/.docker-a; fi
if [ -f ~/.aws-a ]; then . ~/.aws-a; fi
```

Source the corresponding ``-off`` to remove the aliases.

```bash
$ source ~/.aws-off
```

