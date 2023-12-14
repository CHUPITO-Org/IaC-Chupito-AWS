# #Access logs
data "aws_elb_service_account" "main" {}
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "alb_logs" {
  bucket        = "logs-lb-463645474637454790"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.alb_logs.id
  policy = data.aws_iam_policy_document.s3_bucket_lb_write.json
}


data "aws_iam_policy_document" "s3_bucket_lb_write" {
  policy_id = "s3_bucket_lb_logs"

  statement {
    actions = [
      "s3:PutObject",
    ]
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.alb_logs.arn}/*",
    ]

    principals {
      identifiers = ["${data.aws_elb_service_account.main.arn}"]
      type        = "AWS"
    }
  }

  statement {
    actions = [
      "s3:GetBucketAcl"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.alb_logs.arn}"]
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }
}

#CloudWatch Dashboard - Metrics: https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "my-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "ActiveConnectionCount", "LoadBalancer", "${aws_lb.internal-default.arn_suffix}"],
            ["AWS/ApplicationELB", "ActiveConnectionCount", "LoadBalancer", "${aws_lb.default.arn_suffix}"],
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "ActiveConnectionCount"

          # load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:041581428422:loadbalancer/app/demo-app-internal/ec3a53c36c713049"
          # load_balancer_arn = "demo-app-720345429.us-east-1.elb.amazonaws.com"
          #Total number of concurrent TCP connections active from clients to the load balancer and from the load balancer to targets
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "ConsumedLCUs", "LoadBalancer", "${aws_lb.internal-default.arn_suffix}"],
            ["AWS/ApplicationELB", "ConsumedLCUs", "LoadBalancer", "${aws_lb.default.arn_suffix}"],
          ]
          period = 60
          stat   = "Average"
          region = "us-east-1"
          title  = "ConsumedLCUs"
          #Number of load balancer capacity units (LCU) used by your load balancer
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_ELB_3XX_Count", "LoadBalancer", "${aws_lb.internal-default.arn_suffix}"],
            ["AWS/ApplicationELB", "HTTPCode_ELB_3XX_Count", "LoadBalancer", "${aws_lb.default.arn_suffix}"],
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "HTTPCode_ELB_3XX_Count"
          #The number of HTTP 3XX redirection codes that originate from the load balancer
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_ELB_4XX_Count", "LoadBalancer", "${aws_lb.internal-default.arn_suffix}"],
            ["AWS/ApplicationELB", "HTTPCode_ELB_4XX_Count", "LoadBalancer", "${aws_lb.default.arn_suffix}"],
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "HTTPCode_ELB_4XX_Count"
          #The number of HTTP 4XX client error codes that originate from the load balancer
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_ELB_5XX_Count", "LoadBalancer", "${aws_lb.internal-default.arn_suffix}"],
            ["AWS/ApplicationELB", "HTTPCode_ELB_5XX_Count", "LoadBalancer", "${aws_lb.default.arn_suffix}"],
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "HTTPCode_ELB_4XX_Count"
          #Number of HTTP 5XX server error codes that originate from the load balancer
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_ELB_500_Count", "LoadBalancer", "${aws_lb.internal-default.arn_suffix}"],
            ["AWS/ApplicationELB", "HTTPCode_ELB_500_Count", "LoadBalancer", "${aws_lb.default.arn_suffix}"],
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "HTTPCode_ELB_500_Count"
          #Number of HTTP 500 error codes that originate from the load balancer
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_ELB_502_Count", "LoadBalancer", "${aws_lb.internal-default.arn_suffix}"],
            ["AWS/ApplicationELB", "HTTPCode_ELB_502_Count", "LoadBalancer", "${aws_lb.default.arn_suffix}"],
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "HTTPCode_ELB_502_Count"
          #Number of HTTP 502 error codes that originate from the load balancer
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/ApplicationELB",
              "HTTPCode_ELB_503_Count"
            ]
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "HTTPCode_ELB_503_Count"
          #Number of HTTP 502 error codes that originate from the load balancer
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_ELB_504_Count", "LoadBalancer", "${aws_lb.internal-default.arn_suffix}"],
            ["AWS/ApplicationELB", "HTTPCode_ELB_504_Count", "LoadBalancer", "${aws_lb.default.arn_suffix}"],
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "HTTPCode_ELB_504_Count"
          #Nnumber of HTTP 504 error codes that originate from the load balancer
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", "${aws_lb.internal-default.arn_suffix}"],
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", "${aws_lb.default.arn_suffix}"],
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "RequestCount"
          #Nnumber of HTTP 504 error codes that originate from the load balancer
        }
      }
    ]
  })
}

