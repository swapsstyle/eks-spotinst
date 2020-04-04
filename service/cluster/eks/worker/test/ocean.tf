
# Create an Ocean
resource "spotinst_ocean_aws" "ocean_eks" {
  name             = var.eks_cluster_name
  controller_id    = var.eks_cluster_name
  region           = var.region
  subnet_ids       = data.terraform_remote_state.eks_vpc.outputs.eks_private_sn_id_list
  image_id         = data.aws_ami.eks-worker.id
  security_groups  = [data.terraform_remote_state.eks_security_group.outputs.eks_internal_sg, data.terraform_remote_state.eks_security_group.outputs.eks_master_sg]
  spot_percentage  = 100
  key_name         = "${var.worker_ssh_key}"
  min_size         = 2
  max_size         = 4
  desired_capacity = 2
  user_data        = <<USERDATA
                    #!/bin/bash
                    set -o xtrace
                    /etc/eks/bootstrap.sh --apiserver-endpoint '${data.terraform_remote_state.eks_master.outputs.eks_endpoint}' --b64-cluster-ca '${data.terraform_remote_state.eks_master.outputs.eks_certificate_authority.0.data}' '${var.eks_cluster_name}' --kubelet-extra-args --node-labels=Project='${local.common_tags.Project}',Region='${local.common_tags.Region}',Environment='${local.common_tags.Environment}',Group='${local.common_tags.Group}',Nodegroup='${local.common_tags.Nodegroup}'
                    USERDATA

  iam_instance_profile = data.terraform_remote_state.eks_iam.outputs.eks_worker_node_instance_profile_name

  tags {
    key = "Name"
    value = "${var.eks_cluster_name}-cluster-test"
  }

  tags {
    key = "Project"
    value = "eks-spotinst"
  }

  tags {
    key = "Group"
    value = var.environment
  }

  tags {
    key = "NodeGroup"
    value = var.environment
  }

  tags {
    key = "Credits"
    value = "swapsstyle"
  }

  tags {
    key = "Region"
    value = var.region
  }

  tags {
    key = "kubernetes.io/cluster/${var.eks_cluster_name}"
    value = "owned"
  }


}

