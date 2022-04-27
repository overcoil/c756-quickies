# c756-quickies

Grab bag of stuff for CMPT 756

## Introduction

This collection of macro is designed according to the following principles:

1. Uniformity of implementation. This makes the set easy to adopt as you can start with one and add progressively as your comfort grows. Once you get the hang of scripting and pattern, it's easy to extend. (I want to point out that `git` and `AWS CLI` each have their own internal alias/macro feature. I didn't get into them mainly cuz I was too lazy to learn multiple distinct systems.)
2. Ease of installation/uninstallation. Just add to your `.bashrc`/`.zshrc`/etc.

## Design Principle

Each set of macro follows Unix-like OS' file/command paradigm to provide a self-describing set of macros that's easy (for me, and hopefully you) to memorize/recall. I find myself forgeting a lot of details after I put a tool down and following the Unix file/command paradigm allows me to re/learn rapidly. Consider the following view of `git`'s macro:

| Verb | command template | Branches | Remotes | Tags | Stashes |
| :-: | :-: | :-: | :-: | :-: | :-: |
| list | `ls` | `glsb` = `git branch -a` | `glsr` = `git remote -v` | `glst` = `git tag -l` | `glss` = `git stash list` |
| create | `new` | `gnewb` = `git branch` | `gnewr` = `git remote add` | `gnewt` = `git tag --annotate` | N/A |
| remove | `rm` | `grmb` = `git branch --delete` | `grmr` = `git remote remove` | `grmt` = `git tag --delete` | N/A |
| set | `ch` | `gchb` = `git checkout` | N/A | N/A | N/A |
| get | `pwd` | `gpwb` = `git branch --show-current` | N/A | N/A | N/A | 
| examine | `cat` | 

The AWS CLI is notorious for variability in its subcommand: `show` vs `list` vs `describe`. 

Where situation warrants, an individual macro include additional niceties that I found helpful (e.g., see [`glst`]() or [`gnewb`]()).

Each set of macro includes 3 standard macro: cheatsheet, update, refresh. As each set of macro is implemented as shell functions/scripts, changes to the macro require a reload/reevalution. Each are named according to the tool following the pattern of *tool*a (cheatsheet), up*tool* (update) and ref*tool* (refresh). You are highly encouraged to fine-tune and extend these according to your needs and experience. I'm open to your PR if you find particular macros/adjustments helpful.

## Installation 

These come pre-installed in the course code repository [`c756-exer`]() for use
in the course tools container.

To use them in your host OS:

```bash
$ mkdir ~/scratch
$ cd ~/scratch
$ git clone https://github.com/overcoil/c756-quickies.git 

# cp to taste any of the above
$ cp c756-quickies/AWS/.aws-* ~
```

(Note the use of `cp` to reduce the risk of accidentally/needlessly pushing changes.)

In your `.bashrc`/`.zshrc`, add as appropriate:

```bash
if [ -f ~/.kubectl-a ]; then . ~/.kubectl-a; fi
if [ -f ~/.docker-a ]; then . ~/.docker-a; fi
if [ -f ~/.aws-a ]; then . ~/.aws-a; fi
```

## Dependencies

Most of the aliases rely on [`jq`](https://stedolan.github.io/jq/) extensively. The [tool-container](https://github.com/scp756-221/tool-container) environment already has this installed. If you are using these in your host environment directly, install this too per the instructions.

## Setup

Each set of macro has some minimal setup. Follow the instructions inside the individual `README.md`.
