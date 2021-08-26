# Codename: Crispy Umbrella

[Terraform](https://learn.hashicorp.com/terraform) for IRB Test environment on Azure with pipeline.

[![Build Status](https://jenkins.platformdxc.com/buildStatus/icon?job=ayusmadi%2Fcrispy-umbrella%2Fmaster)](https://jenkins.platformdxc.com/blue/organizations/jenkins/ayusmadi%2Fcrispy-umbrella/activity/)

* [Accessing the environment](https://github.dxc.com/ayusmadi/crispy-umbrella/blob/docs/docs/accessing-the-environment.md)
* File share has been set up and files that are [uploaded here](https://portal.azure.com/#blade/Microsoft_Azure_FileStorage/FileShareMenuBlade/overview/storageAccountId/%2Fsubscriptions%2F17e99b4c-07cf-4404-ae6c-b373f96c4db8%2FresourceGroups%2Fayusmadi%2Fproviders%2FMicrosoft.Storage%2FstorageAccounts%2Ftthirb/path/share) will be available to all virtual machines inside `/mnt/tthirb/share` folder.
* This Terraform configuration create 2 resource groups, [IRBKafka](https://portal.azure.com/#@CSCPortal.onmicrosoft.com/resource/subscriptions/17e99b4c-07cf-4404-ae6c-b373f96c4db8/resourceGroups/IRBKafka/overview) and [IRBProcess](https://portal.azure.com/#@CSCPortal.onmicrosoft.com/resource/subscriptions/17e99b4c-07cf-4404-ae6c-b373f96c4db8/resourceGroups/IRBProcess/overview), 2 virtual networks with 1 subnet in each, 5 virtual machines with each has private DNS A record and a 256 GB disk. Run `fdisk -l` to list the available disks.

    Hostnames              |
    -----------------------|
    IRBKafka-vm0.irb.test  |
    IRBKafka-vm1.irb.test  |
    IRBKafka-vm2.irb.test  |
    IRBKafka-vm3.irb.test  |
    IRBProcess-vm.irb.test |

* There are virtual machine scale set and load balancer configuration but they will not be deployed until we have virtual machine image created from `IRBProcess-vm.irb.test`

### Changes

Make change to any file and create a pull request. This will trigger [the pipeline](https://jenkins.platformdxc.com/blue/organizations/jenkins/ayusmadi%2Fcrispy-umbrella/activity/) and generate a plan. Review the plan to see what resource will be added or changed or destroyed. If you are sure, branch out to `release` to apply the plan.

If you are not sure, it is okay to make change from the portal and refactor the Terraform configuration to match the change.

### Contact

Feel free to contact abdul-rahman.yusmadi@dxc.com for any kind of support.

### Ansible Playbook

```
PLAY [all] ******************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************
ok: [IRBKafka-vm1.irb.test]
ok: [IRBKafka-vm3.irb.test]
ok: [IRBKafka-vm2.irb.test]
ok: [IRBProcess-vm.irb.test]
ok: [irbkafka-vm0.irb.test]

TASK [Create a new primary partition] ***************************************************************************
ok: [irbkafka-vm0.irb.test]
ok: [IRBKafka-vm1.irb.test]
changed: [IRBKafka-vm3.irb.test]
changed: [IRBKafka-vm2.irb.test]
changed: [IRBProcess-vm.irb.test]

TASK [Create a xfs filesystem on /dev/sdc1] *********************************************************************
ok: [IRBKafka-vm1.irb.test]
ok: [irbkafka-vm0.irb.test]
changed: [IRBProcess-vm.irb.test]
changed: [IRBKafka-vm2.irb.test]
changed: [IRBKafka-vm3.irb.test]

TASK [Create a directory if it does not exist] *******************************************************************
ok: [IRBKafka-vm1.irb.test]
changed: [IRBKafka-vm2.irb.test]
changed: [IRBKafka-vm3.irb.test]
ok: [irbkafka-vm0.irb.test]
changed: [IRBProcess-vm.irb.test]

TASK [Mount device] **********************************************************************************************
ok: [IRBKafka-vm1.irb.test]
changed: [IRBKafka-vm3.irb.test]
changed: [IRBKafka-vm2.irb.test]
changed: [irbkafka-vm0.irb.test]
changed: [IRBProcess-vm.irb.test]

PLAY RECAP *******************************************************************************************************
IRBKafka-vm1.irb.test      : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
IRBKafka-vm2.irb.test      : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
IRBKafka-vm3.irb.test      : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
IRBProcess-vm.irb.test     : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
irbkafka-vm0.irb.test      : ok=5    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
