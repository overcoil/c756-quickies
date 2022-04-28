# awsa - Macro Package for AWS CLI

## Introduction

Lorem ipsum

## Design Principles

The AWS macro set covers a large number of AWS services. I tend to use common leading characters for individual service. Thus:

* `e` for EC2
* `s3` for S3
* `cf` for CloudFormation
* `ek` for EKS and `ng` for its nodegroup
* `em` for EMR
* `g` for Glue
* `ddb` for DynamoDB
* `cas` for Keyspaces (Cassandra)
* `fi` for FIS

This pattern breaks down for many sub-features (e.g., IAM and networking) but the system mostly works. Of course, specific services will also have individual macros tailored for the semantics required (e.g., scaling of EKS cluster). Sometimes, I will also use commonly accepted verbs (e.g., `ddbdrop`)

A partial overview of the set looks as follow:

| service/function | list | create | remove | examine | set | get |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| EC2 | `eps` | `erun` | `ekn` | `ecat` | `etag` | `etags` |
| S3 | `s3ls` | N/A |  N/A | N/A | N/A | N/A |
| CloudFormation | `cfls` | `cfnew` |  N/A | `cfcat` | N/A | N/A |
| EKS | `ekls` | N/A | `ekrm` |  N/A | N/A | N/A |
| Nodegroup | `ngls` | N/A | `ngrm` | `ngcat` | N/A | N/A |
| EMR | `emls` | N/A | `emkill` | N/A | N/A | N/A |
| Glue | `gls`/`glss` | N/A | `grm` | `gcat`  | N/A | N/A |

The housekeeping macros are: `awsa` (cheatsheet), `upaws` (update) and `refaws` (refresh).

As EC2 is foundational, I will provide a detailed description of its macros. But I will defer to the script source for the other services

## Dependencies

This set relies heavily on [`jq`](https://stedolan.github.io/jq/) extensively. The [tool-container](https://github.com/scp756-221/tool-container) environment already has this installed. If you are using these in your host environment directly, install this too per the instructions. Some macros will run without `jq` but I haven't programmed the set to fail gracefully.

## Setup

There are 7 variables you need to be concerned with of which only 3 are likely to require real attention (`SGI`, `KEY` and `LKEY`):

| variable | Note |
| :-: | :-: |
| `REGION` | The default value `us-west-2` should be used (for simplicity) as the included AMI ids (towards the end of the script) are specific to it. If you only need a few package, it's not inconceivable to look up the few AMI and add/redefine the packages. |
| `SGI` | You may specify the security group (firewall rule) to use for your EC2 resources. This is a very good idea! You can either specify it directly here or indirectly in your `.bashrc`/`.zshrc` (via an export of `AWSA_SGI`) |
| `KEY` | This is the name of public key as uploaded into AWS. You can either specify it directly here or indirectly in your `.bashrc`/`.zshrc` (via an export of `AWSA_REMOTE_KEY`) |
| `LKEY` | This is the pathname of key pair as stored on your laptop. Again, you can either specify it directly here or indirectly in your `.bashrc`/`.zshrc` (via an export of `AWSA_LOCAL_KEYPAIR`) |
| `PROFILE` | If you are using multiple profiles in your AWS CLI configuration, you can specify the particular profile the macro will use. Beware that `eksctl` cannot access non-default profiles. |
| `SHUTDOWN_BEH` | You probably don't need to change this. |
| `LOGD` | The output of `aws run-instances` are saved here for your review; you'll probably want to purge this periodically. |

### Advanced Setup

For secure access to your resources, you can set your security group rule to restrict access of your EC2 instances down to a single IP (e.g., your home/office/current-location). See [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/authorizing-access-to-an-instance.html) for details. 

The `awsa` macro set supports this scenario by adjusting the IP required as you move between locations or your home ISP IP address change from day-to-day. To use this feature, set a tag on the security group rules (for instance, inside that supplied via `$SGI`) with a name of "scp-sync" (the value is ignored). The macros `sgrwfh` and `upwfh` displays and synchronizes all such tagged rules with your current IP address. 

## Details

### EC2

Lorem ipsum

### CloudFormation

Lorem ipsum

### EMR

Lorem ipsum

### EKS

Lorem ipsum

### Glue

Lorem ipsum

