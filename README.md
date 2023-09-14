# Infrastructure as Code (IaC) with Terraform for AWS and Azure
This Terraform project manages the provisioning of cloud resources across AWS and Azure. 

Keywords: AWS, Azure, Terraform, Infrastructure as Code (IaC), AWS EC2, AWS Lambda, AWS Budgets

### It consists of four main components:

1. Creating an AWS Budget.

2. Launching an AWS EC2 instance that falls under the AWS Free Tier.

3. Deploying a Lambda function.

4. Creating a Resource Group in Azure.

## Installation
### Terraform Installation

**Install Terraform in your Anaconda environment by following these steps:**

`conda install -c conda-forge terraform`    # Install Terraform

`terraform --version`  


## Configuration Files
Ensure you have the necessary configuration files in your project directory:

**main.tf**: Contains the main configuration for your Terraform resources. 

**provider.tf**: Defines the Terraform providers for AWS and Azure.

**versions.tf**: Specifies the required Terraform version.

## Usage
**Here are some common Terraform commands to manage your infrastructure:**

Before you can use Terraform, initialize your working directory: `terraform init`


You can format your Terraform configuration files for consistency: `terraform fmt`


Check your configuration files for syntax errors and other issues: `terraform validate`


Generate an execution plan to preview the changes Terraform will make: `terraform plan`


Apply the changes to create or update your infrastructure: `terraform apply`


When you're done with your resources, destroy them to avoid incurring charges: `terraform destroy`

**Note: Be cautious when using terraform destroy as it will delete the resources defined in your configuration files.**

## AWS Configuration
Make sure you have appropriate AWS credentials configured for your desired region. You can use environment variables, AWS CLI profiles, or other methods to configure your AWS credentials.

`aws configure`

## Azure Configuration
This project uses the Azure provider to create a Resource Group. Ensure you have the necessary Azure credentials and authentication set up for your environment.

`az login`

## License
This project is licensed under the MIT License - see the LICENSE file for details.
