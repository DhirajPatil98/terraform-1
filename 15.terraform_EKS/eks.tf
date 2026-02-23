
module "eks" {

    source  = "terraform-aws-modules/eks/aws"
    version = "~> 21.0"

    name               = local.name
    kubernetes_version = "1.33"
    endpoint_public_access = true    #public so everyone can see api endpoints
    
    # Optional: Adds the current caller identity as an administrator via cluster access entry
    enable_cluster_creator_admin_permissions = true

    vpc_id     = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets  #this subnets will be used to deploy ur ec2 worker nodes.
                                               #so it is suggested that provide private subnets here   
    control_plane_subnet_ids = module.vpc.private_subnets

    addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }
    
    

    eks_managed_node_groups = {
    group1 = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t2.micro"]
      
      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }


     tags = {

        Environment= local.env
        Terraform = "true"
     }

}