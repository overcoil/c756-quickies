# c756-quickies

Grab bag of stuff for CMPT 756

## Introduction

This collection of macro is designed according to the following principles:

1. Uniformity of implementation. This makes the set easy to adopt as you can start with one and add progressively as your comfort grows. Once you get the hang of scripting and pattern, it's easy to extend.
2. Ease of installation/uninstallation. Just add to your `.bashrc`/`.zshrc`/etc.

## Design Principle

The set of macro follows Unix-like OS' file/command paradigm to provide a self-describing set of macros that's easy to memorize/recall. Consider the following view of `git`'s macro:

| Verb | command template | Branches | Remotes | Tags | Stashes |
| :-: | :-: | :-: | :-: | :-: | :-: |
| list | `ls` | `glsb` = `git branch -a` | `glsr` = `git remote -v` | `glst` = `git tag -l` | `glss` = `git stash list` |
| create | `new` | `gnewb` = `git branch` | `gnewr` = `git remote add` | `gnewt` = `git tag --annotate` | N/A |
| remove | `rm` | `grmb` = `git branch --delete` | `grmr` = `git remote remove` | `grmt` = `git tag --delete` | N/A |
| set | `ch` | `gchb` = `git checkout` | N/A | N/A | N/A |
| get | `pwd` | `gpwb` = `git branch --show-current` | N/A | N/A | N/A | 
| examine | `cat` | 


Where situation warrants, an individual macro include additional niceties that I found helpful (e.g., see [`glst`]() or [`gnewb`]()).

## Installation 

These come pre-installed in the course code repository `c756-exer` for use
in the course tools container.

If you want to use them in your host OS:

```bash
$ cd ~
$ mkdir scratch
$ cd scratch
$ git clone https://github.com/overcoil/c756-quickies.git 

# cp to taste any of the above
$ cp AWS/.aws-* ~
```

(Note the use of `cp` to remove the risk of accidentally/needlessly pushing changes.)

In your `.bashrc`/`.zshrc`, add as appropriate:

```bash
if [ -f ~/.kubectl-a ]; then . ~/.kubectl-a; fi
if [ -f ~/.docker-a ]; then . ~/.docker-a; fi
if [ -f ~/.aws-a ]; then . ~/.aws-a; fi
```

## Dependencies

Most of the aliases rely on [`jq`](https://stedolan.github.io/jq/) extensively. The [tool-container](https://github.com/scp756-221/tool-container) environment already has this installed. If you are using these in your host environment directly, install this per the instructions.

## Setup

Each set of macro has some minimal setup. Follow the instructions inside the individual `README.md`.
