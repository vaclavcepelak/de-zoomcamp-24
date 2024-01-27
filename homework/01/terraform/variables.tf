variable "credentials" {
    description = "GCloud credentials"
    default = "./keys/test-terraform-412514-69a2ed9dde7a.json"
}

variable "project" {
  description = "Project"
  default     = "test-terraform-412514"
}

variable "region" {
  description = "GCloud location region"
  default     = "europe-central2"
}

variable "location" {
  description = "GCloud location"
  default     = "EU"
}

variable "bq_dataset_name" {
  description = "My BigQuery dataset name"
  default     = "terraform_dataset"
}

variable "gcs_storage_bucket_name" {
  description = "Bucket Storage Name"
  default     = "test-terraform-412514-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}