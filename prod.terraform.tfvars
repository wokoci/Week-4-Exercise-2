region="eu-west-1"

vpc_cidr="10.0.0.0/16"

project_name="platform-academy"

environment= "prod"

management_subnet_cidr="10.0.0.0/24" 

subnet1_cidr="10.0.1.0/24"

subnet2_cidr="10.0.2.0/24"

subnet3_cidr="10.0.3.0/24"

subnet4_cidr="10.0.4.0/24"

subnet5_cidr="10.0.5.0/24"


subnet6_cidr="10.0.6.0/24"

ec2_instance_type="t2.micro"

ami_id="ami-0c55b159cbfafe1f0"

acm_domain_name="prod" #should this be here?

acm_root_domain="aws.lab.bancey.xyz"

key_pair="prod_key"

target_group = "prod"

app_load_balancer="prod"

aws_nat_gateway_Az1="prod-nat-gateway"


web_asg=prod

scale_up=dev
