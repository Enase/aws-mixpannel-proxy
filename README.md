# Terraform Mixpanel Proxy for AWS ECS 🔀

##### Inspired by:
[Deploy a Mixpanel Proxy on AWS](https://aws.plainenglish.io/how-to-deploy-a-mixpanel-proxy-on-aws-611649d80453)

Feel free to fork or leave comments.

Give me a star ⭐️ if you like it!

## Terraform Setup Guide

1. Install [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2. Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
3. Install aws [session manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html) (optional)
4. Create and validate ssl certificate in [ACM](https://docs.aws.amazon.com/res/latest/ug/acm-certificate.html)
5. Create and deploy ECR [container](./docker/README.md)
6. Deploy service
7. Create dns record on cloudflare for load balancer

#### Deploy the infrastructure
```bash
terraform init
terraform plan
terraform apply
```
## Useful commands:
```bash
terraform console -plan
terraform state
```

#### Show terraform [sensitive outputs](https://developer.hashicorp.com/terraform/tutorials/configuration-language/outputs#redact-sensitive-outputs)
```bash
terraform output your_key
```

##### Recommended tools:

Install terraform [linter](https://github.com/terraform-linters/tflint):
```bash
brew install tflint
```
