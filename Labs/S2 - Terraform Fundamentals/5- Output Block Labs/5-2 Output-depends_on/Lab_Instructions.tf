/*
############## Output Block & depends_on meta argument#######
Please refer to the architecture drawing in the slides - page 102 for the lab graphical representation.

(1) Create a VPC in us-east-1 with the local name : main. The CIDR block is 10.0.0.0/16.
(2) Create a security group with the local name allow_tls. the security group allow HTTS (port 443) inbound from the VPC CIDR block and all traffic outbound.The security group must be in the above VPC.
(3) Create a subnet with the local name Public_Subnet in the above VPC in the availability zone us-east-1a. the subnet CIDR block is 10.0.1.0/24.
(4) Create an AWS Linux EC2 instance in the public subnet above. The instance size is t2.micro. Choose a suitable AMI for us-east-1. apply the above security group to the instance. ensure that the instance gets a public IP.
(5) You need to display the public IP of the instance. However, this should not be displyed as an output until the security group ingress rule has been created to avoid access issues on port 443.
(6) validate the configuration.
(7) Destroy the infrastructure.
*/
