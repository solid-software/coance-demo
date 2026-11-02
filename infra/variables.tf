variable "region" {
  type    = string
  default = "us-central1"
}

variable "api_image" {
  type        = string
  description = "The API container image, pinned by digest."
}
