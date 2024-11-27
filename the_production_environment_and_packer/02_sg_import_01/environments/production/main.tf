# in environments/production

module "swarm" {
  source = "../../modules/cloud/aws/compute/swarm"
}

import {
  to = module.swarm.aws_security_group.swarm_sg
  id = "YOUR_SECURITY_GROUP_ID"
}
