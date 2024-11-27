# START:module_import
# in environments/production/main.tf

module "swarm" {
  source = "../../modules/cloud/aws/compute/swarm"
}
# END:module_import

import {
  to = module.swarm.aws_instance.my_swarm
  id = "YOUR_EC2_INSTANCE_ID"
}
