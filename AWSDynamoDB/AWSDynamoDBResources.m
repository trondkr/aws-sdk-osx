//
// Copyright 2010-2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSDynamoDBResources.h"
#import "AWSBolts.h"
#import "AWSCocoaLumberjack.h"

@interface AWSDynamoDBResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSDynamoDBResources

+ (instancetype)sharedInstance {
    static AWSDynamoDBResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSDynamoDBResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSDDLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2012-08-10\",\
    \"endpointPrefix\":\"dynamodb\",\
    \"jsonVersion\":\"1.0\",\
    \"protocol\":\"json\",\
    \"serviceAbbreviation\":\"DynamoDB\",\
    \"serviceFullName\":\"Amazon DynamoDB\",\
    \"serviceId\":\"DynamoDB\",\
    \"signatureVersion\":\"v4\",\
    \"targetPrefix\":\"DynamoDB_20120810\",\
    \"uid\":\"dynamodb-2012-08-10\"\
  },\
  \"operations\":{\
    \"BatchGetItem\":{\
      \"name\":\"BatchGetItem\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"BatchGetItemInput\"},\
      \"output\":{\"shape\":\"BatchGetItemOutput\"},\
      \"errors\":[\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"RequestLimitExceeded\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>The <code>BatchGetItem</code> operation returns the attributes of one or more items from one or more tables. You identify requested items by primary key.</p> <p>A single operation can retrieve up to 16 MB of data, which can contain as many as 100 items. <code>BatchGetItem</code> will return a partial result if the response size limit is exceeded, the table's provisioned throughput is exceeded, or an internal processing failure occurs. If a partial result is returned, the operation returns a value for <code>UnprocessedKeys</code>. You can use this value to retry the operation starting with the next item to get.</p> <important> <p>If you request more than 100 items <code>BatchGetItem</code> will return a <code>ValidationException</code> with the message \\\"Too many items requested for the BatchGetItem call\\\".</p> </important> <p>For example, if you ask to retrieve 100 items, but each individual item is 300 KB in size, the system returns 52 items (so as not to exceed the 16 MB limit). It also returns an appropriate <code>UnprocessedKeys</code> value so you can get the next page of results. If desired, your application can include its own logic to assemble the pages of results into one data set.</p> <p>If <i>none</i> of the items can be processed due to insufficient provisioned throughput on all of the tables in the request, then <code>BatchGetItem</code> will return a <code>ProvisionedThroughputExceededException</code>. If <i>at least one</i> of the items is successfully processed, then <code>BatchGetItem</code> completes successfully, while returning the keys of the unread items in <code>UnprocessedKeys</code>.</p> <important> <p>If DynamoDB returns any unprocessed items, you should retry the batch operation on those items. However, <i>we strongly recommend that you use an exponential backoff algorithm</i>. If you retry the batch operation immediately, the underlying read or write requests can still fail due to throttling on the individual tables. If you delay the batch operation using exponential backoff, the individual requests in the batch are much more likely to succeed.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ErrorHandling.html#BatchOperations\\\">Batch Operations and Error Handling</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> </important> <p>By default, <code>BatchGetItem</code> performs eventually consistent reads on every table in the request. If you want strongly consistent reads instead, you can set <code>ConsistentRead</code> to <code>true</code> for any or all tables.</p> <p>In order to minimize response latency, <code>BatchGetItem</code> retrieves items in parallel.</p> <p>When designing your application, keep in mind that DynamoDB does not return items in any particular order. To help parse the response by item, include the primary key values for the items in your request in the <code>ProjectionExpression</code> parameter.</p> <p>If a requested item does not exist, it is not returned in the result. Requests for nonexistent items consume the minimum read capacity units according to the type of read. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#CapacityUnitCalculations\\\">Capacity Units Calculations</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"BatchWriteItem\":{\
      \"name\":\"BatchWriteItem\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"BatchWriteItemInput\"},\
      \"output\":{\"shape\":\"BatchWriteItemOutput\"},\
      \"errors\":[\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ItemCollectionSizeLimitExceededException\"},\
        {\"shape\":\"RequestLimitExceeded\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>The <code>BatchWriteItem</code> operation puts or deletes multiple items in one or more tables. A single call to <code>BatchWriteItem</code> can write up to 16 MB of data, which can comprise as many as 25 put or delete requests. Individual items to be written can be as large as 400 KB.</p> <note> <p> <code>BatchWriteItem</code> cannot update items. To update items, use the <code>UpdateItem</code> action.</p> </note> <p>The individual <code>PutItem</code> and <code>DeleteItem</code> operations specified in <code>BatchWriteItem</code> are atomic; however <code>BatchWriteItem</code> as a whole is not. If any requested operations fail because the table's provisioned throughput is exceeded or an internal processing failure occurs, the failed operations are returned in the <code>UnprocessedItems</code> response parameter. You can investigate and optionally resend the requests. Typically, you would call <code>BatchWriteItem</code> in a loop. Each iteration would check for unprocessed items and submit a new <code>BatchWriteItem</code> request with those unprocessed items until all items have been processed.</p> <p>Note that if <i>none</i> of the items can be processed due to insufficient provisioned throughput on all of the tables in the request, then <code>BatchWriteItem</code> will return a <code>ProvisionedThroughputExceededException</code>.</p> <important> <p>If DynamoDB returns any unprocessed items, you should retry the batch operation on those items. However, <i>we strongly recommend that you use an exponential backoff algorithm</i>. If you retry the batch operation immediately, the underlying read or write requests can still fail due to throttling on the individual tables. If you delay the batch operation using exponential backoff, the individual requests in the batch are much more likely to succeed.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ErrorHandling.html#BatchOperations\\\">Batch Operations and Error Handling</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> </important> <p>With <code>BatchWriteItem</code>, you can efficiently write or delete large amounts of data, such as from Amazon Elastic MapReduce (EMR), or copy data from another database into DynamoDB. In order to improve performance with these large-scale operations, <code>BatchWriteItem</code> does not behave in the same way as individual <code>PutItem</code> and <code>DeleteItem</code> calls would. For example, you cannot specify conditions on individual put and delete requests, and <code>BatchWriteItem</code> does not return deleted items in the response.</p> <p>If you use a programming language that supports concurrency, you can use threads to write items in parallel. Your application must include the necessary logic to manage the threads. With languages that don't support threading, you must update or delete the specified items one at a time. In both situations, <code>BatchWriteItem</code> performs the specified put and delete operations in parallel, giving you the power of the thread pool approach without having to introduce complexity into your application.</p> <p>Parallel processing reduces latency, but each specified put and delete request consumes the same number of write capacity units whether it is processed in parallel or not. Delete operations on nonexistent items consume one write capacity unit.</p> <p>If one or more of the following is true, DynamoDB rejects the entire batch write operation:</p> <ul> <li> <p>One or more tables specified in the <code>BatchWriteItem</code> request does not exist.</p> </li> <li> <p>Primary key attributes specified on an item in the request do not match those in the corresponding table's primary key schema.</p> </li> <li> <p>You try to perform multiple operations on the same item in the same <code>BatchWriteItem</code> request. For example, you cannot put and delete the same item in the same <code>BatchWriteItem</code> request. </p> </li> <li> <p> Your request contains at least two items with identical hash and range keys (which essentially is two put operations). </p> </li> <li> <p>There are more than 25 requests in the batch.</p> </li> <li> <p>Any individual item in a batch exceeds 400 KB.</p> </li> <li> <p>The total request size exceeds 16 MB.</p> </li> </ul>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"CreateBackup\":{\
      \"name\":\"CreateBackup\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateBackupInput\"},\
      \"output\":{\"shape\":\"CreateBackupOutput\"},\
      \"errors\":[\
        {\"shape\":\"TableNotFoundException\"},\
        {\"shape\":\"TableInUseException\"},\
        {\"shape\":\"ContinuousBackupsUnavailableException\"},\
        {\"shape\":\"BackupInUseException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Creates a backup for an existing table.</p> <p> Each time you create an On-Demand Backup, the entire table data is backed up. There is no limit to the number of on-demand backups that can be taken. </p> <p> When you create an On-Demand Backup, a time marker of the request is cataloged, and the backup is created asynchronously, by applying all changes until the time of the request to the last full table snapshot. Backup requests are processed instantaneously and become available for restore within minutes. </p> <p>You can call <code>CreateBackup</code> at a maximum rate of 50 times per second.</p> <p>All backups in DynamoDB work without consuming any provisioned throughput on the table.</p> <p> If you submit a backup request on 2018-12-14 at 14:25:00, the backup is guaranteed to contain all data committed to the table up to 14:24:00, and data committed after 14:26:00 will not be. The backup may or may not contain data modifications made between 14:24:00 and 14:26:00. On-Demand Backup does not support causal consistency. </p> <p> Along with data, the following are also included on the backups: </p> <ul> <li> <p>Global secondary indexes (GSIs)</p> </li> <li> <p>Local secondary indexes (LSIs)</p> </li> <li> <p>Streams</p> </li> <li> <p>Provisioned read and write capacity</p> </li> </ul>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"CreateGlobalTable\":{\
      \"name\":\"CreateGlobalTable\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateGlobalTableInput\"},\
      \"output\":{\"shape\":\"CreateGlobalTableOutput\"},\
      \"errors\":[\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalServerError\"},\
        {\"shape\":\"GlobalTableAlreadyExistsException\"},\
        {\"shape\":\"TableNotFoundException\"}\
      ],\
      \"documentation\":\"<p>Creates a global table from an existing table. A global table creates a replication relationship between two or more DynamoDB tables with the same table name in the provided regions. </p> <p>If you want to add a new replica table to a global table, each of the following conditions must be true:</p> <ul> <li> <p>The table must have the same primary key as all of the other replicas.</p> </li> <li> <p>The table must have the same name as all of the other replicas.</p> </li> <li> <p>The table must have DynamoDB Streams enabled, with the stream containing both the new and the old images of the item.</p> </li> <li> <p>None of the replica tables in the global table can contain any data.</p> </li> </ul> <p> If global secondary indexes are specified, then the following conditions must also be met: </p> <ul> <li> <p> The global secondary indexes must have the same name. </p> </li> <li> <p> The global secondary indexes must have the same hash key and sort key (if present). </p> </li> </ul> <important> <p> Write capacity settings should be set consistently across your replica tables and secondary indexes. DynamoDB strongly recommends enabling auto scaling to manage the write capacity settings for all of your global tables replicas and indexes. </p> <p> If you prefer to manage write capacity settings manually, you should provision equal replicated write capacity units to your replica tables. You should also provision equal replicated write capacity units to matching secondary indexes across your global table. </p> </important>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"CreateTable\":{\
      \"name\":\"CreateTable\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateTableInput\"},\
      \"output\":{\"shape\":\"CreateTableOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>The <code>CreateTable</code> operation adds a new table to your account. In an AWS account, table names must be unique within each region. That is, you can have two tables with same name if you create the tables in different regions.</p> <p> <code>CreateTable</code> is an asynchronous operation. Upon receiving a <code>CreateTable</code> request, DynamoDB immediately returns a response with a <code>TableStatus</code> of <code>CREATING</code>. After the table is created, DynamoDB sets the <code>TableStatus</code> to <code>ACTIVE</code>. You can perform read and write operations only on an <code>ACTIVE</code> table. </p> <p>You can optionally define secondary indexes on the new table, as part of the <code>CreateTable</code> operation. If you want to create multiple tables with secondary indexes on them, you must create the tables sequentially. Only one table with secondary indexes can be in the <code>CREATING</code> state at any given time.</p> <p>You can use the <code>DescribeTable</code> action to check the table status.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"DeleteBackup\":{\
      \"name\":\"DeleteBackup\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteBackupInput\"},\
      \"output\":{\"shape\":\"DeleteBackupOutput\"},\
      \"errors\":[\
        {\"shape\":\"BackupNotFoundException\"},\
        {\"shape\":\"BackupInUseException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Deletes an existing backup of a table.</p> <p>You can call <code>DeleteBackup</code> at a maximum rate of 10 times per second.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"DeleteItem\":{\
      \"name\":\"DeleteItem\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteItemInput\"},\
      \"output\":{\"shape\":\"DeleteItemOutput\"},\
      \"errors\":[\
        {\"shape\":\"ConditionalCheckFailedException\"},\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ItemCollectionSizeLimitExceededException\"},\
        {\"shape\":\"TransactionConflictException\"},\
        {\"shape\":\"RequestLimitExceeded\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Deletes a single item in a table by primary key. You can perform a conditional delete operation that deletes the item if it exists, or if it has an expected attribute value.</p> <p>In addition to deleting an item, you can also return the item's attribute values in the same operation, using the <code>ReturnValues</code> parameter.</p> <p>Unless you specify conditions, the <code>DeleteItem</code> is an idempotent operation; running it multiple times on the same item or attribute does <i>not</i> result in an error response.</p> <p>Conditional deletes are useful for deleting items only if specific conditions are met. If those conditions are met, DynamoDB performs the delete. Otherwise, the item is not deleted.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"DeleteTable\":{\
      \"name\":\"DeleteTable\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteTableInput\"},\
      \"output\":{\"shape\":\"DeleteTableOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>The <code>DeleteTable</code> operation deletes a table and all of its items. After a <code>DeleteTable</code> request, the specified table is in the <code>DELETING</code> state until DynamoDB completes the deletion. If the table is in the <code>ACTIVE</code> state, you can delete it. If a table is in <code>CREATING</code> or <code>UPDATING</code> states, then DynamoDB returns a <code>ResourceInUseException</code>. If the specified table does not exist, DynamoDB returns a <code>ResourceNotFoundException</code>. If table is already in the <code>DELETING</code> state, no error is returned. </p> <note> <p>DynamoDB might continue to accept data read and write operations, such as <code>GetItem</code> and <code>PutItem</code>, on a table in the <code>DELETING</code> state until the table deletion is complete.</p> </note> <p>When you delete a table, any indexes on that table are also deleted.</p> <p>If you have DynamoDB Streams enabled on the table, then the corresponding stream on that table goes into the <code>DISABLED</code> state, and the stream is automatically deleted after 24 hours.</p> <p>Use the <code>DescribeTable</code> action to check the status of the table. </p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"DescribeBackup\":{\
      \"name\":\"DescribeBackup\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeBackupInput\"},\
      \"output\":{\"shape\":\"DescribeBackupOutput\"},\
      \"errors\":[\
        {\"shape\":\"BackupNotFoundException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Describes an existing backup of a table.</p> <p>You can call <code>DescribeBackup</code> at a maximum rate of 10 times per second.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"DescribeContinuousBackups\":{\
      \"name\":\"DescribeContinuousBackups\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeContinuousBackupsInput\"},\
      \"output\":{\"shape\":\"DescribeContinuousBackupsOutput\"},\
      \"errors\":[\
        {\"shape\":\"TableNotFoundException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Checks the status of continuous backups and point in time recovery on the specified table. Continuous backups are <code>ENABLED</code> on all tables at table creation. If point in time recovery is enabled, <code>PointInTimeRecoveryStatus</code> will be set to ENABLED.</p> <p> Once continuous backups and point in time recovery are enabled, you can restore to any point in time within <code>EarliestRestorableDateTime</code> and <code>LatestRestorableDateTime</code>. </p> <p> <code>LatestRestorableDateTime</code> is typically 5 minutes before the current time. You can restore your table to any point in time during the last 35 days. </p> <p>You can call <code>DescribeContinuousBackups</code> at a maximum rate of 10 times per second.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"DescribeEndpoints\":{\
      \"name\":\"DescribeEndpoints\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeEndpointsRequest\"},\
      \"output\":{\"shape\":\"DescribeEndpointsResponse\"},\
      \"documentation\":\"<p>Returns the regional endpoint information.</p>\",\
      \"endpointoperation\":true\
    },\
    \"DescribeGlobalTable\":{\
      \"name\":\"DescribeGlobalTable\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeGlobalTableInput\"},\
      \"output\":{\"shape\":\"DescribeGlobalTableOutput\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerError\"},\
        {\"shape\":\"GlobalTableNotFoundException\"}\
      ],\
      \"documentation\":\"<p>Returns information about the specified global table.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"DescribeGlobalTableSettings\":{\
      \"name\":\"DescribeGlobalTableSettings\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeGlobalTableSettingsInput\"},\
      \"output\":{\"shape\":\"DescribeGlobalTableSettingsOutput\"},\
      \"errors\":[\
        {\"shape\":\"GlobalTableNotFoundException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Describes region specific settings for a global table.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"DescribeLimits\":{\
      \"name\":\"DescribeLimits\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeLimitsInput\"},\
      \"output\":{\"shape\":\"DescribeLimitsOutput\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Returns the current provisioned-capacity limits for your AWS account in a region, both for the region as a whole and for any one DynamoDB table that you create there.</p> <p>When you establish an AWS account, the account has initial limits on the maximum read capacity units and write capacity units that you can provision across all of your DynamoDB tables in a given region. Also, there are per-table limits that apply when you create a table there. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html\\\">Limits</a> page in the <i>Amazon DynamoDB Developer Guide</i>.</p> <p>Although you can increase these limits by filing a case at <a href=\\\"https://console.aws.amazon.com/support/home#/\\\">AWS Support Center</a>, obtaining the increase is not instantaneous. The <code>DescribeLimits</code> action lets you write code to compare the capacity you are currently using to those limits imposed by your account so that you have enough time to apply for an increase before you hit a limit.</p> <p>For example, you could use one of the AWS SDKs to do the following:</p> <ol> <li> <p>Call <code>DescribeLimits</code> for a particular region to obtain your current account limits on provisioned capacity there.</p> </li> <li> <p>Create a variable to hold the aggregate read capacity units provisioned for all your tables in that region, and one to hold the aggregate write capacity units. Zero them both.</p> </li> <li> <p>Call <code>ListTables</code> to obtain a list of all your DynamoDB tables.</p> </li> <li> <p>For each table name listed by <code>ListTables</code>, do the following:</p> <ul> <li> <p>Call <code>DescribeTable</code> with the table name.</p> </li> <li> <p>Use the data returned by <code>DescribeTable</code> to add the read capacity units and write capacity units provisioned for the table itself to your variables.</p> </li> <li> <p>If the table has one or more global secondary indexes (GSIs), loop over these GSIs and add their provisioned capacity values to your variables as well.</p> </li> </ul> </li> <li> <p>Report the account limits for that region returned by <code>DescribeLimits</code>, along with the total current provisioned capacity levels you have calculated.</p> </li> </ol> <p>This will let you see whether you are getting close to your account-level limits.</p> <p>The per-table limits apply only when you are creating a new table. They restrict the sum of the provisioned capacity of the new table itself and all its global secondary indexes.</p> <p>For existing tables and their GSIs, DynamoDB will not let you increase provisioned capacity extremely rapidly, but the only upper limit that applies is that the aggregate provisioned capacity over all your tables and GSIs cannot exceed either of the per-account limits.</p> <note> <p> <code>DescribeLimits</code> should only be called periodically. You can expect throttling errors if you call it more than once in a minute.</p> </note> <p>The <code>DescribeLimits</code> Request element has no content.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"DescribeTable\":{\
      \"name\":\"DescribeTable\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeTableInput\"},\
      \"output\":{\"shape\":\"DescribeTableOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Returns information about the table, including the current status of the table, when it was created, the primary key schema, and any indexes on the table.</p> <note> <p>If you issue a <code>DescribeTable</code> request immediately after a <code>CreateTable</code> request, DynamoDB might return a <code>ResourceNotFoundException</code>. This is because <code>DescribeTable</code> uses an eventually consistent query, and the metadata for your table might not be available at that moment. Wait for a few seconds, and then try the <code>DescribeTable</code> request again.</p> </note>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"DescribeTimeToLive\":{\
      \"name\":\"DescribeTimeToLive\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeTimeToLiveInput\"},\
      \"output\":{\"shape\":\"DescribeTimeToLiveOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Gives a description of the Time to Live (TTL) status on the specified table. </p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"GetItem\":{\
      \"name\":\"GetItem\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetItemInput\"},\
      \"output\":{\"shape\":\"GetItemOutput\"},\
      \"errors\":[\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"RequestLimitExceeded\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>The <code>GetItem</code> operation returns a set of attributes for the item with the given primary key. If there is no matching item, <code>GetItem</code> does not return any data and there will be no <code>Item</code> element in the response.</p> <p> <code>GetItem</code> provides an eventually consistent read by default. If your application requires a strongly consistent read, set <code>ConsistentRead</code> to <code>true</code>. Although a strongly consistent read might take more time than an eventually consistent read, it always returns the last updated value.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"ListBackups\":{\
      \"name\":\"ListBackups\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListBackupsInput\"},\
      \"output\":{\"shape\":\"ListBackupsOutput\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>List backups associated with an AWS account. To list backups for a given table, specify <code>TableName</code>. <code>ListBackups</code> returns a paginated list of results with at most 1MB worth of items in a page. You can also specify a limit for the maximum number of entries to be returned in a page. </p> <p>In the request, start time is inclusive but end time is exclusive. Note that these limits are for the time at which the original backup was requested.</p> <p>You can call <code>ListBackups</code> a maximum of 5 times per second.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"ListGlobalTables\":{\
      \"name\":\"ListGlobalTables\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListGlobalTablesInput\"},\
      \"output\":{\"shape\":\"ListGlobalTablesOutput\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Lists all global tables that have a replica in the specified region.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"ListTables\":{\
      \"name\":\"ListTables\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListTablesInput\"},\
      \"output\":{\"shape\":\"ListTablesOutput\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Returns an array of table names associated with the current account and endpoint. The output from <code>ListTables</code> is paginated, with each page returning a maximum of 100 table names.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"ListTagsOfResource\":{\
      \"name\":\"ListTagsOfResource\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListTagsOfResourceInput\"},\
      \"output\":{\"shape\":\"ListTagsOfResourceOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>List all tags on an Amazon DynamoDB resource. You can call ListTagsOfResource up to 10 times per second, per account.</p> <p>For an overview on tagging DynamoDB resources, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tagging.html\\\">Tagging for DynamoDB</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"PutItem\":{\
      \"name\":\"PutItem\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutItemInput\"},\
      \"output\":{\"shape\":\"PutItemOutput\"},\
      \"errors\":[\
        {\"shape\":\"ConditionalCheckFailedException\"},\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ItemCollectionSizeLimitExceededException\"},\
        {\"shape\":\"TransactionConflictException\"},\
        {\"shape\":\"RequestLimitExceeded\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Creates a new item, or replaces an old item with a new item. If an item that has the same primary key as the new item already exists in the specified table, the new item completely replaces the existing item. You can perform a conditional put operation (add a new item if one with the specified primary key doesn't exist), or replace an existing item if it has certain attribute values. You can return the item's attribute values in the same operation, using the <code>ReturnValues</code> parameter.</p> <important> <p>This topic provides general information about the <code>PutItem</code> API.</p> <p>For information on how to call the <code>PutItem</code> API using the AWS SDK in specific languages, see the following:</p> <ul> <li> <p> <a href=\\\"http://docs.aws.amazon.com/goto/aws-cli/dynamodb-2012-08-10/PutItem\\\"> PutItem in the AWS Command Line Interface </a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/goto/DotNetSDKV3/dynamodb-2012-08-10/PutItem\\\"> PutItem in the AWS SDK for .NET </a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/goto/SdkForCpp/dynamodb-2012-08-10/PutItem\\\"> PutItem in the AWS SDK for C++ </a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/goto/SdkForGoV1/dynamodb-2012-08-10/PutItem\\\"> PutItem in the AWS SDK for Go </a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/goto/SdkForJava/dynamodb-2012-08-10/PutItem\\\"> PutItem in the AWS SDK for Java </a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/goto/AWSJavaScriptSDK/dynamodb-2012-08-10/PutItem\\\"> PutItem in the AWS SDK for JavaScript </a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/goto/SdkForPHPV3/dynamodb-2012-08-10/PutItem\\\"> PutItem in the AWS SDK for PHP V3 </a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/goto/boto3/dynamodb-2012-08-10/PutItem\\\"> PutItem in the AWS SDK for Python </a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/goto/SdkForRubyV2/dynamodb-2012-08-10/PutItem\\\"> PutItem in the AWS SDK for Ruby V2 </a> </p> </li> </ul> </important> <p>When you add an item, the primary key attribute(s) are the only required attributes. Attribute values cannot be null. String and Binary type attributes must have lengths greater than zero. Set type attributes cannot be empty. Requests with empty values will be rejected with a <code>ValidationException</code> exception.</p> <note> <p>To prevent a new item from replacing an existing item, use a conditional expression that contains the <code>attribute_not_exists</code> function with the name of the attribute being used as the partition key for the table. Since every record must contain that attribute, the <code>attribute_not_exists</code> function will only succeed if no matching item exists.</p> </note> <p>For more information about <code>PutItem</code>, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithItems.html\\\">Working with Items</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"Query\":{\
      \"name\":\"Query\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"QueryInput\"},\
      \"output\":{\"shape\":\"QueryOutput\"},\
      \"errors\":[\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"RequestLimitExceeded\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>The <code>Query</code> operation finds items based on primary key values. You can query any table or secondary index that has a composite primary key (a partition key and a sort key). </p> <p>Use the <code>KeyConditionExpression</code> parameter to provide a specific value for the partition key. The <code>Query</code> operation will return all of the items from the table or index with that partition key value. You can optionally narrow the scope of the <code>Query</code> operation by specifying a sort key value and a comparison operator in <code>KeyConditionExpression</code>. To further refine the <code>Query</code> results, you can optionally provide a <code>FilterExpression</code>. A <code>FilterExpression</code> determines which items within the results should be returned to you. All of the other results are discarded. </p> <p> A <code>Query</code> operation always returns a result set. If no matching items are found, the result set will be empty. Queries that do not return results consume the minimum number of read capacity units for that type of read operation. </p> <note> <p> DynamoDB calculates the number of read capacity units consumed based on item size, not on the amount of data that is returned to an application. The number of capacity units consumed will be the same whether you request all of the attributes (the default behavior) or just some of them (using a projection expression). The number will also be the same whether or not you use a <code>FilterExpression</code>. </p> </note> <p> <code>Query</code> results are always sorted by the sort key value. If the data type of the sort key is Number, the results are returned in numeric order; otherwise, the results are returned in order of UTF-8 bytes. By default, the sort order is ascending. To reverse the order, set the <code>ScanIndexForward</code> parameter to false. </p> <p> A single <code>Query</code> operation will read up to the maximum number of items set (if using the <code>Limit</code> parameter) or a maximum of 1 MB of data and then apply any filtering to the results using <code>FilterExpression</code>. If <code>LastEvaluatedKey</code> is present in the response, you will need to paginate the result set. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html#Query.Pagination\\\">Paginating the Results</a> in the <i>Amazon DynamoDB Developer Guide</i>. </p> <p> <code>FilterExpression</code> is applied after a <code>Query</code> finishes, but before the results are returned. A <code>FilterExpression</code> cannot contain partition key or sort key attributes. You need to specify those attributes in the <code>KeyConditionExpression</code>. </p> <note> <p> A <code>Query</code> operation can return an empty result set and a <code>LastEvaluatedKey</code> if all the items read for the page of results are filtered out. </p> </note> <p>You can query a table, a local secondary index, or a global secondary index. For a query on a table or on a local secondary index, you can set the <code>ConsistentRead</code> parameter to <code>true</code> and obtain a strongly consistent result. Global secondary indexes support eventually consistent reads only, so do not specify <code>ConsistentRead</code> when querying a global secondary index.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"RestoreTableFromBackup\":{\
      \"name\":\"RestoreTableFromBackup\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"RestoreTableFromBackupInput\"},\
      \"output\":{\"shape\":\"RestoreTableFromBackupOutput\"},\
      \"errors\":[\
        {\"shape\":\"TableAlreadyExistsException\"},\
        {\"shape\":\"TableInUseException\"},\
        {\"shape\":\"BackupNotFoundException\"},\
        {\"shape\":\"BackupInUseException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Creates a new table from an existing backup. Any number of users can execute up to 4 concurrent restores (any type of restore) in a given account. </p> <p>You can call <code>RestoreTableFromBackup</code> at a maximum rate of 10 times per second.</p> <p>You must manually set up the following on the restored table:</p> <ul> <li> <p>Auto scaling policies</p> </li> <li> <p>IAM policies</p> </li> <li> <p>Cloudwatch metrics and alarms</p> </li> <li> <p>Tags</p> </li> <li> <p>Stream settings</p> </li> <li> <p>Time to Live (TTL) settings</p> </li> </ul>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"RestoreTableToPointInTime\":{\
      \"name\":\"RestoreTableToPointInTime\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"RestoreTableToPointInTimeInput\"},\
      \"output\":{\"shape\":\"RestoreTableToPointInTimeOutput\"},\
      \"errors\":[\
        {\"shape\":\"TableAlreadyExistsException\"},\
        {\"shape\":\"TableNotFoundException\"},\
        {\"shape\":\"TableInUseException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InvalidRestoreTimeException\"},\
        {\"shape\":\"PointInTimeRecoveryUnavailableException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Restores the specified table to the specified point in time within <code>EarliestRestorableDateTime</code> and <code>LatestRestorableDateTime</code>. You can restore your table to any point in time during the last 35 days. Any number of users can execute up to 4 concurrent restores (any type of restore) in a given account. </p> <p> When you restore using point in time recovery, DynamoDB restores your table data to the state based on the selected date and time (day:hour:minute:second) to a new table. </p> <p> Along with data, the following are also included on the new restored table using point in time recovery: </p> <ul> <li> <p>Global secondary indexes (GSIs)</p> </li> <li> <p>Local secondary indexes (LSIs)</p> </li> <li> <p>Provisioned read and write capacity</p> </li> <li> <p>Encryption settings</p> <important> <p> All these settings come from the current settings of the source table at the time of restore. </p> </important> </li> </ul> <p>You must manually set up the following on the restored table:</p> <ul> <li> <p>Auto scaling policies</p> </li> <li> <p>IAM policies</p> </li> <li> <p>Cloudwatch metrics and alarms</p> </li> <li> <p>Tags</p> </li> <li> <p>Stream settings</p> </li> <li> <p>Time to Live (TTL) settings</p> </li> <li> <p>Point in time recovery settings</p> </li> </ul>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"Scan\":{\
      \"name\":\"Scan\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ScanInput\"},\
      \"output\":{\"shape\":\"ScanOutput\"},\
      \"errors\":[\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"RequestLimitExceeded\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>The <code>Scan</code> operation returns one or more items and item attributes by accessing every item in a table or a secondary index. To have DynamoDB return fewer items, you can provide a <code>FilterExpression</code> operation.</p> <p>If the total number of scanned items exceeds the maximum data set size limit of 1 MB, the scan stops and results are returned to the user as a <code>LastEvaluatedKey</code> value to continue the scan in a subsequent operation. The results also include the number of items exceeding the limit. A scan can result in no table data meeting the filter criteria. </p> <p>A single <code>Scan</code> operation will read up to the maximum number of items set (if using the <code>Limit</code> parameter) or a maximum of 1 MB of data and then apply any filtering to the results using <code>FilterExpression</code>. If <code>LastEvaluatedKey</code> is present in the response, you will need to paginate the result set. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Scan.html#Scan.Pagination\\\">Paginating the Results</a> in the <i>Amazon DynamoDB Developer Guide</i>. </p> <p> <code>Scan</code> operations proceed sequentially; however, for faster performance on a large table or secondary index, applications can request a parallel <code>Scan</code> operation by providing the <code>Segment</code> and <code>TotalSegments</code> parameters. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Scan.html#Scan.ParallelScan\\\">Parallel Scan</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> <p> <code>Scan</code> uses eventually consistent reads when accessing the data in a table; therefore, the result set might not include the changes to data in the table immediately before the operation began. If you need a consistent copy of the data, as of the time that the <code>Scan</code> begins, you can set the <code>ConsistentRead</code> parameter to <code>true</code>.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"TagResource\":{\
      \"name\":\"TagResource\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"TagResourceInput\"},\
      \"errors\":[\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InternalServerError\"},\
        {\"shape\":\"ResourceInUseException\"}\
      ],\
      \"documentation\":\"<p>Associate a set of tags with an Amazon DynamoDB resource. You can then activate these user-defined tags so that they appear on the Billing and Cost Management console for cost allocation tracking. You can call TagResource up to 5 times per second, per account. </p> <p>For an overview on tagging DynamoDB resources, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tagging.html\\\">Tagging for DynamoDB</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"TransactGetItems\":{\
      \"name\":\"TransactGetItems\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"TransactGetItemsInput\"},\
      \"output\":{\"shape\":\"TransactGetItemsOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"TransactionCanceledException\"},\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p> <code>TransactGetItems</code> is a synchronous operation that atomically retrieves multiple items from one or more tables (but not from indexes) in a single account and region. A <code>TransactGetItems</code> call can contain up to 10 <code>TransactGetItem</code> objects, each of which contains a <code>Get</code> structure that specifies an item to retrieve from a table in the account and region. A call to <code>TransactGetItems</code> cannot retrieve items from tables in more than one AWS account or region.</p> <p>DynamoDB rejects the entire <code>TransactGetItems</code> request if any of the following is true:</p> <ul> <li> <p>A conflicting operation is in the process of updating an item to be read.</p> </li> <li> <p>There is insufficient provisioned capacity for the transaction to be completed.</p> </li> <li> <p>There is a user error, such as an invalid data format.</p> </li> </ul>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"TransactWriteItems\":{\
      \"name\":\"TransactWriteItems\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"TransactWriteItemsInput\"},\
      \"output\":{\"shape\":\"TransactWriteItemsOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"TransactionCanceledException\"},\
        {\"shape\":\"TransactionInProgressException\"},\
        {\"shape\":\"IdempotentParameterMismatchException\"},\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p> <code>TransactWriteItems</code> is a synchronous write operation that groups up to 10 action requests. These actions can target items in different tables, but not in different AWS accounts or regions, and no two actions can target the same item. For example, you cannot both <code>ConditionCheck</code> and <code>Update</code> the same item.</p> <p>The actions are completed atomically so that either all of them succeed, or all of them fail. They are defined by the following objects:</p> <ul> <li> <p> <code>Put</code> Â &#x97; Â  Initiates a <code>PutItem</code> operation to write a new item. This structure specifies the primary key of the item to be written, the name of the table to write it in, an optional condition expression that must be satisfied for the write to succeed, a list of the item's attributes, and a field indicating whether or not to retrieve the item's attributes if the condition is not met.</p> </li> <li> <p> <code>Update</code> Â &#x97; Â  Initiates an <code>UpdateItem</code> operation to update an existing item. This structure specifies the primary key of the item to be updated, the name of the table where it resides, an optional condition expression that must be satisfied for the update to succeed, an expression that defines one or more attributes to be updated, and a field indicating whether or not to retrieve the item's attributes if the condition is not met.</p> </li> <li> <p> <code>Delete</code> Â &#x97; Â  Initiates a <code>DeleteItem</code> operation to delete an existing item. This structure specifies the primary key of the item to be deleted, the name of the table where it resides, an optional condition expression that must be satisfied for the deletion to succeed, and a field indicating whether or not to retrieve the item's attributes if the condition is not met.</p> </li> <li> <p> <code>ConditionCheck</code> Â &#x97; Â  Applies a condition to an item that is not being modified by the transaction. This structure specifies the primary key of the item to be checked, the name of the table where it resides, a condition expression that must be satisfied for the transaction to succeed, and a field indicating whether or not to retrieve the item's attributes if the condition is not met.</p> </li> </ul> <p>DynamoDB rejects the entire <code>TransactWriteItems</code> request if any of the following is true:</p> <ul> <li> <p>A condition in one of the condition expressions is not met.</p> </li> <li> <p>A conflicting operation is in the process of updating the same item.</p> </li> <li> <p>There is insufficient provisioned capacity for the transaction to be completed.</p> </li> <li> <p>An item size becomes too large (bigger than 400 KB), a Local Secondary Index (LSI) becomes too large, or a similar validation error occurs because of changes made by the transaction.</p> </li> <li> <p>There is a user error, such as an invalid data format.</p> </li> </ul>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"UntagResource\":{\
      \"name\":\"UntagResource\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UntagResourceInput\"},\
      \"errors\":[\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InternalServerError\"},\
        {\"shape\":\"ResourceInUseException\"}\
      ],\
      \"documentation\":\"<p>Removes the association of tags from an Amazon DynamoDB resource. You can call UntagResource up to 5 times per second, per account. </p> <p>For an overview on tagging DynamoDB resources, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tagging.html\\\">Tagging for DynamoDB</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"UpdateContinuousBackups\":{\
      \"name\":\"UpdateContinuousBackups\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateContinuousBackupsInput\"},\
      \"output\":{\"shape\":\"UpdateContinuousBackupsOutput\"},\
      \"errors\":[\
        {\"shape\":\"TableNotFoundException\"},\
        {\"shape\":\"ContinuousBackupsUnavailableException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p> <code>UpdateContinuousBackups</code> enables or disables point in time recovery for the specified table. A successful <code>UpdateContinuousBackups</code> call returns the current <code>ContinuousBackupsDescription</code>. Continuous backups are <code>ENABLED</code> on all tables at table creation. If point in time recovery is enabled, <code>PointInTimeRecoveryStatus</code> will be set to ENABLED.</p> <p> Once continuous backups and point in time recovery are enabled, you can restore to any point in time within <code>EarliestRestorableDateTime</code> and <code>LatestRestorableDateTime</code>. </p> <p> <code>LatestRestorableDateTime</code> is typically 5 minutes before the current time. You can restore your table to any point in time during the last 35 days.. </p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"UpdateGlobalTable\":{\
      \"name\":\"UpdateGlobalTable\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateGlobalTableInput\"},\
      \"output\":{\"shape\":\"UpdateGlobalTableOutput\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerError\"},\
        {\"shape\":\"GlobalTableNotFoundException\"},\
        {\"shape\":\"ReplicaAlreadyExistsException\"},\
        {\"shape\":\"ReplicaNotFoundException\"},\
        {\"shape\":\"TableNotFoundException\"}\
      ],\
      \"documentation\":\"<p>Adds or removes replicas in the specified global table. The global table must already exist to be able to use this operation. Any replica to be added must be empty, must have the same name as the global table, must have the same key schema, and must have DynamoDB Streams enabled and must have same provisioned and maximum write capacity units.</p> <note> <p>Although you can use <code>UpdateGlobalTable</code> to add replicas and remove replicas in a single request, for simplicity we recommend that you issue separate requests for adding or removing replicas.</p> </note> <p> If global secondary indexes are specified, then the following conditions must also be met: </p> <ul> <li> <p> The global secondary indexes must have the same name. </p> </li> <li> <p> The global secondary indexes must have the same hash key and sort key (if present). </p> </li> <li> <p> The global secondary indexes must have the same provisioned and maximum write capacity units. </p> </li> </ul>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"UpdateGlobalTableSettings\":{\
      \"name\":\"UpdateGlobalTableSettings\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateGlobalTableSettingsInput\"},\
      \"output\":{\"shape\":\"UpdateGlobalTableSettingsOutput\"},\
      \"errors\":[\
        {\"shape\":\"GlobalTableNotFoundException\"},\
        {\"shape\":\"ReplicaNotFoundException\"},\
        {\"shape\":\"IndexNotFoundException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Updates settings for a global table.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"UpdateItem\":{\
      \"name\":\"UpdateItem\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateItemInput\"},\
      \"output\":{\"shape\":\"UpdateItemOutput\"},\
      \"errors\":[\
        {\"shape\":\"ConditionalCheckFailedException\"},\
        {\"shape\":\"ProvisionedThroughputExceededException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ItemCollectionSizeLimitExceededException\"},\
        {\"shape\":\"TransactionConflictException\"},\
        {\"shape\":\"RequestLimitExceeded\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Edits an existing item's attributes, or adds a new item to the table if it does not already exist. You can put, delete, or add attribute values. You can also perform a conditional update on an existing item (insert a new attribute name-value pair if it doesn't exist, or replace an existing name-value pair if it has certain expected attribute values).</p> <p>You can also return the item's attribute values in the same <code>UpdateItem</code> operation using the <code>ReturnValues</code> parameter.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"UpdateTable\":{\
      \"name\":\"UpdateTable\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateTableInput\"},\
      \"output\":{\"shape\":\"UpdateTableOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>Modifies the provisioned throughput settings, global secondary indexes, or DynamoDB Streams settings for a given table.</p> <p>You can only perform one of the following operations at once:</p> <ul> <li> <p>Modify the provisioned throughput settings of the table.</p> </li> <li> <p>Enable or disable Streams on the table.</p> </li> <li> <p>Remove a global secondary index from the table.</p> </li> <li> <p>Create a new global secondary index on the table. Once the index begins backfilling, you can use <code>UpdateTable</code> to perform other operations.</p> </li> </ul> <p> <code>UpdateTable</code> is an asynchronous operation; while it is executing, the table status changes from <code>ACTIVE</code> to <code>UPDATING</code>. While it is <code>UPDATING</code>, you cannot issue another <code>UpdateTable</code> request. When the table returns to the <code>ACTIVE</code> state, the <code>UpdateTable</code> operation is complete.</p>\",\
      \"endpointdiscovery\":{\
      }\
    },\
    \"UpdateTimeToLive\":{\
      \"name\":\"UpdateTimeToLive\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateTimeToLiveInput\"},\
      \"output\":{\"shape\":\"UpdateTimeToLiveOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalServerError\"}\
      ],\
      \"documentation\":\"<p>The UpdateTimeToLive method will enable or disable TTL for the specified table. A successful <code>UpdateTimeToLive</code> call returns the current <code>TimeToLiveSpecification</code>; it may take up to one hour for the change to fully process. Any additional <code>UpdateTimeToLive</code> calls for the same table during this one hour duration result in a <code>ValidationException</code>. </p> <p>TTL compares the current time in epoch time format to the time stored in the TTL attribute of an item. If the epoch time value stored in the attribute is less than the current time, the item is marked as expired and subsequently deleted.</p> <note> <p> The epoch time format is the number of seconds elapsed since 12:00:00 AM January 1st, 1970 UTC. </p> </note> <p>DynamoDB deletes expired items on a best-effort basis to ensure availability of throughput for other data operations. </p> <important> <p>DynamoDB typically deletes expired items within two days of expiration. The exact duration within which an item gets deleted after expiration is specific to the nature of the workload. Items that have expired and not been deleted will still show up in reads, queries, and scans.</p> </important> <p>As items are deleted, they are removed from any Local Secondary Index and Global Secondary Index immediately in the same eventually consistent way as a standard delete operation.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/TTL.html\\\">Time To Live</a> in the Amazon DynamoDB Developer Guide. </p>\",\
      \"endpointdiscovery\":{\
      }\
    }\
  },\
  \"shapes\":{\
    \"AttributeAction\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ADD\",\
        \"PUT\",\
        \"DELETE\"\
      ]\
    },\
    \"AttributeDefinition\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AttributeName\",\
        \"AttributeType\"\
      ],\
      \"members\":{\
        \"AttributeName\":{\
          \"shape\":\"KeySchemaAttributeName\",\
          \"documentation\":\"<p>A name for the attribute.</p>\"\
        },\
        \"AttributeType\":{\
          \"shape\":\"ScalarAttributeType\",\
          \"documentation\":\"<p>The data type for the attribute, where:</p> <ul> <li> <p> <code>S</code> - the attribute is of type String</p> </li> <li> <p> <code>N</code> - the attribute is of type Number</p> </li> <li> <p> <code>B</code> - the attribute is of type Binary</p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Represents an attribute for describing the key schema for the table and indexes.</p>\"\
    },\
    \"AttributeDefinitions\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AttributeDefinition\"}\
    },\
    \"AttributeMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"AttributeName\"},\
      \"value\":{\"shape\":\"AttributeValue\"}\
    },\
    \"AttributeName\":{\
      \"type\":\"string\",\
      \"max\":65535\
    },\
    \"AttributeNameList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AttributeName\"},\
      \"min\":1\
    },\
    \"AttributeUpdates\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"AttributeName\"},\
      \"value\":{\"shape\":\"AttributeValueUpdate\"}\
    },\
    \"AttributeValue\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"S\":{\
          \"shape\":\"StringAttributeValue\",\
          \"documentation\":\"<p>An attribute of type String. For example:</p> <p> <code>\\\"S\\\": \\\"Hello\\\"</code> </p>\"\
        },\
        \"N\":{\
          \"shape\":\"NumberAttributeValue\",\
          \"documentation\":\"<p>An attribute of type Number. For example:</p> <p> <code>\\\"N\\\": \\\"123.45\\\"</code> </p> <p>Numbers are sent across the network to DynamoDB as strings, to maximize compatibility across languages and libraries. However, DynamoDB treats them as number type attributes for mathematical operations.</p>\"\
        },\
        \"B\":{\
          \"shape\":\"BinaryAttributeValue\",\
          \"documentation\":\"<p>An attribute of type Binary. For example:</p> <p> <code>\\\"B\\\": \\\"dGhpcyB0ZXh0IGlzIGJhc2U2NC1lbmNvZGVk\\\"</code> </p>\"\
        },\
        \"SS\":{\
          \"shape\":\"StringSetAttributeValue\",\
          \"documentation\":\"<p>An attribute of type String Set. For example:</p> <p> <code>\\\"SS\\\": [\\\"Giraffe\\\", \\\"Hippo\\\" ,\\\"Zebra\\\"]</code> </p>\"\
        },\
        \"NS\":{\
          \"shape\":\"NumberSetAttributeValue\",\
          \"documentation\":\"<p>An attribute of type Number Set. For example:</p> <p> <code>\\\"NS\\\": [\\\"42.2\\\", \\\"-19\\\", \\\"7.5\\\", \\\"3.14\\\"]</code> </p> <p>Numbers are sent across the network to DynamoDB as strings, to maximize compatibility across languages and libraries. However, DynamoDB treats them as number type attributes for mathematical operations.</p>\"\
        },\
        \"BS\":{\
          \"shape\":\"BinarySetAttributeValue\",\
          \"documentation\":\"<p>An attribute of type Binary Set. For example:</p> <p> <code>\\\"BS\\\": [\\\"U3Vubnk=\\\", \\\"UmFpbnk=\\\", \\\"U25vd3k=\\\"]</code> </p>\"\
        },\
        \"M\":{\
          \"shape\":\"MapAttributeValue\",\
          \"documentation\":\"<p>An attribute of type Map. For example:</p> <p> <code>\\\"M\\\": {\\\"Name\\\": {\\\"S\\\": \\\"Joe\\\"}, \\\"Age\\\": {\\\"N\\\": \\\"35\\\"}}</code> </p>\"\
        },\
        \"L\":{\
          \"shape\":\"ListAttributeValue\",\
          \"documentation\":\"<p>An attribute of type List. For example:</p> <p> <code>\\\"L\\\": [ {\\\"S\\\": \\\"Cookies\\\"} , {\\\"S\\\": \\\"Coffee\\\"}, {\\\"N\\\", \\\"3.14159\\\"}]</code> </p>\"\
        },\
        \"NULL\":{\
          \"shape\":\"NullAttributeValue\",\
          \"documentation\":\"<p>An attribute of type Null. For example:</p> <p> <code>\\\"NULL\\\": true</code> </p>\"\
        },\
        \"BOOL\":{\
          \"shape\":\"BooleanAttributeValue\",\
          \"documentation\":\"<p>An attribute of type Boolean. For example:</p> <p> <code>\\\"BOOL\\\": true</code> </p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the data for an attribute.</p> <p>Each attribute value is described as a name-value pair. The name is the data type, and the value is the data itself.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypes\\\">Data Types</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
    },\
    \"AttributeValueList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AttributeValue\"}\
    },\
    \"AttributeValueUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Value\":{\
          \"shape\":\"AttributeValue\",\
          \"documentation\":\"<p>Represents the data for an attribute.</p> <p>Each attribute value is described as a name-value pair. The name is the data type, and the value is the data itself.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypes\\\">Data Types</a> in the <i>Amazon DynamoDB Developer Guide</i>. </p>\"\
        },\
        \"Action\":{\
          \"shape\":\"AttributeAction\",\
          \"documentation\":\"<p>Specifies how to perform the update. Valid values are <code>PUT</code> (default), <code>DELETE</code>, and <code>ADD</code>. The behavior depends on whether the specified primary key already exists in the table.</p> <p> <b>If an item with the specified <i>Key</i> is found in the table:</b> </p> <ul> <li> <p> <code>PUT</code> - Adds the specified attribute to the item. If the attribute already exists, it is replaced by the new value. </p> </li> <li> <p> <code>DELETE</code> - If no value is specified, the attribute and its value are removed from the item. The data type of the specified value must match the existing value's data type.</p> <p>If a <i>set</i> of values is specified, then those values are subtracted from the old set. For example, if the attribute value was the set <code>[a,b,c]</code> and the <code>DELETE</code> action specified <code>[a,c]</code>, then the final attribute value would be <code>[b]</code>. Specifying an empty set is an error.</p> </li> <li> <p> <code>ADD</code> - If the attribute does not already exist, then the attribute and its values are added to the item. If the attribute does exist, then the behavior of <code>ADD</code> depends on the data type of the attribute:</p> <ul> <li> <p>If the existing attribute is a number, and if <code>Value</code> is also a number, then the <code>Value</code> is mathematically added to the existing attribute. If <code>Value</code> is a negative number, then it is subtracted from the existing attribute.</p> <note> <p> If you use <code>ADD</code> to increment or decrement a number value for an item that doesn't exist before the update, DynamoDB uses 0 as the initial value.</p> <p>In addition, if you use <code>ADD</code> to update an existing item, and intend to increment or decrement an attribute value which does not yet exist, DynamoDB uses <code>0</code> as the initial value. For example, suppose that the item you want to update does not yet have an attribute named <i>itemcount</i>, but you decide to <code>ADD</code> the number <code>3</code> to this attribute anyway, even though it currently does not exist. DynamoDB will create the <i>itemcount</i> attribute, set its initial value to <code>0</code>, and finally add <code>3</code> to it. The result will be a new <i>itemcount</i> attribute in the item, with a value of <code>3</code>.</p> </note> </li> <li> <p>If the existing data type is a set, and if the <code>Value</code> is also a set, then the <code>Value</code> is added to the existing set. (This is a <i>set</i> operation, not mathematical addition.) For example, if the attribute value was the set <code>[1,2]</code>, and the <code>ADD</code> action specified <code>[3]</code>, then the final attribute value would be <code>[1,2,3]</code>. An error occurs if an Add action is specified for a set attribute and the attribute type specified does not match the existing set type. </p> <p>Both sets must have the same primitive data type. For example, if the existing data type is a set of strings, the <code>Value</code> must also be a set of strings. The same holds true for number sets and binary sets.</p> </li> </ul> <p>This action is only valid for an existing attribute whose data type is number or is a set. Do not use <code>ADD</code> for any other data types.</p> </li> </ul> <p> <b>If no item with the specified <i>Key</i> is found:</b> </p> <ul> <li> <p> <code>PUT</code> - DynamoDB creates a new item with the specified primary key, and then adds the attribute. </p> </li> <li> <p> <code>DELETE</code> - Nothing happens; there is no attribute to delete.</p> </li> <li> <p> <code>ADD</code> - DynamoDB creates an item with the supplied primary key and number (or set of numbers) for the attribute value. The only data types allowed are number and number set; no other data types can be specified.</p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>For the <code>UpdateItem</code> operation, represents the attributes to be modified, the action to perform on each, and the new value for each.</p> <note> <p>You cannot use <code>UpdateItem</code> to update any primary key attributes. Instead, you will need to delete the item, and then use <code>PutItem</code> to create a new item with new attributes.</p> </note> <p>Attribute values cannot be null; string and binary type attributes must have lengths greater than zero; and set type attributes must not be empty. Requests with empty values will be rejected with a <code>ValidationException</code> exception.</p>\"\
    },\
    \"AutoScalingPolicyDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PolicyName\":{\
          \"shape\":\"AutoScalingPolicyName\",\
          \"documentation\":\"<p>The name of the scaling policy.</p>\"\
        },\
        \"TargetTrackingScalingPolicyConfiguration\":{\
          \"shape\":\"AutoScalingTargetTrackingScalingPolicyConfigurationDescription\",\
          \"documentation\":\"<p>Represents a target tracking scaling policy configuration.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of the scaling policy.</p>\"\
    },\
    \"AutoScalingPolicyDescriptionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AutoScalingPolicyDescription\"}\
    },\
    \"AutoScalingPolicyName\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":1,\
      \"pattern\":\"\\\\p{Print}+\"\
    },\
    \"AutoScalingPolicyUpdate\":{\
      \"type\":\"structure\",\
      \"required\":[\"TargetTrackingScalingPolicyConfiguration\"],\
      \"members\":{\
        \"PolicyName\":{\
          \"shape\":\"AutoScalingPolicyName\",\
          \"documentation\":\"<p>The name of the scaling policy.</p>\"\
        },\
        \"TargetTrackingScalingPolicyConfiguration\":{\
          \"shape\":\"AutoScalingTargetTrackingScalingPolicyConfigurationUpdate\",\
          \"documentation\":\"<p>Represents a target tracking scaling policy configuration.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the autoscaling policy to be modified.</p>\"\
    },\
    \"AutoScalingRoleArn\":{\
      \"type\":\"string\",\
      \"max\":1600,\
      \"min\":1,\
      \"pattern\":\"[\\\\u0020-\\\\uD7FF\\\\uE000-\\\\uFFFD\\\\uD800\\\\uDC00-\\\\uDBFF\\\\uDFFF\\\\r\\\\n\\\\t]*\"\
    },\
    \"AutoScalingSettingsDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MinimumUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The minimum capacity units that a global table or global secondary index should be scaled down to.</p>\"\
        },\
        \"MaximumUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum capacity units that a global table or global secondary index should be scaled up to.</p>\"\
        },\
        \"AutoScalingDisabled\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Disabled autoscaling for this global table or global secondary index.</p>\"\
        },\
        \"AutoScalingRoleArn\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Role ARN used for configuring autoScaling policy.</p>\"\
        },\
        \"ScalingPolicies\":{\
          \"shape\":\"AutoScalingPolicyDescriptionList\",\
          \"documentation\":\"<p>Information about the scaling policies.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the autoscaling settings for a global table or global secondary index.</p>\"\
    },\
    \"AutoScalingSettingsUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MinimumUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The minimum capacity units that a global table or global secondary index should be scaled down to.</p>\"\
        },\
        \"MaximumUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum capacity units that a global table or global secondary index should be scaled up to.</p>\"\
        },\
        \"AutoScalingDisabled\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Disabled autoscaling for this global table or global secondary index.</p>\"\
        },\
        \"AutoScalingRoleArn\":{\
          \"shape\":\"AutoScalingRoleArn\",\
          \"documentation\":\"<p>Role ARN used for configuring autoscaling policy.</p>\"\
        },\
        \"ScalingPolicyUpdate\":{\
          \"shape\":\"AutoScalingPolicyUpdate\",\
          \"documentation\":\"<p>The scaling policy to apply for scaling target global table or global secondary index capacity units.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the autoscaling settings to be modified for a global table or global secondary index.</p>\"\
    },\
    \"AutoScalingTargetTrackingScalingPolicyConfigurationDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\"TargetValue\"],\
      \"members\":{\
        \"DisableScaleIn\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Indicates whether scale in by the target tracking policy is disabled. If the value is true, scale in is disabled and the target tracking policy won't remove capacity from the scalable resource. Otherwise, scale in is enabled and the target tracking policy can remove capacity from the scalable resource. The default value is false.</p>\"\
        },\
        \"ScaleInCooldown\":{\
          \"shape\":\"IntegerObject\",\
          \"documentation\":\"<p>The amount of time, in seconds, after a scale in activity completes before another scale in activity can start. The cooldown period is used to block subsequent scale in requests until it has expired. You should scale in conservatively to protect your application's availability. However, if another alarm triggers a scale out policy during the cooldown period after a scale-in, application autoscaling scales out your scalable target immediately. </p>\"\
        },\
        \"ScaleOutCooldown\":{\
          \"shape\":\"IntegerObject\",\
          \"documentation\":\"<p>The amount of time, in seconds, after a scale out activity completes before another scale out activity can start. While the cooldown period is in effect, the capacity that has been added by the previous scale out event that initiated the cooldown is calculated as part of the desired capacity for the next scale out. You should continuously (but not excessively) scale out.</p>\"\
        },\
        \"TargetValue\":{\
          \"shape\":\"Double\",\
          \"documentation\":\"<p>The target value for the metric. The range is 8.515920e-109 to 1.174271e+108 (Base 10) or 2e-360 to 2e360 (Base 2).</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a target tracking scaling policy.</p>\"\
    },\
    \"AutoScalingTargetTrackingScalingPolicyConfigurationUpdate\":{\
      \"type\":\"structure\",\
      \"required\":[\"TargetValue\"],\
      \"members\":{\
        \"DisableScaleIn\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Indicates whether scale in by the target tracking policy is disabled. If the value is true, scale in is disabled and the target tracking policy won't remove capacity from the scalable resource. Otherwise, scale in is enabled and the target tracking policy can remove capacity from the scalable resource. The default value is false.</p>\"\
        },\
        \"ScaleInCooldown\":{\
          \"shape\":\"IntegerObject\",\
          \"documentation\":\"<p>The amount of time, in seconds, after a scale in activity completes before another scale in activity can start. The cooldown period is used to block subsequent scale in requests until it has expired. You should scale in conservatively to protect your application's availability. However, if another alarm triggers a scale out policy during the cooldown period after a scale-in, application autoscaling scales out your scalable target immediately. </p>\"\
        },\
        \"ScaleOutCooldown\":{\
          \"shape\":\"IntegerObject\",\
          \"documentation\":\"<p>The amount of time, in seconds, after a scale out activity completes before another scale out activity can start. While the cooldown period is in effect, the capacity that has been added by the previous scale out event that initiated the cooldown is calculated as part of the desired capacity for the next scale out. You should continuously (but not excessively) scale out.</p>\"\
        },\
        \"TargetValue\":{\
          \"shape\":\"Double\",\
          \"documentation\":\"<p>The target value for the metric. The range is 8.515920e-109 to 1.174271e+108 (Base 10) or 2e-360 to 2e360 (Base 2).</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the settings of a target tracking scaling policy that will be modified.</p>\"\
    },\
    \"Backfilling\":{\"type\":\"boolean\"},\
    \"BackupArn\":{\
      \"type\":\"string\",\
      \"max\":1024,\
      \"min\":37\
    },\
    \"BackupCreationDateTime\":{\"type\":\"timestamp\"},\
    \"BackupDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"BackupDetails\":{\
          \"shape\":\"BackupDetails\",\
          \"documentation\":\"<p>Contains the details of the backup created for the table. </p>\"\
        },\
        \"SourceTableDetails\":{\
          \"shape\":\"SourceTableDetails\",\
          \"documentation\":\"<p>Contains the details of the table when the backup was created. </p>\"\
        },\
        \"SourceTableFeatureDetails\":{\
          \"shape\":\"SourceTableFeatureDetails\",\
          \"documentation\":\"<p>Contains the details of the features enabled on the table when the backup was created. For example, LSIs, GSIs, streams, TTL.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the description of the backup created for the table.</p>\"\
    },\
    \"BackupDetails\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"BackupArn\",\
        \"BackupName\",\
        \"BackupStatus\",\
        \"BackupType\",\
        \"BackupCreationDateTime\"\
      ],\
      \"members\":{\
        \"BackupArn\":{\
          \"shape\":\"BackupArn\",\
          \"documentation\":\"<p>ARN associated with the backup.</p>\"\
        },\
        \"BackupName\":{\
          \"shape\":\"BackupName\",\
          \"documentation\":\"<p>Name of the requested backup.</p>\"\
        },\
        \"BackupSizeBytes\":{\
          \"shape\":\"BackupSizeBytes\",\
          \"documentation\":\"<p>Size of the backup in bytes.</p>\"\
        },\
        \"BackupStatus\":{\
          \"shape\":\"BackupStatus\",\
          \"documentation\":\"<p>Backup can be in one of the following states: CREATING, ACTIVE, DELETED. </p>\"\
        },\
        \"BackupType\":{\
          \"shape\":\"BackupType\",\
          \"documentation\":\"<p>BackupType:</p> <ul> <li> <p> <code>USER</code> - You create and manage these using the on-demand backup feature.</p> </li> <li> <p> <code>SYSTEM</code> - If you delete a table with point-in-time recovery enabled, a <code>SYSTEM</code> backup is automatically created and is retained for 35 days (at no additional cost). System backups allow you to restore the deleted table to the state it was in just before the point of deletion. </p> </li> <li> <p> <code>AWS_BACKUP</code> - On-demand backup created by you from AWS Backup service.</p> </li> </ul>\"\
        },\
        \"BackupCreationDateTime\":{\
          \"shape\":\"BackupCreationDateTime\",\
          \"documentation\":\"<p>Time at which the backup was created. This is the request time of the backup. </p>\"\
        },\
        \"BackupExpiryDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>Time at which the automatic on-demand backup created by DynamoDB will expire. This <code>SYSTEM</code> on-demand backup expires automatically 35 days after its creation.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the details of the backup created for the table.</p>\"\
    },\
    \"BackupInUseException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>There is another ongoing conflicting backup control plane operation on the table. The backup is either being created, deleted or restored to a table.</p>\",\
      \"exception\":true\
    },\
    \"BackupName\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":3,\
      \"pattern\":\"[a-zA-Z0-9_.-]+\"\
    },\
    \"BackupNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>Backup not found for the given BackupARN. </p>\",\
      \"exception\":true\
    },\
    \"BackupSizeBytes\":{\
      \"type\":\"long\",\
      \"min\":0\
    },\
    \"BackupStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CREATING\",\
        \"DELETED\",\
        \"AVAILABLE\"\
      ]\
    },\
    \"BackupSummaries\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"BackupSummary\"}\
    },\
    \"BackupSummary\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>Name of the table.</p>\"\
        },\
        \"TableId\":{\
          \"shape\":\"TableId\",\
          \"documentation\":\"<p>Unique identifier for the table.</p>\"\
        },\
        \"TableArn\":{\
          \"shape\":\"TableArn\",\
          \"documentation\":\"<p>ARN associated with the table.</p>\"\
        },\
        \"BackupArn\":{\
          \"shape\":\"BackupArn\",\
          \"documentation\":\"<p>ARN associated with the backup.</p>\"\
        },\
        \"BackupName\":{\
          \"shape\":\"BackupName\",\
          \"documentation\":\"<p>Name of the specified backup.</p>\"\
        },\
        \"BackupCreationDateTime\":{\
          \"shape\":\"BackupCreationDateTime\",\
          \"documentation\":\"<p>Time at which the backup was created.</p>\"\
        },\
        \"BackupExpiryDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>Time at which the automatic on-demand backup created by DynamoDB will expire. This <code>SYSTEM</code> on-demand backup expires automatically 35 days after its creation.</p>\"\
        },\
        \"BackupStatus\":{\
          \"shape\":\"BackupStatus\",\
          \"documentation\":\"<p>Backup can be in one of the following states: CREATING, ACTIVE, DELETED.</p>\"\
        },\
        \"BackupType\":{\
          \"shape\":\"BackupType\",\
          \"documentation\":\"<p>BackupType:</p> <ul> <li> <p> <code>USER</code> - You create and manage these using the on-demand backup feature.</p> </li> <li> <p> <code>SYSTEM</code> - If you delete a table with point-in-time recovery enabled, a <code>SYSTEM</code> backup is automatically created and is retained for 35 days (at no additional cost). System backups allow you to restore the deleted table to the state it was in just before the point of deletion. </p> </li> <li> <p> <code>AWS_BACKUP</code> - On-demand backup created by you from AWS Backup service.</p> </li> </ul>\"\
        },\
        \"BackupSizeBytes\":{\
          \"shape\":\"BackupSizeBytes\",\
          \"documentation\":\"<p>Size of the backup in bytes.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains details for the backup.</p>\"\
    },\
    \"BackupType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"USER\",\
        \"SYSTEM\",\
        \"AWS_BACKUP\"\
      ]\
    },\
    \"BackupTypeFilter\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"USER\",\
        \"SYSTEM\",\
        \"AWS_BACKUP\",\
        \"ALL\"\
      ]\
    },\
    \"BackupsInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":100,\
      \"min\":1\
    },\
    \"BatchGetItemInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"RequestItems\"],\
      \"members\":{\
        \"RequestItems\":{\
          \"shape\":\"BatchGetRequestMap\",\
          \"documentation\":\"<p>A map of one or more table names and, for each table, a map that describes one or more items to retrieve from that table. Each table name can be used only once per <code>BatchGetItem</code> request.</p> <p>Each element in the map of items to retrieve consists of the following:</p> <ul> <li> <p> <code>ConsistentRead</code> - If <code>true</code>, a strongly consistent read is used; if <code>false</code> (the default), an eventually consistent read is used.</p> </li> <li> <p> <code>ExpressionAttributeNames</code> - One or more substitution tokens for attribute names in the <code>ProjectionExpression</code> parameter. The following are some use cases for using <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p>To access an attribute whose name conflicts with a DynamoDB reserved word.</p> </li> <li> <p>To create a placeholder for repeating occurrences of an attribute name in an expression.</p> </li> <li> <p>To prevent special characters in an attribute name from being misinterpreted in an expression.</p> </li> </ul> <p>Use the <b>#</b> character in an expression to dereference an attribute name. For example, consider the following attribute name:</p> <ul> <li> <p> <code>Percentile</code> </p> </li> </ul> <p>The name of this attribute conflicts with a reserved word, so it cannot be used directly in an expression. (For the complete list of reserved words, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html\\\">Reserved Words</a> in the <i>Amazon DynamoDB Developer Guide</i>). To work around this, you could specify the following for <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p> <code>{\\\"#P\\\":\\\"Percentile\\\"}</code> </p> </li> </ul> <p>You could then use this substitution in an expression, as in this example:</p> <ul> <li> <p> <code>#P = :val</code> </p> </li> </ul> <note> <p>Tokens that begin with the <b>:</b> character are <i>expression attribute values</i>, which are placeholders for the actual value at runtime.</p> </note> <p>For more information on expression attribute names, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> </li> <li> <p> <code>Keys</code> - An array of primary key attribute values that define specific items in the table. For each primary key, you must provide <i>all</i> of the key attributes. For example, with a simple primary key, you only need to provide the partition key value. For a composite key, you must provide <i>both</i> the partition key value and the sort key value.</p> </li> <li> <p> <code>ProjectionExpression</code> - A string that identifies one or more attributes to retrieve from the table. These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must be separated by commas.</p> <p>If no attribute names are specified, then all attributes will be returned. If any of the requested attributes are not found, they will not appear in the result.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> </li> <li> <p> <code>AttributesToGet</code> - This is a legacy parameter. Use <code>ProjectionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributesToGet.html\\\">AttributesToGet</a> in the <i>Amazon DynamoDB Developer Guide</i>. </p> </li> </ul>\"\
        },\
        \"ReturnConsumedCapacity\":{\"shape\":\"ReturnConsumedCapacity\"}\
      },\
      \"documentation\":\"<p>Represents the input of a <code>BatchGetItem</code> operation.</p>\"\
    },\
    \"BatchGetItemOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Responses\":{\
          \"shape\":\"BatchGetResponseMap\",\
          \"documentation\":\"<p>A map of table name to a list of items. Each object in <code>Responses</code> consists of a table name, along with a map of attribute data consisting of the data type and attribute value.</p>\"\
        },\
        \"UnprocessedKeys\":{\
          \"shape\":\"BatchGetRequestMap\",\
          \"documentation\":\"<p>A map of tables and their respective keys that were not processed with the current response. The <code>UnprocessedKeys</code> value is in the same form as <code>RequestItems</code>, so the value can be provided directly to a subsequent <code>BatchGetItem</code> operation. For more information, see <code>RequestItems</code> in the Request Parameters section.</p> <p>Each element consists of:</p> <ul> <li> <p> <code>Keys</code> - An array of primary key attribute values that define specific items in the table.</p> </li> <li> <p> <code>ProjectionExpression</code> - One or more attributes to be retrieved from the table or index. By default, all attributes are returned. If a requested attribute is not found, it does not appear in the result.</p> </li> <li> <p> <code>ConsistentRead</code> - The consistency of a read operation. If set to <code>true</code>, then a strongly consistent read is used; otherwise, an eventually consistent read is used.</p> </li> </ul> <p>If there are no unprocessed keys remaining, the response contains an empty <code>UnprocessedKeys</code> map.</p>\"\
        },\
        \"ConsumedCapacity\":{\
          \"shape\":\"ConsumedCapacityMultiple\",\
          \"documentation\":\"<p>The read capacity units consumed by the entire <code>BatchGetItem</code> operation.</p> <p>Each element consists of:</p> <ul> <li> <p> <code>TableName</code> - The table that consumed the provisioned throughput.</p> </li> <li> <p> <code>CapacityUnits</code> - The total number of capacity units consumed.</p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>BatchGetItem</code> operation.</p>\"\
    },\
    \"BatchGetRequestMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"TableName\"},\
      \"value\":{\"shape\":\"KeysAndAttributes\"},\
      \"max\":100,\
      \"min\":1\
    },\
    \"BatchGetResponseMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"TableName\"},\
      \"value\":{\"shape\":\"ItemList\"}\
    },\
    \"BatchWriteItemInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"RequestItems\"],\
      \"members\":{\
        \"RequestItems\":{\
          \"shape\":\"BatchWriteItemRequestMap\",\
          \"documentation\":\"<p>A map of one or more table names and, for each table, a list of operations to be performed (<code>DeleteRequest</code> or <code>PutRequest</code>). Each element in the map consists of the following:</p> <ul> <li> <p> <code>DeleteRequest</code> - Perform a <code>DeleteItem</code> operation on the specified item. The item to be deleted is identified by a <code>Key</code> subelement:</p> <ul> <li> <p> <code>Key</code> - A map of primary key attribute values that uniquely identify the item. Each entry in this map consists of an attribute name and an attribute value. For each primary key, you must provide <i>all</i> of the key attributes. For example, with a simple primary key, you only need to provide a value for the partition key. For a composite primary key, you must provide values for <i>both</i> the partition key and the sort key.</p> </li> </ul> </li> <li> <p> <code>PutRequest</code> - Perform a <code>PutItem</code> operation on the specified item. The item to be put is identified by an <code>Item</code> subelement:</p> <ul> <li> <p> <code>Item</code> - A map of attributes and their values. Each entry in this map consists of an attribute name and an attribute value. Attribute values must not be null; string and binary type attributes must have lengths greater than zero; and set type attributes must not be empty. Requests that contain empty values will be rejected with a <code>ValidationException</code> exception.</p> <p>If you specify any attributes that are part of an index key, then the data types for those attributes must match those of the schema in the table's attribute definition.</p> </li> </ul> </li> </ul>\"\
        },\
        \"ReturnConsumedCapacity\":{\"shape\":\"ReturnConsumedCapacity\"},\
        \"ReturnItemCollectionMetrics\":{\
          \"shape\":\"ReturnItemCollectionMetrics\",\
          \"documentation\":\"<p>Determines whether item collection metrics are returned. If set to <code>SIZE</code>, the response includes statistics about item collections, if any, that were modified during the operation are returned in the response. If set to <code>NONE</code> (the default), no statistics are returned.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of a <code>BatchWriteItem</code> operation.</p>\"\
    },\
    \"BatchWriteItemOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"UnprocessedItems\":{\
          \"shape\":\"BatchWriteItemRequestMap\",\
          \"documentation\":\"<p>A map of tables and requests against those tables that were not processed. The <code>UnprocessedItems</code> value is in the same form as <code>RequestItems</code>, so you can provide this value directly to a subsequent <code>BatchGetItem</code> operation. For more information, see <code>RequestItems</code> in the Request Parameters section.</p> <p>Each <code>UnprocessedItems</code> entry consists of a table name and, for that table, a list of operations to perform (<code>DeleteRequest</code> or <code>PutRequest</code>).</p> <ul> <li> <p> <code>DeleteRequest</code> - Perform a <code>DeleteItem</code> operation on the specified item. The item to be deleted is identified by a <code>Key</code> subelement:</p> <ul> <li> <p> <code>Key</code> - A map of primary key attribute values that uniquely identify the item. Each entry in this map consists of an attribute name and an attribute value.</p> </li> </ul> </li> <li> <p> <code>PutRequest</code> - Perform a <code>PutItem</code> operation on the specified item. The item to be put is identified by an <code>Item</code> subelement:</p> <ul> <li> <p> <code>Item</code> - A map of attributes and their values. Each entry in this map consists of an attribute name and an attribute value. Attribute values must not be null; string and binary type attributes must have lengths greater than zero; and set type attributes must not be empty. Requests that contain empty values will be rejected with a <code>ValidationException</code> exception.</p> <p>If you specify any attributes that are part of an index key, then the data types for those attributes must match those of the schema in the table's attribute definition.</p> </li> </ul> </li> </ul> <p>If there are no unprocessed items remaining, the response contains an empty <code>UnprocessedItems</code> map.</p>\"\
        },\
        \"ItemCollectionMetrics\":{\
          \"shape\":\"ItemCollectionMetricsPerTable\",\
          \"documentation\":\"<p>A list of tables that were processed by <code>BatchWriteItem</code> and, for each table, information about any item collections that were affected by individual <code>DeleteItem</code> or <code>PutItem</code> operations.</p> <p>Each entry consists of the following subelements:</p> <ul> <li> <p> <code>ItemCollectionKey</code> - The partition key value of the item collection. This is the same as the partition key value of the item.</p> </li> <li> <p> <code>SizeEstimateRangeGB</code> - An estimate of item collection size, expressed in GB. This is a two-element array containing a lower bound and an upper bound for the estimate. The estimate includes the size of all the items in the table, plus the size of all attributes projected into all of the local secondary indexes on the table. Use this estimate to measure whether a local secondary index is approaching its size limit.</p> <p>The estimate is subject to change over time; therefore, do not rely on the precision or accuracy of the estimate.</p> </li> </ul>\"\
        },\
        \"ConsumedCapacity\":{\
          \"shape\":\"ConsumedCapacityMultiple\",\
          \"documentation\":\"<p>The capacity units consumed by the entire <code>BatchWriteItem</code> operation.</p> <p>Each element consists of:</p> <ul> <li> <p> <code>TableName</code> - The table that consumed the provisioned throughput.</p> </li> <li> <p> <code>CapacityUnits</code> - The total number of capacity units consumed.</p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>BatchWriteItem</code> operation.</p>\"\
    },\
    \"BatchWriteItemRequestMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"TableName\"},\
      \"value\":{\"shape\":\"WriteRequests\"},\
      \"max\":25,\
      \"min\":1\
    },\
    \"BillingMode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"PROVISIONED\",\
        \"PAY_PER_REQUEST\"\
      ]\
    },\
    \"BillingModeSummary\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"BillingMode\":{\
          \"shape\":\"BillingMode\",\
          \"documentation\":\"<p>Controls how you are charged for read and write throughput and how you manage capacity. This setting can be changed later.</p> <ul> <li> <p> <code>PROVISIONED</code> - Sets the read/write capacity mode to <code>PROVISIONED</code>. We recommend using <code>PROVISIONED</code> for predictable workloads.</p> </li> <li> <p> <code>PAY_PER_REQUEST</code> - Sets the read/write capacity mode to <code>PAY_PER_REQUEST</code>. We recommend using <code>PAY_PER_REQUEST</code> for unpredictable workloads. </p> </li> </ul>\"\
        },\
        \"LastUpdateToPayPerRequestDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>Represents the time when <code>PAY_PER_REQUEST</code> was last set as the read/write capacity mode.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the details for the read/write capacity mode.</p>\"\
    },\
    \"BinaryAttributeValue\":{\"type\":\"blob\"},\
    \"BinarySetAttributeValue\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"BinaryAttributeValue\"}\
    },\
    \"BooleanAttributeValue\":{\"type\":\"boolean\"},\
    \"BooleanObject\":{\"type\":\"boolean\"},\
    \"CancellationReason\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Item\":{\
          \"shape\":\"AttributeMap\",\
          \"documentation\":\"<p>Item in the request which caused the transaction to get cancelled.</p>\"\
        },\
        \"Code\":{\
          \"shape\":\"Code\",\
          \"documentation\":\"<p>Status code for the result of the cancelled transaction.</p>\"\
        },\
        \"Message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>Cancellation reason message description.</p>\"\
        }\
      },\
      \"documentation\":\"<p>An ordered list of errors for each item in the request which caused the transaction to get cancelled. The values of the list are ordered according to the ordering of the <code>TransactWriteItems</code> request parameter. If no error occurred for the associated item an error with a Null code and Null message will be present. </p>\"\
    },\
    \"CancellationReasonList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"CancellationReason\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"Capacity\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ReadCapacityUnits\":{\
          \"shape\":\"ConsumedCapacityUnits\",\
          \"documentation\":\"<p>The total number of read capacity units consumed on a table or an index.</p>\"\
        },\
        \"WriteCapacityUnits\":{\
          \"shape\":\"ConsumedCapacityUnits\",\
          \"documentation\":\"<p>The total number of write capacity units consumed on a table or an index.</p>\"\
        },\
        \"CapacityUnits\":{\
          \"shape\":\"ConsumedCapacityUnits\",\
          \"documentation\":\"<p>The total number of capacity units consumed on a table or an index.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the amount of provisioned throughput capacity consumed on a table or an index.</p>\"\
    },\
    \"ClientRequestToken\":{\
      \"type\":\"string\",\
      \"max\":36,\
      \"min\":1\
    },\
    \"Code\":{\"type\":\"string\"},\
    \"ComparisonOperator\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"EQ\",\
        \"NE\",\
        \"IN\",\
        \"LE\",\
        \"LT\",\
        \"GE\",\
        \"GT\",\
        \"BETWEEN\",\
        \"NOT_NULL\",\
        \"NULL\",\
        \"CONTAINS\",\
        \"NOT_CONTAINS\",\
        \"BEGINS_WITH\"\
      ]\
    },\
    \"Condition\":{\
      \"type\":\"structure\",\
      \"required\":[\"ComparisonOperator\"],\
      \"members\":{\
        \"AttributeValueList\":{\
          \"shape\":\"AttributeValueList\",\
          \"documentation\":\"<p>One or more values to evaluate against the supplied attribute. The number of values in the list depends on the <code>ComparisonOperator</code> being used.</p> <p>For type Number, value comparisons are numeric.</p> <p>String value comparisons for greater than, equals, or less than are based on ASCII character code values. For example, <code>a</code> is greater than <code>A</code>, and <code>a</code> is greater than <code>B</code>. For a list of code values, see <a href=\\\"http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters\\\">http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters</a>.</p> <p>For Binary, DynamoDB treats each byte of the binary data as unsigned when it compares binary values.</p>\"\
        },\
        \"ComparisonOperator\":{\
          \"shape\":\"ComparisonOperator\",\
          \"documentation\":\"<p>A comparator for evaluating attributes. For example, equals, greater than, less than, etc.</p> <p>The following comparison operators are available:</p> <p> <code>EQ | NE | LE | LT | GE | GT | NOT_NULL | NULL | CONTAINS | NOT_CONTAINS | BEGINS_WITH | IN | BETWEEN</code> </p> <p>The following are descriptions of each comparison operator.</p> <ul> <li> <p> <code>EQ</code> : Equal. <code>EQ</code> is supported for all data types, including lists and maps.</p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, Binary, String Set, Number Set, or Binary Set. If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not equal <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>NE</code> : Not equal. <code>NE</code> is supported for all data types, including lists and maps.</p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> of type String, Number, Binary, String Set, Number Set, or Binary Set. If an item contains an <code>AttributeValue</code> of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not equal <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>LE</code> : Less than or equal. </p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, or Binary (not a set type). If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>LT</code> : Less than. </p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> of type String, Number, or Binary (not a set type). If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>GE</code> : Greater than or equal. </p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, or Binary (not a set type). If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>GT</code> : Greater than. </p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, or Binary (not a set type). If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>NOT_NULL</code> : The attribute exists. <code>NOT_NULL</code> is supported for all data types, including lists and maps.</p> <note> <p>This operator tests for the existence of an attribute, not its data type. If the data type of attribute \\\"<code>a</code>\\\" is null, and you evaluate it using <code>NOT_NULL</code>, the result is a Boolean <code>true</code>. This result is because the attribute \\\"<code>a</code>\\\" exists; its data type is not relevant to the <code>NOT_NULL</code> comparison operator.</p> </note> </li> <li> <p> <code>NULL</code> : The attribute does not exist. <code>NULL</code> is supported for all data types, including lists and maps.</p> <note> <p>This operator tests for the nonexistence of an attribute, not its data type. If the data type of attribute \\\"<code>a</code>\\\" is null, and you evaluate it using <code>NULL</code>, the result is a Boolean <code>false</code>. This is because the attribute \\\"<code>a</code>\\\" exists; its data type is not relevant to the <code>NULL</code> comparison operator.</p> </note> </li> <li> <p> <code>CONTAINS</code> : Checks for a subsequence, or value in a set.</p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, or Binary (not a set type). If the target attribute of the comparison is of type String, then the operator checks for a substring match. If the target attribute of the comparison is of type Binary, then the operator looks for a subsequence of the target that matches the input. If the target attribute of the comparison is a set (\\\"<code>SS</code>\\\", \\\"<code>NS</code>\\\", or \\\"<code>BS</code>\\\"), then the operator evaluates to true if it finds an exact match with any member of the set.</p> <p>CONTAINS is supported for lists: When evaluating \\\"<code>a CONTAINS b</code>\\\", \\\"<code>a</code>\\\" can be a list; however, \\\"<code>b</code>\\\" cannot be a set, a map, or a list.</p> </li> <li> <p> <code>NOT_CONTAINS</code> : Checks for absence of a subsequence, or absence of a value in a set.</p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, or Binary (not a set type). If the target attribute of the comparison is a String, then the operator checks for the absence of a substring match. If the target attribute of the comparison is Binary, then the operator checks for the absence of a subsequence of the target that matches the input. If the target attribute of the comparison is a set (\\\"<code>SS</code>\\\", \\\"<code>NS</code>\\\", or \\\"<code>BS</code>\\\"), then the operator evaluates to true if it <i>does not</i> find an exact match with any member of the set.</p> <p>NOT_CONTAINS is supported for lists: When evaluating \\\"<code>a NOT CONTAINS b</code>\\\", \\\"<code>a</code>\\\" can be a list; however, \\\"<code>b</code>\\\" cannot be a set, a map, or a list.</p> </li> <li> <p> <code>BEGINS_WITH</code> : Checks for a prefix. </p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> of type String or Binary (not a Number or a set type). The target attribute of the comparison must be of type String or Binary (not a Number or a set type).</p> <p/> </li> <li> <p> <code>IN</code> : Checks for matching elements in a list.</p> <p> <code>AttributeValueList</code> can contain one or more <code>AttributeValue</code> elements of type String, Number, or Binary. These attributes are compared against an existing attribute of an item. If any elements of the input are equal to the item attribute, the expression evaluates to true.</p> </li> <li> <p> <code>BETWEEN</code> : Greater than or equal to the first value, and less than or equal to the second value. </p> <p> <code>AttributeValueList</code> must contain two <code>AttributeValue</code> elements of the same type, either String, Number, or Binary (not a set type). A target attribute matches if the target value is greater than, or equal to, the first element and less than, or equal to, the second element. If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code> </p> </li> </ul> <p>For usage examples of <code>AttributeValueList</code> and <code>ComparisonOperator</code>, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.html\\\">Legacy Conditional Parameters</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the selection criteria for a <code>Query</code> or <code>Scan</code> operation:</p> <ul> <li> <p>For a <code>Query</code> operation, <code>Condition</code> is used for specifying the <code>KeyConditions</code> to use when querying a table or an index. For <code>KeyConditions</code>, only the following comparison operators are supported:</p> <p> <code>EQ | LE | LT | GE | GT | BEGINS_WITH | BETWEEN</code> </p> <p> <code>Condition</code> is also used in a <code>QueryFilter</code>, which evaluates the query results and returns only the desired values.</p> </li> <li> <p>For a <code>Scan</code> operation, <code>Condition</code> is used in a <code>ScanFilter</code>, which evaluates the scan results and returns only the desired values.</p> </li> </ul>\"\
    },\
    \"ConditionCheck\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Key\",\
        \"TableName\",\
        \"ConditionExpression\"\
      ],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>The primary key of the item to be checked. Each element consists of an attribute name and a value for that attribute.</p>\"\
        },\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>Name of the table for the check item request.</p>\"\
        },\
        \"ConditionExpression\":{\
          \"shape\":\"ConditionExpression\",\
          \"documentation\":\"<p>A condition that must be satisfied in order for a conditional update to succeed.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression.</p>\"\
        },\
        \"ExpressionAttributeValues\":{\
          \"shape\":\"ExpressionAttributeValueMap\",\
          \"documentation\":\"<p>One or more values that can be substituted in an expression.</p>\"\
        },\
        \"ReturnValuesOnConditionCheckFailure\":{\
          \"shape\":\"ReturnValuesOnConditionCheckFailure\",\
          \"documentation\":\"<p>Use <code>ReturnValuesOnConditionCheckFailure</code> to get the item attributes if the <code>ConditionCheck</code> condition fails. For <code>ReturnValuesOnConditionCheckFailure</code>, the valid values are: NONE and ALL_OLD.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a request to perform a check that an item exists or to check the condition of specific attributes of the item..</p>\"\
    },\
    \"ConditionExpression\":{\"type\":\"string\"},\
    \"ConditionalCheckFailedException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>The conditional request failed.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A condition specified in the operation could not be evaluated.</p>\",\
      \"exception\":true\
    },\
    \"ConditionalOperator\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AND\",\
        \"OR\"\
      ]\
    },\
    \"ConsistentRead\":{\"type\":\"boolean\"},\
    \"ConsumedCapacity\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table that was affected by the operation.</p>\"\
        },\
        \"CapacityUnits\":{\
          \"shape\":\"ConsumedCapacityUnits\",\
          \"documentation\":\"<p>The total number of capacity units consumed by the operation.</p>\"\
        },\
        \"ReadCapacityUnits\":{\
          \"shape\":\"ConsumedCapacityUnits\",\
          \"documentation\":\"<p>The total number of read capacity units consumed by the operation.</p>\"\
        },\
        \"WriteCapacityUnits\":{\
          \"shape\":\"ConsumedCapacityUnits\",\
          \"documentation\":\"<p>The total number of write capacity units consumed by the operation.</p>\"\
        },\
        \"Table\":{\
          \"shape\":\"Capacity\",\
          \"documentation\":\"<p>The amount of throughput consumed on the table affected by the operation.</p>\"\
        },\
        \"LocalSecondaryIndexes\":{\
          \"shape\":\"SecondaryIndexesCapacityMap\",\
          \"documentation\":\"<p>The amount of throughput consumed on each local index affected by the operation.</p>\"\
        },\
        \"GlobalSecondaryIndexes\":{\
          \"shape\":\"SecondaryIndexesCapacityMap\",\
          \"documentation\":\"<p>The amount of throughput consumed on each global index affected by the operation.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The capacity units consumed by an operation. The data returned includes the total provisioned throughput consumed, along with statistics for the table and any indexes involved in the operation. <code>ConsumedCapacity</code> is only returned if the request asked for it. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughputIntro.html\\\">Provisioned Throughput</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
    },\
    \"ConsumedCapacityMultiple\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ConsumedCapacity\"}\
    },\
    \"ConsumedCapacityUnits\":{\"type\":\"double\"},\
    \"ContinuousBackupsDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\"ContinuousBackupsStatus\"],\
      \"members\":{\
        \"ContinuousBackupsStatus\":{\
          \"shape\":\"ContinuousBackupsStatus\",\
          \"documentation\":\"<p> <code>ContinuousBackupsStatus</code> can be one of the following states: ENABLED, DISABLED</p>\"\
        },\
        \"PointInTimeRecoveryDescription\":{\
          \"shape\":\"PointInTimeRecoveryDescription\",\
          \"documentation\":\"<p>The description of the point in time recovery settings applied to the table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the continuous backups and point in time recovery settings on the table.</p>\"\
    },\
    \"ContinuousBackupsStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ENABLED\",\
        \"DISABLED\"\
      ]\
    },\
    \"ContinuousBackupsUnavailableException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>Backups have not yet been enabled for this table.</p>\",\
      \"exception\":true\
    },\
    \"CreateBackupInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TableName\",\
        \"BackupName\"\
      ],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table.</p>\"\
        },\
        \"BackupName\":{\
          \"shape\":\"BackupName\",\
          \"documentation\":\"<p>Specified name for the backup.</p>\"\
        }\
      }\
    },\
    \"CreateBackupOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"BackupDetails\":{\
          \"shape\":\"BackupDetails\",\
          \"documentation\":\"<p>Contains the details of the backup created for the table.</p>\"\
        }\
      }\
    },\
    \"CreateGlobalSecondaryIndexAction\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"IndexName\",\
        \"KeySchema\",\
        \"Projection\"\
      ],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of the global secondary index to be created.</p>\"\
        },\
        \"KeySchema\":{\
          \"shape\":\"KeySchema\",\
          \"documentation\":\"<p>The key schema for the global secondary index.</p>\"\
        },\
        \"Projection\":{\
          \"shape\":\"Projection\",\
          \"documentation\":\"<p>Represents attributes that are copied (projected) from the table into an index. These are in addition to the primary key attributes and index key attributes, which are automatically projected.</p>\"\
        },\
        \"ProvisionedThroughput\":{\
          \"shape\":\"ProvisionedThroughput\",\
          \"documentation\":\"<p>Represents the provisioned throughput settings for the specified global secondary index.</p> <p>For current minimum and maximum provisioned throughput values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html\\\">Limits</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a new global secondary index to be added to an existing table.</p>\"\
    },\
    \"CreateGlobalTableInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"GlobalTableName\",\
        \"ReplicationGroup\"\
      ],\
      \"members\":{\
        \"GlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The global table name.</p>\"\
        },\
        \"ReplicationGroup\":{\
          \"shape\":\"ReplicaList\",\
          \"documentation\":\"<p>The regions where the global table needs to be created.</p>\"\
        }\
      }\
    },\
    \"CreateGlobalTableOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GlobalTableDescription\":{\
          \"shape\":\"GlobalTableDescription\",\
          \"documentation\":\"<p>Contains the details of the global table.</p>\"\
        }\
      }\
    },\
    \"CreateReplicaAction\":{\
      \"type\":\"structure\",\
      \"required\":[\"RegionName\"],\
      \"members\":{\
        \"RegionName\":{\
          \"shape\":\"RegionName\",\
          \"documentation\":\"<p>The region of the replica to be added.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a replica to be added.</p>\"\
    },\
    \"CreateTableInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AttributeDefinitions\",\
        \"TableName\",\
        \"KeySchema\"\
      ],\
      \"members\":{\
        \"AttributeDefinitions\":{\
          \"shape\":\"AttributeDefinitions\",\
          \"documentation\":\"<p>An array of attributes that describe the key schema for the table and indexes.</p>\"\
        },\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table to create.</p>\"\
        },\
        \"KeySchema\":{\
          \"shape\":\"KeySchema\",\
          \"documentation\":\"<p>Specifies the attributes that make up the primary key for a table or an index. The attributes in <code>KeySchema</code> must also be defined in the <code>AttributeDefinitions</code> array. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DataModel.html\\\">Data Model</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> <p>Each <code>KeySchemaElement</code> in the array is composed of:</p> <ul> <li> <p> <code>AttributeName</code> - The name of this key attribute.</p> </li> <li> <p> <code>KeyType</code> - The role that the key attribute will assume:</p> <ul> <li> <p> <code>HASH</code> - partition key</p> </li> <li> <p> <code>RANGE</code> - sort key</p> </li> </ul> </li> </ul> <note> <p>The partition key of an item is also known as its <i>hash attribute</i>. The term \\\"hash attribute\\\" derives from DynamoDB' usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values.</p> <p>The sort key of an item is also known as its <i>range attribute</i>. The term \\\"range attribute\\\" derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.</p> </note> <p>For a simple primary key (partition key), you must provide exactly one element with a <code>KeyType</code> of <code>HASH</code>.</p> <p>For a composite primary key (partition key and sort key), you must provide exactly two elements, in this order: The first element must have a <code>KeyType</code> of <code>HASH</code>, and the second element must have a <code>KeyType</code> of <code>RANGE</code>.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#WorkingWithTables.primary.key\\\">Specifying the Primary Key</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"LocalSecondaryIndexes\":{\
          \"shape\":\"LocalSecondaryIndexList\",\
          \"documentation\":\"<p>One or more local secondary indexes (the maximum is 5) to be created on the table. Each index is scoped to a given partition key value. There is a 10 GB size limit per partition key value; otherwise, the size of a local secondary index is unconstrained.</p> <p>Each local secondary index in the array includes the following:</p> <ul> <li> <p> <code>IndexName</code> - The name of the local secondary index. Must be unique only for this table.</p> <p/> </li> <li> <p> <code>KeySchema</code> - Specifies the key schema for the local secondary index. The key schema must begin with the same partition key as the table.</p> </li> <li> <p> <code>Projection</code> - Specifies attributes that are copied (projected) from the table into the index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. Each attribute specification is composed of:</p> <ul> <li> <p> <code>ProjectionType</code> - One of the following:</p> <ul> <li> <p> <code>KEYS_ONLY</code> - Only the index and primary keys are projected into the index.</p> </li> <li> <p> <code>INCLUDE</code> - Only the specified table attributes are projected into the index. The list of projected attributes are in <code>NonKeyAttributes</code>.</p> </li> <li> <p> <code>ALL</code> - All of the table attributes are projected into the index.</p> </li> </ul> </li> <li> <p> <code>NonKeyAttributes</code> - A list of one or more non-key attribute names that are projected into the secondary index. The total count of attributes provided in <code>NonKeyAttributes</code>, summed across all of the secondary indexes, must not exceed 100. If you project the same attribute into two different indexes, this counts as two distinct attributes when determining the total.</p> </li> </ul> </li> </ul>\"\
        },\
        \"GlobalSecondaryIndexes\":{\
          \"shape\":\"GlobalSecondaryIndexList\",\
          \"documentation\":\"<p>One or more global secondary indexes (the maximum is 20) to be created on the table. Each global secondary index in the array includes the following:</p> <ul> <li> <p> <code>IndexName</code> - The name of the global secondary index. Must be unique only for this table.</p> <p/> </li> <li> <p> <code>KeySchema</code> - Specifies the key schema for the global secondary index.</p> </li> <li> <p> <code>Projection</code> - Specifies attributes that are copied (projected) from the table into the index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. Each attribute specification is composed of:</p> <ul> <li> <p> <code>ProjectionType</code> - One of the following:</p> <ul> <li> <p> <code>KEYS_ONLY</code> - Only the index and primary keys are projected into the index.</p> </li> <li> <p> <code>INCLUDE</code> - Only the specified table attributes are projected into the index. The list of projected attributes are in <code>NonKeyAttributes</code>.</p> </li> <li> <p> <code>ALL</code> - All of the table attributes are projected into the index.</p> </li> </ul> </li> <li> <p> <code>NonKeyAttributes</code> - A list of one or more non-key attribute names that are projected into the secondary index. The total count of attributes provided in <code>NonKeyAttributes</code>, summed across all of the secondary indexes, must not exceed 100. If you project the same attribute into two different indexes, this counts as two distinct attributes when determining the total.</p> </li> </ul> </li> <li> <p> <code>ProvisionedThroughput</code> - The provisioned throughput settings for the global secondary index, consisting of read and write capacity units.</p> </li> </ul>\"\
        },\
        \"BillingMode\":{\
          \"shape\":\"BillingMode\",\
          \"documentation\":\"<p>Controls how you are charged for read and write throughput and how you manage capacity. This setting can be changed later.</p> <ul> <li> <p> <code>PROVISIONED</code> - Sets the billing mode to <code>PROVISIONED</code>. We recommend using <code>PROVISIONED</code> for predictable workloads.</p> </li> <li> <p> <code>PAY_PER_REQUEST</code> - Sets the billing mode to <code>PAY_PER_REQUEST</code>. We recommend using <code>PAY_PER_REQUEST</code> for unpredictable workloads. </p> </li> </ul>\"\
        },\
        \"ProvisionedThroughput\":{\
          \"shape\":\"ProvisionedThroughput\",\
          \"documentation\":\"<p>Represents the provisioned throughput settings for a specified table or index. The settings can be modified using the <code>UpdateTable</code> operation.</p> <p> If you set BillingMode as <code>PROVISIONED</code>, you must specify this property. If you set BillingMode as <code>PAY_PER_REQUEST</code>, you cannot specify this property. </p> <p>For current minimum and maximum provisioned throughput values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html\\\">Limits</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"StreamSpecification\":{\
          \"shape\":\"StreamSpecification\",\
          \"documentation\":\"<p>The settings for DynamoDB Streams on the table. These settings consist of:</p> <ul> <li> <p> <code>StreamEnabled</code> - Indicates whether Streams is to be enabled (true) or disabled (false).</p> </li> <li> <p> <code>StreamViewType</code> - When an item in the table is modified, <code>StreamViewType</code> determines what information is written to the table's stream. Valid values for <code>StreamViewType</code> are:</p> <ul> <li> <p> <code>KEYS_ONLY</code> - Only the key attributes of the modified item are written to the stream.</p> </li> <li> <p> <code>NEW_IMAGE</code> - The entire item, as it appears after it was modified, is written to the stream.</p> </li> <li> <p> <code>OLD_IMAGE</code> - The entire item, as it appeared before it was modified, is written to the stream.</p> </li> <li> <p> <code>NEW_AND_OLD_IMAGES</code> - Both the new and the old item images of the item are written to the stream.</p> </li> </ul> </li> </ul>\"\
        },\
        \"SSESpecification\":{\
          \"shape\":\"SSESpecification\",\
          \"documentation\":\"<p>Represents the settings used to enable server-side encryption.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of a <code>CreateTable</code> operation.</p>\"\
    },\
    \"CreateTableOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TableDescription\":{\
          \"shape\":\"TableDescription\",\
          \"documentation\":\"<p>Represents the properties of the table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>CreateTable</code> operation.</p>\"\
    },\
    \"Date\":{\"type\":\"timestamp\"},\
    \"Delete\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Key\",\
        \"TableName\"\
      ],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>The primary key of the item to be deleted. Each element consists of an attribute name and a value for that attribute.</p>\"\
        },\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>Name of the table in which the item to be deleted resides.</p>\"\
        },\
        \"ConditionExpression\":{\
          \"shape\":\"ConditionExpression\",\
          \"documentation\":\"<p>A condition that must be satisfied in order for a conditional delete to succeed.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression.</p>\"\
        },\
        \"ExpressionAttributeValues\":{\
          \"shape\":\"ExpressionAttributeValueMap\",\
          \"documentation\":\"<p>One or more values that can be substituted in an expression.</p>\"\
        },\
        \"ReturnValuesOnConditionCheckFailure\":{\
          \"shape\":\"ReturnValuesOnConditionCheckFailure\",\
          \"documentation\":\"<p>Use <code>ReturnValuesOnConditionCheckFailure</code> to get the item attributes if the <code>Delete</code> condition fails. For <code>ReturnValuesOnConditionCheckFailure</code>, the valid values are: NONE and ALL_OLD.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a request to perform a <code>DeleteItem</code> operation.</p>\"\
    },\
    \"DeleteBackupInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"BackupArn\"],\
      \"members\":{\
        \"BackupArn\":{\
          \"shape\":\"BackupArn\",\
          \"documentation\":\"<p>The ARN associated with the backup.</p>\"\
        }\
      }\
    },\
    \"DeleteBackupOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"BackupDescription\":{\
          \"shape\":\"BackupDescription\",\
          \"documentation\":\"<p>Contains the description of the backup created for the table.</p>\"\
        }\
      }\
    },\
    \"DeleteGlobalSecondaryIndexAction\":{\
      \"type\":\"structure\",\
      \"required\":[\"IndexName\"],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of the global secondary index to be deleted.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a global secondary index to be deleted from an existing table.</p>\"\
    },\
    \"DeleteItemInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TableName\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table from which to delete the item.</p>\"\
        },\
        \"Key\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>A map of attribute names to <code>AttributeValue</code> objects, representing the primary key of the item to delete.</p> <p>For the primary key, you must provide all of the attributes. For example, with a simple primary key, you only need to provide a value for the partition key. For a composite primary key, you must provide values for both the partition key and the sort key.</p>\"\
        },\
        \"Expected\":{\
          \"shape\":\"ExpectedAttributeMap\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>ConditionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.Expected.html\\\">Expected</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ConditionalOperator\":{\
          \"shape\":\"ConditionalOperator\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>ConditionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.ConditionalOperator.html\\\">ConditionalOperator</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ReturnValues\":{\
          \"shape\":\"ReturnValue\",\
          \"documentation\":\"<p>Use <code>ReturnValues</code> if you want to get the item attributes as they appeared before they were deleted. For <code>DeleteItem</code>, the valid values are:</p> <ul> <li> <p> <code>NONE</code> - If <code>ReturnValues</code> is not specified, or if its value is <code>NONE</code>, then nothing is returned. (This setting is the default for <code>ReturnValues</code>.)</p> </li> <li> <p> <code>ALL_OLD</code> - The content of the old item is returned.</p> </li> </ul> <note> <p>The <code>ReturnValues</code> parameter is used by several DynamoDB operations; however, <code>DeleteItem</code> does not recognize any values other than <code>NONE</code> or <code>ALL_OLD</code>.</p> </note>\"\
        },\
        \"ReturnConsumedCapacity\":{\"shape\":\"ReturnConsumedCapacity\"},\
        \"ReturnItemCollectionMetrics\":{\
          \"shape\":\"ReturnItemCollectionMetrics\",\
          \"documentation\":\"<p>Determines whether item collection metrics are returned. If set to <code>SIZE</code>, the response includes statistics about item collections, if any, that were modified during the operation are returned in the response. If set to <code>NONE</code> (the default), no statistics are returned.</p>\"\
        },\
        \"ConditionExpression\":{\
          \"shape\":\"ConditionExpression\",\
          \"documentation\":\"<p>A condition that must be satisfied in order for a conditional <code>DeleteItem</code> to succeed.</p> <p>An expression can contain any of the following:</p> <ul> <li> <p>Functions: <code>attribute_exists | attribute_not_exists | attribute_type | contains | begins_with | size</code> </p> <p>These function names are case-sensitive.</p> </li> <li> <p>Comparison operators: <code>= | &lt;&gt; | &lt; | &gt; | &lt;= | &gt;= | BETWEEN | IN </code> </p> </li> <li> <p> Logical operators: <code>AND | OR | NOT</code> </p> </li> </ul> <p>For more information on condition expressions, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html\\\">Specifying Conditions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression. The following are some use cases for using <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p>To access an attribute whose name conflicts with a DynamoDB reserved word.</p> </li> <li> <p>To create a placeholder for repeating occurrences of an attribute name in an expression.</p> </li> <li> <p>To prevent special characters in an attribute name from being misinterpreted in an expression.</p> </li> </ul> <p>Use the <b>#</b> character in an expression to dereference an attribute name. For example, consider the following attribute name:</p> <ul> <li> <p> <code>Percentile</code> </p> </li> </ul> <p>The name of this attribute conflicts with a reserved word, so it cannot be used directly in an expression. (For the complete list of reserved words, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html\\\">Reserved Words</a> in the <i>Amazon DynamoDB Developer Guide</i>). To work around this, you could specify the following for <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p> <code>{\\\"#P\\\":\\\"Percentile\\\"}</code> </p> </li> </ul> <p>You could then use this substitution in an expression, as in this example:</p> <ul> <li> <p> <code>#P = :val</code> </p> </li> </ul> <note> <p>Tokens that begin with the <b>:</b> character are <i>expression attribute values</i>, which are placeholders for the actual value at runtime.</p> </note> <p>For more information on expression attribute names, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeValues\":{\
          \"shape\":\"ExpressionAttributeValueMap\",\
          \"documentation\":\"<p>One or more values that can be substituted in an expression.</p> <p>Use the <b>:</b> (colon) character in an expression to dereference an attribute value. For example, suppose that you wanted to check whether the value of the <i>ProductStatus</i> attribute was one of the following: </p> <p> <code>Available | Backordered | Discontinued</code> </p> <p>You would first need to specify <code>ExpressionAttributeValues</code> as follows:</p> <p> <code>{ \\\":avail\\\":{\\\"S\\\":\\\"Available\\\"}, \\\":back\\\":{\\\"S\\\":\\\"Backordered\\\"}, \\\":disc\\\":{\\\"S\\\":\\\"Discontinued\\\"} }</code> </p> <p>You could then use these values in an expression, such as this:</p> <p> <code>ProductStatus IN (:avail, :back, :disc)</code> </p> <p>For more information on expression attribute values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html\\\">Specifying Conditions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of a <code>DeleteItem</code> operation.</p>\"\
    },\
    \"DeleteItemOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Attributes\":{\
          \"shape\":\"AttributeMap\",\
          \"documentation\":\"<p>A map of attribute names to <code>AttributeValue</code> objects, representing the item as it appeared before the <code>DeleteItem</code> operation. This map appears in the response only if <code>ReturnValues</code> was specified as <code>ALL_OLD</code> in the request.</p>\"\
        },\
        \"ConsumedCapacity\":{\
          \"shape\":\"ConsumedCapacity\",\
          \"documentation\":\"<p>The capacity units consumed by the <code>DeleteItem</code> operation. The data returned includes the total provisioned throughput consumed, along with statistics for the table and any indexes involved in the operation. <code>ConsumedCapacity</code> is only returned if the <code>ReturnConsumedCapacity</code> parameter was specified. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughputIntro.html\\\">Provisioned Throughput</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ItemCollectionMetrics\":{\
          \"shape\":\"ItemCollectionMetrics\",\
          \"documentation\":\"<p>Information about item collections, if any, that were affected by the <code>DeleteItem</code> operation. <code>ItemCollectionMetrics</code> is only returned if the <code>ReturnItemCollectionMetrics</code> parameter was specified. If the table does not have any local secondary indexes, this information is not returned in the response.</p> <p>Each <code>ItemCollectionMetrics</code> element consists of:</p> <ul> <li> <p> <code>ItemCollectionKey</code> - The partition key value of the item collection. This is the same as the partition key value of the item itself.</p> </li> <li> <p> <code>SizeEstimateRangeGB</code> - An estimate of item collection size, in gigabytes. This value is a two-element array containing a lower bound and an upper bound for the estimate. The estimate includes the size of all the items in the table, plus the size of all attributes projected into all of the local secondary indexes on that table. Use this estimate to measure whether a local secondary index is approaching its size limit.</p> <p>The estimate is subject to change over time; therefore, do not rely on the precision or accuracy of the estimate.</p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>DeleteItem</code> operation.</p>\"\
    },\
    \"DeleteReplicaAction\":{\
      \"type\":\"structure\",\
      \"required\":[\"RegionName\"],\
      \"members\":{\
        \"RegionName\":{\
          \"shape\":\"RegionName\",\
          \"documentation\":\"<p>The region of the replica to be removed.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a replica to be removed.</p>\"\
    },\
    \"DeleteRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Key\"],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>A map of attribute name to attribute values, representing the primary key of the item to delete. All of the table's primary key attributes must be specified, and their data types must match those of the table's key schema.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a request to perform a <code>DeleteItem</code> operation on an item.</p>\"\
    },\
    \"DeleteTableInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TableName\"],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table to delete.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of a <code>DeleteTable</code> operation.</p>\"\
    },\
    \"DeleteTableOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TableDescription\":{\
          \"shape\":\"TableDescription\",\
          \"documentation\":\"<p>Represents the properties of a table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>DeleteTable</code> operation.</p>\"\
    },\
    \"DescribeBackupInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"BackupArn\"],\
      \"members\":{\
        \"BackupArn\":{\
          \"shape\":\"BackupArn\",\
          \"documentation\":\"<p>The ARN associated with the backup.</p>\"\
        }\
      }\
    },\
    \"DescribeBackupOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"BackupDescription\":{\
          \"shape\":\"BackupDescription\",\
          \"documentation\":\"<p>Contains the description of the backup created for the table.</p>\"\
        }\
      }\
    },\
    \"DescribeContinuousBackupsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TableName\"],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>Name of the table for which the customer wants to check the continuous backups and point in time recovery settings.</p>\"\
        }\
      }\
    },\
    \"DescribeContinuousBackupsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ContinuousBackupsDescription\":{\
          \"shape\":\"ContinuousBackupsDescription\",\
          \"documentation\":\"<p>Represents the continuous backups and point in time recovery settings on the table.</p>\"\
        }\
      }\
    },\
    \"DescribeEndpointsRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DescribeEndpointsResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Endpoints\"],\
      \"members\":{\
        \"Endpoints\":{\
          \"shape\":\"Endpoints\",\
          \"documentation\":\"<p>List of endpoints.</p>\"\
        }\
      }\
    },\
    \"DescribeGlobalTableInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"GlobalTableName\"],\
      \"members\":{\
        \"GlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the global table.</p>\"\
        }\
      }\
    },\
    \"DescribeGlobalTableOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GlobalTableDescription\":{\
          \"shape\":\"GlobalTableDescription\",\
          \"documentation\":\"<p>Contains the details of the global table.</p>\"\
        }\
      }\
    },\
    \"DescribeGlobalTableSettingsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"GlobalTableName\"],\
      \"members\":{\
        \"GlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the global table to describe.</p>\"\
        }\
      }\
    },\
    \"DescribeGlobalTableSettingsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the global table.</p>\"\
        },\
        \"ReplicaSettings\":{\
          \"shape\":\"ReplicaSettingsDescriptionList\",\
          \"documentation\":\"<p>The region specific settings for the global table.</p>\"\
        }\
      }\
    },\
    \"DescribeLimitsInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Represents the input of a <code>DescribeLimits</code> operation. Has no content.</p>\"\
    },\
    \"DescribeLimitsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AccountMaxReadCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum total read capacity units that your account allows you to provision across all of your tables in this region.</p>\"\
        },\
        \"AccountMaxWriteCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum total write capacity units that your account allows you to provision across all of your tables in this region.</p>\"\
        },\
        \"TableMaxReadCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum read capacity units that your account allows you to provision for a new table that you are creating in this region, including the read capacity units provisioned for its global secondary indexes (GSIs).</p>\"\
        },\
        \"TableMaxWriteCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum write capacity units that your account allows you to provision for a new table that you are creating in this region, including the write capacity units provisioned for its global secondary indexes (GSIs).</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>DescribeLimits</code> operation.</p>\"\
    },\
    \"DescribeTableInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TableName\"],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table to describe.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of a <code>DescribeTable</code> operation.</p>\"\
    },\
    \"DescribeTableOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Table\":{\
          \"shape\":\"TableDescription\",\
          \"documentation\":\"<p>The properties of the table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>DescribeTable</code> operation.</p>\"\
    },\
    \"DescribeTimeToLiveInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TableName\"],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table to be described.</p>\"\
        }\
      }\
    },\
    \"DescribeTimeToLiveOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TimeToLiveDescription\":{\
          \"shape\":\"TimeToLiveDescription\",\
          \"documentation\":\"<p/>\"\
        }\
      }\
    },\
    \"Double\":{\"type\":\"double\"},\
    \"Endpoint\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Address\",\
        \"CachePeriodInMinutes\"\
      ],\
      \"members\":{\
        \"Address\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>IP address of the endpoint.</p>\"\
        },\
        \"CachePeriodInMinutes\":{\
          \"shape\":\"Long\",\
          \"documentation\":\"<p>Endpoint cache time to live (TTL) value.</p>\"\
        }\
      },\
      \"documentation\":\"<p>An endpoint information details.</p>\"\
    },\
    \"Endpoints\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Endpoint\"}\
    },\
    \"ErrorMessage\":{\"type\":\"string\"},\
    \"ExpectedAttributeMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"AttributeName\"},\
      \"value\":{\"shape\":\"ExpectedAttributeValue\"}\
    },\
    \"ExpectedAttributeValue\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Value\":{\
          \"shape\":\"AttributeValue\",\
          \"documentation\":\"<p>Represents the data for the expected attribute.</p> <p>Each attribute value is described as a name-value pair. The name is the data type, and the value is the data itself.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypes\\\">Data Types</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"Exists\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Causes DynamoDB to evaluate the value before attempting a conditional operation:</p> <ul> <li> <p>If <code>Exists</code> is <code>true</code>, DynamoDB will check to see if that attribute value already exists in the table. If it is found, then the operation succeeds. If it is not found, the operation fails with a <code>ConditionCheckFailedException</code>.</p> </li> <li> <p>If <code>Exists</code> is <code>false</code>, DynamoDB assumes that the attribute value does not exist in the table. If in fact the value does not exist, then the assumption is valid and the operation succeeds. If the value is found, despite the assumption that it does not exist, the operation fails with a <code>ConditionCheckFailedException</code>.</p> </li> </ul> <p>The default setting for <code>Exists</code> is <code>true</code>. If you supply a <code>Value</code> all by itself, DynamoDB assumes the attribute exists: You don't have to set <code>Exists</code> to <code>true</code>, because it is implied.</p> <p>DynamoDB returns a <code>ValidationException</code> if:</p> <ul> <li> <p> <code>Exists</code> is <code>true</code> but there is no <code>Value</code> to check. (You expect a value to exist, but don't specify what that value is.)</p> </li> <li> <p> <code>Exists</code> is <code>false</code> but you also provide a <code>Value</code>. (You cannot expect an attribute to have a value, while also expecting it not to exist.)</p> </li> </ul>\"\
        },\
        \"ComparisonOperator\":{\
          \"shape\":\"ComparisonOperator\",\
          \"documentation\":\"<p>A comparator for evaluating attributes in the <code>AttributeValueList</code>. For example, equals, greater than, less than, etc.</p> <p>The following comparison operators are available:</p> <p> <code>EQ | NE | LE | LT | GE | GT | NOT_NULL | NULL | CONTAINS | NOT_CONTAINS | BEGINS_WITH | IN | BETWEEN</code> </p> <p>The following are descriptions of each comparison operator.</p> <ul> <li> <p> <code>EQ</code> : Equal. <code>EQ</code> is supported for all data types, including lists and maps.</p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, Binary, String Set, Number Set, or Binary Set. If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not equal <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>NE</code> : Not equal. <code>NE</code> is supported for all data types, including lists and maps.</p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> of type String, Number, Binary, String Set, Number Set, or Binary Set. If an item contains an <code>AttributeValue</code> of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not equal <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>LE</code> : Less than or equal. </p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, or Binary (not a set type). If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>LT</code> : Less than. </p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> of type String, Number, or Binary (not a set type). If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>GE</code> : Greater than or equal. </p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, or Binary (not a set type). If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>GT</code> : Greater than. </p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, or Binary (not a set type). If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not equal <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code>.</p> <p/> </li> <li> <p> <code>NOT_NULL</code> : The attribute exists. <code>NOT_NULL</code> is supported for all data types, including lists and maps.</p> <note> <p>This operator tests for the existence of an attribute, not its data type. If the data type of attribute \\\"<code>a</code>\\\" is null, and you evaluate it using <code>NOT_NULL</code>, the result is a Boolean <code>true</code>. This result is because the attribute \\\"<code>a</code>\\\" exists; its data type is not relevant to the <code>NOT_NULL</code> comparison operator.</p> </note> </li> <li> <p> <code>NULL</code> : The attribute does not exist. <code>NULL</code> is supported for all data types, including lists and maps.</p> <note> <p>This operator tests for the nonexistence of an attribute, not its data type. If the data type of attribute \\\"<code>a</code>\\\" is null, and you evaluate it using <code>NULL</code>, the result is a Boolean <code>false</code>. This is because the attribute \\\"<code>a</code>\\\" exists; its data type is not relevant to the <code>NULL</code> comparison operator.</p> </note> </li> <li> <p> <code>CONTAINS</code> : Checks for a subsequence, or value in a set.</p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, or Binary (not a set type). If the target attribute of the comparison is of type String, then the operator checks for a substring match. If the target attribute of the comparison is of type Binary, then the operator looks for a subsequence of the target that matches the input. If the target attribute of the comparison is a set (\\\"<code>SS</code>\\\", \\\"<code>NS</code>\\\", or \\\"<code>BS</code>\\\"), then the operator evaluates to true if it finds an exact match with any member of the set.</p> <p>CONTAINS is supported for lists: When evaluating \\\"<code>a CONTAINS b</code>\\\", \\\"<code>a</code>\\\" can be a list; however, \\\"<code>b</code>\\\" cannot be a set, a map, or a list.</p> </li> <li> <p> <code>NOT_CONTAINS</code> : Checks for absence of a subsequence, or absence of a value in a set.</p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> element of type String, Number, or Binary (not a set type). If the target attribute of the comparison is a String, then the operator checks for the absence of a substring match. If the target attribute of the comparison is Binary, then the operator checks for the absence of a subsequence of the target that matches the input. If the target attribute of the comparison is a set (\\\"<code>SS</code>\\\", \\\"<code>NS</code>\\\", or \\\"<code>BS</code>\\\"), then the operator evaluates to true if it <i>does not</i> find an exact match with any member of the set.</p> <p>NOT_CONTAINS is supported for lists: When evaluating \\\"<code>a NOT CONTAINS b</code>\\\", \\\"<code>a</code>\\\" can be a list; however, \\\"<code>b</code>\\\" cannot be a set, a map, or a list.</p> </li> <li> <p> <code>BEGINS_WITH</code> : Checks for a prefix. </p> <p> <code>AttributeValueList</code> can contain only one <code>AttributeValue</code> of type String or Binary (not a Number or a set type). The target attribute of the comparison must be of type String or Binary (not a Number or a set type).</p> <p/> </li> <li> <p> <code>IN</code> : Checks for matching elements in a list.</p> <p> <code>AttributeValueList</code> can contain one or more <code>AttributeValue</code> elements of type String, Number, or Binary. These attributes are compared against an existing attribute of an item. If any elements of the input are equal to the item attribute, the expression evaluates to true.</p> </li> <li> <p> <code>BETWEEN</code> : Greater than or equal to the first value, and less than or equal to the second value. </p> <p> <code>AttributeValueList</code> must contain two <code>AttributeValue</code> elements of the same type, either String, Number, or Binary (not a set type). A target attribute matches if the target value is greater than, or equal to, the first element and less than, or equal to, the second element. If an item contains an <code>AttributeValue</code> element of a different type than the one provided in the request, the value does not match. For example, <code>{\\\"S\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"N\\\":\\\"6\\\"}</code>. Also, <code>{\\\"N\\\":\\\"6\\\"}</code> does not compare to <code>{\\\"NS\\\":[\\\"6\\\", \\\"2\\\", \\\"1\\\"]}</code> </p> </li> </ul>\"\
        },\
        \"AttributeValueList\":{\
          \"shape\":\"AttributeValueList\",\
          \"documentation\":\"<p>One or more values to evaluate against the supplied attribute. The number of values in the list depends on the <code>ComparisonOperator</code> being used.</p> <p>For type Number, value comparisons are numeric.</p> <p>String value comparisons for greater than, equals, or less than are based on ASCII character code values. For example, <code>a</code> is greater than <code>A</code>, and <code>a</code> is greater than <code>B</code>. For a list of code values, see <a href=\\\"http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters\\\">http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters</a>.</p> <p>For Binary, DynamoDB treats each byte of the binary data as unsigned when it compares binary values.</p> <p>For information on specifying data types in JSON, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DataFormat.html\\\">JSON Data Format</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a condition to be compared with an attribute value. This condition can be used with <code>DeleteItem</code>, <code>PutItem</code> or <code>UpdateItem</code> operations; if the comparison evaluates to true, the operation succeeds; if not, the operation fails. You can use <code>ExpectedAttributeValue</code> in one of two different ways:</p> <ul> <li> <p>Use <code>AttributeValueList</code> to specify one or more values to compare against an attribute. Use <code>ComparisonOperator</code> to specify how you want to perform the comparison. If the comparison evaluates to true, then the conditional operation succeeds.</p> </li> <li> <p>Use <code>Value</code> to specify a value that DynamoDB will compare against an attribute. If the values match, then <code>ExpectedAttributeValue</code> evaluates to true and the conditional operation succeeds. Optionally, you can also set <code>Exists</code> to false, indicating that you <i>do not</i> expect to find the attribute value in the table. In this case, the conditional operation succeeds only if the comparison evaluates to false.</p> </li> </ul> <p> <code>Value</code> and <code>Exists</code> are incompatible with <code>AttributeValueList</code> and <code>ComparisonOperator</code>. Note that if you use both sets of parameters at once, DynamoDB will return a <code>ValidationException</code> exception.</p>\"\
    },\
    \"ExpressionAttributeNameMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"ExpressionAttributeNameVariable\"},\
      \"value\":{\"shape\":\"AttributeName\"}\
    },\
    \"ExpressionAttributeNameVariable\":{\"type\":\"string\"},\
    \"ExpressionAttributeValueMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"ExpressionAttributeValueVariable\"},\
      \"value\":{\"shape\":\"AttributeValue\"}\
    },\
    \"ExpressionAttributeValueVariable\":{\"type\":\"string\"},\
    \"FilterConditionMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"AttributeName\"},\
      \"value\":{\"shape\":\"Condition\"}\
    },\
    \"Get\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Key\",\
        \"TableName\"\
      ],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>A map of attribute names to <code>AttributeValue</code> objects that specifies the primary key of the item to retrieve.</p>\"\
        },\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table from which to retrieve the specified item.</p>\"\
        },\
        \"ProjectionExpression\":{\
          \"shape\":\"ProjectionExpression\",\
          \"documentation\":\"<p>A string that identifies one or more attributes of the specified item to retrieve from the table. The attributes in the expression must be separated by commas. If no attribute names are specified, then all attributes of the specified item are returned. If any of the requested attributes are not found, they do not appear in the result.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in the ProjectionExpression parameter.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies an item and related attribute values to retrieve in a <code>TransactGetItem</code> object.</p>\"\
    },\
    \"GetItemInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TableName\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table containing the requested item.</p>\"\
        },\
        \"Key\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>A map of attribute names to <code>AttributeValue</code> objects, representing the primary key of the item to retrieve.</p> <p>For the primary key, you must provide all of the attributes. For example, with a simple primary key, you only need to provide a value for the partition key. For a composite primary key, you must provide values for both the partition key and the sort key.</p>\"\
        },\
        \"AttributesToGet\":{\
          \"shape\":\"AttributeNameList\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>ProjectionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributesToGet.html\\\">AttributesToGet</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ConsistentRead\":{\
          \"shape\":\"ConsistentRead\",\
          \"documentation\":\"<p>Determines the read consistency model: If set to <code>true</code>, then the operation uses strongly consistent reads; otherwise, the operation uses eventually consistent reads.</p>\"\
        },\
        \"ReturnConsumedCapacity\":{\"shape\":\"ReturnConsumedCapacity\"},\
        \"ProjectionExpression\":{\
          \"shape\":\"ProjectionExpression\",\
          \"documentation\":\"<p>A string that identifies one or more attributes to retrieve from the table. These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must be separated by commas.</p> <p>If no attribute names are specified, then all attributes will be returned. If any of the requested attributes are not found, they will not appear in the result.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression. The following are some use cases for using <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p>To access an attribute whose name conflicts with a DynamoDB reserved word.</p> </li> <li> <p>To create a placeholder for repeating occurrences of an attribute name in an expression.</p> </li> <li> <p>To prevent special characters in an attribute name from being misinterpreted in an expression.</p> </li> </ul> <p>Use the <b>#</b> character in an expression to dereference an attribute name. For example, consider the following attribute name:</p> <ul> <li> <p> <code>Percentile</code> </p> </li> </ul> <p>The name of this attribute conflicts with a reserved word, so it cannot be used directly in an expression. (For the complete list of reserved words, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html\\\">Reserved Words</a> in the <i>Amazon DynamoDB Developer Guide</i>). To work around this, you could specify the following for <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p> <code>{\\\"#P\\\":\\\"Percentile\\\"}</code> </p> </li> </ul> <p>You could then use this substitution in an expression, as in this example:</p> <ul> <li> <p> <code>#P = :val</code> </p> </li> </ul> <note> <p>Tokens that begin with the <b>:</b> character are <i>expression attribute values</i>, which are placeholders for the actual value at runtime.</p> </note> <p>For more information on expression attribute names, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of a <code>GetItem</code> operation.</p>\"\
    },\
    \"GetItemOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Item\":{\
          \"shape\":\"AttributeMap\",\
          \"documentation\":\"<p>A map of attribute names to <code>AttributeValue</code> objects, as specified by <code>ProjectionExpression</code>.</p>\"\
        },\
        \"ConsumedCapacity\":{\
          \"shape\":\"ConsumedCapacity\",\
          \"documentation\":\"<p>The capacity units consumed by the <code>GetItem</code> operation. The data returned includes the total provisioned throughput consumed, along with statistics for the table and any indexes involved in the operation. <code>ConsumedCapacity</code> is only returned if the <code>ReturnConsumedCapacity</code> parameter was specified. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughputIntro.html\\\">Provisioned Throughput</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>GetItem</code> operation.</p>\"\
    },\
    \"GlobalSecondaryIndex\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"IndexName\",\
        \"KeySchema\",\
        \"Projection\"\
      ],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of the global secondary index. The name must be unique among all other indexes on this table.</p>\"\
        },\
        \"KeySchema\":{\
          \"shape\":\"KeySchema\",\
          \"documentation\":\"<p>The complete key schema for a global secondary index, which consists of one or more pairs of attribute names and key types:</p> <ul> <li> <p> <code>HASH</code> - partition key</p> </li> <li> <p> <code>RANGE</code> - sort key</p> </li> </ul> <note> <p>The partition key of an item is also known as its <i>hash attribute</i>. The term \\\"hash attribute\\\" derives from DynamoDB' usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values.</p> <p>The sort key of an item is also known as its <i>range attribute</i>. The term \\\"range attribute\\\" derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.</p> </note>\"\
        },\
        \"Projection\":{\
          \"shape\":\"Projection\",\
          \"documentation\":\"<p>Represents attributes that are copied (projected) from the table into the global secondary index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. </p>\"\
        },\
        \"ProvisionedThroughput\":{\
          \"shape\":\"ProvisionedThroughput\",\
          \"documentation\":\"<p>Represents the provisioned throughput settings for the specified global secondary index.</p> <p>For current minimum and maximum provisioned throughput values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html\\\">Limits</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a global secondary index.</p>\"\
    },\
    \"GlobalSecondaryIndexDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of the global secondary index.</p>\"\
        },\
        \"KeySchema\":{\
          \"shape\":\"KeySchema\",\
          \"documentation\":\"<p>The complete key schema for a global secondary index, which consists of one or more pairs of attribute names and key types:</p> <ul> <li> <p> <code>HASH</code> - partition key</p> </li> <li> <p> <code>RANGE</code> - sort key</p> </li> </ul> <note> <p>The partition key of an item is also known as its <i>hash attribute</i>. The term \\\"hash attribute\\\" derives from DynamoDB' usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values.</p> <p>The sort key of an item is also known as its <i>range attribute</i>. The term \\\"range attribute\\\" derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.</p> </note>\"\
        },\
        \"Projection\":{\
          \"shape\":\"Projection\",\
          \"documentation\":\"<p>Represents attributes that are copied (projected) from the table into the global secondary index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. </p>\"\
        },\
        \"IndexStatus\":{\
          \"shape\":\"IndexStatus\",\
          \"documentation\":\"<p>The current state of the global secondary index:</p> <ul> <li> <p> <code>CREATING</code> - The index is being created.</p> </li> <li> <p> <code>UPDATING</code> - The index is being updated.</p> </li> <li> <p> <code>DELETING</code> - The index is being deleted.</p> </li> <li> <p> <code>ACTIVE</code> - The index is ready for use.</p> </li> </ul>\"\
        },\
        \"Backfilling\":{\
          \"shape\":\"Backfilling\",\
          \"documentation\":\"<p>Indicates whether the index is currently backfilling. <i>Backfilling</i> is the process of reading items from the table and determining whether they can be added to the index. (Not all items will qualify: For example, a partition key cannot have any duplicate values.) If an item can be added to the index, DynamoDB will do so. After all items have been processed, the backfilling operation is complete and <code>Backfilling</code> is false.</p> <note> <p>For indexes that were created during a <code>CreateTable</code> operation, the <code>Backfilling</code> attribute does not appear in the <code>DescribeTable</code> output.</p> </note>\"\
        },\
        \"ProvisionedThroughput\":{\
          \"shape\":\"ProvisionedThroughputDescription\",\
          \"documentation\":\"<p>Represents the provisioned throughput settings for the specified global secondary index.</p> <p>For current minimum and maximum provisioned throughput values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html\\\">Limits</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"IndexSizeBytes\":{\
          \"shape\":\"Long\",\
          \"documentation\":\"<p>The total size of the specified index, in bytes. DynamoDB updates this value approximately every six hours. Recent changes might not be reflected in this value.</p>\"\
        },\
        \"ItemCount\":{\
          \"shape\":\"Long\",\
          \"documentation\":\"<p>The number of items in the specified index. DynamoDB updates this value approximately every six hours. Recent changes might not be reflected in this value.</p>\"\
        },\
        \"IndexArn\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) that uniquely identifies the index.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a global secondary index.</p>\"\
    },\
    \"GlobalSecondaryIndexDescriptionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GlobalSecondaryIndexDescription\"}\
    },\
    \"GlobalSecondaryIndexInfo\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of the global secondary index.</p>\"\
        },\
        \"KeySchema\":{\
          \"shape\":\"KeySchema\",\
          \"documentation\":\"<p>The complete key schema for a global secondary index, which consists of one or more pairs of attribute names and key types:</p> <ul> <li> <p> <code>HASH</code> - partition key</p> </li> <li> <p> <code>RANGE</code> - sort key</p> </li> </ul> <note> <p>The partition key of an item is also known as its <i>hash attribute</i>. The term \\\"hash attribute\\\" derives from DynamoDB' usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values.</p> <p>The sort key of an item is also known as its <i>range attribute</i>. The term \\\"range attribute\\\" derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.</p> </note>\"\
        },\
        \"Projection\":{\
          \"shape\":\"Projection\",\
          \"documentation\":\"<p>Represents attributes that are copied (projected) from the table into the global secondary index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. </p>\"\
        },\
        \"ProvisionedThroughput\":{\
          \"shape\":\"ProvisionedThroughput\",\
          \"documentation\":\"<p>Represents the provisioned throughput settings for the specified global secondary index. </p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a global secondary index for the table when the backup was created.</p>\"\
    },\
    \"GlobalSecondaryIndexList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GlobalSecondaryIndex\"}\
    },\
    \"GlobalSecondaryIndexUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Update\":{\
          \"shape\":\"UpdateGlobalSecondaryIndexAction\",\
          \"documentation\":\"<p>The name of an existing global secondary index, along with new provisioned throughput settings to be applied to that index.</p>\"\
        },\
        \"Create\":{\
          \"shape\":\"CreateGlobalSecondaryIndexAction\",\
          \"documentation\":\"<p>The parameters required for creating a global secondary index on an existing table:</p> <ul> <li> <p> <code>IndexName </code> </p> </li> <li> <p> <code>KeySchema </code> </p> </li> <li> <p> <code>AttributeDefinitions </code> </p> </li> <li> <p> <code>Projection </code> </p> </li> <li> <p> <code>ProvisionedThroughput </code> </p> </li> </ul>\"\
        },\
        \"Delete\":{\
          \"shape\":\"DeleteGlobalSecondaryIndexAction\",\
          \"documentation\":\"<p>The name of an existing global secondary index to be removed.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents one of the following:</p> <ul> <li> <p>A new global secondary index to be added to an existing table.</p> </li> <li> <p>New provisioned throughput parameters for an existing global secondary index.</p> </li> <li> <p>An existing global secondary index to be removed from an existing table.</p> </li> </ul>\"\
    },\
    \"GlobalSecondaryIndexUpdateList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GlobalSecondaryIndexUpdate\"}\
    },\
    \"GlobalSecondaryIndexes\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GlobalSecondaryIndexInfo\"}\
    },\
    \"GlobalTable\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The global table name.</p>\"\
        },\
        \"ReplicationGroup\":{\
          \"shape\":\"ReplicaList\",\
          \"documentation\":\"<p>The regions where the global table has replicas.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a global table.</p>\"\
    },\
    \"GlobalTableAlreadyExistsException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>The specified global table already exists.</p>\",\
      \"exception\":true\
    },\
    \"GlobalTableArnString\":{\"type\":\"string\"},\
    \"GlobalTableDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ReplicationGroup\":{\
          \"shape\":\"ReplicaDescriptionList\",\
          \"documentation\":\"<p>The regions where the global table has replicas.</p>\"\
        },\
        \"GlobalTableArn\":{\
          \"shape\":\"GlobalTableArnString\",\
          \"documentation\":\"<p>The unique identifier of the global table.</p>\"\
        },\
        \"CreationDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>The creation time of the global table.</p>\"\
        },\
        \"GlobalTableStatus\":{\
          \"shape\":\"GlobalTableStatus\",\
          \"documentation\":\"<p>The current state of the global table:</p> <ul> <li> <p> <code>CREATING</code> - The global table is being created.</p> </li> <li> <p> <code>UPDATING</code> - The global table is being updated.</p> </li> <li> <p> <code>DELETING</code> - The global table is being deleted.</p> </li> <li> <p> <code>ACTIVE</code> - The global table is ready for use.</p> </li> </ul>\"\
        },\
        \"GlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The global table name.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains details about the global table.</p>\"\
    },\
    \"GlobalTableGlobalSecondaryIndexSettingsUpdate\":{\
      \"type\":\"structure\",\
      \"required\":[\"IndexName\"],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of the global secondary index. The name must be unique among all other indexes on this table.</p>\"\
        },\
        \"ProvisionedWriteCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum number of writes consumed per second before DynamoDB returns a <code>ThrottlingException.</code> </p>\"\
        },\
        \"ProvisionedWriteCapacityAutoScalingSettingsUpdate\":{\
          \"shape\":\"AutoScalingSettingsUpdate\",\
          \"documentation\":\"<p>AutoScaling settings for managing a global secondary index's write capacity units.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the settings of a global secondary index for a global table that will be modified.</p>\"\
    },\
    \"GlobalTableGlobalSecondaryIndexSettingsUpdateList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GlobalTableGlobalSecondaryIndexSettingsUpdate\"},\
      \"max\":20,\
      \"min\":1\
    },\
    \"GlobalTableList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GlobalTable\"}\
    },\
    \"GlobalTableNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>The specified global table does not exist.</p>\",\
      \"exception\":true\
    },\
    \"GlobalTableStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CREATING\",\
        \"ACTIVE\",\
        \"DELETING\",\
        \"UPDATING\"\
      ]\
    },\
    \"IdempotentParameterMismatchException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>DynamoDB rejected the request because you retried a request with a different payload but with an idempotent token that was already used.</p>\",\
      \"exception\":true\
    },\
    \"IndexName\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":3,\
      \"pattern\":\"[a-zA-Z0-9_.-]+\"\
    },\
    \"IndexNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>The operation tried to access a nonexistent index.</p>\",\
      \"exception\":true\
    },\
    \"IndexStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CREATING\",\
        \"UPDATING\",\
        \"DELETING\",\
        \"ACTIVE\"\
      ]\
    },\
    \"Integer\":{\"type\":\"integer\"},\
    \"IntegerObject\":{\"type\":\"integer\"},\
    \"InternalServerError\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>The server encountered an internal error trying to fulfill the request.</p>\"\
        }\
      },\
      \"documentation\":\"<p>An error occurred on the server side.</p>\",\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"InvalidRestoreTimeException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>An invalid restore time was specified. RestoreDateTime must be between EarliestRestorableDateTime and LatestRestorableDateTime.</p>\",\
      \"exception\":true\
    },\
    \"ItemCollectionKeyAttributeMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"AttributeName\"},\
      \"value\":{\"shape\":\"AttributeValue\"}\
    },\
    \"ItemCollectionMetrics\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ItemCollectionKey\":{\
          \"shape\":\"ItemCollectionKeyAttributeMap\",\
          \"documentation\":\"<p>The partition key value of the item collection. This value is the same as the partition key value of the item.</p>\"\
        },\
        \"SizeEstimateRangeGB\":{\
          \"shape\":\"ItemCollectionSizeEstimateRange\",\
          \"documentation\":\"<p>An estimate of item collection size, in gigabytes. This value is a two-element array containing a lower bound and an upper bound for the estimate. The estimate includes the size of all the items in the table, plus the size of all attributes projected into all of the local secondary indexes on that table. Use this estimate to measure whether a local secondary index is approaching its size limit.</p> <p>The estimate is subject to change over time; therefore, do not rely on the precision or accuracy of the estimate.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Information about item collections, if any, that were affected by the operation. <code>ItemCollectionMetrics</code> is only returned if the request asked for it. If the table does not have any local secondary indexes, this information is not returned in the response.</p>\"\
    },\
    \"ItemCollectionMetricsMultiple\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ItemCollectionMetrics\"}\
    },\
    \"ItemCollectionMetricsPerTable\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"TableName\"},\
      \"value\":{\"shape\":\"ItemCollectionMetricsMultiple\"}\
    },\
    \"ItemCollectionSizeEstimateBound\":{\"type\":\"double\"},\
    \"ItemCollectionSizeEstimateRange\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ItemCollectionSizeEstimateBound\"}\
    },\
    \"ItemCollectionSizeLimitExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>The total size of an item collection has exceeded the maximum limit of 10 gigabytes.</p>\"\
        }\
      },\
      \"documentation\":\"<p>An item collection is too large. This exception is only returned for tables that have one or more local secondary indexes.</p>\",\
      \"exception\":true\
    },\
    \"ItemCount\":{\
      \"type\":\"long\",\
      \"min\":0\
    },\
    \"ItemList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AttributeMap\"}\
    },\
    \"ItemResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Item\":{\
          \"shape\":\"AttributeMap\",\
          \"documentation\":\"<p>Map of attribute data consisting of the data type and attribute value.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Details for the requested item.</p>\"\
    },\
    \"ItemResponseList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ItemResponse\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"KMSMasterKeyArn\":{\"type\":\"string\"},\
    \"KMSMasterKeyId\":{\"type\":\"string\"},\
    \"Key\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"AttributeName\"},\
      \"value\":{\"shape\":\"AttributeValue\"}\
    },\
    \"KeyConditions\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"AttributeName\"},\
      \"value\":{\"shape\":\"Condition\"}\
    },\
    \"KeyExpression\":{\"type\":\"string\"},\
    \"KeyList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Key\"},\
      \"max\":100,\
      \"min\":1\
    },\
    \"KeySchema\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"KeySchemaElement\"},\
      \"max\":2,\
      \"min\":1\
    },\
    \"KeySchemaAttributeName\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1\
    },\
    \"KeySchemaElement\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AttributeName\",\
        \"KeyType\"\
      ],\
      \"members\":{\
        \"AttributeName\":{\
          \"shape\":\"KeySchemaAttributeName\",\
          \"documentation\":\"<p>The name of a key attribute.</p>\"\
        },\
        \"KeyType\":{\
          \"shape\":\"KeyType\",\
          \"documentation\":\"<p>The role that this key attribute will assume:</p> <ul> <li> <p> <code>HASH</code> - partition key</p> </li> <li> <p> <code>RANGE</code> - sort key</p> </li> </ul> <note> <p>The partition key of an item is also known as its <i>hash attribute</i>. The term \\\"hash attribute\\\" derives from DynamoDB' usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values.</p> <p>The sort key of an item is also known as its <i>range attribute</i>. The term \\\"range attribute\\\" derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.</p> </note>\"\
        }\
      },\
      \"documentation\":\"<p>Represents <i>a single element</i> of a key schema. A key schema specifies the attributes that make up the primary key of a table, or the key attributes of an index.</p> <p>A <code>KeySchemaElement</code> represents exactly one attribute of the primary key. For example, a simple primary key would be represented by one <code>KeySchemaElement</code> (for the partition key). A composite primary key would require one <code>KeySchemaElement</code> for the partition key, and another <code>KeySchemaElement</code> for the sort key.</p> <p>A <code>KeySchemaElement</code> must be a scalar, top-level attribute (not a nested attribute). The data type must be one of String, Number, or Binary. The attribute cannot be nested within a List or a Map.</p>\"\
    },\
    \"KeyType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"HASH\",\
        \"RANGE\"\
      ]\
    },\
    \"KeysAndAttributes\":{\
      \"type\":\"structure\",\
      \"required\":[\"Keys\"],\
      \"members\":{\
        \"Keys\":{\
          \"shape\":\"KeyList\",\
          \"documentation\":\"<p>The primary key attribute values that define the items and the attributes associated with the items.</p>\"\
        },\
        \"AttributesToGet\":{\
          \"shape\":\"AttributeNameList\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>ProjectionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.html\\\">Legacy Conditional Parameters</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ConsistentRead\":{\
          \"shape\":\"ConsistentRead\",\
          \"documentation\":\"<p>The consistency of a read operation. If set to <code>true</code>, then a strongly consistent read is used; otherwise, an eventually consistent read is used.</p>\"\
        },\
        \"ProjectionExpression\":{\
          \"shape\":\"ProjectionExpression\",\
          \"documentation\":\"<p>A string that identifies one or more attributes to retrieve from the table. These attributes can include scalars, sets, or elements of a JSON document. The attributes in the <code>ProjectionExpression</code> must be separated by commas.</p> <p>If no attribute names are specified, then all attributes will be returned. If any of the requested attributes are not found, they will not appear in the result.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression. The following are some use cases for using <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p>To access an attribute whose name conflicts with a DynamoDB reserved word.</p> </li> <li> <p>To create a placeholder for repeating occurrences of an attribute name in an expression.</p> </li> <li> <p>To prevent special characters in an attribute name from being misinterpreted in an expression.</p> </li> </ul> <p>Use the <b>#</b> character in an expression to dereference an attribute name. For example, consider the following attribute name:</p> <ul> <li> <p> <code>Percentile</code> </p> </li> </ul> <p>The name of this attribute conflicts with a reserved word, so it cannot be used directly in an expression. (For the complete list of reserved words, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html\\\">Reserved Words</a> in the <i>Amazon DynamoDB Developer Guide</i>). To work around this, you could specify the following for <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p> <code>{\\\"#P\\\":\\\"Percentile\\\"}</code> </p> </li> </ul> <p>You could then use this substitution in an expression, as in this example:</p> <ul> <li> <p> <code>#P = :val</code> </p> </li> </ul> <note> <p>Tokens that begin with the <b>:</b> character are <i>expression attribute values</i>, which are placeholders for the actual value at runtime.</p> </note> <p>For more information on expression attribute names, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a set of primary keys and, for each key, the attributes to retrieve from the table.</p> <p>For each primary key, you must provide <i>all</i> of the key attributes. For example, with a simple primary key, you only need to provide the partition key. For a composite primary key, you must provide <i>both</i> the partition key and the sort key.</p>\"\
    },\
    \"LimitExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>Too many operations for a given subscriber.</p>\"\
        }\
      },\
      \"documentation\":\"<p>There is no limit to the number of daily on-demand backups that can be taken. </p> <p>Up to 10 simultaneous table operations are allowed per account. These operations include <code>CreateTable</code>, <code>UpdateTable</code>, <code>DeleteTable</code>,<code>UpdateTimeToLive</code>, <code>RestoreTableFromBackup</code>, and <code>RestoreTableToPointInTime</code>. </p> <p>For tables with secondary indexes, only one of those tables can be in the <code>CREATING</code> state at any point in time. Do not attempt to create more than one such table simultaneously.</p> <p>The total limit of tables in the <code>ACTIVE</code> state is 250.</p>\",\
      \"exception\":true\
    },\
    \"ListAttributeValue\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AttributeValue\"}\
    },\
    \"ListBackupsInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The backups from the table specified by <code>TableName</code> are listed. </p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"BackupsInputLimit\",\
          \"documentation\":\"<p>Maximum number of backups to return at once.</p>\"\
        },\
        \"TimeRangeLowerBound\":{\
          \"shape\":\"TimeRangeLowerBound\",\
          \"documentation\":\"<p>Only backups created after this time are listed. <code>TimeRangeLowerBound</code> is inclusive.</p>\"\
        },\
        \"TimeRangeUpperBound\":{\
          \"shape\":\"TimeRangeUpperBound\",\
          \"documentation\":\"<p>Only backups created before this time are listed. <code>TimeRangeUpperBound</code> is exclusive. </p>\"\
        },\
        \"ExclusiveStartBackupArn\":{\
          \"shape\":\"BackupArn\",\
          \"documentation\":\"<p> <code>LastEvaluatedBackupArn</code> is the ARN of the backup last evaluated when the current page of results was returned, inclusive of the current page of results. This value may be specified as the <code>ExclusiveStartBackupArn</code> of a new <code>ListBackups</code> operation in order to fetch the next page of results. </p>\"\
        },\
        \"BackupType\":{\
          \"shape\":\"BackupTypeFilter\",\
          \"documentation\":\"<p>The backups from the table specified by <code>BackupType</code> are listed.</p> <p>Where <code>BackupType</code> can be:</p> <ul> <li> <p> <code>USER</code> - On-demand backup created by you.</p> </li> <li> <p> <code>SYSTEM</code> - On-demand backup automatically created by DynamoDB.</p> </li> <li> <p> <code>ALL</code> - All types of on-demand backups (USER and SYSTEM).</p> </li> </ul>\"\
        }\
      }\
    },\
    \"ListBackupsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"BackupSummaries\":{\
          \"shape\":\"BackupSummaries\",\
          \"documentation\":\"<p>List of <code>BackupSummary</code> objects.</p>\"\
        },\
        \"LastEvaluatedBackupArn\":{\
          \"shape\":\"BackupArn\",\
          \"documentation\":\"<p> The ARN of the backup last evaluated when the current page of results was returned, inclusive of the current page of results. This value may be specified as the <code>ExclusiveStartBackupArn</code> of a new <code>ListBackups</code> operation in order to fetch the next page of results. </p> <p> If <code>LastEvaluatedBackupArn</code> is empty, then the last page of results has been processed and there are no more results to be retrieved. </p> <p> If <code>LastEvaluatedBackupArn</code> is not empty, this may or may not indicate there is more data to be returned. All results are guaranteed to have been returned if and only if no value for <code>LastEvaluatedBackupArn</code> is returned. </p>\"\
        }\
      }\
    },\
    \"ListGlobalTablesInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ExclusiveStartGlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The first global table name that this operation will evaluate.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"PositiveIntegerObject\",\
          \"documentation\":\"<p>The maximum number of table names to return.</p>\"\
        },\
        \"RegionName\":{\
          \"shape\":\"RegionName\",\
          \"documentation\":\"<p>Lists the global tables in a specific region.</p>\"\
        }\
      }\
    },\
    \"ListGlobalTablesOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GlobalTables\":{\
          \"shape\":\"GlobalTableList\",\
          \"documentation\":\"<p>List of global table names.</p>\"\
        },\
        \"LastEvaluatedGlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>Last evaluated global table name.</p>\"\
        }\
      }\
    },\
    \"ListTablesInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ExclusiveStartTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The first table name that this operation will evaluate. Use the value that was returned for <code>LastEvaluatedTableName</code> in a previous operation, so that you can obtain the next page of results.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"ListTablesInputLimit\",\
          \"documentation\":\"<p>A maximum number of table names to return. If this parameter is not specified, the limit is 100.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of a <code>ListTables</code> operation.</p>\"\
    },\
    \"ListTablesInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":100,\
      \"min\":1\
    },\
    \"ListTablesOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TableNames\":{\
          \"shape\":\"TableNameList\",\
          \"documentation\":\"<p>The names of the tables associated with the current account at the current endpoint. The maximum size of this array is 100.</p> <p>If <code>LastEvaluatedTableName</code> also appears in the output, you can use this value as the <code>ExclusiveStartTableName</code> parameter in a subsequent <code>ListTables</code> request and obtain the next page of results.</p>\"\
        },\
        \"LastEvaluatedTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the last table in the current page of results. Use this value as the <code>ExclusiveStartTableName</code> in a new request to obtain the next page of results, until all the table names are returned.</p> <p>If you do not receive a <code>LastEvaluatedTableName</code> value in the response, this means that there are no more table names to be retrieved.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>ListTables</code> operation.</p>\"\
    },\
    \"ListTagsOfResourceInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"ResourceArn\"],\
      \"members\":{\
        \"ResourceArn\":{\
          \"shape\":\"ResourceArnString\",\
          \"documentation\":\"<p>The Amazon DynamoDB resource with tags to be listed. This value is an Amazon Resource Name (ARN).</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"NextTokenString\",\
          \"documentation\":\"<p>An optional string that, if supplied, must be copied from the output of a previous call to ListTagOfResource. When provided in this manner, this API fetches the next page of results.</p>\"\
        }\
      }\
    },\
    \"ListTagsOfResourceOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Tags\":{\
          \"shape\":\"TagList\",\
          \"documentation\":\"<p>The tags currently associated with the Amazon DynamoDB resource.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"NextTokenString\",\
          \"documentation\":\"<p>If this value is returned, there are additional results to be displayed. To retrieve them, call ListTagsOfResource again, with NextToken set to this value.</p>\"\
        }\
      }\
    },\
    \"LocalSecondaryIndex\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"IndexName\",\
        \"KeySchema\",\
        \"Projection\"\
      ],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of the local secondary index. The name must be unique among all other indexes on this table.</p>\"\
        },\
        \"KeySchema\":{\
          \"shape\":\"KeySchema\",\
          \"documentation\":\"<p>The complete key schema for the local secondary index, consisting of one or more pairs of attribute names and key types:</p> <ul> <li> <p> <code>HASH</code> - partition key</p> </li> <li> <p> <code>RANGE</code> - sort key</p> </li> </ul> <note> <p>The partition key of an item is also known as its <i>hash attribute</i>. The term \\\"hash attribute\\\" derives from DynamoDB' usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values.</p> <p>The sort key of an item is also known as its <i>range attribute</i>. The term \\\"range attribute\\\" derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.</p> </note>\"\
        },\
        \"Projection\":{\
          \"shape\":\"Projection\",\
          \"documentation\":\"<p>Represents attributes that are copied (projected) from the table into the local secondary index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. </p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a local secondary index.</p>\"\
    },\
    \"LocalSecondaryIndexDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>Represents the name of the local secondary index.</p>\"\
        },\
        \"KeySchema\":{\
          \"shape\":\"KeySchema\",\
          \"documentation\":\"<p>The complete key schema for the local secondary index, consisting of one or more pairs of attribute names and key types:</p> <ul> <li> <p> <code>HASH</code> - partition key</p> </li> <li> <p> <code>RANGE</code> - sort key</p> </li> </ul> <note> <p>The partition key of an item is also known as its <i>hash attribute</i>. The term \\\"hash attribute\\\" derives from DynamoDB' usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values.</p> <p>The sort key of an item is also known as its <i>range attribute</i>. The term \\\"range attribute\\\" derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.</p> </note>\"\
        },\
        \"Projection\":{\
          \"shape\":\"Projection\",\
          \"documentation\":\"<p>Represents attributes that are copied (projected) from the table into the global secondary index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. </p>\"\
        },\
        \"IndexSizeBytes\":{\
          \"shape\":\"Long\",\
          \"documentation\":\"<p>The total size of the specified index, in bytes. DynamoDB updates this value approximately every six hours. Recent changes might not be reflected in this value.</p>\"\
        },\
        \"ItemCount\":{\
          \"shape\":\"Long\",\
          \"documentation\":\"<p>The number of items in the specified index. DynamoDB updates this value approximately every six hours. Recent changes might not be reflected in this value.</p>\"\
        },\
        \"IndexArn\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) that uniquely identifies the index.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a local secondary index.</p>\"\
    },\
    \"LocalSecondaryIndexDescriptionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"LocalSecondaryIndexDescription\"}\
    },\
    \"LocalSecondaryIndexInfo\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>Represents the name of the local secondary index.</p>\"\
        },\
        \"KeySchema\":{\
          \"shape\":\"KeySchema\",\
          \"documentation\":\"<p>The complete key schema for a local secondary index, which consists of one or more pairs of attribute names and key types:</p> <ul> <li> <p> <code>HASH</code> - partition key</p> </li> <li> <p> <code>RANGE</code> - sort key</p> </li> </ul> <note> <p>The partition key of an item is also known as its <i>hash attribute</i>. The term \\\"hash attribute\\\" derives from DynamoDB' usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values.</p> <p>The sort key of an item is also known as its <i>range attribute</i>. The term \\\"range attribute\\\" derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.</p> </note>\"\
        },\
        \"Projection\":{\
          \"shape\":\"Projection\",\
          \"documentation\":\"<p>Represents attributes that are copied (projected) from the table into the global secondary index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. </p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a local secondary index for the table when the backup was created.</p>\"\
    },\
    \"LocalSecondaryIndexList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"LocalSecondaryIndex\"}\
    },\
    \"LocalSecondaryIndexes\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"LocalSecondaryIndexInfo\"}\
    },\
    \"Long\":{\"type\":\"long\"},\
    \"MapAttributeValue\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"AttributeName\"},\
      \"value\":{\"shape\":\"AttributeValue\"}\
    },\
    \"NextTokenString\":{\"type\":\"string\"},\
    \"NonKeyAttributeName\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1\
    },\
    \"NonKeyAttributeNameList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"NonKeyAttributeName\"},\
      \"max\":20,\
      \"min\":1\
    },\
    \"NonNegativeLongObject\":{\
      \"type\":\"long\",\
      \"min\":0\
    },\
    \"NullAttributeValue\":{\"type\":\"boolean\"},\
    \"NumberAttributeValue\":{\"type\":\"string\"},\
    \"NumberSetAttributeValue\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"NumberAttributeValue\"}\
    },\
    \"PointInTimeRecoveryDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PointInTimeRecoveryStatus\":{\
          \"shape\":\"PointInTimeRecoveryStatus\",\
          \"documentation\":\"<p>The current state of point in time recovery:</p> <ul> <li> <p> <code>ENABLING</code> - Point in time recovery is being enabled.</p> </li> <li> <p> <code>ENABLED</code> - Point in time recovery is enabled.</p> </li> <li> <p> <code>DISABLED</code> - Point in time recovery is disabled.</p> </li> </ul>\"\
        },\
        \"EarliestRestorableDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>Specifies the earliest point in time you can restore your table to. It You can restore your table to any point in time during the last 35 days. </p>\"\
        },\
        \"LatestRestorableDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p> <code>LatestRestorableDateTime</code> is typically 5 minutes before the current time. </p>\"\
        }\
      },\
      \"documentation\":\"<p>The description of the point in time settings applied to the table.</p>\"\
    },\
    \"PointInTimeRecoverySpecification\":{\
      \"type\":\"structure\",\
      \"required\":[\"PointInTimeRecoveryEnabled\"],\
      \"members\":{\
        \"PointInTimeRecoveryEnabled\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Indicates whether point in time recovery is enabled (true) or disabled (false) on the table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the settings used to enable point in time recovery.</p>\"\
    },\
    \"PointInTimeRecoveryStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ENABLED\",\
        \"DISABLED\"\
      ]\
    },\
    \"PointInTimeRecoveryUnavailableException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>Point in time recovery has not yet been enabled for this source table.</p>\",\
      \"exception\":true\
    },\
    \"PositiveIntegerObject\":{\
      \"type\":\"integer\",\
      \"min\":1\
    },\
    \"PositiveLongObject\":{\
      \"type\":\"long\",\
      \"min\":1\
    },\
    \"Projection\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ProjectionType\":{\
          \"shape\":\"ProjectionType\",\
          \"documentation\":\"<p>The set of attributes that are projected into the index:</p> <ul> <li> <p> <code>KEYS_ONLY</code> - Only the index and primary keys are projected into the index.</p> </li> <li> <p> <code>INCLUDE</code> - Only the specified table attributes are projected into the index. The list of projected attributes are in <code>NonKeyAttributes</code>.</p> </li> <li> <p> <code>ALL</code> - All of the table attributes are projected into the index.</p> </li> </ul>\"\
        },\
        \"NonKeyAttributes\":{\
          \"shape\":\"NonKeyAttributeNameList\",\
          \"documentation\":\"<p>Represents the non-key attribute names which will be projected into the index.</p> <p>For local secondary indexes, the total count of <code>NonKeyAttributes</code> summed across all of the local secondary indexes, must not exceed 20. If you project the same attribute into two different indexes, this counts as two distinct attributes when determining the total.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents attributes that are copied (projected) from the table into an index. These are in addition to the primary key attributes and index key attributes, which are automatically projected.</p>\"\
    },\
    \"ProjectionExpression\":{\"type\":\"string\"},\
    \"ProjectionType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ALL\",\
        \"KEYS_ONLY\",\
        \"INCLUDE\"\
      ]\
    },\
    \"ProvisionedThroughput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"ReadCapacityUnits\",\
        \"WriteCapacityUnits\"\
      ],\
      \"members\":{\
        \"ReadCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum number of strongly consistent reads consumed per second before DynamoDB returns a <code>ThrottlingException</code>. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#ProvisionedThroughput\\\">Specifying Read and Write Requirements</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> <p>If read/write capacity mode is <code>PAY_PER_REQUEST</code> the value is set to 0.</p>\"\
        },\
        \"WriteCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum number of writes consumed per second before DynamoDB returns a <code>ThrottlingException</code>. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#ProvisionedThroughput\\\">Specifying Read and Write Requirements</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> <p>If read/write capacity mode is <code>PAY_PER_REQUEST</code> the value is set to 0.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the provisioned throughput settings for a specified table or index. The settings can be modified using the <code>UpdateTable</code> operation.</p> <p>For current minimum and maximum provisioned throughput values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html\\\">Limits</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
    },\
    \"ProvisionedThroughputDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"LastIncreaseDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>The date and time of the last provisioned throughput increase for this table.</p>\"\
        },\
        \"LastDecreaseDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>The date and time of the last provisioned throughput decrease for this table.</p>\"\
        },\
        \"NumberOfDecreasesToday\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The number of provisioned throughput decreases for this table during this UTC calendar day. For current maximums on provisioned throughput decreases, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html\\\">Limits</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ReadCapacityUnits\":{\
          \"shape\":\"NonNegativeLongObject\",\
          \"documentation\":\"<p>The maximum number of strongly consistent reads consumed per second before DynamoDB returns a <code>ThrottlingException</code>. Eventually consistent reads require less effort than strongly consistent reads, so a setting of 50 <code>ReadCapacityUnits</code> per second provides 100 eventually consistent <code>ReadCapacityUnits</code> per second.</p>\"\
        },\
        \"WriteCapacityUnits\":{\
          \"shape\":\"NonNegativeLongObject\",\
          \"documentation\":\"<p>The maximum number of writes consumed per second before DynamoDB returns a <code>ThrottlingException</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the provisioned throughput settings for the table, consisting of read and write capacity units, along with data about increases and decreases.</p>\"\
    },\
    \"ProvisionedThroughputExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>You exceeded your maximum allowed provisioned throughput.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Your request rate is too high. The AWS SDKs for DynamoDB automatically retry requests that receive this exception. Your request is eventually successful, unless your retry queue is too large to finish. Reduce the frequency of requests and use exponential backoff. For more information, go to <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html#Programming.Errors.RetryAndBackoff\\\">Error Retries and Exponential Backoff</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\",\
      \"exception\":true\
    },\
    \"Put\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Item\",\
        \"TableName\"\
      ],\
      \"members\":{\
        \"Item\":{\
          \"shape\":\"PutItemInputAttributeMap\",\
          \"documentation\":\"<p>A map of attribute name to attribute values, representing the primary key of the item to be written by <code>PutItem</code>. All of the table's primary key attributes must be specified, and their data types must match those of the table's key schema. If any attributes are present in the item that are part of an index key schema for the table, their types must match the index key schema. </p>\"\
        },\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>Name of the table in which to write the item.</p>\"\
        },\
        \"ConditionExpression\":{\
          \"shape\":\"ConditionExpression\",\
          \"documentation\":\"<p>A condition that must be satisfied in order for a conditional update to succeed.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression.</p>\"\
        },\
        \"ExpressionAttributeValues\":{\
          \"shape\":\"ExpressionAttributeValueMap\",\
          \"documentation\":\"<p>One or more values that can be substituted in an expression.</p>\"\
        },\
        \"ReturnValuesOnConditionCheckFailure\":{\
          \"shape\":\"ReturnValuesOnConditionCheckFailure\",\
          \"documentation\":\"<p>Use <code>ReturnValuesOnConditionCheckFailure</code> to get the item attributes if the <code>Put</code> condition fails. For <code>ReturnValuesOnConditionCheckFailure</code>, the valid values are: NONE and ALL_OLD.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a request to perform a <code>PutItem</code> operation.</p>\"\
    },\
    \"PutItemInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TableName\",\
        \"Item\"\
      ],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table to contain the item.</p>\"\
        },\
        \"Item\":{\
          \"shape\":\"PutItemInputAttributeMap\",\
          \"documentation\":\"<p>A map of attribute name/value pairs, one for each attribute. Only the primary key attributes are required; you can optionally provide other attribute name-value pairs for the item.</p> <p>You must provide all of the attributes for the primary key. For example, with a simple primary key, you only need to provide a value for the partition key. For a composite primary key, you must provide both values for both the partition key and the sort key.</p> <p>If you specify any attributes that are part of an index key, then the data types for those attributes must match those of the schema in the table's attribute definition.</p> <p>For more information about primary keys, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DataModel.html#DataModelPrimaryKey\\\">Primary Key</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> <p>Each element in the <code>Item</code> map is an <code>AttributeValue</code> object.</p>\"\
        },\
        \"Expected\":{\
          \"shape\":\"ExpectedAttributeMap\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>ConditionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.Expected.html\\\">Expected</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ReturnValues\":{\
          \"shape\":\"ReturnValue\",\
          \"documentation\":\"<p>Use <code>ReturnValues</code> if you want to get the item attributes as they appeared before they were updated with the <code>PutItem</code> request. For <code>PutItem</code>, the valid values are:</p> <ul> <li> <p> <code>NONE</code> - If <code>ReturnValues</code> is not specified, or if its value is <code>NONE</code>, then nothing is returned. (This setting is the default for <code>ReturnValues</code>.)</p> </li> <li> <p> <code>ALL_OLD</code> - If <code>PutItem</code> overwrote an attribute name-value pair, then the content of the old item is returned.</p> </li> </ul> <note> <p>The <code>ReturnValues</code> parameter is used by several DynamoDB operations; however, <code>PutItem</code> does not recognize any values other than <code>NONE</code> or <code>ALL_OLD</code>.</p> </note>\"\
        },\
        \"ReturnConsumedCapacity\":{\"shape\":\"ReturnConsumedCapacity\"},\
        \"ReturnItemCollectionMetrics\":{\
          \"shape\":\"ReturnItemCollectionMetrics\",\
          \"documentation\":\"<p>Determines whether item collection metrics are returned. If set to <code>SIZE</code>, the response includes statistics about item collections, if any, that were modified during the operation are returned in the response. If set to <code>NONE</code> (the default), no statistics are returned.</p>\"\
        },\
        \"ConditionalOperator\":{\
          \"shape\":\"ConditionalOperator\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>ConditionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.ConditionalOperator.html\\\">ConditionalOperator</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ConditionExpression\":{\
          \"shape\":\"ConditionExpression\",\
          \"documentation\":\"<p>A condition that must be satisfied in order for a conditional <code>PutItem</code> operation to succeed.</p> <p>An expression can contain any of the following:</p> <ul> <li> <p>Functions: <code>attribute_exists | attribute_not_exists | attribute_type | contains | begins_with | size</code> </p> <p>These function names are case-sensitive.</p> </li> <li> <p>Comparison operators: <code>= | &lt;&gt; | &lt; | &gt; | &lt;= | &gt;= | BETWEEN | IN </code> </p> </li> <li> <p> Logical operators: <code>AND | OR | NOT</code> </p> </li> </ul> <p>For more information on condition expressions, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html\\\">Specifying Conditions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression. The following are some use cases for using <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p>To access an attribute whose name conflicts with a DynamoDB reserved word.</p> </li> <li> <p>To create a placeholder for repeating occurrences of an attribute name in an expression.</p> </li> <li> <p>To prevent special characters in an attribute name from being misinterpreted in an expression.</p> </li> </ul> <p>Use the <b>#</b> character in an expression to dereference an attribute name. For example, consider the following attribute name:</p> <ul> <li> <p> <code>Percentile</code> </p> </li> </ul> <p>The name of this attribute conflicts with a reserved word, so it cannot be used directly in an expression. (For the complete list of reserved words, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html\\\">Reserved Words</a> in the <i>Amazon DynamoDB Developer Guide</i>). To work around this, you could specify the following for <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p> <code>{\\\"#P\\\":\\\"Percentile\\\"}</code> </p> </li> </ul> <p>You could then use this substitution in an expression, as in this example:</p> <ul> <li> <p> <code>#P = :val</code> </p> </li> </ul> <note> <p>Tokens that begin with the <b>:</b> character are <i>expression attribute values</i>, which are placeholders for the actual value at runtime.</p> </note> <p>For more information on expression attribute names, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeValues\":{\
          \"shape\":\"ExpressionAttributeValueMap\",\
          \"documentation\":\"<p>One or more values that can be substituted in an expression.</p> <p>Use the <b>:</b> (colon) character in an expression to dereference an attribute value. For example, suppose that you wanted to check whether the value of the <i>ProductStatus</i> attribute was one of the following: </p> <p> <code>Available | Backordered | Discontinued</code> </p> <p>You would first need to specify <code>ExpressionAttributeValues</code> as follows:</p> <p> <code>{ \\\":avail\\\":{\\\"S\\\":\\\"Available\\\"}, \\\":back\\\":{\\\"S\\\":\\\"Backordered\\\"}, \\\":disc\\\":{\\\"S\\\":\\\"Discontinued\\\"} }</code> </p> <p>You could then use these values in an expression, such as this:</p> <p> <code>ProductStatus IN (:avail, :back, :disc)</code> </p> <p>For more information on expression attribute values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html\\\">Specifying Conditions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of a <code>PutItem</code> operation.</p>\"\
    },\
    \"PutItemInputAttributeMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"AttributeName\"},\
      \"value\":{\"shape\":\"AttributeValue\"}\
    },\
    \"PutItemOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Attributes\":{\
          \"shape\":\"AttributeMap\",\
          \"documentation\":\"<p>The attribute values as they appeared before the <code>PutItem</code> operation, but only if <code>ReturnValues</code> is specified as <code>ALL_OLD</code> in the request. Each element consists of an attribute name and an attribute value.</p>\"\
        },\
        \"ConsumedCapacity\":{\
          \"shape\":\"ConsumedCapacity\",\
          \"documentation\":\"<p>The capacity units consumed by the <code>PutItem</code> operation. The data returned includes the total provisioned throughput consumed, along with statistics for the table and any indexes involved in the operation. <code>ConsumedCapacity</code> is only returned if the <code>ReturnConsumedCapacity</code> parameter was specified. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughputIntro.html\\\">Provisioned Throughput</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ItemCollectionMetrics\":{\
          \"shape\":\"ItemCollectionMetrics\",\
          \"documentation\":\"<p>Information about item collections, if any, that were affected by the <code>PutItem</code> operation. <code>ItemCollectionMetrics</code> is only returned if the <code>ReturnItemCollectionMetrics</code> parameter was specified. If the table does not have any local secondary indexes, this information is not returned in the response.</p> <p>Each <code>ItemCollectionMetrics</code> element consists of:</p> <ul> <li> <p> <code>ItemCollectionKey</code> - The partition key value of the item collection. This is the same as the partition key value of the item itself.</p> </li> <li> <p> <code>SizeEstimateRangeGB</code> - An estimate of item collection size, in gigabytes. This value is a two-element array containing a lower bound and an upper bound for the estimate. The estimate includes the size of all the items in the table, plus the size of all attributes projected into all of the local secondary indexes on that table. Use this estimate to measure whether a local secondary index is approaching its size limit.</p> <p>The estimate is subject to change over time; therefore, do not rely on the precision or accuracy of the estimate.</p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>PutItem</code> operation.</p>\"\
    },\
    \"PutRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Item\"],\
      \"members\":{\
        \"Item\":{\
          \"shape\":\"PutItemInputAttributeMap\",\
          \"documentation\":\"<p>A map of attribute name to attribute values, representing the primary key of an item to be processed by <code>PutItem</code>. All of the table's primary key attributes must be specified, and their data types must match those of the table's key schema. If any attributes are present in the item which are part of an index key schema for the table, their types must match the index key schema.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a request to perform a <code>PutItem</code> operation on an item.</p>\"\
    },\
    \"QueryInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TableName\"],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table containing the requested items.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of an index to query. This index can be any local secondary index or global secondary index on the table. Note that if you use the <code>IndexName</code> parameter, you must also provide <code>TableName.</code> </p>\"\
        },\
        \"Select\":{\
          \"shape\":\"Select\",\
          \"documentation\":\"<p>The attributes to be returned in the result. You can retrieve all item attributes, specific item attributes, the count of matching items, or in the case of an index, some or all of the attributes projected into the index.</p> <ul> <li> <p> <code>ALL_ATTRIBUTES</code> - Returns all of the item attributes from the specified table or index. If you query a local secondary index, then for each matching item in the index DynamoDB will fetch the entire item from the parent table. If the index is configured to project all item attributes, then all of the data can be obtained from the local secondary index, and no fetching is required.</p> </li> <li> <p> <code>ALL_PROJECTED_ATTRIBUTES</code> - Allowed only when querying an index. Retrieves all attributes that have been projected into the index. If the index is configured to project all attributes, this return value is equivalent to specifying <code>ALL_ATTRIBUTES</code>.</p> </li> <li> <p> <code>COUNT</code> - Returns the number of matching items, rather than the matching items themselves.</p> </li> <li> <p> <code>SPECIFIC_ATTRIBUTES</code> - Returns only the attributes listed in <code>AttributesToGet</code>. This return value is equivalent to specifying <code>AttributesToGet</code> without specifying any value for <code>Select</code>.</p> <p>If you query or scan a local secondary index and request only attributes that are projected into that index, the operation will read only the index and not the table. If any of the requested attributes are not projected into the local secondary index, DynamoDB will fetch each of these attributes from the parent table. This extra fetching incurs additional throughput cost and latency.</p> <p>If you query or scan a global secondary index, you can only request attributes that are projected into the index. Global secondary index queries cannot fetch attributes from the parent table.</p> </li> </ul> <p>If neither <code>Select</code> nor <code>AttributesToGet</code> are specified, DynamoDB defaults to <code>ALL_ATTRIBUTES</code> when accessing a table, and <code>ALL_PROJECTED_ATTRIBUTES</code> when accessing an index. You cannot use both <code>Select</code> and <code>AttributesToGet</code> together in a single request, unless the value for <code>Select</code> is <code>SPECIFIC_ATTRIBUTES</code>. (This usage is equivalent to specifying <code>AttributesToGet</code> without any value for <code>Select</code>.)</p> <note> <p>If you use the <code>ProjectionExpression</code> parameter, then the value for <code>Select</code> can only be <code>SPECIFIC_ATTRIBUTES</code>. Any other value for <code>Select</code> will return an error.</p> </note>\"\
        },\
        \"AttributesToGet\":{\
          \"shape\":\"AttributeNameList\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>ProjectionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributesToGet.html\\\">AttributesToGet</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"PositiveIntegerObject\",\
          \"documentation\":\"<p>The maximum number of items to evaluate (not necessarily the number of matching items). If DynamoDB processes the number of items up to the limit while processing the results, it stops the operation and returns the matching values up to that point, and a key in <code>LastEvaluatedKey</code> to apply in a subsequent operation, so that you can pick up where you left off. Also, if the processed data set size exceeds 1 MB before DynamoDB reaches this limit, it stops the operation and returns the matching values up to the limit, and a key in <code>LastEvaluatedKey</code> to apply in a subsequent operation to continue the operation. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html\\\">Query and Scan</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ConsistentRead\":{\
          \"shape\":\"ConsistentRead\",\
          \"documentation\":\"<p>Determines the read consistency model: If set to <code>true</code>, then the operation uses strongly consistent reads; otherwise, the operation uses eventually consistent reads.</p> <p>Strongly consistent reads are not supported on global secondary indexes. If you query a global secondary index with <code>ConsistentRead</code> set to <code>true</code>, you will receive a <code>ValidationException</code>.</p>\"\
        },\
        \"KeyConditions\":{\
          \"shape\":\"KeyConditions\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>KeyConditionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.KeyConditions.html\\\">KeyConditions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"QueryFilter\":{\
          \"shape\":\"FilterConditionMap\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>FilterExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.QueryFilter.html\\\">QueryFilter</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ConditionalOperator\":{\
          \"shape\":\"ConditionalOperator\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>FilterExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.ConditionalOperator.html\\\">ConditionalOperator</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ScanIndexForward\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Specifies the order for index traversal: If <code>true</code> (default), the traversal is performed in ascending order; if <code>false</code>, the traversal is performed in descending order. </p> <p>Items with the same partition key value are stored in sorted order by sort key. If the sort key data type is Number, the results are stored in numeric order. For type String, the results are stored in order of UTF-8 bytes. For type Binary, DynamoDB treats each byte of the binary data as unsigned.</p> <p>If <code>ScanIndexForward</code> is <code>true</code>, DynamoDB returns the results in the order in which they are stored (by sort key value). This is the default behavior. If <code>ScanIndexForward</code> is <code>false</code>, DynamoDB reads the results in reverse order by sort key value, and then returns the results to the client.</p>\"\
        },\
        \"ExclusiveStartKey\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>The primary key of the first item that this operation will evaluate. Use the value that was returned for <code>LastEvaluatedKey</code> in the previous operation.</p> <p>The data type for <code>ExclusiveStartKey</code> must be String, Number or Binary. No set data types are allowed.</p>\"\
        },\
        \"ReturnConsumedCapacity\":{\"shape\":\"ReturnConsumedCapacity\"},\
        \"ProjectionExpression\":{\
          \"shape\":\"ProjectionExpression\",\
          \"documentation\":\"<p>A string that identifies one or more attributes to retrieve from the table. These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must be separated by commas.</p> <p>If no attribute names are specified, then all attributes will be returned. If any of the requested attributes are not found, they will not appear in the result.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"FilterExpression\":{\
          \"shape\":\"ConditionExpression\",\
          \"documentation\":\"<p>A string that contains conditions that DynamoDB applies after the <code>Query</code> operation, but before the data is returned to you. Items that do not satisfy the <code>FilterExpression</code> criteria are not returned.</p> <p>A <code>FilterExpression</code> does not allow key attributes. You cannot define a filter expression based on a partition key or a sort key.</p> <note> <p>A <code>FilterExpression</code> is applied after the items have already been read; the process of filtering does not consume any additional read capacity units.</p> </note> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html#FilteringResults\\\">Filter Expressions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"KeyConditionExpression\":{\
          \"shape\":\"KeyExpression\",\
          \"documentation\":\"<p>The condition that specifies the key value(s) for items to be retrieved by the <code>Query</code> action.</p> <p>The condition must perform an equality test on a single partition key value.</p> <p>The condition can optionally perform one of several comparison tests on a single sort key value. This allows <code>Query</code> to retrieve one item with a given partition key value and sort key value, or several items that have the same partition key value but different sort key values.</p> <p>The partition key equality test is required, and must be specified in the following format:</p> <p> <code>partitionKeyName</code> <i>=</i> <code>:partitionkeyval</code> </p> <p>If you also want to provide a condition for the sort key, it must be combined using <code>AND</code> with the condition for the sort key. Following is an example, using the <b>=</b> comparison operator for the sort key:</p> <p> <code>partitionKeyName</code> <code>=</code> <code>:partitionkeyval</code> <code>AND</code> <code>sortKeyName</code> <code>=</code> <code>:sortkeyval</code> </p> <p>Valid comparisons for the sort key condition are as follows:</p> <ul> <li> <p> <code>sortKeyName</code> <code>=</code> <code>:sortkeyval</code> - true if the sort key value is equal to <code>:sortkeyval</code>.</p> </li> <li> <p> <code>sortKeyName</code> <code>&lt;</code> <code>:sortkeyval</code> - true if the sort key value is less than <code>:sortkeyval</code>.</p> </li> <li> <p> <code>sortKeyName</code> <code>&lt;=</code> <code>:sortkeyval</code> - true if the sort key value is less than or equal to <code>:sortkeyval</code>.</p> </li> <li> <p> <code>sortKeyName</code> <code>&gt;</code> <code>:sortkeyval</code> - true if the sort key value is greater than <code>:sortkeyval</code>.</p> </li> <li> <p> <code>sortKeyName</code> <code>&gt;= </code> <code>:sortkeyval</code> - true if the sort key value is greater than or equal to <code>:sortkeyval</code>.</p> </li> <li> <p> <code>sortKeyName</code> <code>BETWEEN</code> <code>:sortkeyval1</code> <code>AND</code> <code>:sortkeyval2</code> - true if the sort key value is greater than or equal to <code>:sortkeyval1</code>, and less than or equal to <code>:sortkeyval2</code>.</p> </li> <li> <p> <code>begins_with (</code> <code>sortKeyName</code>, <code>:sortkeyval</code> <code>)</code> - true if the sort key value begins with a particular operand. (You cannot use this function with a sort key that is of type Number.) Note that the function name <code>begins_with</code> is case-sensitive.</p> </li> </ul> <p>Use the <code>ExpressionAttributeValues</code> parameter to replace tokens such as <code>:partitionval</code> and <code>:sortval</code> with actual values at runtime.</p> <p>You can optionally use the <code>ExpressionAttributeNames</code> parameter to replace the names of the partition key and sort key with placeholder tokens. This option might be necessary if an attribute name conflicts with a DynamoDB reserved word. For example, the following <code>KeyConditionExpression</code> parameter causes an error because <i>Size</i> is a reserved word:</p> <ul> <li> <p> <code>Size = :myval</code> </p> </li> </ul> <p>To work around this, define a placeholder (such a <code>#S</code>) to represent the attribute name <i>Size</i>. <code>KeyConditionExpression</code> then is as follows:</p> <ul> <li> <p> <code>#S = :myval</code> </p> </li> </ul> <p>For a list of reserved words, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html\\\">Reserved Words</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> <p>For more information on <code>ExpressionAttributeNames</code> and <code>ExpressionAttributeValues</code>, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ExpressionPlaceholders.html\\\">Using Placeholders for Attribute Names and Values</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression. The following are some use cases for using <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p>To access an attribute whose name conflicts with a DynamoDB reserved word.</p> </li> <li> <p>To create a placeholder for repeating occurrences of an attribute name in an expression.</p> </li> <li> <p>To prevent special characters in an attribute name from being misinterpreted in an expression.</p> </li> </ul> <p>Use the <b>#</b> character in an expression to dereference an attribute name. For example, consider the following attribute name:</p> <ul> <li> <p> <code>Percentile</code> </p> </li> </ul> <p>The name of this attribute conflicts with a reserved word, so it cannot be used directly in an expression. (For the complete list of reserved words, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html\\\">Reserved Words</a> in the <i>Amazon DynamoDB Developer Guide</i>). To work around this, you could specify the following for <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p> <code>{\\\"#P\\\":\\\"Percentile\\\"}</code> </p> </li> </ul> <p>You could then use this substitution in an expression, as in this example:</p> <ul> <li> <p> <code>#P = :val</code> </p> </li> </ul> <note> <p>Tokens that begin with the <b>:</b> character are <i>expression attribute values</i>, which are placeholders for the actual value at runtime.</p> </note> <p>For more information on expression attribute names, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeValues\":{\
          \"shape\":\"ExpressionAttributeValueMap\",\
          \"documentation\":\"<p>One or more values that can be substituted in an expression.</p> <p>Use the <b>:</b> (colon) character in an expression to dereference an attribute value. For example, suppose that you wanted to check whether the value of the <i>ProductStatus</i> attribute was one of the following: </p> <p> <code>Available | Backordered | Discontinued</code> </p> <p>You would first need to specify <code>ExpressionAttributeValues</code> as follows:</p> <p> <code>{ \\\":avail\\\":{\\\"S\\\":\\\"Available\\\"}, \\\":back\\\":{\\\"S\\\":\\\"Backordered\\\"}, \\\":disc\\\":{\\\"S\\\":\\\"Discontinued\\\"} }</code> </p> <p>You could then use these values in an expression, such as this:</p> <p> <code>ProductStatus IN (:avail, :back, :disc)</code> </p> <p>For more information on expression attribute values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html\\\">Specifying Conditions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of a <code>Query</code> operation.</p>\"\
    },\
    \"QueryOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Items\":{\
          \"shape\":\"ItemList\",\
          \"documentation\":\"<p>An array of item attributes that match the query criteria. Each element in this array consists of an attribute name and the value for that attribute.</p>\"\
        },\
        \"Count\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The number of items in the response.</p> <p>If you used a <code>QueryFilter</code> in the request, then <code>Count</code> is the number of items returned after the filter was applied, and <code>ScannedCount</code> is the number of matching items before the filter was applied.</p> <p>If you did not use a filter in the request, then <code>Count</code> and <code>ScannedCount</code> are the same.</p>\"\
        },\
        \"ScannedCount\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The number of items evaluated, before any <code>QueryFilter</code> is applied. A high <code>ScannedCount</code> value with few, or no, <code>Count</code> results indicates an inefficient <code>Query</code> operation. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html#Count\\\">Count and ScannedCount</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> <p>If you did not use a filter in the request, then <code>ScannedCount</code> is the same as <code>Count</code>.</p>\"\
        },\
        \"LastEvaluatedKey\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>The primary key of the item where the operation stopped, inclusive of the previous result set. Use this value to start a new operation, excluding this value in the new request.</p> <p>If <code>LastEvaluatedKey</code> is empty, then the \\\"last page\\\" of results has been processed and there is no more data to be retrieved.</p> <p>If <code>LastEvaluatedKey</code> is not empty, it does not necessarily mean that there is more data in the result set. The only way to know when you have reached the end of the result set is when <code>LastEvaluatedKey</code> is empty.</p>\"\
        },\
        \"ConsumedCapacity\":{\
          \"shape\":\"ConsumedCapacity\",\
          \"documentation\":\"<p>The capacity units consumed by the <code>Query</code> operation. The data returned includes the total provisioned throughput consumed, along with statistics for the table and any indexes involved in the operation. <code>ConsumedCapacity</code> is only returned if the <code>ReturnConsumedCapacity</code> parameter was specified For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughputIntro.html\\\">Provisioned Throughput</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>Query</code> operation.</p>\"\
    },\
    \"RegionName\":{\"type\":\"string\"},\
    \"Replica\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RegionName\":{\
          \"shape\":\"RegionName\",\
          \"documentation\":\"<p>The region where the replica needs to be created.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a replica.</p>\"\
    },\
    \"ReplicaAlreadyExistsException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>The specified replica is already part of the global table.</p>\",\
      \"exception\":true\
    },\
    \"ReplicaDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RegionName\":{\
          \"shape\":\"RegionName\",\
          \"documentation\":\"<p>The name of the region.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the details of the replica.</p>\"\
    },\
    \"ReplicaDescriptionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ReplicaDescription\"}\
    },\
    \"ReplicaGlobalSecondaryIndexSettingsDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\"IndexName\"],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of the global secondary index. The name must be unique among all other indexes on this table.</p>\"\
        },\
        \"IndexStatus\":{\
          \"shape\":\"IndexStatus\",\
          \"documentation\":\"<p> The current status of the global secondary index:</p> <ul> <li> <p> <code>CREATING</code> - The global secondary index is being created.</p> </li> <li> <p> <code>UPDATING</code> - The global secondary index is being updated.</p> </li> <li> <p> <code>DELETING</code> - The global secondary index is being deleted.</p> </li> <li> <p> <code>ACTIVE</code> - The global secondary index is ready for use.</p> </li> </ul>\"\
        },\
        \"ProvisionedReadCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum number of strongly consistent reads consumed per second before DynamoDB returns a <code>ThrottlingException</code>.</p>\"\
        },\
        \"ProvisionedReadCapacityAutoScalingSettings\":{\
          \"shape\":\"AutoScalingSettingsDescription\",\
          \"documentation\":\"<p>Autoscaling settings for a global secondary index replica's read capacity units.</p>\"\
        },\
        \"ProvisionedWriteCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum number of writes consumed per second before DynamoDB returns a <code>ThrottlingException</code>.</p>\"\
        },\
        \"ProvisionedWriteCapacityAutoScalingSettings\":{\
          \"shape\":\"AutoScalingSettingsDescription\",\
          \"documentation\":\"<p>AutoScaling settings for a global secondary index replica's write capacity units.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a global secondary index.</p>\"\
    },\
    \"ReplicaGlobalSecondaryIndexSettingsDescriptionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ReplicaGlobalSecondaryIndexSettingsDescription\"}\
    },\
    \"ReplicaGlobalSecondaryIndexSettingsUpdate\":{\
      \"type\":\"structure\",\
      \"required\":[\"IndexName\"],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of the global secondary index. The name must be unique among all other indexes on this table.</p>\"\
        },\
        \"ProvisionedReadCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum number of strongly consistent reads consumed per second before DynamoDB returns a <code>ThrottlingException</code>.</p>\"\
        },\
        \"ProvisionedReadCapacityAutoScalingSettingsUpdate\":{\
          \"shape\":\"AutoScalingSettingsUpdate\",\
          \"documentation\":\"<p>Autoscaling settings for managing a global secondary index replica's read capacity units.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the settings of a global secondary index for a global table that will be modified.</p>\"\
    },\
    \"ReplicaGlobalSecondaryIndexSettingsUpdateList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ReplicaGlobalSecondaryIndexSettingsUpdate\"},\
      \"max\":20,\
      \"min\":1\
    },\
    \"ReplicaList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Replica\"}\
    },\
    \"ReplicaNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>The specified replica is no longer part of the global table.</p>\",\
      \"exception\":true\
    },\
    \"ReplicaSettingsDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\"RegionName\"],\
      \"members\":{\
        \"RegionName\":{\
          \"shape\":\"RegionName\",\
          \"documentation\":\"<p>The region name of the replica.</p>\"\
        },\
        \"ReplicaStatus\":{\
          \"shape\":\"ReplicaStatus\",\
          \"documentation\":\"<p>The current state of the region:</p> <ul> <li> <p> <code>CREATING</code> - The region is being created.</p> </li> <li> <p> <code>UPDATING</code> - The region is being updated.</p> </li> <li> <p> <code>DELETING</code> - The region is being deleted.</p> </li> <li> <p> <code>ACTIVE</code> - The region is ready for use.</p> </li> </ul>\"\
        },\
        \"ReplicaBillingModeSummary\":{\
          \"shape\":\"BillingModeSummary\",\
          \"documentation\":\"<p>The read/write capacity mode of the replica.</p>\"\
        },\
        \"ReplicaProvisionedReadCapacityUnits\":{\
          \"shape\":\"NonNegativeLongObject\",\
          \"documentation\":\"<p>The maximum number of strongly consistent reads consumed per second before DynamoDB returns a <code>ThrottlingException</code>. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#ProvisionedThroughput\\\">Specifying Read and Write Requirements</a> in the <i>Amazon DynamoDB Developer Guide</i>. </p>\"\
        },\
        \"ReplicaProvisionedReadCapacityAutoScalingSettings\":{\
          \"shape\":\"AutoScalingSettingsDescription\",\
          \"documentation\":\"<p>Autoscaling settings for a global table replica's read capacity units.</p>\"\
        },\
        \"ReplicaProvisionedWriteCapacityUnits\":{\
          \"shape\":\"NonNegativeLongObject\",\
          \"documentation\":\"<p>The maximum number of writes consumed per second before DynamoDB returns a <code>ThrottlingException</code>. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#ProvisionedThroughput\\\">Specifying Read and Write Requirements</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ReplicaProvisionedWriteCapacityAutoScalingSettings\":{\
          \"shape\":\"AutoScalingSettingsDescription\",\
          \"documentation\":\"<p>AutoScaling settings for a global table replica's write capacity units.</p>\"\
        },\
        \"ReplicaGlobalSecondaryIndexSettings\":{\
          \"shape\":\"ReplicaGlobalSecondaryIndexSettingsDescriptionList\",\
          \"documentation\":\"<p>Replica global secondary index settings for the global table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a replica.</p>\"\
    },\
    \"ReplicaSettingsDescriptionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ReplicaSettingsDescription\"}\
    },\
    \"ReplicaSettingsUpdate\":{\
      \"type\":\"structure\",\
      \"required\":[\"RegionName\"],\
      \"members\":{\
        \"RegionName\":{\
          \"shape\":\"RegionName\",\
          \"documentation\":\"<p>The region of the replica to be added.</p>\"\
        },\
        \"ReplicaProvisionedReadCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum number of strongly consistent reads consumed per second before DynamoDB returns a <code>ThrottlingException</code>. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#ProvisionedThroughput\\\">Specifying Read and Write Requirements</a> in the <i>Amazon DynamoDB Developer Guide</i>. </p>\"\
        },\
        \"ReplicaProvisionedReadCapacityAutoScalingSettingsUpdate\":{\
          \"shape\":\"AutoScalingSettingsUpdate\",\
          \"documentation\":\"<p>Autoscaling settings for managing a global table replica's read capacity units.</p>\"\
        },\
        \"ReplicaGlobalSecondaryIndexSettingsUpdate\":{\
          \"shape\":\"ReplicaGlobalSecondaryIndexSettingsUpdateList\",\
          \"documentation\":\"<p>Represents the settings of a global secondary index for a global table that will be modified.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the settings for a global table in a region that will be modified.</p>\"\
    },\
    \"ReplicaSettingsUpdateList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ReplicaSettingsUpdate\"},\
      \"max\":50,\
      \"min\":1\
    },\
    \"ReplicaStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CREATING\",\
        \"UPDATING\",\
        \"DELETING\",\
        \"ACTIVE\"\
      ]\
    },\
    \"ReplicaUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Create\":{\
          \"shape\":\"CreateReplicaAction\",\
          \"documentation\":\"<p>The parameters required for creating a replica on an existing global table.</p>\"\
        },\
        \"Delete\":{\
          \"shape\":\"DeleteReplicaAction\",\
          \"documentation\":\"<p>The name of the existing replica to be removed.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents one of the following:</p> <ul> <li> <p>A new replica to be added to an existing global table.</p> </li> <li> <p>New parameters for an existing replica.</p> </li> <li> <p>An existing replica to be removed from an existing global table.</p> </li> </ul>\"\
    },\
    \"ReplicaUpdateList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ReplicaUpdate\"}\
    },\
    \"RequestLimitExceeded\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>Throughput exceeds the current throughput limit for your account. Please contact AWS Support at <a href=\\\"http://docs.aws.amazon.com/https:/aws.amazon.com/support\\\">AWS Support</a> to request a limit increase.</p>\",\
      \"exception\":true\
    },\
    \"ResourceArnString\":{\
      \"type\":\"string\",\
      \"max\":1283,\
      \"min\":1\
    },\
    \"ResourceInUseException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>The resource which is being attempted to be changed is in use.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The operation conflicts with the resource's availability. For example, you attempted to recreate an existing table, or tried to delete a table currently in the <code>CREATING</code> state.</p>\",\
      \"exception\":true\
    },\
    \"ResourceNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>The resource which is being requested does not exist.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The operation tried to access a nonexistent table or index. The resource might not be specified correctly, or its status might not be <code>ACTIVE</code>.</p>\",\
      \"exception\":true\
    },\
    \"RestoreInProgress\":{\"type\":\"boolean\"},\
    \"RestoreSummary\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RestoreDateTime\",\
        \"RestoreInProgress\"\
      ],\
      \"members\":{\
        \"SourceBackupArn\":{\
          \"shape\":\"BackupArn\",\
          \"documentation\":\"<p>ARN of the backup from which the table was restored.</p>\"\
        },\
        \"SourceTableArn\":{\
          \"shape\":\"TableArn\",\
          \"documentation\":\"<p>ARN of the source table of the backup that is being restored.</p>\"\
        },\
        \"RestoreDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>Point in time or source backup time.</p>\"\
        },\
        \"RestoreInProgress\":{\
          \"shape\":\"RestoreInProgress\",\
          \"documentation\":\"<p>Indicates if a restore is in progress or not.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains details for the restore.</p>\"\
    },\
    \"RestoreTableFromBackupInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TargetTableName\",\
        \"BackupArn\"\
      ],\
      \"members\":{\
        \"TargetTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the new table to which the backup must be restored.</p>\"\
        },\
        \"BackupArn\":{\
          \"shape\":\"BackupArn\",\
          \"documentation\":\"<p>The ARN associated with the backup.</p>\"\
        }\
      }\
    },\
    \"RestoreTableFromBackupOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TableDescription\":{\
          \"shape\":\"TableDescription\",\
          \"documentation\":\"<p>The description of the table created from an existing backup.</p>\"\
        }\
      }\
    },\
    \"RestoreTableToPointInTimeInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"SourceTableName\",\
        \"TargetTableName\"\
      ],\
      \"members\":{\
        \"SourceTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>Name of the source table that is being restored.</p>\"\
        },\
        \"TargetTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the new table to which it must be restored to.</p>\"\
        },\
        \"UseLatestRestorableTime\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Restore the table to the latest possible time. <code>LatestRestorableDateTime</code> is typically 5 minutes before the current time. </p>\"\
        },\
        \"RestoreDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>Time in the past to restore the table to.</p>\"\
        }\
      }\
    },\
    \"RestoreTableToPointInTimeOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TableDescription\":{\
          \"shape\":\"TableDescription\",\
          \"documentation\":\"<p>Represents the properties of a table.</p>\"\
        }\
      }\
    },\
    \"ReturnConsumedCapacity\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>Determines the level of detail about provisioned throughput consumption that is returned in the response:</p> <ul> <li> <p> <code>INDEXES</code> - The response includes the aggregate <code>ConsumedCapacity</code> for the operation, together with <code>ConsumedCapacity</code> for each table and secondary index that was accessed.</p> <p>Note that some operations, such as <code>GetItem</code> and <code>BatchGetItem</code>, do not access any indexes at all. In these cases, specifying <code>INDEXES</code> will only return <code>ConsumedCapacity</code> information for table(s).</p> </li> <li> <p> <code>TOTAL</code> - The response includes only the aggregate <code>ConsumedCapacity</code> for the operation.</p> </li> <li> <p> <code>NONE</code> - No <code>ConsumedCapacity</code> details are included in the response.</p> </li> </ul>\",\
      \"enum\":[\
        \"INDEXES\",\
        \"TOTAL\",\
        \"NONE\"\
      ]\
    },\
    \"ReturnItemCollectionMetrics\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"SIZE\",\
        \"NONE\"\
      ]\
    },\
    \"ReturnValue\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"NONE\",\
        \"ALL_OLD\",\
        \"UPDATED_OLD\",\
        \"ALL_NEW\",\
        \"UPDATED_NEW\"\
      ]\
    },\
    \"ReturnValuesOnConditionCheckFailure\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ALL_OLD\",\
        \"NONE\"\
      ]\
    },\
    \"SSEDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"SSEStatus\",\
          \"documentation\":\"<p>The current state of server-side encryption:</p> <ul> <li> <p> <code>ENABLING</code> - Server-side encryption is being enabled.</p> </li> <li> <p> <code>ENABLED</code> - Server-side encryption is enabled.</p> </li> <li> <p> <code>DISABLING</code> - Server-side encryption is being disabled.</p> </li> <li> <p> <code>DISABLED</code> - Server-side encryption is disabled.</p> </li> <li> <p> <code>UPDATING</code> - Server-side encryption is being updated.</p> </li> </ul>\"\
        },\
        \"SSEType\":{\
          \"shape\":\"SSEType\",\
          \"documentation\":\"<p>Server-side encryption type:</p> <ul> <li> <p> <code>AES256</code> - Server-side encryption which uses the AES256 algorithm (not applicable).</p> </li> <li> <p> <code>KMS</code> - Server-side encryption which uses AWS Key Management Service. Key is stored in your account and is managed by AWS KMS (KMS charges apply).</p> </li> </ul>\"\
        },\
        \"KMSMasterKeyArn\":{\
          \"shape\":\"KMSMasterKeyArn\",\
          \"documentation\":\"<p>The KMS master key ARN used for the KMS encryption.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The description of the server-side encryption status on the specified table.</p>\"\
    },\
    \"SSEEnabled\":{\"type\":\"boolean\"},\
    \"SSESpecification\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Enabled\":{\
          \"shape\":\"SSEEnabled\",\
          \"documentation\":\"<p>Indicates whether server-side encryption is enabled (true) or disabled (false) on the table. If enabled (true), server-side encryption type is set to <code>KMS</code>. If disabled (false) or not specified, server-side encryption is set to AWS owned CMK.</p>\"\
        },\
        \"SSEType\":{\
          \"shape\":\"SSEType\",\
          \"documentation\":\"<p>Server-side encryption type:</p> <ul> <li> <p> <code>AES256</code> - Server-side encryption which uses the AES256 algorithm (not applicable).</p> </li> <li> <p> <code>KMS</code> - Server-side encryption which uses AWS Key Management Service. Key is stored in your account and is managed by AWS KMS (KMS charges apply).</p> </li> </ul>\"\
        },\
        \"KMSMasterKeyId\":{\
          \"shape\":\"KMSMasterKeyId\",\
          \"documentation\":\"<p>The KMS Master Key (CMK) which should be used for the KMS encryption. To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. Note that you should only provide this parameter if the key is different from the default DynamoDB KMS Master Key alias/aws/dynamodb.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the settings used to enable server-side encryption.</p>\"\
    },\
    \"SSEStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ENABLING\",\
        \"ENABLED\",\
        \"DISABLING\",\
        \"DISABLED\",\
        \"UPDATING\"\
      ]\
    },\
    \"SSEType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AES256\",\
        \"KMS\"\
      ]\
    },\
    \"ScalarAttributeType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"S\",\
        \"N\",\
        \"B\"\
      ]\
    },\
    \"ScanInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TableName\"],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table containing the requested items; or, if you provide <code>IndexName</code>, the name of the table to which that index belongs.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of a secondary index to scan. This index can be any local secondary index or global secondary index. Note that if you use the <code>IndexName</code> parameter, you must also provide <code>TableName</code>.</p>\"\
        },\
        \"AttributesToGet\":{\
          \"shape\":\"AttributeNameList\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>ProjectionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributesToGet.html\\\">AttributesToGet</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"PositiveIntegerObject\",\
          \"documentation\":\"<p>The maximum number of items to evaluate (not necessarily the number of matching items). If DynamoDB processes the number of items up to the limit while processing the results, it stops the operation and returns the matching values up to that point, and a key in <code>LastEvaluatedKey</code> to apply in a subsequent operation, so that you can pick up where you left off. Also, if the processed data set size exceeds 1 MB before DynamoDB reaches this limit, it stops the operation and returns the matching values up to the limit, and a key in <code>LastEvaluatedKey</code> to apply in a subsequent operation to continue the operation. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html\\\">Query and Scan</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"Select\":{\
          \"shape\":\"Select\",\
          \"documentation\":\"<p>The attributes to be returned in the result. You can retrieve all item attributes, specific item attributes, the count of matching items, or in the case of an index, some or all of the attributes projected into the index.</p> <ul> <li> <p> <code>ALL_ATTRIBUTES</code> - Returns all of the item attributes from the specified table or index. If you query a local secondary index, then for each matching item in the index DynamoDB will fetch the entire item from the parent table. If the index is configured to project all item attributes, then all of the data can be obtained from the local secondary index, and no fetching is required.</p> </li> <li> <p> <code>ALL_PROJECTED_ATTRIBUTES</code> - Allowed only when querying an index. Retrieves all attributes that have been projected into the index. If the index is configured to project all attributes, this return value is equivalent to specifying <code>ALL_ATTRIBUTES</code>.</p> </li> <li> <p> <code>COUNT</code> - Returns the number of matching items, rather than the matching items themselves.</p> </li> <li> <p> <code>SPECIFIC_ATTRIBUTES</code> - Returns only the attributes listed in <code>AttributesToGet</code>. This return value is equivalent to specifying <code>AttributesToGet</code> without specifying any value for <code>Select</code>.</p> <p>If you query or scan a local secondary index and request only attributes that are projected into that index, the operation will read only the index and not the table. If any of the requested attributes are not projected into the local secondary index, DynamoDB will fetch each of these attributes from the parent table. This extra fetching incurs additional throughput cost and latency.</p> <p>If you query or scan a global secondary index, you can only request attributes that are projected into the index. Global secondary index queries cannot fetch attributes from the parent table.</p> </li> </ul> <p>If neither <code>Select</code> nor <code>AttributesToGet</code> are specified, DynamoDB defaults to <code>ALL_ATTRIBUTES</code> when accessing a table, and <code>ALL_PROJECTED_ATTRIBUTES</code> when accessing an index. You cannot use both <code>Select</code> and <code>AttributesToGet</code> together in a single request, unless the value for <code>Select</code> is <code>SPECIFIC_ATTRIBUTES</code>. (This usage is equivalent to specifying <code>AttributesToGet</code> without any value for <code>Select</code>.)</p> <note> <p>If you use the <code>ProjectionExpression</code> parameter, then the value for <code>Select</code> can only be <code>SPECIFIC_ATTRIBUTES</code>. Any other value for <code>Select</code> will return an error.</p> </note>\"\
        },\
        \"ScanFilter\":{\
          \"shape\":\"FilterConditionMap\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>FilterExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.ScanFilter.html\\\">ScanFilter</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ConditionalOperator\":{\
          \"shape\":\"ConditionalOperator\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>FilterExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.ConditionalOperator.html\\\">ConditionalOperator</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExclusiveStartKey\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>The primary key of the first item that this operation will evaluate. Use the value that was returned for <code>LastEvaluatedKey</code> in the previous operation.</p> <p>The data type for <code>ExclusiveStartKey</code> must be String, Number or Binary. No set data types are allowed.</p> <p>In a parallel scan, a <code>Scan</code> request that includes <code>ExclusiveStartKey</code> must specify the same segment whose previous <code>Scan</code> returned the corresponding value of <code>LastEvaluatedKey</code>.</p>\"\
        },\
        \"ReturnConsumedCapacity\":{\"shape\":\"ReturnConsumedCapacity\"},\
        \"TotalSegments\":{\
          \"shape\":\"ScanTotalSegments\",\
          \"documentation\":\"<p>For a parallel <code>Scan</code> request, <code>TotalSegments</code> represents the total number of segments into which the <code>Scan</code> operation will be divided. The value of <code>TotalSegments</code> corresponds to the number of application workers that will perform the parallel scan. For example, if you want to use four application threads to scan a table or an index, specify a <code>TotalSegments</code> value of 4.</p> <p>The value for <code>TotalSegments</code> must be greater than or equal to 1, and less than or equal to 1000000. If you specify a <code>TotalSegments</code> value of 1, the <code>Scan</code> operation will be sequential rather than parallel.</p> <p>If you specify <code>TotalSegments</code>, you must also specify <code>Segment</code>.</p>\"\
        },\
        \"Segment\":{\
          \"shape\":\"ScanSegment\",\
          \"documentation\":\"<p>For a parallel <code>Scan</code> request, <code>Segment</code> identifies an individual segment to be scanned by an application worker.</p> <p>Segment IDs are zero-based, so the first segment is always 0. For example, if you want to use four application threads to scan a table or an index, then the first thread specifies a <code>Segment</code> value of 0, the second thread specifies 1, and so on.</p> <p>The value of <code>LastEvaluatedKey</code> returned from a parallel <code>Scan</code> request must be used as <code>ExclusiveStartKey</code> with the same segment ID in a subsequent <code>Scan</code> operation.</p> <p>The value for <code>Segment</code> must be greater than or equal to 0, and less than the value provided for <code>TotalSegments</code>.</p> <p>If you provide <code>Segment</code>, you must also provide <code>TotalSegments</code>.</p>\"\
        },\
        \"ProjectionExpression\":{\
          \"shape\":\"ProjectionExpression\",\
          \"documentation\":\"<p>A string that identifies one or more attributes to retrieve from the specified table or index. These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must be separated by commas.</p> <p>If no attribute names are specified, then all attributes will be returned. If any of the requested attributes are not found, they will not appear in the result.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"FilterExpression\":{\
          \"shape\":\"ConditionExpression\",\
          \"documentation\":\"<p>A string that contains conditions that DynamoDB applies after the <code>Scan</code> operation, but before the data is returned to you. Items that do not satisfy the <code>FilterExpression</code> criteria are not returned.</p> <note> <p>A <code>FilterExpression</code> is applied after the items have already been read; the process of filtering does not consume any additional read capacity units.</p> </note> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html#FilteringResults\\\">Filter Expressions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression. The following are some use cases for using <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p>To access an attribute whose name conflicts with a DynamoDB reserved word.</p> </li> <li> <p>To create a placeholder for repeating occurrences of an attribute name in an expression.</p> </li> <li> <p>To prevent special characters in an attribute name from being misinterpreted in an expression.</p> </li> </ul> <p>Use the <b>#</b> character in an expression to dereference an attribute name. For example, consider the following attribute name:</p> <ul> <li> <p> <code>Percentile</code> </p> </li> </ul> <p>The name of this attribute conflicts with a reserved word, so it cannot be used directly in an expression. (For the complete list of reserved words, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html\\\">Reserved Words</a> in the <i>Amazon DynamoDB Developer Guide</i>). To work around this, you could specify the following for <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p> <code>{\\\"#P\\\":\\\"Percentile\\\"}</code> </p> </li> </ul> <p>You could then use this substitution in an expression, as in this example:</p> <ul> <li> <p> <code>#P = :val</code> </p> </li> </ul> <note> <p>Tokens that begin with the <b>:</b> character are <i>expression attribute values</i>, which are placeholders for the actual value at runtime.</p> </note> <p>For more information on expression attribute names, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeValues\":{\
          \"shape\":\"ExpressionAttributeValueMap\",\
          \"documentation\":\"<p>One or more values that can be substituted in an expression.</p> <p>Use the <b>:</b> (colon) character in an expression to dereference an attribute value. For example, suppose that you wanted to check whether the value of the <i>ProductStatus</i> attribute was one of the following: </p> <p> <code>Available | Backordered | Discontinued</code> </p> <p>You would first need to specify <code>ExpressionAttributeValues</code> as follows:</p> <p> <code>{ \\\":avail\\\":{\\\"S\\\":\\\"Available\\\"}, \\\":back\\\":{\\\"S\\\":\\\"Backordered\\\"}, \\\":disc\\\":{\\\"S\\\":\\\"Discontinued\\\"} }</code> </p> <p>You could then use these values in an expression, such as this:</p> <p> <code>ProductStatus IN (:avail, :back, :disc)</code> </p> <p>For more information on expression attribute values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html\\\">Specifying Conditions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ConsistentRead\":{\
          \"shape\":\"ConsistentRead\",\
          \"documentation\":\"<p>A Boolean value that determines the read consistency model during the scan:</p> <ul> <li> <p>If <code>ConsistentRead</code> is <code>false</code>, then the data returned from <code>Scan</code> might not contain the results from other recently completed write operations (PutItem, UpdateItem or DeleteItem).</p> </li> <li> <p>If <code>ConsistentRead</code> is <code>true</code>, then all of the write operations that completed before the <code>Scan</code> began are guaranteed to be contained in the <code>Scan</code> response.</p> </li> </ul> <p>The default setting for <code>ConsistentRead</code> is <code>false</code>.</p> <p>The <code>ConsistentRead</code> parameter is not supported on global secondary indexes. If you scan a global secondary index with <code>ConsistentRead</code> set to true, you will receive a <code>ValidationException</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of a <code>Scan</code> operation.</p>\"\
    },\
    \"ScanOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Items\":{\
          \"shape\":\"ItemList\",\
          \"documentation\":\"<p>An array of item attributes that match the scan criteria. Each element in this array consists of an attribute name and the value for that attribute.</p>\"\
        },\
        \"Count\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The number of items in the response.</p> <p>If you set <code>ScanFilter</code> in the request, then <code>Count</code> is the number of items returned after the filter was applied, and <code>ScannedCount</code> is the number of matching items before the filter was applied.</p> <p>If you did not use a filter in the request, then <code>Count</code> is the same as <code>ScannedCount</code>.</p>\"\
        },\
        \"ScannedCount\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The number of items evaluated, before any <code>ScanFilter</code> is applied. A high <code>ScannedCount</code> value with few, or no, <code>Count</code> results indicates an inefficient <code>Scan</code> operation. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html#Count\\\">Count and ScannedCount</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p> <p>If you did not use a filter in the request, then <code>ScannedCount</code> is the same as <code>Count</code>.</p>\"\
        },\
        \"LastEvaluatedKey\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>The primary key of the item where the operation stopped, inclusive of the previous result set. Use this value to start a new operation, excluding this value in the new request.</p> <p>If <code>LastEvaluatedKey</code> is empty, then the \\\"last page\\\" of results has been processed and there is no more data to be retrieved.</p> <p>If <code>LastEvaluatedKey</code> is not empty, it does not necessarily mean that there is more data in the result set. The only way to know when you have reached the end of the result set is when <code>LastEvaluatedKey</code> is empty.</p>\"\
        },\
        \"ConsumedCapacity\":{\
          \"shape\":\"ConsumedCapacity\",\
          \"documentation\":\"<p>The capacity units consumed by the <code>Scan</code> operation. The data returned includes the total provisioned throughput consumed, along with statistics for the table and any indexes involved in the operation. <code>ConsumedCapacity</code> is only returned if the <code>ReturnConsumedCapacity</code> parameter was specified. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughputIntro.html\\\">Provisioned Throughput</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of a <code>Scan</code> operation.</p>\"\
    },\
    \"ScanSegment\":{\
      \"type\":\"integer\",\
      \"max\":999999,\
      \"min\":0\
    },\
    \"ScanTotalSegments\":{\
      \"type\":\"integer\",\
      \"max\":1000000,\
      \"min\":1\
    },\
    \"SecondaryIndexesCapacityMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"IndexName\"},\
      \"value\":{\"shape\":\"Capacity\"}\
    },\
    \"Select\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ALL_ATTRIBUTES\",\
        \"ALL_PROJECTED_ATTRIBUTES\",\
        \"SPECIFIC_ATTRIBUTES\",\
        \"COUNT\"\
      ]\
    },\
    \"SourceTableDetails\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TableName\",\
        \"TableId\",\
        \"KeySchema\",\
        \"TableCreationDateTime\",\
        \"ProvisionedThroughput\"\
      ],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table for which the backup was created. </p>\"\
        },\
        \"TableId\":{\
          \"shape\":\"TableId\",\
          \"documentation\":\"<p>Unique identifier for the table for which the backup was created. </p>\"\
        },\
        \"TableArn\":{\
          \"shape\":\"TableArn\",\
          \"documentation\":\"<p>ARN of the table for which backup was created. </p>\"\
        },\
        \"TableSizeBytes\":{\
          \"shape\":\"Long\",\
          \"documentation\":\"<p>Size of the table in bytes. Please note this is an approximate value.</p>\"\
        },\
        \"KeySchema\":{\
          \"shape\":\"KeySchema\",\
          \"documentation\":\"<p>Schema of the table. </p>\"\
        },\
        \"TableCreationDateTime\":{\
          \"shape\":\"TableCreationDateTime\",\
          \"documentation\":\"<p>Time when the source table was created. </p>\"\
        },\
        \"ProvisionedThroughput\":{\
          \"shape\":\"ProvisionedThroughput\",\
          \"documentation\":\"<p>Read IOPs and Write IOPS on the table when the backup was created.</p>\"\
        },\
        \"ItemCount\":{\
          \"shape\":\"ItemCount\",\
          \"documentation\":\"<p>Number of items in the table. Please note this is an approximate value. </p>\"\
        },\
        \"BillingMode\":{\
          \"shape\":\"BillingMode\",\
          \"documentation\":\"<p>Controls how you are charged for read and write throughput and how you manage capacity. This setting can be changed later.</p> <ul> <li> <p> <code>PROVISIONED</code> - Sets the read/write capacity mode to <code>PROVISIONED</code>. We recommend using <code>PROVISIONED</code> for predictable workloads.</p> </li> <li> <p> <code>PAY_PER_REQUEST</code> - Sets the read/write capacity mode to <code>PAY_PER_REQUEST</code>. We recommend using <code>PAY_PER_REQUEST</code> for unpredictable workloads. </p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the details of the table when the backup was created. </p>\"\
    },\
    \"SourceTableFeatureDetails\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"LocalSecondaryIndexes\":{\
          \"shape\":\"LocalSecondaryIndexes\",\
          \"documentation\":\"<p>Represents the LSI properties for the table when the backup was created. It includes the IndexName, KeySchema and Projection for the LSIs on the table at the time of backup. </p>\"\
        },\
        \"GlobalSecondaryIndexes\":{\
          \"shape\":\"GlobalSecondaryIndexes\",\
          \"documentation\":\"<p>Represents the GSI properties for the table when the backup was created. It includes the IndexName, KeySchema, Projection and ProvisionedThroughput for the GSIs on the table at the time of backup. </p>\"\
        },\
        \"StreamDescription\":{\
          \"shape\":\"StreamSpecification\",\
          \"documentation\":\"<p>Stream settings on the table when the backup was created.</p>\"\
        },\
        \"TimeToLiveDescription\":{\
          \"shape\":\"TimeToLiveDescription\",\
          \"documentation\":\"<p>Time to Live settings on the table when the backup was created.</p>\"\
        },\
        \"SSEDescription\":{\
          \"shape\":\"SSEDescription\",\
          \"documentation\":\"<p>The description of the server-side encryption status on the table when the backup was created.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the details of the features enabled on the table when the backup was created. For example, LSIs, GSIs, streams, TTL. </p>\"\
    },\
    \"StreamArn\":{\
      \"type\":\"string\",\
      \"max\":1024,\
      \"min\":37\
    },\
    \"StreamEnabled\":{\"type\":\"boolean\"},\
    \"StreamSpecification\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"StreamEnabled\":{\
          \"shape\":\"StreamEnabled\",\
          \"documentation\":\"<p>Indicates whether DynamoDB Streams is enabled (true) or disabled (false) on the table.</p>\"\
        },\
        \"StreamViewType\":{\
          \"shape\":\"StreamViewType\",\
          \"documentation\":\"<p> When an item in the table is modified, <code>StreamViewType</code> determines what information is written to the stream for this table. Valid values for <code>StreamViewType</code> are:</p> <ul> <li> <p> <code>KEYS_ONLY</code> - Only the key attributes of the modified item are written to the stream.</p> </li> <li> <p> <code>NEW_IMAGE</code> - The entire item, as it appears after it was modified, is written to the stream.</p> </li> <li> <p> <code>OLD_IMAGE</code> - The entire item, as it appeared before it was modified, is written to the stream.</p> </li> <li> <p> <code>NEW_AND_OLD_IMAGES</code> - Both the new and the old item images of the item are written to the stream.</p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the DynamoDB Streams configuration for a table in DynamoDB.</p>\"\
    },\
    \"StreamViewType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"NEW_IMAGE\",\
        \"OLD_IMAGE\",\
        \"NEW_AND_OLD_IMAGES\",\
        \"KEYS_ONLY\"\
      ]\
    },\
    \"String\":{\"type\":\"string\"},\
    \"StringAttributeValue\":{\"type\":\"string\"},\
    \"StringSetAttributeValue\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"StringAttributeValue\"}\
    },\
    \"TableAlreadyExistsException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>A target table with the specified name already exists. </p>\",\
      \"exception\":true\
    },\
    \"TableArn\":{\"type\":\"string\"},\
    \"TableCreationDateTime\":{\"type\":\"timestamp\"},\
    \"TableDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AttributeDefinitions\":{\
          \"shape\":\"AttributeDefinitions\",\
          \"documentation\":\"<p>An array of <code>AttributeDefinition</code> objects. Each of these objects describes one attribute in the table and index key schema.</p> <p>Each <code>AttributeDefinition</code> object in this array is composed of:</p> <ul> <li> <p> <code>AttributeName</code> - The name of the attribute.</p> </li> <li> <p> <code>AttributeType</code> - The data type for the attribute.</p> </li> </ul>\"\
        },\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table.</p>\"\
        },\
        \"KeySchema\":{\
          \"shape\":\"KeySchema\",\
          \"documentation\":\"<p>The primary key structure for the table. Each <code>KeySchemaElement</code> consists of:</p> <ul> <li> <p> <code>AttributeName</code> - The name of the attribute.</p> </li> <li> <p> <code>KeyType</code> - The role of the attribute:</p> <ul> <li> <p> <code>HASH</code> - partition key</p> </li> <li> <p> <code>RANGE</code> - sort key</p> </li> </ul> <note> <p>The partition key of an item is also known as its <i>hash attribute</i>. The term \\\"hash attribute\\\" derives from DynamoDB' usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values.</p> <p>The sort key of an item is also known as its <i>range attribute</i>. The term \\\"range attribute\\\" derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.</p> </note> </li> </ul> <p>For more information about primary keys, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DataModel.html#DataModelPrimaryKey\\\">Primary Key</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"TableStatus\":{\
          \"shape\":\"TableStatus\",\
          \"documentation\":\"<p>The current state of the table:</p> <ul> <li> <p> <code>CREATING</code> - The table is being created.</p> </li> <li> <p> <code>UPDATING</code> - The table is being updated.</p> </li> <li> <p> <code>DELETING</code> - The table is being deleted.</p> </li> <li> <p> <code>ACTIVE</code> - The table is ready for use.</p> </li> </ul>\"\
        },\
        \"CreationDateTime\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>The date and time when the table was created, in <a href=\\\"http://www.epochconverter.com/\\\">UNIX epoch time</a> format.</p>\"\
        },\
        \"ProvisionedThroughput\":{\
          \"shape\":\"ProvisionedThroughputDescription\",\
          \"documentation\":\"<p>The provisioned throughput settings for the table, consisting of read and write capacity units, along with data about increases and decreases.</p>\"\
        },\
        \"TableSizeBytes\":{\
          \"shape\":\"Long\",\
          \"documentation\":\"<p>The total size of the specified table, in bytes. DynamoDB updates this value approximately every six hours. Recent changes might not be reflected in this value.</p>\"\
        },\
        \"ItemCount\":{\
          \"shape\":\"Long\",\
          \"documentation\":\"<p>The number of items in the specified table. DynamoDB updates this value approximately every six hours. Recent changes might not be reflected in this value.</p>\"\
        },\
        \"TableArn\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) that uniquely identifies the table.</p>\"\
        },\
        \"TableId\":{\
          \"shape\":\"TableId\",\
          \"documentation\":\"<p>Unique identifier for the table for which the backup was created. </p>\"\
        },\
        \"BillingModeSummary\":{\
          \"shape\":\"BillingModeSummary\",\
          \"documentation\":\"<p>Contains the details for the read/write capacity mode.</p>\"\
        },\
        \"LocalSecondaryIndexes\":{\
          \"shape\":\"LocalSecondaryIndexDescriptionList\",\
          \"documentation\":\"<p>Represents one or more local secondary indexes on the table. Each index is scoped to a given partition key value. Tables with one or more local secondary indexes are subject to an item collection size limit, where the amount of data within a given item collection cannot exceed 10 GB. Each element is composed of:</p> <ul> <li> <p> <code>IndexName</code> - The name of the local secondary index.</p> </li> <li> <p> <code>KeySchema</code> - Specifies the complete index key schema. The attribute names in the key schema must be between 1 and 255 characters (inclusive). The key schema must begin with the same partition key as the table.</p> </li> <li> <p> <code>Projection</code> - Specifies attributes that are copied (projected) from the table into the index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. Each attribute specification is composed of:</p> <ul> <li> <p> <code>ProjectionType</code> - One of the following:</p> <ul> <li> <p> <code>KEYS_ONLY</code> - Only the index and primary keys are projected into the index.</p> </li> <li> <p> <code>INCLUDE</code> - Only the specified table attributes are projected into the index. The list of projected attributes are in <code>NonKeyAttributes</code>.</p> </li> <li> <p> <code>ALL</code> - All of the table attributes are projected into the index.</p> </li> </ul> </li> <li> <p> <code>NonKeyAttributes</code> - A list of one or more non-key attribute names that are projected into the secondary index. The total count of attributes provided in <code>NonKeyAttributes</code>, summed across all of the secondary indexes, must not exceed 20. If you project the same attribute into two different indexes, this counts as two distinct attributes when determining the total.</p> </li> </ul> </li> <li> <p> <code>IndexSizeBytes</code> - Represents the total size of the index, in bytes. DynamoDB updates this value approximately every six hours. Recent changes might not be reflected in this value.</p> </li> <li> <p> <code>ItemCount</code> - Represents the number of items in the index. DynamoDB updates this value approximately every six hours. Recent changes might not be reflected in this value.</p> </li> </ul> <p>If the table is in the <code>DELETING</code> state, no information about indexes will be returned.</p>\"\
        },\
        \"GlobalSecondaryIndexes\":{\
          \"shape\":\"GlobalSecondaryIndexDescriptionList\",\
          \"documentation\":\"<p>The global secondary indexes, if any, on the table. Each index is scoped to a given partition key value. Each element is composed of:</p> <ul> <li> <p> <code>Backfilling</code> - If true, then the index is currently in the backfilling phase. Backfilling occurs only when a new global secondary index is added to the table; it is the process by which DynamoDB populates the new index with data from the table. (This attribute does not appear for indexes that were created during a <code>CreateTable</code> operation.)</p> </li> <li> <p> <code>IndexName</code> - The name of the global secondary index.</p> </li> <li> <p> <code>IndexSizeBytes</code> - The total size of the global secondary index, in bytes. DynamoDB updates this value approximately every six hours. Recent changes might not be reflected in this value. </p> </li> <li> <p> <code>IndexStatus</code> - The current status of the global secondary index:</p> <ul> <li> <p> <code>CREATING</code> - The index is being created.</p> </li> <li> <p> <code>UPDATING</code> - The index is being updated.</p> </li> <li> <p> <code>DELETING</code> - The index is being deleted.</p> </li> <li> <p> <code>ACTIVE</code> - The index is ready for use.</p> </li> </ul> </li> <li> <p> <code>ItemCount</code> - The number of items in the global secondary index. DynamoDB updates this value approximately every six hours. Recent changes might not be reflected in this value. </p> </li> <li> <p> <code>KeySchema</code> - Specifies the complete index key schema. The attribute names in the key schema must be between 1 and 255 characters (inclusive). The key schema must begin with the same partition key as the table.</p> </li> <li> <p> <code>Projection</code> - Specifies attributes that are copied (projected) from the table into the index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. Each attribute specification is composed of:</p> <ul> <li> <p> <code>ProjectionType</code> - One of the following:</p> <ul> <li> <p> <code>KEYS_ONLY</code> - Only the index and primary keys are projected into the index.</p> </li> <li> <p> <code>INCLUDE</code> - Only the specified table attributes are projected into the index. The list of projected attributes are in <code>NonKeyAttributes</code>.</p> </li> <li> <p> <code>ALL</code> - All of the table attributes are projected into the index.</p> </li> </ul> </li> <li> <p> <code>NonKeyAttributes</code> - A list of one or more non-key attribute names that are projected into the secondary index. The total count of attributes provided in <code>NonKeyAttributes</code>, summed across all of the secondary indexes, must not exceed 20. If you project the same attribute into two different indexes, this counts as two distinct attributes when determining the total.</p> </li> </ul> </li> <li> <p> <code>ProvisionedThroughput</code> - The provisioned throughput settings for the global secondary index, consisting of read and write capacity units, along with data about increases and decreases. </p> </li> </ul> <p>If the table is in the <code>DELETING</code> state, no information about indexes will be returned.</p>\"\
        },\
        \"StreamSpecification\":{\
          \"shape\":\"StreamSpecification\",\
          \"documentation\":\"<p>The current DynamoDB Streams configuration for the table.</p>\"\
        },\
        \"LatestStreamLabel\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A timestamp, in ISO 8601 format, for this stream.</p> <p>Note that <code>LatestStreamLabel</code> is not a unique identifier for the stream, because it is possible that a stream from another table might have the same timestamp. However, the combination of the following three elements is guaranteed to be unique:</p> <ul> <li> <p>the AWS customer ID.</p> </li> <li> <p>the table name.</p> </li> <li> <p>the <code>StreamLabel</code>.</p> </li> </ul>\"\
        },\
        \"LatestStreamArn\":{\
          \"shape\":\"StreamArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) that uniquely identifies the latest stream for this table.</p>\"\
        },\
        \"RestoreSummary\":{\
          \"shape\":\"RestoreSummary\",\
          \"documentation\":\"<p>Contains details for the restore.</p>\"\
        },\
        \"SSEDescription\":{\
          \"shape\":\"SSEDescription\",\
          \"documentation\":\"<p>The description of the server-side encryption status on the specified table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the properties of a table.</p>\"\
    },\
    \"TableId\":{\
      \"type\":\"string\",\
      \"pattern\":\"[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\"\
    },\
    \"TableInUseException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>A target table with the specified name is either being created or deleted. </p>\",\
      \"exception\":true\
    },\
    \"TableName\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":3,\
      \"pattern\":\"[a-zA-Z0-9_.-]+\"\
    },\
    \"TableNameList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"TableName\"}\
    },\
    \"TableNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>A source table with the name <code>TableName</code> does not currently exist within the subscriber's account.</p>\",\
      \"exception\":true\
    },\
    \"TableStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CREATING\",\
        \"UPDATING\",\
        \"DELETING\",\
        \"ACTIVE\"\
      ]\
    },\
    \"Tag\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Key\",\
        \"Value\"\
      ],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"TagKeyString\",\
          \"documentation\":\"<p>The key of the tag.Tag keys are case sensitive. Each DynamoDB table can only have up to one tag with the same key. If you try to add an existing tag (same key), the existing tag value will be updated to the new value. </p>\"\
        },\
        \"Value\":{\
          \"shape\":\"TagValueString\",\
          \"documentation\":\"<p>The value of the tag. Tag values are case-sensitive and can be null.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a tag. A tag is a key-value pair. You can add up to 50 tags to a single DynamoDB table. </p> <p> AWS-assigned tag names and values are automatically assigned the aws: prefix, which the user cannot assign. AWS-assigned tag names do not count towards the tag limit of 50. User-assigned tag names have the prefix user: in the Cost Allocation Report. You cannot backdate the application of a tag. </p> <p>For an overview on tagging DynamoDB resources, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tagging.html\\\">Tagging for DynamoDB</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
    },\
    \"TagKeyList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"TagKeyString\"}\
    },\
    \"TagKeyString\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1\
    },\
    \"TagList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Tag\"}\
    },\
    \"TagResourceInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"ResourceArn\",\
        \"Tags\"\
      ],\
      \"members\":{\
        \"ResourceArn\":{\
          \"shape\":\"ResourceArnString\",\
          \"documentation\":\"<p>Identifies the Amazon DynamoDB resource to which tags should be added. This value is an Amazon Resource Name (ARN).</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagList\",\
          \"documentation\":\"<p>The tags to be assigned to the Amazon DynamoDB resource.</p>\"\
        }\
      }\
    },\
    \"TagValueString\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":0\
    },\
    \"TimeRangeLowerBound\":{\"type\":\"timestamp\"},\
    \"TimeRangeUpperBound\":{\"type\":\"timestamp\"},\
    \"TimeToLiveAttributeName\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1\
    },\
    \"TimeToLiveDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TimeToLiveStatus\":{\
          \"shape\":\"TimeToLiveStatus\",\
          \"documentation\":\"<p> The Time to Live status for the table.</p>\"\
        },\
        \"AttributeName\":{\
          \"shape\":\"TimeToLiveAttributeName\",\
          \"documentation\":\"<p> The name of the Time to Live attribute for items in the table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The description of the Time to Live (TTL) status on the specified table. </p>\"\
    },\
    \"TimeToLiveEnabled\":{\"type\":\"boolean\"},\
    \"TimeToLiveSpecification\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Enabled\",\
        \"AttributeName\"\
      ],\
      \"members\":{\
        \"Enabled\":{\
          \"shape\":\"TimeToLiveEnabled\",\
          \"documentation\":\"<p>Indicates whether Time To Live is to be enabled (true) or disabled (false) on the table.</p>\"\
        },\
        \"AttributeName\":{\
          \"shape\":\"TimeToLiveAttributeName\",\
          \"documentation\":\"<p>The name of the Time to Live attribute used to store the expiration time for items in the table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the settings used to enable or disable Time to Live for the specified table.</p>\"\
    },\
    \"TimeToLiveStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ENABLING\",\
        \"DISABLING\",\
        \"ENABLED\",\
        \"DISABLED\"\
      ]\
    },\
    \"TransactGetItem\":{\
      \"type\":\"structure\",\
      \"required\":[\"Get\"],\
      \"members\":{\
        \"Get\":{\
          \"shape\":\"Get\",\
          \"documentation\":\"<p>Contains the primary key that identifies the item to get, together with the name of the table that contains the item, and optionally the specific attributes of the item to retrieve.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies an item to be retrieved as part of the transaction.</p>\"\
    },\
    \"TransactGetItemList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"TransactGetItem\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"TransactGetItemsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TransactItems\"],\
      \"members\":{\
        \"TransactItems\":{\
          \"shape\":\"TransactGetItemList\",\
          \"documentation\":\"<p>An ordered array of up to 10 <code>TransactGetItem</code> objects, each of which contains a <code>Get</code> structure.</p>\"\
        },\
        \"ReturnConsumedCapacity\":{\
          \"shape\":\"ReturnConsumedCapacity\",\
          \"documentation\":\"<p>A value of <code>TOTAL</code> causes consumed capacity information to be returned, and a value of <code>NONE</code> prevents that information from being returned. No other value is valid.</p>\"\
        }\
      }\
    },\
    \"TransactGetItemsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ConsumedCapacity\":{\
          \"shape\":\"ConsumedCapacityMultiple\",\
          \"documentation\":\"<p>If the <i>ReturnConsumedCapacity</i> value was <code>TOTAL</code>, this is an array of <code>ConsumedCapacity</code> objects, one for each table addressed by <code>TransactGetItem</code> objects in the <i>TransactItems</i> parameter. These <code>ConsumedCapacity</code> objects report the read-capacity units consumed by the <code>TransactGetItems</code> call in that table.</p>\"\
        },\
        \"Responses\":{\
          \"shape\":\"ItemResponseList\",\
          \"documentation\":\"<p>An ordered array of up to 10 <code>ItemResponse</code> objects, each of which corresponds to the <code>TransactGetItem</code> object in the same position in the <i>TransactItems</i> array. Each <code>ItemResponse</code> object contains a Map of the name-value pairs that are the projected attributes of the requested item.</p> <p>If a requested item could not be retrieved, the corresponding <code>ItemResponse</code> object is Null, or if the requested item has no projected attributes, the corresponding <code>ItemResponse</code> object is an empty Map. </p>\"\
        }\
      }\
    },\
    \"TransactWriteItem\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ConditionCheck\":{\
          \"shape\":\"ConditionCheck\",\
          \"documentation\":\"<p>A request to perform a check item operation.</p>\"\
        },\
        \"Put\":{\
          \"shape\":\"Put\",\
          \"documentation\":\"<p>A request to perform a <code>PutItem</code> operation.</p>\"\
        },\
        \"Delete\":{\
          \"shape\":\"Delete\",\
          \"documentation\":\"<p>A request to perform a <code>DeleteItem</code> operation.</p>\"\
        },\
        \"Update\":{\
          \"shape\":\"Update\",\
          \"documentation\":\"<p>A request to perform an <code>UpdateItem</code> operation.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A list of requests that can perform update, put, delete, or check operations on multiple items in one or more tables atomically.</p>\"\
    },\
    \"TransactWriteItemList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"TransactWriteItem\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"TransactWriteItemsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TransactItems\"],\
      \"members\":{\
        \"TransactItems\":{\
          \"shape\":\"TransactWriteItemList\",\
          \"documentation\":\"<p>An ordered array of up to 10 <code>TransactWriteItem</code> objects, each of which contains a <code>ConditionCheck</code>, <code>Put</code>, <code>Update</code>, or <code>Delete</code> object. These can operate on items in different tables, but the tables must reside in the same AWS account and region, and no two of them can operate on the same item. </p>\"\
        },\
        \"ReturnConsumedCapacity\":{\"shape\":\"ReturnConsumedCapacity\"},\
        \"ReturnItemCollectionMetrics\":{\
          \"shape\":\"ReturnItemCollectionMetrics\",\
          \"documentation\":\"<p>Determines whether item collection metrics are returned. If set to <code>SIZE</code>, the response includes statistics about item collections (if any), that were modified during the operation and are returned in the response. If set to <code>NONE</code> (the default), no statistics are returned. </p>\"\
        },\
        \"ClientRequestToken\":{\
          \"shape\":\"ClientRequestToken\",\
          \"documentation\":\"<p>Providing a <code>ClientRequestToken</code> makes the call to <code>TransactWriteItems</code> idempotent, meaning that multiple identical calls have the same effect as one single call.</p> <p>Although multiple identical calls using the same client request token produce the same result on the server (no side effects), the responses to the calls may not be the same. If the <code>ReturnConsumedCapacity&gt;</code> parameter is set, then the initial <code>TransactWriteItems</code> call returns the amount of write capacity units consumed in making the changes, and subsequent <code>TransactWriteItems</code> calls with the same client token return the amount of read capacity units consumed in reading the item.</p> <p>A client request token is valid for 10 minutes after the first request that uses it completes. After 10 minutes, any request with the same client token is treated as a new request. Do not resubmit the same request with the same client token for more than 10 minutes or the result may not be idempotent.</p> <p>If you submit a request with the same client token but a change in other parameters within the 10 minute idempotency window, DynamoDB returns an <code>IdempotentParameterMismatch</code> exception.</p>\",\
          \"idempotencyToken\":true\
        }\
      }\
    },\
    \"TransactWriteItemsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ConsumedCapacity\":{\
          \"shape\":\"ConsumedCapacityMultiple\",\
          \"documentation\":\"<p>The capacity units consumed by the entire <code>TransactWriteItems</code> operation. The values of the list are ordered according to the ordering of the <code>TransactItems</code> request parameter. </p>\"\
        },\
        \"ItemCollectionMetrics\":{\
          \"shape\":\"ItemCollectionMetricsPerTable\",\
          \"documentation\":\"<p>A list of tables that were processed by <code>TransactWriteItems</code> and, for each table, information about any item collections that were affected by individual <code>UpdateItem</code>, <code>PutItem</code> or <code>DeleteItem</code> operations. </p>\"\
        }\
      }\
    },\
    \"TransactionCanceledException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\"shape\":\"ErrorMessage\"},\
        \"CancellationReasons\":{\
          \"shape\":\"CancellationReasonList\",\
          \"documentation\":\"<p>A list of cancellation reasons.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The entire transaction request was rejected.</p> <p>DynamoDB rejects a <code>TransactWriteItems</code> request under the following circumstances:</p> <ul> <li> <p>A condition in one of the condition expressions is not met.</p> </li> <li> <p>A table in the <code>TransactWriteItems</code> request is in a different account or region.</p> </li> <li> <p>More than one action in the <code>TransactWriteItems</code> operation targets the same item.</p> </li> <li> <p>There is insufficient provisioned capacity for the transaction to be completed.</p> </li> <li> <p>An item size becomes too large (larger than 400 KB), or a local secondary index (LSI) becomes too large, or a similar validation error occurs because of changes made by the transaction.</p> </li> <li> <p>There is a user error, such as an invalid data format.</p> </li> </ul> <p>DynamoDB rejects a <code>TransactGetItems</code> request under the following circumstances:</p> <ul> <li> <p>There is an ongoing <code>TransactGetItems</code> operation that conflicts with a concurrent <code>PutItem</code>, <code>UpdateItem</code>, <code>DeleteItem</code> or <code>TransactWriteItems</code> request. In this case the <code>TransactGetItems</code> operation fails with a <code>TransactionCanceledException</code>.</p> </li> <li> <p>A table in the <code>TransactGetItems</code> request is in a different account or region.</p> </li> <li> <p>There is insufficient provisioned capacity for the transaction to be completed.</p> </li> <li> <p>There is a user error, such as an invalid data format.</p> </li> </ul>\",\
      \"exception\":true\
    },\
    \"TransactionConflictException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>Operation was rejected because there is an ongoing transaction for the item.</p>\",\
      \"exception\":true\
    },\
    \"TransactionInProgressException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>The transaction with the given request token is already in progress.</p>\",\
      \"exception\":true\
    },\
    \"UntagResourceInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"ResourceArn\",\
        \"TagKeys\"\
      ],\
      \"members\":{\
        \"ResourceArn\":{\
          \"shape\":\"ResourceArnString\",\
          \"documentation\":\"<p>The Amazon DyanamoDB resource the tags will be removed from. This value is an Amazon Resource Name (ARN).</p>\"\
        },\
        \"TagKeys\":{\
          \"shape\":\"TagKeyList\",\
          \"documentation\":\"<p>A list of tag keys. Existing tags of the resource whose keys are members of this list will be removed from the Amazon DynamoDB resource.</p>\"\
        }\
      }\
    },\
    \"Update\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Key\",\
        \"UpdateExpression\",\
        \"TableName\"\
      ],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>The primary key of the item to be updated. Each element consists of an attribute name and a value for that attribute.</p>\"\
        },\
        \"UpdateExpression\":{\
          \"shape\":\"UpdateExpression\",\
          \"documentation\":\"<p>An expression that defines one or more attributes to be updated, the action to be performed on them, and new value(s) for them.</p>\"\
        },\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>Name of the table for the <code>UpdateItem</code> request.</p>\"\
        },\
        \"ConditionExpression\":{\
          \"shape\":\"ConditionExpression\",\
          \"documentation\":\"<p>A condition that must be satisfied in order for a conditional update to succeed.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression.</p>\"\
        },\
        \"ExpressionAttributeValues\":{\
          \"shape\":\"ExpressionAttributeValueMap\",\
          \"documentation\":\"<p>One or more values that can be substituted in an expression.</p>\"\
        },\
        \"ReturnValuesOnConditionCheckFailure\":{\
          \"shape\":\"ReturnValuesOnConditionCheckFailure\",\
          \"documentation\":\"<p>Use <code>ReturnValuesOnConditionCheckFailure</code> to get the item attributes if the <code>Update</code> condition fails. For <code>ReturnValuesOnConditionCheckFailure</code>, the valid values are: NONE, ALL_OLD, UPDATED_OLD, ALL_NEW, UPDATED_NEW.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a request to perform an <code>UpdateItem</code> operation.</p>\"\
    },\
    \"UpdateContinuousBackupsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TableName\",\
        \"PointInTimeRecoverySpecification\"\
      ],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table.</p>\"\
        },\
        \"PointInTimeRecoverySpecification\":{\
          \"shape\":\"PointInTimeRecoverySpecification\",\
          \"documentation\":\"<p>Represents the settings used to enable point in time recovery.</p>\"\
        }\
      }\
    },\
    \"UpdateContinuousBackupsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ContinuousBackupsDescription\":{\
          \"shape\":\"ContinuousBackupsDescription\",\
          \"documentation\":\"<p>Represents the continuous backups and point in time recovery settings on the table.</p>\"\
        }\
      }\
    },\
    \"UpdateExpression\":{\"type\":\"string\"},\
    \"UpdateGlobalSecondaryIndexAction\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"IndexName\",\
        \"ProvisionedThroughput\"\
      ],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"IndexName\",\
          \"documentation\":\"<p>The name of the global secondary index to be updated.</p>\"\
        },\
        \"ProvisionedThroughput\":{\
          \"shape\":\"ProvisionedThroughput\",\
          \"documentation\":\"<p>Represents the provisioned throughput settings for the specified global secondary index.</p> <p>For current minimum and maximum provisioned throughput values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html\\\">Limits</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the new provisioned throughput settings to be applied to a global secondary index.</p>\"\
    },\
    \"UpdateGlobalTableInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"GlobalTableName\",\
        \"ReplicaUpdates\"\
      ],\
      \"members\":{\
        \"GlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The global table name.</p>\"\
        },\
        \"ReplicaUpdates\":{\
          \"shape\":\"ReplicaUpdateList\",\
          \"documentation\":\"<p>A list of regions that should be added or removed from the global table.</p>\"\
        }\
      }\
    },\
    \"UpdateGlobalTableOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GlobalTableDescription\":{\
          \"shape\":\"GlobalTableDescription\",\
          \"documentation\":\"<p>Contains the details of the global table.</p>\"\
        }\
      }\
    },\
    \"UpdateGlobalTableSettingsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"GlobalTableName\"],\
      \"members\":{\
        \"GlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the global table</p>\"\
        },\
        \"GlobalTableBillingMode\":{\
          \"shape\":\"BillingMode\",\
          \"documentation\":\"<p>The billing mode of the global table. If <code>GlobalTableBillingMode</code> is not specified, the global table defaults to <code>PROVISIONED</code> capacity billing mode.</p>\"\
        },\
        \"GlobalTableProvisionedWriteCapacityUnits\":{\
          \"shape\":\"PositiveLongObject\",\
          \"documentation\":\"<p>The maximum number of writes consumed per second before DynamoDB returns a <code>ThrottlingException.</code> </p>\"\
        },\
        \"GlobalTableProvisionedWriteCapacityAutoScalingSettingsUpdate\":{\
          \"shape\":\"AutoScalingSettingsUpdate\",\
          \"documentation\":\"<p>AutoScaling settings for managing provisioned write capacity for the global table.</p>\"\
        },\
        \"GlobalTableGlobalSecondaryIndexSettingsUpdate\":{\
          \"shape\":\"GlobalTableGlobalSecondaryIndexSettingsUpdateList\",\
          \"documentation\":\"<p>Represents the settings of a global secondary index for a global table that will be modified.</p>\"\
        },\
        \"ReplicaSettingsUpdate\":{\
          \"shape\":\"ReplicaSettingsUpdateList\",\
          \"documentation\":\"<p>Represents the settings for a global table in a region that will be modified.</p>\"\
        }\
      }\
    },\
    \"UpdateGlobalTableSettingsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GlobalTableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the global table.</p>\"\
        },\
        \"ReplicaSettings\":{\
          \"shape\":\"ReplicaSettingsDescriptionList\",\
          \"documentation\":\"<p>The region specific settings for the global table.</p>\"\
        }\
      }\
    },\
    \"UpdateItemInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TableName\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table containing the item to update.</p>\"\
        },\
        \"Key\":{\
          \"shape\":\"Key\",\
          \"documentation\":\"<p>The primary key of the item to be updated. Each element consists of an attribute name and a value for that attribute.</p> <p>For the primary key, you must provide all of the attributes. For example, with a simple primary key, you only need to provide a value for the partition key. For a composite primary key, you must provide values for both the partition key and the sort key.</p>\"\
        },\
        \"AttributeUpdates\":{\
          \"shape\":\"AttributeUpdates\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>UpdateExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributeUpdates.html\\\">AttributeUpdates</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"Expected\":{\
          \"shape\":\"ExpectedAttributeMap\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>ConditionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.Expected.html\\\">Expected</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ConditionalOperator\":{\
          \"shape\":\"ConditionalOperator\",\
          \"documentation\":\"<p>This is a legacy parameter. Use <code>ConditionExpression</code> instead. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.ConditionalOperator.html\\\">ConditionalOperator</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ReturnValues\":{\
          \"shape\":\"ReturnValue\",\
          \"documentation\":\"<p>Use <code>ReturnValues</code> if you want to get the item attributes as they appear before or after they are updated. For <code>UpdateItem</code>, the valid values are:</p> <ul> <li> <p> <code>NONE</code> - If <code>ReturnValues</code> is not specified, or if its value is <code>NONE</code>, then nothing is returned. (This setting is the default for <code>ReturnValues</code>.)</p> </li> <li> <p> <code>ALL_OLD</code> - Returns all of the attributes of the item, as they appeared before the UpdateItem operation.</p> </li> <li> <p> <code>UPDATED_OLD</code> - Returns only the updated attributes, as they appeared before the UpdateItem operation.</p> </li> <li> <p> <code>ALL_NEW</code> - Returns all of the attributes of the item, as they appear after the UpdateItem operation.</p> </li> <li> <p> <code>UPDATED_NEW</code> - Returns only the updated attributes, as they appear after the UpdateItem operation.</p> </li> </ul> <p>There is no additional cost associated with requesting a return value aside from the small network and processing overhead of receiving a larger response. No read capacity units are consumed.</p> <p>The values returned are strongly consistent.</p>\"\
        },\
        \"ReturnConsumedCapacity\":{\"shape\":\"ReturnConsumedCapacity\"},\
        \"ReturnItemCollectionMetrics\":{\
          \"shape\":\"ReturnItemCollectionMetrics\",\
          \"documentation\":\"<p>Determines whether item collection metrics are returned. If set to <code>SIZE</code>, the response includes statistics about item collections, if any, that were modified during the operation are returned in the response. If set to <code>NONE</code> (the default), no statistics are returned.</p>\"\
        },\
        \"UpdateExpression\":{\
          \"shape\":\"UpdateExpression\",\
          \"documentation\":\"<p>An expression that defines one or more attributes to be updated, the action to be performed on them, and new value(s) for them.</p> <p>The following action values are available for <code>UpdateExpression</code>.</p> <ul> <li> <p> <code>SET</code> - Adds one or more attributes and values to an item. If any of these attribute already exist, they are replaced by the new values. You can also use <code>SET</code> to add or subtract from an attribute that is of type Number. For example: <code>SET myNum = myNum + :val</code> </p> <p> <code>SET</code> supports the following functions:</p> <ul> <li> <p> <code>if_not_exists (path, operand)</code> - if the item does not contain an attribute at the specified path, then <code>if_not_exists</code> evaluates to operand; otherwise, it evaluates to path. You can use this function to avoid overwriting an attribute that may already be present in the item.</p> </li> <li> <p> <code>list_append (operand, operand)</code> - evaluates to a list with a new element added to it. You can append the new element to the start or the end of the list by reversing the order of the operands.</p> </li> </ul> <p>These function names are case-sensitive.</p> </li> <li> <p> <code>REMOVE</code> - Removes one or more attributes from an item.</p> </li> <li> <p> <code>ADD</code> - Adds the specified value to the item, if the attribute does not already exist. If the attribute does exist, then the behavior of <code>ADD</code> depends on the data type of the attribute:</p> <ul> <li> <p>If the existing attribute is a number, and if <code>Value</code> is also a number, then <code>Value</code> is mathematically added to the existing attribute. If <code>Value</code> is a negative number, then it is subtracted from the existing attribute.</p> <note> <p>If you use <code>ADD</code> to increment or decrement a number value for an item that doesn't exist before the update, DynamoDB uses <code>0</code> as the initial value.</p> <p>Similarly, if you use <code>ADD</code> for an existing item to increment or decrement an attribute value that doesn't exist before the update, DynamoDB uses <code>0</code> as the initial value. For example, suppose that the item you want to update doesn't have an attribute named <i>itemcount</i>, but you decide to <code>ADD</code> the number <code>3</code> to this attribute anyway. DynamoDB will create the <i>itemcount</i> attribute, set its initial value to <code>0</code>, and finally add <code>3</code> to it. The result will be a new <i>itemcount</i> attribute in the item, with a value of <code>3</code>.</p> </note> </li> <li> <p>If the existing data type is a set and if <code>Value</code> is also a set, then <code>Value</code> is added to the existing set. For example, if the attribute value is the set <code>[1,2]</code>, and the <code>ADD</code> action specified <code>[3]</code>, then the final attribute value is <code>[1,2,3]</code>. An error occurs if an <code>ADD</code> action is specified for a set attribute and the attribute type specified does not match the existing set type. </p> <p>Both sets must have the same primitive data type. For example, if the existing data type is a set of strings, the <code>Value</code> must also be a set of strings.</p> </li> </ul> <important> <p>The <code>ADD</code> action only supports Number and set data types. In addition, <code>ADD</code> can only be used on top-level attributes, not nested attributes.</p> </important> </li> <li> <p> <code>DELETE</code> - Deletes an element from a set.</p> <p>If a set of values is specified, then those values are subtracted from the old set. For example, if the attribute value was the set <code>[a,b,c]</code> and the <code>DELETE</code> action specifies <code>[a,c]</code>, then the final attribute value is <code>[b]</code>. Specifying an empty set is an error.</p> <important> <p>The <code>DELETE</code> action only supports set data types. In addition, <code>DELETE</code> can only be used on top-level attributes, not nested attributes.</p> </important> </li> </ul> <p>You can have many actions in a single expression, such as the following: <code>SET a=:value1, b=:value2 DELETE :value3, :value4, :value5</code> </p> <p>For more information on update expressions, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.Modifying.html\\\">Modifying Items and Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ConditionExpression\":{\
          \"shape\":\"ConditionExpression\",\
          \"documentation\":\"<p>A condition that must be satisfied in order for a conditional update to succeed.</p> <p>An expression can contain any of the following:</p> <ul> <li> <p>Functions: <code>attribute_exists | attribute_not_exists | attribute_type | contains | begins_with | size</code> </p> <p>These function names are case-sensitive.</p> </li> <li> <p>Comparison operators: <code>= | &lt;&gt; | &lt; | &gt; | &lt;= | &gt;= | BETWEEN | IN </code> </p> </li> <li> <p> Logical operators: <code>AND | OR | NOT</code> </p> </li> </ul> <p>For more information on condition expressions, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html\\\">Specifying Conditions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeNames\":{\
          \"shape\":\"ExpressionAttributeNameMap\",\
          \"documentation\":\"<p>One or more substitution tokens for attribute names in an expression. The following are some use cases for using <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p>To access an attribute whose name conflicts with a DynamoDB reserved word.</p> </li> <li> <p>To create a placeholder for repeating occurrences of an attribute name in an expression.</p> </li> <li> <p>To prevent special characters in an attribute name from being misinterpreted in an expression.</p> </li> </ul> <p>Use the <b>#</b> character in an expression to dereference an attribute name. For example, consider the following attribute name:</p> <ul> <li> <p> <code>Percentile</code> </p> </li> </ul> <p>The name of this attribute conflicts with a reserved word, so it cannot be used directly in an expression. (For the complete list of reserved words, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html\\\">Reserved Words</a> in the <i>Amazon DynamoDB Developer Guide</i>). To work around this, you could specify the following for <code>ExpressionAttributeNames</code>:</p> <ul> <li> <p> <code>{\\\"#P\\\":\\\"Percentile\\\"}</code> </p> </li> </ul> <p>You could then use this substitution in an expression, as in this example:</p> <ul> <li> <p> <code>#P = :val</code> </p> </li> </ul> <note> <p>Tokens that begin with the <b>:</b> character are <i>expression attribute values</i>, which are placeholders for the actual value at runtime.</p> </note> <p>For more information on expression attribute names, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html\\\">Accessing Item Attributes</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ExpressionAttributeValues\":{\
          \"shape\":\"ExpressionAttributeValueMap\",\
          \"documentation\":\"<p>One or more values that can be substituted in an expression.</p> <p>Use the <b>:</b> (colon) character in an expression to dereference an attribute value. For example, suppose that you wanted to check whether the value of the <i>ProductStatus</i> attribute was one of the following: </p> <p> <code>Available | Backordered | Discontinued</code> </p> <p>You would first need to specify <code>ExpressionAttributeValues</code> as follows:</p> <p> <code>{ \\\":avail\\\":{\\\"S\\\":\\\"Available\\\"}, \\\":back\\\":{\\\"S\\\":\\\"Backordered\\\"}, \\\":disc\\\":{\\\"S\\\":\\\"Discontinued\\\"} }</code> </p> <p>You could then use these values in an expression, such as this:</p> <p> <code>ProductStatus IN (:avail, :back, :disc)</code> </p> <p>For more information on expression attribute values, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html\\\">Specifying Conditions</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of an <code>UpdateItem</code> operation.</p>\"\
    },\
    \"UpdateItemOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Attributes\":{\
          \"shape\":\"AttributeMap\",\
          \"documentation\":\"<p>A map of attribute values as they appear before or after the <code>UpdateItem</code> operation, as determined by the <code>ReturnValues</code> parameter.</p> <p>The <code>Attributes</code> map is only present if <code>ReturnValues</code> was specified as something other than <code>NONE</code> in the request. Each element represents one attribute.</p>\"\
        },\
        \"ConsumedCapacity\":{\
          \"shape\":\"ConsumedCapacity\",\
          \"documentation\":\"<p>The capacity units consumed by the <code>UpdateItem</code> operation. The data returned includes the total provisioned throughput consumed, along with statistics for the table and any indexes involved in the operation. <code>ConsumedCapacity</code> is only returned if the <code>ReturnConsumedCapacity</code> parameter was specified. For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughputIntro.html\\\">Provisioned Throughput</a> in the <i>Amazon DynamoDB Developer Guide</i>.</p>\"\
        },\
        \"ItemCollectionMetrics\":{\
          \"shape\":\"ItemCollectionMetrics\",\
          \"documentation\":\"<p>Information about item collections, if any, that were affected by the <code>UpdateItem</code> operation. <code>ItemCollectionMetrics</code> is only returned if the <code>ReturnItemCollectionMetrics</code> parameter was specified. If the table does not have any local secondary indexes, this information is not returned in the response.</p> <p>Each <code>ItemCollectionMetrics</code> element consists of:</p> <ul> <li> <p> <code>ItemCollectionKey</code> - The partition key value of the item collection. This is the same as the partition key value of the item itself.</p> </li> <li> <p> <code>SizeEstimateRangeGB</code> - An estimate of item collection size, in gigabytes. This value is a two-element array containing a lower bound and an upper bound for the estimate. The estimate includes the size of all the items in the table, plus the size of all attributes projected into all of the local secondary indexes on that table. Use this estimate to measure whether a local secondary index is approaching its size limit.</p> <p>The estimate is subject to change over time; therefore, do not rely on the precision or accuracy of the estimate.</p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of an <code>UpdateItem</code> operation.</p>\"\
    },\
    \"UpdateTableInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TableName\"],\
      \"members\":{\
        \"AttributeDefinitions\":{\
          \"shape\":\"AttributeDefinitions\",\
          \"documentation\":\"<p>An array of attributes that describe the key schema for the table and indexes. If you are adding a new global secondary index to the table, <code>AttributeDefinitions</code> must include the key element(s) of the new index.</p>\"\
        },\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table to be updated.</p>\"\
        },\
        \"BillingMode\":{\
          \"shape\":\"BillingMode\",\
          \"documentation\":\"<p>Controls how you are charged for read and write throughput and how you manage capacity. When switching from pay-per-request to provisioned capacity, initial provisioned capacity values must be set. The initial provisioned capacity values are estimated based on the consumed read and write capacity of your table and global secondary indexes over the past 30 minutes.</p> <ul> <li> <p> <code>PROVISIONED</code> - Sets the billing mode to <code>PROVISIONED</code>. We recommend using <code>PROVISIONED</code> for predictable workloads.</p> </li> <li> <p> <code>PAY_PER_REQUEST</code> - Sets the billing mode to <code>PAY_PER_REQUEST</code>. We recommend using <code>PAY_PER_REQUEST</code> for unpredictable workloads. </p> </li> </ul>\"\
        },\
        \"ProvisionedThroughput\":{\
          \"shape\":\"ProvisionedThroughput\",\
          \"documentation\":\"<p>The new provisioned throughput settings for the specified table or index.</p>\"\
        },\
        \"GlobalSecondaryIndexUpdates\":{\
          \"shape\":\"GlobalSecondaryIndexUpdateList\",\
          \"documentation\":\"<p>An array of one or more global secondary indexes for the table. For each index in the array, you can request one action:</p> <ul> <li> <p> <code>Create</code> - add a new global secondary index to the table.</p> </li> <li> <p> <code>Update</code> - modify the provisioned throughput settings of an existing global secondary index.</p> </li> <li> <p> <code>Delete</code> - remove a global secondary index from the table.</p> </li> </ul> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GSI.OnlineOps.html\\\">Managing Global Secondary Indexes</a> in the <i>Amazon DynamoDB Developer Guide</i>. </p>\"\
        },\
        \"StreamSpecification\":{\
          \"shape\":\"StreamSpecification\",\
          \"documentation\":\"<p>Represents the DynamoDB Streams configuration for the table.</p> <note> <p>You will receive a <code>ResourceInUseException</code> if you attempt to enable a stream on a table that already has a stream, or if you attempt to disable a stream on a table which does not have a stream.</p> </note>\"\
        },\
        \"SSESpecification\":{\
          \"shape\":\"SSESpecification\",\
          \"documentation\":\"<p>The new server-side encryption settings for the specified table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of an <code>UpdateTable</code> operation.</p>\"\
    },\
    \"UpdateTableOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TableDescription\":{\
          \"shape\":\"TableDescription\",\
          \"documentation\":\"<p>Represents the properties of the table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the output of an <code>UpdateTable</code> operation.</p>\"\
    },\
    \"UpdateTimeToLiveInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TableName\",\
        \"TimeToLiveSpecification\"\
      ],\
      \"members\":{\
        \"TableName\":{\
          \"shape\":\"TableName\",\
          \"documentation\":\"<p>The name of the table to be configured.</p>\"\
        },\
        \"TimeToLiveSpecification\":{\
          \"shape\":\"TimeToLiveSpecification\",\
          \"documentation\":\"<p>Represents the settings used to enable or disable Time to Live for the specified table.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the input of an <code>UpdateTimeToLive</code> operation.</p>\"\
    },\
    \"UpdateTimeToLiveOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TimeToLiveSpecification\":{\
          \"shape\":\"TimeToLiveSpecification\",\
          \"documentation\":\"<p>Represents the output of an <code>UpdateTimeToLive</code> operation.</p>\"\
        }\
      }\
    },\
    \"WriteRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PutRequest\":{\
          \"shape\":\"PutRequest\",\
          \"documentation\":\"<p>A request to perform a <code>PutItem</code> operation.</p>\"\
        },\
        \"DeleteRequest\":{\
          \"shape\":\"DeleteRequest\",\
          \"documentation\":\"<p>A request to perform a <code>DeleteItem</code> operation.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents an operation to perform - either <code>DeleteItem</code> or <code>PutItem</code>. You can only request one of these operations, not both, in a single <code>WriteRequest</code>. If you do need to perform both of these operations, you will need to provide two separate <code>WriteRequest</code> objects.</p>\"\
    },\
    \"WriteRequests\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"WriteRequest\"},\
      \"max\":25,\
      \"min\":1\
    }\
  },\
  \"documentation\":\"<fullname>Amazon DynamoDB</fullname> <p>Amazon DynamoDB is a fully managed NoSQL database service that provides fast and predictable performance with seamless scalability. DynamoDB lets you offload the administrative burdens of operating and scaling a distributed database, so that you don't have to worry about hardware provisioning, setup and configuration, replication, software patching, or cluster scaling.</p> <p>With DynamoDB, you can create database tables that can store and retrieve any amount of data, and serve any level of request traffic. You can scale up or scale down your tables' throughput capacity without downtime or performance degradation, and use the AWS Management Console to monitor resource utilization and performance metrics.</p> <p>DynamoDB automatically spreads the data and traffic for your tables over a sufficient number of servers to handle your throughput and storage requirements, while maintaining consistent and fast performance. All of your data is stored on solid state disks (SSDs) and automatically replicated across multiple Availability Zones in an AWS region, providing built-in high availability and data durability. </p>\"\
}\
";
}

@end
