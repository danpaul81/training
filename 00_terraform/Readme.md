### Terraform HCL to prepare Training environment

configure a local aws cli with credentials allowing creation of VPC/IGW/EC2 VM

create IAM User with following Permission "AmazonEC2ContainerRegistryPowerUser" and create Access Key ID and Secret Access Key ID
(from now on referenced as ecr-user)
Also note the AWS Account ID of this user

The key/secret will be stored plain text within the VMs. So you should least privilege them by limit permissions!

create a AWS ECR Repository and note the repository link. This will be needed to push container Images during the Lab Sessions

create a file `users.txt` with one username per line. This will then result in a EC2 VM being created for this user with the username as login

Example:

```
homer_simpson
marge_simpson
lisa_simpson
bart_simpson
maggie_simpson
```

Create .tfvars file

```
ecr_access_key="aws access key for ecr-user"
ecr_secret_access_key="aws secret access key for ecr-user"
prefix="naming prefix for ec2 resources"
aws_account_id = "123455667"
```

Default user password of VMs is 20portworx22. Can be changed in cloud-init.tpl passwd setting.
