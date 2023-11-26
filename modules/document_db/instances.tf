resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "docdb-cluster-demo-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.medium"

  tags = {
    Project = "chupito"
  }
}

# apply_immediately - (Optional) Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default isfalse.
# auto_minor_version_upgrade - (Optional) This parameter does not apply to Amazon DocumentDB. Amazon DocumentDB does not perform minor version upgrades regardless of the value set (see docs). Default true.
# cluster_identifier - (Required) The identifier of the aws_docdb_cluster in which to launch this instance.
# copy_tags_to_snapshot – (Optional, boolean) Copy all DB instance tags to snapshots. Default is false.
# enable_performance_insights - (Optional) A value that indicates whether to enable Performance Insights for the DB Instance. Default false. See docs about the details.
# engine - (Optional) The name of the database engine to be used for the DocumentDB instance. Defaults to docdb. Valid Values: docdb.
# identifier - (Optional, Forces new resource) The identifier for the DocumentDB instance, if omitted, Terraform will assign a random, unique identifier.
# identifier_prefix - (Optional, Forces new resource) Creates a unique identifier beginning with the specified prefix. Conflicts with identifier.
# performance_insights_kms_key_id - (Optional) The KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key. If you do not specify a value for PerformanceInsightsKMSKeyId, then Amazon DocumentDB uses your default KMS key.
# preferred_maintenance_window - (Optional) The window to perform maintenance in. Syntax: "ddd:hh24:mi-ddd:hh24:mi". Eg: "Mon:00:00-Mon:03:00".
# promotion_tier - (Optional) Default 0. Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoter to writer.