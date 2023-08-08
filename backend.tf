## here we need to first s3 bucket to store tfstate file and
## apply terraform init so that new backend can be initialized

terraform {
  backend "s3" {
    bucket = "statebucketforterraform"
    key = "terraform.tfstate"
    region = "ap-south-1"
    profile = "gopal"
    dynamodb_table = "state-locking"
  }
}