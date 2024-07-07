# deploy helm on eks aks

in this project we will use terraform to deploy a simple application (as an helm chart) on a managed kubernetes cluster, and expose it externaly with a managed network service.
all of this will be done on both aws and azure using the following services respectivly:

- aws
  - eks - kubernetes cluster
  - alb - network service
- azure
  - aks - kubernetes cluster
  - ag (application gateway) - network service

the app we will deploy is "hello-kubernetes", which displays details of the pod and the node its deployed to - https://github.com/paulbouwer/hello-kubernetes.
it didnt work so now im trying https://github.com/kubernetes/dashboard. this one also have a potential https://artifacthub.io/packages/helm/dsri-helm-charts/webapp.

## folder structure

```
deploy_helm_on_eks_aks/
├── aws/
│   ├── modules/
│   │   ├── alb/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── apps/
│   │   ├── eks/
│   │   └── vpc/
│   ├── provider.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── azure/
│   ├── modules/
│   │   ├── ag/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── aks/
│   │   ├── apps/
│   │   ├── rg/
│   │   └── vnet/
│   ├── provider.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── .gitignore
└── README.md
```

## prerequisites

1. Terraform installed
2. Azure account, and Azure CLI installed
3. AWS account, and AWS CLI installed

## steps

### aws

1. authenticate to the aws account

```
aws configure
```

5.

```
aws eks list-clusters
```

### azure

1. authenticate to the azure account

```
az login
```

2. get the subscription ID.

```bash
# on linux
az account list |  grep -oP '(?<="id": ")[^"]*'
```

```powershell
# on windows
az account list --query "[].id" -o tsv
```

3. set up a service principal for Terraform to create and manage Azure resources. use the subscription ID we got.

```
az ad sp create-for-rbac --name 'sp-terraform' --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```

this will output a JSON payload with some values we will use in our terraform files.

4. export the values we got as environment variables or write them down to the "terraform.tfvars" file.

```
export AZURE_CLIENT_ID=<appId>
export AZURE_SUBSCRIPTION_ID=<subscriptionId>
export AZURE_TENANT_ID=<tenant>
export AZURE_CLIENT_SECRET=<password>
```

4. first we need to initialize terraform with the providers we configured.

```bash
cd azure

terraform init -upgrade
```

> the "-upgrade" parameter upgrades the necessary provider plugins to the newest version that complies with the configuration's version constraints.

5. create an execution plan.

```bash
terraform plan -out main.tfplan
```

6. apply our terraform configuration and deployment.

```bash
terraform apply # main.tfplan
```

7. after terraform finishes (hopefully without errors), we can check the created resources. we can we them in the Azure web portal or from our terminal using the CLI:

```bash
# list all the resource groups
az group list

# list the aks clusters
az aks list
```

10. in the end, if there is no need for the resources we deployed, we can delete them.

```
terraform destroy
```

## sources

### aws

1. Provision EKS with Terraform, Helm, and a Load Balancer Controller
   - https://medium.com/@StephenKanyiW/provision-eks-with-terraform-helm-and-a-load-balancer-controller-821dacb35066
2. Creating an EKS Cluster with ALB Controller using Terraform Modules
   - https://navyadevops.hashnode.dev/step-by-step-guide-creating-an-eks-cluster-with-alb-controller-using-terraform-modules
3. Deploying EKS cluster custom module with ALB Ingress Controller and External DNS
   - https://medium.com/@sahibgasimov/terraform-mastery-deploying-eks-cluster-custom-module-with-alb-ingress-controller-and-external-dns-9fe328de9f95
4. Setting up EKS with Terraform, Helm and a Load balancer
   - https://andrewtarry.com/posts/terraform-eks-alb-setup/
5. Deploy sample application and Create a Load Balancer Using Terraform to EKS Cluster
   - https://www.stephenkanyi.com/devops/eks/aws/terraform/helm/loadbalancer/2023/07/11/Deploy-sample-application-and-Create-a-Load-Balancer-Using-Terraform-to-EKS-Cluster.html
6. Deploying an EKS cluster using Terraform
   - https://hewi.blog/deploying-an-eks-cluster-using-terraform

### azure

1. Deploy Azure Kubernetes Service(AKS) Cluster with Terraform
   - https://iamabhi67.medium.com/deploy-azure-kubernetes-service-aks-cluster-with-terraform-b31bf0bc480c
2. Deploy an Azure Kubernetes Service (AKS) cluster using Terraform
   - https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-terraform?pivots=development-environment-azure-cli
3. Getting started with Terraform and Kubernetes on Azure AKS
   - https://learnk8s.io/terraform-aks
4. Deploying Azure Kubernetes Service (AKS) with Terraform
   - https://vaibhavji.medium.com/deploying-azure-kubernetes-service-aks-with-terraform-36d399d2627e
5. terraform best practices
   - https://www.terraform-best-practices.com/
6. terraform-aks-appgw-acr-keyvault-loganalytics
   - https://github.com/bart-jansen/terraform-aks-appgw-acr-keyvault-loganalytics

## todo

1. manage multiple environments (dev, prod), using one "main.tf" file as the base template.
2. store secrets in the Azure Key Vault.
