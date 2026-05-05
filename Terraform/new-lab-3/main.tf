 locals {                                                                                      
    full_queue_name = "${var.queue_name}-${var.environment}"
    dlq_name        = "${var.queue_name}-${var.environment}-dlq"                                
  }                                                                                             
                                                                                                
  # Dead Letter Queue - receives messages that fail processing                                  
  resource "aws_sqs_queue" "dlq" {                                
    count = var.enable_dlq ? 1 : 0                                                              
   
    name                      = local.dlq_name                                                  
    message_retention_seconds = 1209600  # 14 days max for DLQ    
                                                                                                
    sqs_managed_sse_enabled = true                                
                                                                                                
    tags = {                                                                                    
      Name        = local.dlq_name
      Environment = var.environment                                                             
      Purpose     = "dead-letter-queue"                           
    }                                                                                           
  }
                                                                                                
  # Main Queue                                                    
  resource "aws_sqs_queue" "this" {
    name                       = local.full_queue_name                                          
    message_retention_seconds  = var.message_retention_seconds
    visibility_timeout_seconds = var.visibility_timeout_seconds                                 
                                                                                                
    sqs_managed_sse_enabled = true                                                              
                                                                                                
    tags = {                                                                                    
      Name        = local.full_queue_name                         
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
                   
  resource "aws_sqs_queue_redrive_policy" "this" {
    count = var.enable_dlq ? 1 : 0                                                              
                                                                  
    queue_url = aws_sqs_queue.this.id
    redrive_policy = jsonencode({
      deadLetterTargetArn = aws_sqs_queue.dlq[0].arn                                            
      maxReceiveCount     = var.max_receive_count
    })                                                                                          
  }                        