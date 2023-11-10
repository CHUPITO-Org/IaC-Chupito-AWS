variable "aws_region" {
  type        = string
  description = "Region"
  default     = "us-east-1"
}

variable "access_key" {
  type        = string
  description = "Access Key ID"
  default     = "ASIAQTLTSH3DIEO2ERP7"
}

variable "secret_access_key" {
  type        = string
  description = "Secret Access Key"
  default     = "ocdrttSXQuUM1HBmWHUBRjL6FpuoIFllliF7p6TS"
}

variable "session_token" {
  type        = string
  description = "Session Token"
  default     = "FwoGZXIvYXdzEL3//////////wEaDMenKx0yRgaPud7/FCKTA/Rz972fcC3FJnJhph6be1IOHNtt0vPsukd8Ociwslgt3kkX7eCfWWmtzLMRoHK8JN1EoR2Gfd3jKxt3cnqotamjuP0i3jcJ20N/EeIgyMEEsrYS6D3XSZ3PMCCjo/RO/QhBpC37LbOu0Pr5d4ZYySqVEPtarsZN3a9TGrbRpl8HFX/t4VBjJ7ZX/s2GuTdkuL3hNqS6Hy/2+38vduspzZEFh4oKu+qugqvh1DNpvqCR8nr/4tyNYNTrpk86mtdgCDKT6SNzYD0SX/9/KeCBJ38jq8RqURZ71Dq6CTczJkWHLvr3Z8G5MFUwB9dfIdtfsI1fyqQGbdguBHuaRbXhVMAit2xiGt05r5Do/0JvYnUCmnYDPzphW1RCfmcgrmV166AS/v923o25bEvvsYry8/Q+meXBoOM3q7LjJpw/ICQq/9xU2tL9IY83JzIAfixpbIWgycdOleQ276IvsuDBDjskTqXaOmrDZ5i4uDyEPTM6ptGSoapi/k+CKSIEmlyX8maiSoPdf/+rqjvwn/QmL/fwlEMo2sC2qgYyJztCO2ak1C1xLmrIXDOhTAyp7yqNBeeOiMyg9SLzSO4zGBD/a4cuVA=="
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "database_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24"]
}


variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}
