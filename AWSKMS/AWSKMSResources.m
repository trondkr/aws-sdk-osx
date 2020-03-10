//
// Copyright 2010-2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

#import "AWSKMSResources.h"
#import "AWSBolts.h"
#import "AWSCocoaLumberjack.h"

@interface AWSKMSResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSKMSResources

+ (instancetype)sharedInstance {
    static AWSKMSResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSKMSResources new];
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
    \"apiVersion\":\"2014-11-01\",\
    \"endpointPrefix\":\"kms\",\
    \"jsonVersion\":\"1.1\",\
    \"protocol\":\"json\",\
    \"serviceAbbreviation\":\"KMS\",\
    \"serviceFullName\":\"AWS Key Management Service\",\
    \"serviceId\":\"KMS\",\
    \"signatureVersion\":\"v4\",\
    \"targetPrefix\":\"TrentService\",\
    \"uid\":\"kms-2014-11-01\"\
  },\
  \"operations\":{\
    \"CancelKeyDeletion\":{\
      \"name\":\"CancelKeyDeletion\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CancelKeyDeletionRequest\"},\
      \"output\":{\"shape\":\"CancelKeyDeletionResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Cancels the deletion of a customer master key (CMK). When this operation succeeds, the key state of the CMK is <code>Disabled</code>. To enable the CMK, use <a>EnableKey</a>. You cannot perform this operation on a CMK in a different AWS account.</p> <p>For more information about scheduling and canceling deletion of a CMK, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/deleting-keys.html\\\">Deleting Customer Master Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"ConnectCustomKeyStore\":{\
      \"name\":\"ConnectCustomKeyStore\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ConnectCustomKeyStoreRequest\"},\
      \"output\":{\"shape\":\"ConnectCustomKeyStoreResponse\"},\
      \"errors\":[\
        {\"shape\":\"CloudHsmClusterNotActiveException\"},\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"},\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"CloudHsmClusterInvalidConfigurationException\"}\
      ],\
      \"documentation\":\"<p>Connects or reconnects a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> to its associated AWS CloudHSM cluster.</p> <p>The custom key store must be connected before you can create customer master keys (CMKs) in the key store or use the CMKs it contains. You can disconnect and reconnect a custom key store at any time.</p> <p>To connect a custom key store, its associated AWS CloudHSM cluster must have at least one active HSM. To get the number of active HSMs in a cluster, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html\\\">DescribeClusters</a> operation. To add HSMs to the cluster, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_CreateHsm.html\\\">CreateHsm</a> operation. Also, the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-store-concepts.html#concept-kmsuser\\\"> <code>kmsuser</code> crypto user</a> (CU) must not be logged into the cluster. This prevents AWS KMS from using this account to log in.</p> <p>The connection process can take an extended amount of time to complete; up to 20 minutes. This operation starts the connection process, but it does not wait for it to complete. When it succeeds, this operation quickly returns an HTTP 200 response and a JSON object with no properties. However, this response does not indicate that the custom key store is connected. To get the connection state of the custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p> <p>During the connection process, AWS KMS finds the AWS CloudHSM cluster that is associated with the custom key store, creates the connection infrastructure, connects to the cluster, logs into the AWS CloudHSM client as the <code>kmsuser</code> CU, and rotates its password.</p> <p>The <code>ConnectCustomKeyStore</code> operation might fail for various reasons. To find the reason, use the <a>DescribeCustomKeyStores</a> operation and see the <code>ConnectionErrorCode</code> in the response. For help interpreting the <code>ConnectionErrorCode</code>, see <a>CustomKeyStoresListEntry</a>.</p> <p>To fix the failure, use the <a>DisconnectCustomKeyStore</a> operation to disconnect the custom key store, correct the error, use the <a>UpdateCustomKeyStore</a> operation if necessary, and then use <code>ConnectCustomKeyStore</code> again.</p> <p>If you are having trouble connecting or disconnecting a custom key store, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html\\\">Troubleshooting a Custom Key Store</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"CreateAlias\":{\
      \"name\":\"CreateAlias\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateAliasRequest\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"AlreadyExistsException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidAliasNameException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Creates a display name for a customer managed customer master key (CMK). You can use an alias to identify a CMK in cryptographic operations, such as <a>Encrypt</a> and <a>GenerateDataKey</a>. You can change the CMK associated with the alias at any time.</p> <p>Aliases are easier to remember than key IDs. They can also help to simplify your applications. For example, if you use an alias in your code, you can change the CMK your code uses by associating a given alias with a different CMK. </p> <p>To run the same code in multiple AWS regions, use an alias in your code, such as <code>alias/ApplicationKey</code>. Then, in each AWS Region, create an <code>alias/ApplicationKey</code> alias that is associated with a CMK in that Region. When you run your code, it uses the <code>alias/ApplicationKey</code> CMK for that AWS Region without any Region-specific code.</p> <p>This operation does not return a response. To get the alias that you created, use the <a>ListAliases</a> operation.</p> <p>To use aliases successfully, be aware of the following information.</p> <ul> <li> <p>Each alias points to only one CMK at a time, although a single CMK can have multiple aliases. The alias and its associated CMK must be in the same AWS account and Region. </p> </li> <li> <p>You can associate an alias with any customer managed CMK in the same AWS account and Region. However, you do not have permission to associate an alias with an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk\\\">AWS managed CMK</a> or an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-owned-cmk\\\">AWS owned CMK</a>. </p> </li> <li> <p>To change the CMK associated with an alias, use the <a>UpdateAlias</a> operation. The current CMK and the new CMK must be the same type (both symmetric or both asymmetric) and they must have the same key usage (<code>ENCRYPT_DECRYPT</code> or <code>SIGN_VERIFY</code>). This restriction prevents cryptographic errors in code that uses aliases.</p> </li> <li> <p>The alias name must begin with <code>alias/</code> followed by a name, such as <code>alias/ExampleAlias</code>. It can contain only alphanumeric characters, forward slashes (/), underscores (_), and dashes (-). The alias name cannot begin with <code>alias/aws/</code>. The <code>alias/aws/</code> prefix is reserved for <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk\\\">AWS managed CMKs</a>. </p> </li> <li> <p>The alias name must be unique within an AWS Region. However, you can use the same alias name in multiple Regions of the same AWS account. Each instance of the alias is associated with a CMK in its Region.</p> </li> <li> <p>After you create an alias, you cannot change its alias name. However, you can use the <a>DeleteAlias</a> operation to delete the alias and then create a new alias with the desired name.</p> </li> <li> <p>You can use an alias name or alias ARN to identify a CMK in AWS KMS cryptographic operations and in the <a>DescribeKey</a> operation. However, you cannot use alias names or alias ARNs in API operations that manage CMKs, such as <a>DisableKey</a> or <a>GetKeyPolicy</a>. For information about the valid CMK identifiers for each AWS KMS API operation, see the descriptions of the <code>KeyId</code> parameter in the API operation documentation.</p> </li> </ul> <p>Because an alias is not a property of a CMK, you can delete and change the aliases of a CMK without affecting the CMK. Also, aliases do not appear in the response from the <a>DescribeKey</a> operation. To get the aliases and alias ARNs of CMKs in each AWS account and Region, use the <a>ListAliases</a> operation.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"CreateCustomKeyStore\":{\
      \"name\":\"CreateCustomKeyStore\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateCustomKeyStoreRequest\"},\
      \"output\":{\"shape\":\"CreateCustomKeyStoreResponse\"},\
      \"errors\":[\
        {\"shape\":\"CloudHsmClusterInUseException\"},\
        {\"shape\":\"CustomKeyStoreNameInUseException\"},\
        {\"shape\":\"CloudHsmClusterNotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"CloudHsmClusterNotActiveException\"},\
        {\"shape\":\"IncorrectTrustAnchorException\"},\
        {\"shape\":\"CloudHsmClusterInvalidConfigurationException\"}\
      ],\
      \"documentation\":\"<p>Creates a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> that is associated with an <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/clusters.html\\\">AWS CloudHSM cluster</a> that you own and manage.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p> <p>Before you create the custom key store, you must assemble the required elements, including an AWS CloudHSM cluster that fulfills the requirements for a custom key store. For details about the required elements, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keystore.html#before-keystore\\\">Assemble the Prerequisites</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>When the operation completes successfully, it returns the ID of the new custom key store. Before you can use your new custom key store, you need to use the <a>ConnectCustomKeyStore</a> operation to connect the new key store to its AWS CloudHSM cluster. Even if you are not going to use your custom key store immediately, you might want to connect it to verify that all settings are correct and then disconnect it until you are ready to use it.</p> <p>For help with failures, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html\\\">Troubleshooting a Custom Key Store</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"CreateGrant\":{\
      \"name\":\"CreateGrant\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateGrantRequest\"},\
      \"output\":{\"shape\":\"CreateGrantResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Adds a grant to a customer master key (CMK). The grant allows the grantee principal to use the CMK when the conditions specified in the grant are met. When setting permissions, grants are an alternative to key policies. </p> <p>To create a grant that allows a cryptographic operation only when the request includes a particular <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">encryption context</a>, use the <code>Constraints</code> parameter. For details, see <a>GrantConstraints</a>.</p> <p>You can create grants on symmetric and asymmetric CMKs. However, if the grant allows an operation that the CMK does not support, <code>CreateGrant</code> fails with a <code>ValidationException</code>. </p> <ul> <li> <p>Grants for symmetric CMKs cannot allow operations that are not supported for symmetric CMKs, including <a>Sign</a>, <a>Verify</a>, and <a>GetPublicKey</a>. (There are limited exceptions to this rule for legacy operations, but you should not create a grant for an operation that AWS KMS does not support.)</p> </li> <li> <p>Grants for asymmetric CMKs cannot allow operations that are not supported for asymmetric CMKs, including operations that <a href=\\\"https://docs.aws.amazon.com/kms/latest/APIReference/API_GenerateDataKey\\\">generate data keys</a> or <a href=\\\"https://docs.aws.amazon.com/kms/latest/APIReference/API_GenerateDataKeyPair\\\">data key pairs</a>, or operations related to <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html\\\">automatic key rotation</a>, <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">imported key material</a>, or CMKs in <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key stores</a>.</p> </li> <li> <p>Grants for asymmetric CMKs with a <code>KeyUsage</code> of <code>ENCRYPT_DECRYPT</code> cannot allow the <a>Sign</a> or <a>Verify</a> operations. Grants for asymmetric CMKs with a <code>KeyUsage</code> of <code>SIGN_VERIFY</code> cannot allow the <a>Encrypt</a> or <a>Decrypt</a> operations.</p> </li> <li> <p>Grants for asymmetric CMKs cannot include an encryption context grant constraint. An encryption context is not supported on asymmetric CMKs.</p> </li> </ul> <p>For information about symmetric and asymmetric CMKs, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\\\">Using Symmetric and Asymmetric CMKs</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN in the value of the <code>KeyId</code> parameter. For more information about grants, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/grants.html\\\">Grants</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"CreateKey\":{\
      \"name\":\"CreateKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateKeyRequest\"},\
      \"output\":{\"shape\":\"CreateKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"TagException\"},\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"},\
        {\"shape\":\"CloudHsmClusterInvalidConfigurationException\"}\
      ],\
      \"documentation\":\"<p>Creates a unique customer managed <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master-keys\\\">customer master key</a> (CMK) in your AWS account and Region. You cannot use this operation to create a CMK in a different AWS account.</p> <p>You can use the <code>CreateKey</code> operation to create symmetric or asymmetric CMKs.</p> <ul> <li> <p> <b>Symmetric CMKs</b> contain a 256-bit symmetric key that never leaves AWS KMS unencrypted. To use the CMK, you must call AWS KMS. You can use a symmetric CMK to encrypt and decrypt small amounts of data, but they are typically used to generate <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#data-keys\\\">data keys</a> and <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#data-key-pairs\\\">data keys pairs</a>. For details, see <a>GenerateDataKey</a> and <a>GenerateDataKeyPair</a>.</p> </li> <li> <p> <b>Asymmetric CMKs</b> can contain an RSA key pair or an Elliptic Curve (ECC) key pair. The private key in an asymmetric CMK never leaves AWS KMS unencrypted. However, you can use the <a>GetPublicKey</a> operation to download the public key so it can be used outside of AWS KMS. CMKs with RSA key pairs can be used to encrypt or decrypt data or sign and verify messages (but not both). CMKs with ECC key pairs can be used only to sign and verify messages.</p> </li> </ul> <p>For information about symmetric and asymmetric CMKs, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\\\">Using Symmetric and Asymmetric CMKs</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>To create different types of CMKs, use the following guidance:</p> <dl> <dt>Asymmetric CMKs</dt> <dd> <p>To create an asymmetric CMK, use the <code>CustomerMasterKeySpec</code> parameter to specify the type of key material in the CMK. Then, use the <code>KeyUsage</code> parameter to determine whether the CMK will be used to encrypt and decrypt or sign and verify. You can't change these properties after the CMK is created.</p> <p> </p> </dd> <dt>Symmetric CMKs</dt> <dd> <p>When creating a symmetric CMK, you don't need to specify the <code>CustomerMasterKeySpec</code> or <code>KeyUsage</code> parameters. The default value for <code>CustomerMasterKeySpec</code>, <code>SYMMETRIC_DEFAULT</code>, and the default value for <code>KeyUsage</code>, <code>ENCRYPT_DECRYPT</code>, are the only valid values for symmetric CMKs. </p> <p> </p> </dd> <dt>Imported Key Material</dt> <dd> <p>To import your own key material, begin by creating a symmetric CMK with no key material. To do this, use the <code>Origin</code> parameter of <code>CreateKey</code> with a value of <code>EXTERNAL</code>. Next, use <a>GetParametersForImport</a> operation to get a public key and import token, and use the public key to encrypt your key material. Then, use <a>ImportKeyMaterial</a> with your import token to import the key material. For step-by-step instructions, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">Importing Key Material</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>. You cannot import the key material into an asymmetric CMK.</p> <p> </p> </dd> <dt>Custom Key Stores</dt> <dd> <p>To create a symmetric CMK in a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>, use the <code>CustomKeyStoreId</code> parameter to specify the custom key store. You must also use the <code>Origin</code> parameter with a value of <code>AWS_CLOUDHSM</code>. The AWS CloudHSM cluster that is associated with the custom key store must have at least two active HSMs in different Availability Zones in the AWS Region. </p> <p>You cannot create an asymmetric CMK in a custom key store. For information about custom key stores in AWS KMS see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Using Custom Key Stores</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> </dd> </dl>\"\
    },\
    \"Decrypt\":{\
      \"name\":\"Decrypt\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DecryptRequest\"},\
      \"output\":{\"shape\":\"DecryptResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"InvalidCiphertextException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"IncorrectKeyException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Decrypts ciphertext that was encrypted by a AWS KMS customer master key (CMK) using any of the following operations:</p> <ul> <li> <p> <a>Encrypt</a> </p> </li> <li> <p> <a>GenerateDataKey</a> </p> </li> <li> <p> <a>GenerateDataKeyPair</a> </p> </li> <li> <p> <a>GenerateDataKeyWithoutPlaintext</a> </p> </li> <li> <p> <a>GenerateDataKeyPairWithoutPlaintext</a> </p> </li> </ul> <p>You can use this operation to decrypt ciphertext that was encrypted under a symmetric or asymmetric CMK. When the CMK is asymmetric, you must specify the CMK and the encryption algorithm that was used to encrypt the ciphertext. For information about symmetric and asymmetric CMKs, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\\\">Using Symmetric and Asymmetric CMKs</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The Decrypt operation also decrypts ciphertext that was encrypted outside of AWS KMS by the public key in an AWS KMS asymmetric CMK. However, it cannot decrypt ciphertext produced by other libraries, such as the <a href=\\\"https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/\\\">AWS Encryption SDK</a> or <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingClientSideEncryption.html\\\">Amazon S3 client-side encryption</a>. These libraries return a ciphertext format that is incompatible with AWS KMS.</p> <p>If the ciphertext was encrypted under a symmetric CMK, you do not need to specify the CMK or the encryption algorithm. AWS KMS can get this information from metadata that it adds to the symmetric ciphertext blob. However, if you prefer, you can specify the <code>KeyId</code> to ensure that a particular CMK is used to decrypt the ciphertext. If you specify a different CMK than the one used to encrypt the ciphertext, the <code>Decrypt</code> operation fails.</p> <p>Whenever possible, use key policies to give users permission to call the Decrypt operation on a particular CMK, instead of using IAM policies. Otherwise, you might create an IAM user policy that gives the user Decrypt permission on all CMKs. This user could decrypt ciphertext that was encrypted by CMKs in other accounts if the key policy for the cross-account CMK permits it. If you must use an IAM policy for <code>Decrypt</code> permissions, limit the user to particular CMKs or particular trusted accounts.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"DeleteAlias\":{\
      \"name\":\"DeleteAlias\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteAliasRequest\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Deletes the specified alias. You cannot perform this operation on an alias in a different AWS account. </p> <p>Because an alias is not a property of a CMK, you can delete and change the aliases of a CMK without affecting the CMK. Also, aliases do not appear in the response from the <a>DescribeKey</a> operation. To get the aliases of all CMKs, use the <a>ListAliases</a> operation. </p> <p>Each CMK can have multiple aliases. To change the alias of a CMK, use <a>DeleteAlias</a> to delete the current alias and <a>CreateAlias</a> to create a new alias. To associate an existing alias with a different customer master key (CMK), call <a>UpdateAlias</a>.</p>\"\
    },\
    \"DeleteCustomKeyStore\":{\
      \"name\":\"DeleteCustomKeyStore\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteCustomKeyStoreRequest\"},\
      \"output\":{\"shape\":\"DeleteCustomKeyStoreResponse\"},\
      \"errors\":[\
        {\"shape\":\"CustomKeyStoreHasCMKsException\"},\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"},\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"KMSInternalException\"}\
      ],\
      \"documentation\":\"<p>Deletes a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>. This operation does not delete the AWS CloudHSM cluster that is associated with the custom key store, or affect any users or keys in the cluster.</p> <p>The custom key store that you delete cannot contain any AWS KMS <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys\\\">customer master keys (CMKs)</a>. Before deleting the key store, verify that you will never need to use any of the CMKs in the key store for any cryptographic operations. Then, use <a>ScheduleKeyDeletion</a> to delete the AWS KMS customer master keys (CMKs) from the key store. When the scheduled waiting period expires, the <code>ScheduleKeyDeletion</code> operation deletes the CMKs. Then it makes a best effort to delete the key material from the associated cluster. However, you might need to manually <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html#fix-keystore-orphaned-key\\\">delete the orphaned key material</a> from the cluster and its backups.</p> <p>After all CMKs are deleted from AWS KMS, use <a>DisconnectCustomKeyStore</a> to disconnect the key store from AWS KMS. Then, you can delete the custom key store.</p> <p>Instead of deleting the custom key store, consider using <a>DisconnectCustomKeyStore</a> to disconnect it from AWS KMS. While the key store is disconnected, you cannot create or use the CMKs in the key store. But, you do not need to delete CMKs and you can reconnect a disconnected custom key store at any time.</p> <p>If the operation succeeds, it returns a JSON object with no properties.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p>\"\
    },\
    \"DeleteImportedKeyMaterial\":{\
      \"name\":\"DeleteImportedKeyMaterial\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteImportedKeyMaterialRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Deletes key material that you previously imported. This operation makes the specified customer master key (CMK) unusable. For more information about importing key material into AWS KMS, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">Importing Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>. You cannot perform this operation on a CMK in a different AWS account.</p> <p>When the specified CMK is in the <code>PendingDeletion</code> state, this operation does not change the CMK's state. Otherwise, it changes the CMK's state to <code>PendingImport</code>.</p> <p>After you delete key material, you can use <a>ImportKeyMaterial</a> to reimport the same key material into the CMK.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"DescribeCustomKeyStores\":{\
      \"name\":\"DescribeCustomKeyStores\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeCustomKeyStoresRequest\"},\
      \"output\":{\"shape\":\"DescribeCustomKeyStoresResponse\"},\
      \"errors\":[\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"KMSInternalException\"}\
      ],\
      \"documentation\":\"<p>Gets information about <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key stores</a> in the account and region.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p> <p>By default, this operation returns information about all custom key stores in the account and region. To get only information about a particular custom key store, use either the <code>CustomKeyStoreName</code> or <code>CustomKeyStoreId</code> parameter (but not both).</p> <p>To determine whether the custom key store is connected to its AWS CloudHSM cluster, use the <code>ConnectionState</code> element in the response. If an attempt to connect the custom key store failed, the <code>ConnectionState</code> value is <code>FAILED</code> and the <code>ConnectionErrorCode</code> element in the response indicates the cause of the failure. For help interpreting the <code>ConnectionErrorCode</code>, see <a>CustomKeyStoresListEntry</a>.</p> <p>Custom key stores have a <code>DISCONNECTED</code> connection state if the key store has never been connected or you use the <a>DisconnectCustomKeyStore</a> operation to disconnect it. If your custom key store state is <code>CONNECTED</code> but you are having trouble using it, make sure that its associated AWS CloudHSM cluster is active and contains the minimum number of HSMs required for the operation, if any.</p> <p> For help repairing your custom key store, see the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html\\\">Troubleshooting Custom Key Stores</a> topic in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"DescribeKey\":{\
      \"name\":\"DescribeKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeKeyRequest\"},\
      \"output\":{\"shape\":\"DescribeKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"}\
      ],\
      \"documentation\":\"<p>Provides detailed information about a customer master key (CMK). You can run <code>DescribeKey</code> on a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk\\\">customer managed CMK</a> or an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk\\\">AWS managed CMK</a>.</p> <p>This detailed information includes the key ARN, creation date (and deletion date, if applicable), the key state, and the origin and expiration date (if any) of the key material. For CMKs in custom key stores, it includes information about the custom key store, such as the key store ID and the AWS CloudHSM cluster ID. It includes fields, like <code>KeySpec</code>, that help you distinguish symmetric from asymmetric CMKs. It also provides information that is particularly important to asymmetric CMKs, such as the key usage (encryption or signing) and the encryption algorithms or signing algorithms that the CMK supports.</p> <p> <code>DescribeKey</code> does not return the following information:</p> <ul> <li> <p>Aliases associated with the CMK. To get this information, use <a>ListAliases</a>.</p> </li> <li> <p>Whether automatic key rotation is enabled on the CMK. To get this information, use <a>GetKeyRotationStatus</a>. Also, some key states prevent a CMK from being automatically rotated. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html#rotate-keys-how-it-works\\\">How Automatic Key Rotation Works</a> in <i>AWS Key Management Service Developer Guide</i>.</p> </li> <li> <p>Tags on the CMK. To get this information, use <a>ListResourceTags</a>.</p> </li> <li> <p>Key policies and grants on the CMK. To get this information, use <a>GetKeyPolicy</a> and <a>ListGrants</a>.</p> </li> </ul> <p>If you call the <code>DescribeKey</code> operation on a <i>predefined AWS alias</i>, that is, an AWS alias with no key ID, AWS KMS creates an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys\\\">AWS managed CMK</a>. Then, it associates the alias with the new CMK, and returns the <code>KeyId</code> and <code>Arn</code> of the new CMK in the response.</p> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN or alias ARN in the value of the KeyId parameter.</p>\"\
    },\
    \"DisableKey\":{\
      \"name\":\"DisableKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DisableKeyRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Sets the state of a customer master key (CMK) to disabled, thereby preventing its use for cryptographic operations. You cannot perform this operation on a CMK in a different AWS account.</p> <p>For more information about how key state affects the use of a CMK, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects the Use of a Customer Master Key</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"DisableKeyRotation\":{\
      \"name\":\"DisableKeyRotation\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DisableKeyRotationRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"UnsupportedOperationException\"}\
      ],\
      \"documentation\":\"<p>Disables <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html\\\">automatic rotation of the key material</a> for the specified symmetric customer master key (CMK).</p> <p> You cannot enable automatic rotation of asymmetric CMKs, CMKs with imported key material, or CMKs in a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>. You cannot perform this operation on a CMK in a different AWS account.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"DisconnectCustomKeyStore\":{\
      \"name\":\"DisconnectCustomKeyStore\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DisconnectCustomKeyStoreRequest\"},\
      \"output\":{\"shape\":\"DisconnectCustomKeyStoreResponse\"},\
      \"errors\":[\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"},\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"KMSInternalException\"}\
      ],\
      \"documentation\":\"<p>Disconnects the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> from its associated AWS CloudHSM cluster. While a custom key store is disconnected, you can manage the custom key store and its customer master keys (CMKs), but you cannot create or use CMKs in the custom key store. You can reconnect the custom key store at any time.</p> <note> <p>While a custom key store is disconnected, all attempts to create customer master keys (CMKs) in the custom key store or to use existing CMKs in cryptographic operations will fail. This action can prevent users from storing and accessing sensitive data.</p> </note> <p/> <p>To find the connection state of a custom key store, use the <a>DescribeCustomKeyStores</a> operation. To reconnect a custom key store, use the <a>ConnectCustomKeyStore</a> operation.</p> <p>If the operation succeeds, it returns a JSON object with no properties.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p>\"\
    },\
    \"EnableKey\":{\
      \"name\":\"EnableKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"EnableKeyRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Sets the key state of a customer master key (CMK) to enabled. This allows you to use the CMK for cryptographic operations. You cannot perform this operation on a CMK in a different AWS account.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"EnableKeyRotation\":{\
      \"name\":\"EnableKeyRotation\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"EnableKeyRotationRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"UnsupportedOperationException\"}\
      ],\
      \"documentation\":\"<p>Enables <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html\\\">automatic rotation of the key material</a> for the specified symmetric customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p> <p>You cannot enable automatic rotation of asymmetric CMKs, CMKs with imported key material, or CMKs in a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"Encrypt\":{\
      \"name\":\"Encrypt\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"EncryptRequest\"},\
      \"output\":{\"shape\":\"EncryptResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Encrypts plaintext into ciphertext by using a customer master key (CMK). The <code>Encrypt</code> operation has two primary use cases:</p> <ul> <li> <p>You can encrypt small amounts of arbitrary data, such as a personal identifier or database password, or other sensitive information. </p> </li> <li> <p>You can use the <code>Encrypt</code> operation to move encrypted data from one AWS region to another. In the first region, generate a data key and use the plaintext key to encrypt the data. Then, in the new region, call the <code>Encrypt</code> method on same plaintext data key. Now, you can safely move the encrypted data and encrypted data key to the new region, and decrypt in the new region when necessary.</p> </li> </ul> <p>You don't need to use the <code>Encrypt</code> operation to encrypt a data key. The <a>GenerateDataKey</a> and <a>GenerateDataKeyPair</a> operations return a plaintext data key and an encrypted copy of that data key.</p> <p>When you encrypt data, you must specify a symmetric or asymmetric CMK to use in the encryption operation. The CMK must have a <code>KeyUsage</code> value of <code>ENCRYPT_DECRYPT.</code> To find the <code>KeyUsage</code> of a CMK, use the <a>DescribeKey</a> operation. </p> <p>If you use a symmetric CMK, you can use an encryption context to add additional security to your encryption operation. If you specify an <code>EncryptionContext</code> when encrypting data, you must specify the same encryption context (a case-sensitive exact match) when decrypting the data. Otherwise, the request to decrypt fails with an <code>InvalidCiphertextException</code>. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>If you specify an asymmetric CMK, you must also specify the encryption algorithm. The algorithm must be compatible with the CMK type.</p> <important> <p>When you use an asymmetric CMK to encrypt or reencrypt data, be sure to record the CMK and encryption algorithm that you choose. You will be required to provide the same CMK and encryption algorithm when you decrypt the data. If the CMK and algorithm do not match the values used to encrypt the data, the decrypt operation fails.</p> <p>You are not required to supply the CMK ID and encryption algorithm when you decrypt with symmetric CMKs because AWS KMS stores this information in the ciphertext blob. AWS KMS cannot store metadata in ciphertext generated with asymmetric keys. The standard format for asymmetric key ciphertext does not include configurable fields.</p> </important> <p>The maximum size of the data that you can encrypt varies with the type of CMK and the encryption algorithm that you choose.</p> <ul> <li> <p>Symmetric CMKs</p> <ul> <li> <p> <code>SYMMETRIC_DEFAULT</code>: 4096 bytes</p> </li> </ul> </li> <li> <p> <code>RSA_2048</code> </p> <ul> <li> <p> <code>RSAES_OAEP_SHA_1</code>: 214 bytes</p> </li> <li> <p> <code>RSAES_OAEP_SHA_256</code>: 190 bytes</p> </li> </ul> </li> <li> <p> <code>RSA_3072</code> </p> <ul> <li> <p> <code>RSAES_OAEP_SHA_1</code>: 342 bytes</p> </li> <li> <p> <code>RSAES_OAEP_SHA_256</code>: 318 bytes</p> </li> </ul> </li> <li> <p> <code>RSA_4096</code> </p> <ul> <li> <p> <code>RSAES_OAEP_SHA_1</code>: 470 bytes</p> </li> <li> <p> <code>RSAES_OAEP_SHA_256</code>: 446 bytes</p> </li> </ul> </li> </ul> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN or alias ARN in the value of the KeyId parameter.</p>\"\
    },\
    \"GenerateDataKey\":{\
      \"name\":\"GenerateDataKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GenerateDataKeyRequest\"},\
      \"output\":{\"shape\":\"GenerateDataKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Generates a unique symmetric data key. This operation returns a plaintext copy of the data key and a copy that is encrypted under a customer master key (CMK) that you specify. You can use the plaintext key to encrypt your data outside of AWS KMS and store the encrypted data key with the encrypted data.</p> <p> <code>GenerateDataKey</code> returns a unique data key for each request. The bytes in the key are not related to the caller or CMK that is used to encrypt the data key.</p> <p>To generate a data key, specify the symmetric CMK that will be used to encrypt the data key. You cannot use an asymmetric CMK to generate data keys. To get the type of your CMK, use the <a>DescribeKey</a> operation.</p> <p>You must also specify the length of the data key. Use either the <code>KeySpec</code> or <code>NumberOfBytes</code> parameters (but not both). For 128-bit and 256-bit data keys, use the <code>KeySpec</code> parameter. </p> <p>If the operation succeeds, the plaintext copy of the data key is in the <code>Plaintext</code> field of the response, and the encrypted copy of the data key in the <code>CiphertextBlob</code> field.</p> <p>To get only an encrypted copy of the data key, use <a>GenerateDataKeyWithoutPlaintext</a>. To generate an asymmetric data key pair, use the <a>GenerateDataKeyPair</a> or <a>GenerateDataKeyPairWithoutPlaintext</a> operation. To get a cryptographically secure random byte string, use <a>GenerateRandom</a>.</p> <p>You can use the optional encryption context to add additional security to the encryption operation. If you specify an <code>EncryptionContext</code>, you must specify the same encryption context (a case-sensitive exact match) when decrypting the encrypted data key. Otherwise, the request to decrypt fails with an InvalidCiphertextException. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>We recommend that you use the following pattern to encrypt data locally in your application:</p> <ol> <li> <p>Use the <code>GenerateDataKey</code> operation to get a data encryption key.</p> </li> <li> <p>Use the plaintext data key (returned in the <code>Plaintext</code> field of the response) to encrypt data locally, then erase the plaintext data key from memory.</p> </li> <li> <p>Store the encrypted data key (returned in the <code>CiphertextBlob</code> field of the response) alongside the locally encrypted data.</p> </li> </ol> <p>To decrypt data locally:</p> <ol> <li> <p>Use the <a>Decrypt</a> operation to decrypt the encrypted data key. The operation returns a plaintext copy of the data key.</p> </li> <li> <p>Use the plaintext data key to decrypt data locally, then erase the plaintext data key from memory.</p> </li> </ol>\"\
    },\
    \"GenerateDataKeyPair\":{\
      \"name\":\"GenerateDataKeyPair\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GenerateDataKeyPairRequest\"},\
      \"output\":{\"shape\":\"GenerateDataKeyPairResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Generates a unique asymmetric data key pair. The <code>GenerateDataKeyPair</code> operation returns a plaintext public key, a plaintext private key, and a copy of the private key that is encrypted under the symmetric CMK you specify. You can use the data key pair to perform asymmetric cryptography outside of AWS KMS.</p> <p> <code>GenerateDataKeyPair</code> returns a unique data key pair for each request. The bytes in the keys are not related to the caller or the CMK that is used to encrypt the private key.</p> <p>You can use the public key that <code>GenerateDataKeyPair</code> returns to encrypt data or verify a signature outside of AWS KMS. Then, store the encrypted private key with the data. When you are ready to decrypt data or sign a message, you can use the <a>Decrypt</a> operation to decrypt the encrypted private key.</p> <p>To generate a data key pair, you must specify a symmetric customer master key (CMK) to encrypt the private key in a data key pair. You cannot use an asymmetric CMK. To get the type of your CMK, use the <a>DescribeKey</a> operation.</p> <p>If you are using the data key pair to encrypt data, or for any operation where you don't immediately need a private key, consider using the <a>GenerateDataKeyPairWithoutPlaintext</a> operation. <code>GenerateDataKeyPairWithoutPlaintext</code> returns a plaintext public key and an encrypted private key, but omits the plaintext private key that you need only to decrypt ciphertext or sign a message. Later, when you need to decrypt the data or sign a message, use the <a>Decrypt</a> operation to decrypt the encrypted private key in the data key pair.</p> <p>You can use the optional encryption context to add additional security to the encryption operation. If you specify an <code>EncryptionContext</code>, you must specify the same encryption context (a case-sensitive exact match) when decrypting the encrypted data key. Otherwise, the request to decrypt fails with an InvalidCiphertextException. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"GenerateDataKeyPairWithoutPlaintext\":{\
      \"name\":\"GenerateDataKeyPairWithoutPlaintext\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GenerateDataKeyPairWithoutPlaintextRequest\"},\
      \"output\":{\"shape\":\"GenerateDataKeyPairWithoutPlaintextResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Generates a unique asymmetric data key pair. The <code>GenerateDataKeyPairWithoutPlaintext</code> operation returns a plaintext public key and a copy of the private key that is encrypted under the symmetric CMK you specify. Unlike <a>GenerateDataKeyPair</a>, this operation does not return a plaintext private key. </p> <p>To generate a data key pair, you must specify a symmetric customer master key (CMK) to encrypt the private key in the data key pair. You cannot use an asymmetric CMK. To get the type of your CMK, use the <code>KeySpec</code> field in the <a>DescribeKey</a> response.</p> <p>You can use the public key that <code>GenerateDataKeyPairWithoutPlaintext</code> returns to encrypt data or verify a signature outside of AWS KMS. Then, store the encrypted private key with the data. When you are ready to decrypt data or sign a message, you can use the <a>Decrypt</a> operation to decrypt the encrypted private key.</p> <p> <code>GenerateDataKeyPairWithoutPlaintext</code> returns a unique data key pair for each request. The bytes in the key are not related to the caller or CMK that is used to encrypt the private key.</p> <p>You can use the optional encryption context to add additional security to the encryption operation. If you specify an <code>EncryptionContext</code>, you must specify the same encryption context (a case-sensitive exact match) when decrypting the encrypted data key. Otherwise, the request to decrypt fails with an InvalidCiphertextException. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"GenerateDataKeyWithoutPlaintext\":{\
      \"name\":\"GenerateDataKeyWithoutPlaintext\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GenerateDataKeyWithoutPlaintextRequest\"},\
      \"output\":{\"shape\":\"GenerateDataKeyWithoutPlaintextResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Generates a unique symmetric data key. This operation returns a data key that is encrypted under a customer master key (CMK) that you specify. To request an asymmetric data key pair, use the <a>GenerateDataKeyPair</a> or <a>GenerateDataKeyPairWithoutPlaintext</a> operations.</p> <p> <code>GenerateDataKeyWithoutPlaintext</code> is identical to the <a>GenerateDataKey</a> operation except that returns only the encrypted copy of the data key. This operation is useful for systems that need to encrypt data at some point, but not immediately. When you need to encrypt the data, you call the <a>Decrypt</a> operation on the encrypted copy of the key. </p> <p>It's also useful in distributed systems with different levels of trust. For example, you might store encrypted data in containers. One component of your system creates new containers and stores an encrypted data key with each container. Then, a different component puts the data into the containers. That component first decrypts the data key, uses the plaintext data key to encrypt data, puts the encrypted data into the container, and then destroys the plaintext data key. In this system, the component that creates the containers never sees the plaintext data key.</p> <p> <code>GenerateDataKeyWithoutPlaintext</code> returns a unique data key for each request. The bytes in the keys are not related to the caller or CMK that is used to encrypt the private key.</p> <p>To generate a data key, you must specify the symmetric customer master key (CMK) that is used to encrypt the data key. You cannot use an asymmetric CMK to generate a data key. To get the type of your CMK, use the <a>DescribeKey</a> operation.</p> <p>If the operation succeeds, you will find the encrypted copy of the data key in the <code>CiphertextBlob</code> field.</p> <p>You can use the optional encryption context to add additional security to the encryption operation. If you specify an <code>EncryptionContext</code>, you must specify the same encryption context (a case-sensitive exact match) when decrypting the encrypted data key. Otherwise, the request to decrypt fails with an InvalidCiphertextException. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"GenerateRandom\":{\
      \"name\":\"GenerateRandom\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GenerateRandomRequest\"},\
      \"output\":{\"shape\":\"GenerateRandomResponse\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Returns a random byte string that is cryptographically secure.</p> <p>By default, the random byte string is generated in AWS KMS. To generate the byte string in the AWS CloudHSM cluster that is associated with a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>, specify the custom key store ID.</p> <p>For more information about entropy and random number generation, see the <a href=\\\"https://d0.awsstatic.com/whitepapers/KMS-Cryptographic-Details.pdf\\\">AWS Key Management Service Cryptographic Details</a> whitepaper.</p>\"\
    },\
    \"GetKeyPolicy\":{\
      \"name\":\"GetKeyPolicy\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetKeyPolicyRequest\"},\
      \"output\":{\"shape\":\"GetKeyPolicyResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Gets a key policy attached to the specified customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p>\"\
    },\
    \"GetKeyRotationStatus\":{\
      \"name\":\"GetKeyRotationStatus\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetKeyRotationStatusRequest\"},\
      \"output\":{\"shape\":\"GetKeyRotationStatusResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"UnsupportedOperationException\"}\
      ],\
      \"documentation\":\"<p>Gets a Boolean value that indicates whether <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html\\\">automatic rotation of the key material</a> is enabled for the specified customer master key (CMK).</p> <p>You cannot enable automatic rotation of asymmetric CMKs, CMKs with imported key material, or CMKs in a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>. The key rotation status for these CMKs is always <code>false</code>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <ul> <li> <p>Disabled: The key rotation status does not change when you disable a CMK. However, while the CMK is disabled, AWS KMS does not rotate the backing key.</p> </li> <li> <p>Pending deletion: While a CMK is pending deletion, its key rotation status is <code>false</code> and AWS KMS does not rotate the backing key. If you cancel the deletion, the original key rotation status is restored.</p> </li> </ul> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN in the value of the <code>KeyId</code> parameter.</p>\"\
    },\
    \"GetParametersForImport\":{\
      \"name\":\"GetParametersForImport\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetParametersForImportRequest\"},\
      \"output\":{\"shape\":\"GetParametersForImportResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Returns the items you need to import key material into a symmetric, customer managed customer master key (CMK). For more information about importing key material into AWS KMS, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">Importing Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>This operation returns a public key and an import token. Use the public key to encrypt the symmetric key material. Store the import token to send with a subsequent <a>ImportKeyMaterial</a> request.</p> <p>You must specify the key ID of the symmetric CMK into which you will import key material. This CMK's <code>Origin</code> must be <code>EXTERNAL</code>. You must also specify the wrapping algorithm and type of wrapping key (public key) that you will use to encrypt the key material. You cannot perform this operation on an asymmetric CMK or on any CMK in a different AWS account.</p> <p>To import key material, you must use the public key and import token from the same response. These items are valid for 24 hours. The expiration date and time appear in the <code>GetParametersForImport</code> response. You cannot use an expired token in an <a>ImportKeyMaterial</a> request. If your key and token expire, send another <code>GetParametersForImport</code> request.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"GetPublicKey\":{\
      \"name\":\"GetPublicKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetPublicKeyRequest\"},\
      \"output\":{\"shape\":\"GetPublicKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Returns the public key of an asymmetric CMK. Unlike the private key of a asymmetric CMK, which never leaves AWS KMS unencrypted, callers with <code>kms:GetPublicKey</code> permission can download the public key of an asymmetric CMK. You can share the public key to allow others to encrypt messages and verify signatures outside of AWS KMS. For information about symmetric and asymmetric CMKs, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\\\">Using Symmetric and Asymmetric CMKs</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>You do not need to download the public key. Instead, you can use the public key within AWS KMS by calling the <a>Encrypt</a>, <a>ReEncrypt</a>, or <a>Verify</a> operations with the identifier of an asymmetric CMK. When you use the public key within AWS KMS, you benefit from the authentication, authorization, and logging that are part of every AWS KMS operation. You also reduce of risk of encrypting data that cannot be decrypted. These features are not effective outside of AWS KMS. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/download-public-key.html#download-public-key-considerations\\\">Special Considerations for Downloading Public Keys</a>.</p> <p>To help you use the public key safely outside of AWS KMS, <code>GetPublicKey</code> returns important information about the public key in the response, including:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/kms/latest/APIReference/API_GetPublicKey.html#KMS-GetPublicKey-response-CustomerMasterKeySpec\\\">CustomerMasterKeySpec</a>: The type of key material in the public key, such as <code>RSA_4096</code> or <code>ECC_NIST_P521</code>.</p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/kms/latest/APIReference/API_GetPublicKey.html#KMS-GetPublicKey-response-KeyUsage\\\">KeyUsage</a>: Whether the key is used for encryption or signing.</p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/kms/latest/APIReference/API_GetPublicKey.html#KMS-GetPublicKey-response-EncryptionAlgorithms\\\">EncryptionAlgorithms</a> or <a href=\\\"https://docs.aws.amazon.com/kms/latest/APIReference/API_GetPublicKey.html#KMS-GetPublicKey-response-SigningAlgorithms\\\">SigningAlgorithms</a>: A list of the encryption algorithms or the signing algorithms for the key.</p> </li> </ul> <p>Although AWS KMS cannot enforce these restrictions on external operations, it is crucial that you use this information to prevent the public key from being used improperly. For example, you can prevent a public signing key from being used encrypt data, or prevent a public key from being used with an encryption algorithm that is not supported by AWS KMS. You can also avoid errors, such as using the wrong signing algorithm in a verification operation.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"ImportKeyMaterial\":{\
      \"name\":\"ImportKeyMaterial\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ImportKeyMaterialRequest\"},\
      \"output\":{\"shape\":\"ImportKeyMaterialResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"InvalidCiphertextException\"},\
        {\"shape\":\"IncorrectKeyMaterialException\"},\
        {\"shape\":\"ExpiredImportTokenException\"},\
        {\"shape\":\"InvalidImportTokenException\"}\
      ],\
      \"documentation\":\"<p>Imports key material into an existing symmetric AWS KMS customer master key (CMK) that was created without key material. After you successfully import key material into a CMK, you can <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html#reimport-key-material\\\">reimport the same key material</a> into that CMK, but you cannot import different key material.</p> <p>You cannot perform this operation on an asymmetric CMK or on any CMK in a different AWS account. For more information about creating CMKs with no key material and then importing key material, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">Importing Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>Before using this operation, call <a>GetParametersForImport</a>. Its response includes a public key and an import token. Use the public key to encrypt the key material. Then, submit the import token from the same <code>GetParametersForImport</code> response.</p> <p>When calling this operation, you must specify the following values:</p> <ul> <li> <p>The key ID or key ARN of a CMK with no key material. Its <code>Origin</code> must be <code>EXTERNAL</code>.</p> <p>To create a CMK with no key material, call <a>CreateKey</a> and set the value of its <code>Origin</code> parameter to <code>EXTERNAL</code>. To get the <code>Origin</code> of a CMK, call <a>DescribeKey</a>.)</p> </li> <li> <p>The encrypted key material. To get the public key to encrypt the key material, call <a>GetParametersForImport</a>.</p> </li> <li> <p>The import token that <a>GetParametersForImport</a> returned. You must use a public key and token from the same <code>GetParametersForImport</code> response.</p> </li> <li> <p>Whether the key material expires and if so, when. If you set an expiration date, AWS KMS deletes the key material from the CMK on the specified date, and the CMK becomes unusable. To use the CMK again, you must reimport the same key material. The only way to change an expiration date is by reimporting the same key material and specifying a new expiration date. </p> </li> </ul> <p>When this operation is successful, the key state of the CMK changes from <code>PendingImport</code> to <code>Enabled</code>, and you can use the CMK.</p> <p>If this operation fails, use the exception to help determine the problem. If the error is related to the key material, the import token, or wrapping key, use <a>GetParametersForImport</a> to get a new public key and import token for the CMK and repeat the import procedure. For help, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html#importing-keys-overview\\\">How To Import Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"ListAliases\":{\
      \"name\":\"ListAliases\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListAliasesRequest\"},\
      \"output\":{\"shape\":\"ListAliasesResponse\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidMarkerException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"NotFoundException\"}\
      ],\
      \"documentation\":\"<p>Gets a list of aliases in the caller's AWS account and region. You cannot list aliases in other accounts. For more information about aliases, see <a>CreateAlias</a>.</p> <p>By default, the ListAliases command returns all aliases in the account and region. To get only the aliases that point to a particular customer master key (CMK), use the <code>KeyId</code> parameter.</p> <p>The <code>ListAliases</code> response can include aliases that you created and associated with your customer managed CMKs, and aliases that AWS created and associated with AWS managed CMKs in your account. You can recognize AWS aliases because their names have the format <code>aws/&lt;service-name&gt;</code>, such as <code>aws/dynamodb</code>.</p> <p>The response might also include aliases that have no <code>TargetKeyId</code> field. These are predefined aliases that AWS has created but has not yet associated with a CMK. Aliases that AWS creates in your account, including predefined aliases, do not count against your <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/limits.html#aliases-limit\\\">AWS KMS aliases quota</a>.</p>\"\
    },\
    \"ListGrants\":{\
      \"name\":\"ListGrants\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListGrantsRequest\"},\
      \"output\":{\"shape\":\"ListGrantsResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidMarkerException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Gets a list of all grants for the specified customer master key (CMK).</p> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN in the value of the <code>KeyId</code> parameter.</p>\"\
    },\
    \"ListKeyPolicies\":{\
      \"name\":\"ListKeyPolicies\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListKeyPoliciesRequest\"},\
      \"output\":{\"shape\":\"ListKeyPoliciesResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Gets the names of the key policies that are attached to a customer master key (CMK). This operation is designed to get policy names that you can use in a <a>GetKeyPolicy</a> operation. However, the only valid policy name is <code>default</code>. You cannot perform this operation on a CMK in a different AWS account.</p>\"\
    },\
    \"ListKeys\":{\
      \"name\":\"ListKeys\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListKeysRequest\"},\
      \"output\":{\"shape\":\"ListKeysResponse\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"InvalidMarkerException\"}\
      ],\
      \"documentation\":\"<p>Gets a list of all customer master keys (CMKs) in the caller's AWS account and Region.</p>\"\
    },\
    \"ListResourceTags\":{\
      \"name\":\"ListResourceTags\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListResourceTagsRequest\"},\
      \"output\":{\"shape\":\"ListResourceTagsResponse\"},\
      \"errors\":[\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"InvalidMarkerException\"}\
      ],\
      \"documentation\":\"<p>Returns a list of all tags for the specified customer master key (CMK).</p> <p>You cannot perform this operation on a CMK in a different AWS account.</p>\"\
    },\
    \"ListRetirableGrants\":{\
      \"name\":\"ListRetirableGrants\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListRetirableGrantsRequest\"},\
      \"output\":{\"shape\":\"ListGrantsResponse\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidMarkerException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"}\
      ],\
      \"documentation\":\"<p>Returns a list of all grants for which the grant's <code>RetiringPrincipal</code> matches the one specified.</p> <p>A typical use is to list all grants that you are able to retire. To retire a grant, use <a>RetireGrant</a>.</p>\"\
    },\
    \"PutKeyPolicy\":{\
      \"name\":\"PutKeyPolicy\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutKeyPolicyRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Attaches a key policy to the specified customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p> <p>For more information about key policies, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html\\\">Key Policies</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"ReEncrypt\":{\
      \"name\":\"ReEncrypt\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ReEncryptRequest\"},\
      \"output\":{\"shape\":\"ReEncryptResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"InvalidCiphertextException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"IncorrectKeyException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Decrypts ciphertext and then reencrypts it entirely within AWS KMS. You can use this operation to change the customer master key (CMK) under which data is encrypted, such as when you <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html#rotate-keys-manually\\\">manually rotate</a> a CMK or change the CMK that protects a ciphertext. You can also use it to reencrypt ciphertext under the same CMK, such as to change the encryption context of a ciphertext. </p> <p>The <code>ReEncrypt</code> operation can decrypt ciphertext that was encrypted by using an AWS KMS CMK in an AWS KMS operation, such as <a>Encrypt</a> or <a>GenerateDataKey</a>. It can also decrypt ciphertext that was encrypted by using the public key of an asymmetric CMK outside of AWS KMS. However, it cannot decrypt ciphertext produced by other libraries, such as the <a href=\\\"https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/\\\">AWS Encryption SDK</a> or <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingClientSideEncryption.html\\\">Amazon S3 client-side encryption</a>. These libraries return a ciphertext format that is incompatible with AWS KMS.</p> <p>When you use the <code>ReEncrypt</code> operation, you need to provide information for the decrypt operation and the subsequent encrypt operation.</p> <ul> <li> <p>If your ciphertext was encrypted under an asymmetric CMK, you must identify the <i>source CMK</i>, that is, the CMK that encrypted the ciphertext. You must also supply the encryption algorithm that was used. This information is required to decrypt the data.</p> </li> <li> <p>It is optional, but you can specify a source CMK even when the ciphertext was encrypted under a symmetric CMK. This ensures that the ciphertext is decrypted only by using a particular CMK. If the CMK that you specify cannot decrypt the ciphertext, the <code>ReEncrypt</code> operation fails.</p> </li> <li> <p>To reencrypt the data, you must specify the <i>destination CMK</i>, that is, the CMK that re-encrypts the data after it is decrypted. You can select a symmetric or asymmetric CMK. If the destination CMK is an asymmetric CMK, you must also provide the encryption algorithm. The algorithm that you choose must be compatible with the CMK.</p> <important> <p>When you use an asymmetric CMK to encrypt or reencrypt data, be sure to record the CMK and encryption algorithm that you choose. You will be required to provide the same CMK and encryption algorithm when you decrypt the data. If the CMK and algorithm do not match the values used to encrypt the data, the decrypt operation fails.</p> <p>You are not required to supply the CMK ID and encryption algorithm when you decrypt with symmetric CMKs because AWS KMS stores this information in the ciphertext blob. AWS KMS cannot store metadata in ciphertext generated with asymmetric keys. The standard format for asymmetric key ciphertext does not include configurable fields.</p> </important> </li> </ul> <p>Unlike other AWS KMS API operations, <code>ReEncrypt</code> callers must have two permissions:</p> <ul> <li> <p> <code>kms:EncryptFrom</code> permission on the source CMK</p> </li> <li> <p> <code>kms:EncryptTo</code> permission on the destination CMK</p> </li> </ul> <p>To permit reencryption from</p> <p> or to a CMK, include the <code>\\\"kms:ReEncrypt*\\\"</code> permission in your <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html\\\">key policy</a>. This permission is automatically included in the key policy when you use the console to create a CMK. But you must include it manually when you create a CMK programmatically or when you use the <a>PutKeyPolicy</a> operation set a key policy.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"RetireGrant\":{\
      \"name\":\"RetireGrant\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"RetireGrantRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"InvalidGrantIdException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Retires a grant. To clean up, you can retire a grant when you're done using it. You should revoke a grant when you intend to actively deny operations that depend on it. The following are permitted to call this API:</p> <ul> <li> <p>The AWS account (root user) under which the grant was created</p> </li> <li> <p>The <code>RetiringPrincipal</code>, if present in the grant</p> </li> <li> <p>The <code>GranteePrincipal</code>, if <code>RetireGrant</code> is an operation specified in the grant</p> </li> </ul> <p>You must identify the grant to retire by its grant token or by a combination of the grant ID and the Amazon Resource Name (ARN) of the customer master key (CMK). A grant token is a unique variable-length base64-encoded string. A grant ID is a 64 character unique identifier of a grant. The <a>CreateGrant</a> operation returns both.</p>\"\
    },\
    \"RevokeGrant\":{\
      \"name\":\"RevokeGrant\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"RevokeGrantRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"InvalidGrantIdException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Revokes the specified grant for the specified customer master key (CMK). You can revoke a grant to actively deny operations that depend on it.</p> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN in the value of the <code>KeyId</code> parameter.</p>\"\
    },\
    \"ScheduleKeyDeletion\":{\
      \"name\":\"ScheduleKeyDeletion\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ScheduleKeyDeletionRequest\"},\
      \"output\":{\"shape\":\"ScheduleKeyDeletionResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Schedules the deletion of a customer master key (CMK). You may provide a waiting period, specified in days, before deletion occurs. If you do not provide a waiting period, the default period of 30 days is used. When this operation is successful, the key state of the CMK changes to <code>PendingDeletion</code>. Before the waiting period ends, you can use <a>CancelKeyDeletion</a> to cancel the deletion of the CMK. After the waiting period ends, AWS KMS deletes the CMK and all AWS KMS data associated with it, including all aliases that refer to it.</p> <important> <p>Deleting a CMK is a destructive and potentially dangerous operation. When a CMK is deleted, all data that was encrypted under the CMK is unrecoverable. To prevent the use of a CMK without deleting it, use <a>DisableKey</a>.</p> </important> <p>If you schedule deletion of a CMK from a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>, when the waiting period expires, <code>ScheduleKeyDeletion</code> deletes the CMK from AWS KMS. Then AWS KMS makes a best effort to delete the key material from the associated AWS CloudHSM cluster. However, you might need to manually <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html#fix-keystore-orphaned-key\\\">delete the orphaned key material</a> from the cluster and its backups.</p> <p>You cannot perform this operation on a CMK in a different AWS account.</p> <p>For more information about scheduling a CMK for deletion, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/deleting-keys.html\\\">Deleting Customer Master Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"Sign\":{\
      \"name\":\"Sign\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"SignRequest\"},\
      \"output\":{\"shape\":\"SignResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Creates a <a href=\\\"https://en.wikipedia.org/wiki/Digital_signature\\\">digital signature</a> for a message or message digest by using the private key in an asymmetric CMK. To verify the signature, use the <a>Verify</a> operation, or use the public key in the same asymmetric CMK outside of AWS KMS. For information about symmetric and asymmetric CMKs, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\\\">Using Symmetric and Asymmetric CMKs</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>Digital signatures are generated and verified by using asymmetric key pair, such as an RSA or ECC pair that is represented by an asymmetric customer master key (CMK). The key owner (or an authorized user) uses their private key to sign a message. Anyone with the public key can verify that the message was signed with that particular private key and that the message hasn't changed since it was signed. </p> <p>To use the <code>Sign</code> operation, provide the following information:</p> <ul> <li> <p>Use the <code>KeyId</code> parameter to identify an asymmetric CMK with a <code>KeyUsage</code> value of <code>SIGN_VERIFY</code>. To get the <code>KeyUsage</code> value of a CMK, use the <a>DescribeKey</a> operation. The caller must have <code>kms:Sign</code> permission on the CMK.</p> </li> <li> <p>Use the <code>Message</code> parameter to specify the message or message digest to sign. You can submit messages of up to 4096 bytes. To sign a larger message, generate a hash digest of the message, and then provide the hash digest in the <code>Message</code> parameter. To indicate whether the message is a full message or a digest, use the <code>MessageType</code> parameter.</p> </li> <li> <p>Choose a signing algorithm that is compatible with the CMK. </p> </li> </ul> <important> <p>When signing a message, be sure to record the CMK and the signing algorithm. This information is required to verify the signature.</p> </important> <p>To verify the signature that this operation generates, use the <a>Verify</a> operation. Or use the <a>GetPublicKey</a> operation to download the public key and then use the public key to verify the signature outside of AWS KMS. </p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"TagResource\":{\
      \"name\":\"TagResource\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"TagResourceRequest\"},\
      \"errors\":[\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"TagException\"}\
      ],\
      \"documentation\":\"<p>Adds or edits tags for a customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p> <p>Each tag consists of a tag key and a tag value. Tag keys and tag values are both required, but tag values can be empty (null) strings.</p> <p>You can only use a tag key once for each CMK. If you use the tag key again, AWS KMS replaces the current tag value with the specified value.</p> <p>For information about the rules that apply to tag keys and tag values, see <a href=\\\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html\\\">User-Defined Tag Restrictions</a> in the <i>AWS Billing and Cost Management User Guide</i>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"UntagResource\":{\
      \"name\":\"UntagResource\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UntagResourceRequest\"},\
      \"errors\":[\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"TagException\"}\
      ],\
      \"documentation\":\"<p>Removes the specified tags from the specified customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p> <p>To remove a tag, specify the tag key. To change the tag value of an existing tag key, use <a>TagResource</a>.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"UpdateAlias\":{\
      \"name\":\"UpdateAlias\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateAliasRequest\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Associates an existing AWS KMS alias with a different customer master key (CMK). Each alias is associated with only one CMK at a time, although a CMK can have multiple aliases. The alias and the CMK must be in the same AWS account and region. You cannot perform this operation on an alias in a different AWS account. </p> <p>The current and new CMK must be the same type (both symmetric or both asymmetric), and they must have the same key usage (<code>ENCRYPT_DECRYPT</code> or <code>SIGN_VERIFY</code>). This restriction prevents errors in code that uses aliases. If you must assign an alias to a different type of CMK, use <a>DeleteAlias</a> to delete the old alias and <a>CreateAlias</a> to create a new alias.</p> <p>You cannot use <code>UpdateAlias</code> to change an alias name. To change an alias name, use <a>DeleteAlias</a> to delete the old alias and <a>CreateAlias</a> to create a new alias.</p> <p>Because an alias is not a property of a CMK, you can create, update, and delete the aliases of a CMK without affecting the CMK. Also, aliases do not appear in the response from the <a>DescribeKey</a> operation. To get the aliases of all CMKs in the account, use the <a>ListAliases</a> operation. </p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"UpdateCustomKeyStore\":{\
      \"name\":\"UpdateCustomKeyStore\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateCustomKeyStoreRequest\"},\
      \"output\":{\"shape\":\"UpdateCustomKeyStoreResponse\"},\
      \"errors\":[\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"CustomKeyStoreNameInUseException\"},\
        {\"shape\":\"CloudHsmClusterNotFoundException\"},\
        {\"shape\":\"CloudHsmClusterNotRelatedException\"},\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"CloudHsmClusterNotActiveException\"},\
        {\"shape\":\"CloudHsmClusterInvalidConfigurationException\"}\
      ],\
      \"documentation\":\"<p>Changes the properties of a custom key store. Use the <code>CustomKeyStoreId</code> parameter to identify the custom key store you want to edit. Use the remaining parameters to change the properties of the custom key store.</p> <p>You can only update a custom key store that is disconnected. To disconnect the custom key store, use <a>DisconnectCustomKeyStore</a>. To reconnect the custom key store after the update completes, use <a>ConnectCustomKeyStore</a>. To find the connection state of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p> <p>Use the parameters of <code>UpdateCustomKeyStore</code> to edit your keystore settings.</p> <ul> <li> <p>Use the <b>NewCustomKeyStoreName</b> parameter to change the friendly name of the custom key store to the value that you specify.</p> <p> </p> </li> <li> <p>Use the <b>KeyStorePassword</b> parameter tell AWS KMS the current password of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-store-concepts.html#concept-kmsuser\\\"> <code>kmsuser</code> crypto user (CU)</a> in the associated AWS CloudHSM cluster. You can use this parameter to <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html#fix-keystore-password\\\">fix connection failures</a> that occur when AWS KMS cannot log into the associated cluster because the <code>kmsuser</code> password has changed. This value does not change the password in the AWS CloudHSM cluster.</p> <p> </p> </li> <li> <p>Use the <b>CloudHsmClusterId</b> parameter to associate the custom key store with a different, but related, AWS CloudHSM cluster. You can use this parameter to repair a custom key store if its AWS CloudHSM cluster becomes corrupted or is deleted, or when you need to create or restore a cluster from a backup. </p> </li> </ul> <p>If the operation succeeds, it returns a JSON object with no properties.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p>\"\
    },\
    \"UpdateKeyDescription\":{\
      \"name\":\"UpdateKeyDescription\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateKeyDescriptionRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Updates the description of a customer master key (CMK). To see the description of a CMK, use <a>DescribeKey</a>. </p> <p>You cannot perform this operation on a CMK in a different AWS account.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"Verify\":{\
      \"name\":\"Verify\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"VerifyRequest\"},\
      \"output\":{\"shape\":\"VerifyResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"KMSInvalidSignatureException\"}\
      ],\
      \"documentation\":\"<p>Verifies a digital signature that was generated by the <a>Sign</a> operation. </p> <p/> <p>Verification confirms that an authorized user signed the message with the specified CMK and signing algorithm, and the message hasn't changed since it was signed. If the signature is verified, the value of the <code>SignatureValid</code> field in the response is <code>True</code>. If the signature verification fails, the <code>Verify</code> operation fails with an <code>KMSInvalidSignatureException</code> exception.</p> <p>A digital signature is generated by using the private key in an asymmetric CMK. The signature is verified by using the public key in the same asymmetric CMK. For information about symmetric and asymmetric CMKs, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\\\">Using Symmetric and Asymmetric CMKs</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>To verify a digital signature, you can use the <code>Verify</code> operation. Specify the same asymmetric CMK, message, and signing algorithm that were used to produce the signature.</p> <p>You can also verify the digital signature by using the public key of the CMK outside of AWS KMS. Use the <a>GetPublicKey</a> operation to download the public key in the asymmetric CMK and then use the public key to verify the signature outside of AWS KMS. The advantage of using the <code>Verify</code> operation is that it is performed within AWS KMS. As a result, it's easy to call, the operation is performed within the FIPS boundary, it is logged in AWS CloudTrail, and you can use key policy and IAM policy to determine who is authorized to use the CMK to verify signatures.</p> <p>The CMK that you use for this operation must be in a compatible key state. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    }\
  },\
  \"shapes\":{\
    \"AWSAccountIdType\":{\"type\":\"string\"},\
    \"AlgorithmSpec\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"RSAES_PKCS1_V1_5\",\
        \"RSAES_OAEP_SHA_1\",\
        \"RSAES_OAEP_SHA_256\"\
      ]\
    },\
    \"AliasList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AliasListEntry\"}\
    },\
    \"AliasListEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AliasName\":{\
          \"shape\":\"AliasNameType\",\
          \"documentation\":\"<p>String that contains the alias. This value begins with <code>alias/</code>.</p>\"\
        },\
        \"AliasArn\":{\
          \"shape\":\"ArnType\",\
          \"documentation\":\"<p>String that contains the key ARN.</p>\"\
        },\
        \"TargetKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>String that contains the key identifier referred to by the alias.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about an alias.</p>\"\
    },\
    \"AliasNameType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":1,\
      \"pattern\":\"^[a-zA-Z0-9:/_-]+$\"\
    },\
    \"AlreadyExistsException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because it attempted to create a resource that already exists.</p>\",\
      \"exception\":true\
    },\
    \"ArnType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":20\
    },\
    \"BooleanType\":{\"type\":\"boolean\"},\
    \"CancelKeyDeletionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier for the customer master key (CMK) for which to cancel deletion.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"CancelKeyDeletionResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier of the master key for which deletion is canceled.</p>\"\
        }\
      }\
    },\
    \"CiphertextType\":{\
      \"type\":\"blob\",\
      \"max\":6144,\
      \"min\":1\
    },\
    \"CloudHsmClusterIdType\":{\
      \"type\":\"string\",\
      \"max\":24,\
      \"min\":19\
    },\
    \"CloudHsmClusterInUseException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified AWS CloudHSM cluster is already associated with a custom key store or it shares a backup history with a cluster that is associated with a custom key store. Each custom key store must be associated with a different AWS CloudHSM cluster.</p> <p>Clusters that share a backup history have the same cluster certificate. To view the cluster certificate of a cluster, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html\\\">DescribeClusters</a> operation.</p>\",\
      \"exception\":true\
    },\
    \"CloudHsmClusterInvalidConfigurationException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the associated AWS CloudHSM cluster did not meet the configuration requirements for a custom key store.</p> <ul> <li> <p>The cluster must be configured with private subnets in at least two different Availability Zones in the Region.</p> </li> <li> <p>The <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/configure-sg.html\\\">security group for the cluster</a> (cloudhsm-cluster-<i>&lt;cluster-id&gt;</i>-sg) must include inbound rules and outbound rules that allow TCP traffic on ports 2223-2225. The <b>Source</b> in the inbound rules and the <b>Destination</b> in the outbound rules must match the security group ID. These rules are set by default when you create the cluster. Do not delete or change them. To get information about a particular security group, use the <a href=\\\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSecurityGroups.html\\\">DescribeSecurityGroups</a> operation.</p> </li> <li> <p>The cluster must contain at least as many HSMs as the operation requires. To add HSMs, use the AWS CloudHSM <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_CreateHsm.html\\\">CreateHsm</a> operation.</p> <p>For the <a>CreateCustomKeyStore</a>, <a>UpdateCustomKeyStore</a>, and <a>CreateKey</a> operations, the AWS CloudHSM cluster must have at least two active HSMs, each in a different Availability Zone. For the <a>ConnectCustomKeyStore</a> operation, the AWS CloudHSM must contain at least one active HSM.</p> </li> </ul> <p>For information about the requirements for an AWS CloudHSM cluster that is associated with a custom key store, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keystore.html#before-keystore\\\">Assemble the Prerequisites</a> in the <i>AWS Key Management Service Developer Guide</i>. For information about creating a private subnet for an AWS CloudHSM cluster, see <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/create-subnets.html\\\">Create a Private Subnet</a> in the <i>AWS CloudHSM User Guide</i>. For information about cluster security groups, see <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/configure-sg.html\\\">Configure a Default Security Group</a> in the <i> <i>AWS CloudHSM User Guide</i> </i>. </p>\",\
      \"exception\":true\
    },\
    \"CloudHsmClusterNotActiveException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the AWS CloudHSM cluster that is associated with the custom key store is not active. Initialize and activate the cluster and try the command again. For detailed instructions, see <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/getting-started.html\\\">Getting Started</a> in the <i>AWS CloudHSM User Guide</i>.</p>\",\
      \"exception\":true\
    },\
    \"CloudHsmClusterNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because AWS KMS cannot find the AWS CloudHSM cluster with the specified cluster ID. Retry the request with a different cluster ID.</p>\",\
      \"exception\":true\
    },\
    \"CloudHsmClusterNotRelatedException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified AWS CloudHSM cluster has a different cluster certificate than the original cluster. You cannot use the operation to specify an unrelated cluster.</p> <p>Specify a cluster that shares a backup history with the original cluster. This includes clusters that were created from a backup of the current cluster, and clusters that were created from the same backup that produced the current cluster.</p> <p>Clusters that share a backup history have the same cluster certificate. To view the cluster certificate of a cluster, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html\\\">DescribeClusters</a> operation.</p>\",\
      \"exception\":true\
    },\
    \"ConnectCustomKeyStoreRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CustomKeyStoreId\"],\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Enter the key store ID of the custom key store that you want to connect. To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p>\"\
        }\
      }\
    },\
    \"ConnectCustomKeyStoreResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"ConnectionErrorCodeType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"INVALID_CREDENTIALS\",\
        \"CLUSTER_NOT_FOUND\",\
        \"NETWORK_ERRORS\",\
        \"INTERNAL_ERROR\",\
        \"INSUFFICIENT_CLOUDHSM_HSMS\",\
        \"USER_LOCKED_OUT\",\
        \"USER_NOT_FOUND\",\
        \"USER_LOGGED_IN\",\
        \"SUBNET_NOT_FOUND\"\
      ]\
    },\
    \"ConnectionStateType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CONNECTED\",\
        \"CONNECTING\",\
        \"FAILED\",\
        \"DISCONNECTED\",\
        \"DISCONNECTING\"\
      ]\
    },\
    \"CreateAliasRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AliasName\",\
        \"TargetKeyId\"\
      ],\
      \"members\":{\
        \"AliasName\":{\
          \"shape\":\"AliasNameType\",\
          \"documentation\":\"<p>Specifies the alias name. This value must begin with <code>alias/</code> followed by a name, such as <code>alias/ExampleAlias</code>. The alias name cannot begin with <code>alias/aws/</code>. The <code>alias/aws/</code> prefix is reserved for AWS managed CMKs.</p>\"\
        },\
        \"TargetKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies the CMK to which the alias refers. Specify the key ID or the Amazon Resource Name (ARN) of the CMK. You cannot specify another alias. For help finding the key ID and ARN, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/viewing-keys.html#find-cmk-id-arn\\\">Finding the Key ID and ARN</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"CreateCustomKeyStoreRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CustomKeyStoreName\",\
        \"CloudHsmClusterId\",\
        \"TrustAnchorCertificate\",\
        \"KeyStorePassword\"\
      ],\
      \"members\":{\
        \"CustomKeyStoreName\":{\
          \"shape\":\"CustomKeyStoreNameType\",\
          \"documentation\":\"<p>Specifies a friendly name for the custom key store. The name must be unique in your AWS account.</p>\"\
        },\
        \"CloudHsmClusterId\":{\
          \"shape\":\"CloudHsmClusterIdType\",\
          \"documentation\":\"<p>Identifies the AWS CloudHSM cluster for the custom key store. Enter the cluster ID of any active AWS CloudHSM cluster that is not already associated with a custom key store. To find the cluster ID, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html\\\">DescribeClusters</a> operation.</p>\"\
        },\
        \"TrustAnchorCertificate\":{\
          \"shape\":\"TrustAnchorCertificateType\",\
          \"documentation\":\"<p>Enter the content of the trust anchor certificate for the cluster. This is the content of the <code>customerCA.crt</code> file that you created when you <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/initialize-cluster.html\\\">initialized the cluster</a>.</p>\"\
        },\
        \"KeyStorePassword\":{\
          \"shape\":\"KeyStorePasswordType\",\
          \"documentation\":\"<p>Enter the password of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-store-concepts.html#concept-kmsuser\\\"> <code>kmsuser</code> crypto user (CU) account</a> in the specified AWS CloudHSM cluster. AWS KMS logs into the cluster as this user to manage key material on your behalf.</p> <p>The password must be a string of 7 to 32 characters. Its value is case sensitive.</p> <p>This parameter tells AWS KMS the <code>kmsuser</code> account password; it does not change the password in the AWS CloudHSM cluster.</p>\"\
        }\
      }\
    },\
    \"CreateCustomKeyStoreResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>A unique identifier for the new custom key store.</p>\"\
        }\
      }\
    },\
    \"CreateGrantRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"GranteePrincipal\",\
        \"Operations\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier for the customer master key (CMK) that the grant applies to.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"GranteePrincipal\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The principal that is given permission to perform the operations that the grant permits.</p> <p>To specify the principal, use the <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Name (ARN)</a> of an AWS principal. Valid AWS principals include AWS accounts (root), IAM users, IAM roles, federated users, and assumed role users. For examples of the ARN syntax to use for specifying a principal, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam\\\">AWS Identity and Access Management (IAM)</a> in the Example ARNs section of the <i>AWS General Reference</i>.</p>\"\
        },\
        \"RetiringPrincipal\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The principal that is given permission to retire the grant by using <a>RetireGrant</a> operation.</p> <p>To specify the principal, use the <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Name (ARN)</a> of an AWS principal. Valid AWS principals include AWS accounts (root), IAM users, federated users, and assumed role users. For examples of the ARN syntax to use for specifying a principal, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam\\\">AWS Identity and Access Management (IAM)</a> in the Example ARNs section of the <i>AWS General Reference</i>.</p>\"\
        },\
        \"Operations\":{\
          \"shape\":\"GrantOperationList\",\
          \"documentation\":\"<p>A list of operations that the grant permits.</p>\"\
        },\
        \"Constraints\":{\
          \"shape\":\"GrantConstraints\",\
          \"documentation\":\"<p>Allows a cryptographic operation only when the encryption context matches or includes the encryption context specified in this structure. For more information about encryption context, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"Name\":{\
          \"shape\":\"GrantNameType\",\
          \"documentation\":\"<p>A friendly name for identifying the grant. Use this value to prevent the unintended creation of duplicate grants when retrying this request.</p> <p>When this value is absent, all <code>CreateGrant</code> requests result in a new grant with a unique <code>GrantId</code> even if all the supplied parameters are identical. This can result in unintended duplicates when you retry the <code>CreateGrant</code> request.</p> <p>When this value is present, you can retry a <code>CreateGrant</code> request with identical parameters; if the grant already exists, the original <code>GrantId</code> is returned without creating a new grant. Note that the returned grant token is unique with every <code>CreateGrant</code> request, even when a duplicate <code>GrantId</code> is returned. All grant tokens obtained in this way can be used interchangeably.</p>\"\
        }\
      }\
    },\
    \"CreateGrantResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GrantToken\":{\
          \"shape\":\"GrantTokenType\",\
          \"documentation\":\"<p>The grant token.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"GrantId\":{\
          \"shape\":\"GrantIdType\",\
          \"documentation\":\"<p>The unique identifier for the grant.</p> <p>You can use the <code>GrantId</code> in a subsequent <a>RetireGrant</a> or <a>RevokeGrant</a> operation.</p>\"\
        }\
      }\
    },\
    \"CreateKeyRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Policy\":{\
          \"shape\":\"PolicyType\",\
          \"documentation\":\"<p>The key policy to attach to the CMK.</p> <p>If you provide a key policy, it must meet the following criteria:</p> <ul> <li> <p>If you don't set <code>BypassPolicyLockoutSafetyCheck</code> to true, the key policy must allow the principal that is making the <code>CreateKey</code> request to make a subsequent <a>PutKeyPolicy</a> request on the CMK. This reduces the risk that the CMK becomes unmanageable. For more information, refer to the scenario in the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default-allow-root-enable-iam\\\">Default Key Policy</a> section of the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> </li> <li> <p>Each statement in the key policy must contain one or more principals. The principals in the key policy must exist and be visible to AWS KMS. When you create a new AWS principal (for example, an IAM user or role), you might need to enforce a delay before including the new principal in a key policy because the new principal might not be immediately visible to AWS KMS. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot_general.html#troubleshoot_general_eventual-consistency\\\">Changes that I make are not always immediately visible</a> in the <i>AWS Identity and Access Management User Guide</i>.</p> </li> </ul> <p>If you do not provide a key policy, AWS KMS attaches a default key policy to the CMK. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default\\\">Default Key Policy</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The key policy size quota is 32 kilobytes (32768 bytes).</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"DescriptionType\",\
          \"documentation\":\"<p>A description of the CMK.</p> <p>Use a description that helps you decide whether the CMK is appropriate for a task.</p>\"\
        },\
        \"KeyUsage\":{\
          \"shape\":\"KeyUsageType\",\
          \"documentation\":\"<p>Determines the cryptographic operations for which you can use the CMK. The default value is <code>ENCRYPT_DECRYPT</code>. This parameter is required only for asymmetric CMKs. You can't change the <code>KeyUsage</code> value after the CMK is created.</p> <p>Select only one valid value.</p> <ul> <li> <p>For symmetric CMKs, omit the parameter or specify <code>ENCRYPT_DECRYPT</code>.</p> </li> <li> <p>For asymmetric CMKs with RSA key material, specify <code>ENCRYPT_DECRYPT</code> or <code>SIGN_VERIFY</code>.</p> </li> <li> <p>For asymmetric CMKs with ECC key material, specify <code>SIGN_VERIFY</code>.</p> </li> </ul>\"\
        },\
        \"CustomerMasterKeySpec\":{\
          \"shape\":\"CustomerMasterKeySpec\",\
          \"documentation\":\"<p>Specifies the type of CMK to create. The default value, <code>SYMMETRIC_DEFAULT</code>, creates a CMK with a 256-bit symmetric key for encryption and decryption. For help choosing a key spec for your CMK, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symm-asymm-choose.html\\\">How to Choose Your CMK Configuration</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The <code>CustomerMasterKeySpec</code> determines whether the CMK contains a symmetric key or an asymmetric key pair. It also determines the encryption algorithms or signing algorithms that the CMK supports. You can't change the <code>CustomerMasterKeySpec</code> after the CMK is created. To further restrict the algorithms that can be used with the CMK, use a condition key in its key policy or IAM policy. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/policy-conditions.html#conditions-kms-encryption-algorithm\\\">kms:EncryptionAlgorithm</a> or <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/policy-conditions.html#conditions-kms-signing-algorithm\\\">kms:Signing Algorithm</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <important> <p> <a href=\\\"http://aws.amazon.com/kms/features/#AWS_Service_Integration\\\">AWS services that are integrated with AWS KMS</a> use symmetric CMKs to protect your data. These services do not support asymmetric CMKs. For help determining whether a CMK is symmetric or asymmetric, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/find-symm-asymm.html\\\">Identifying Symmetric and Asymmetric CMKs</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> </important> <p>AWS KMS supports the following key specs for CMKs:</p> <ul> <li> <p>Symmetric key (default)</p> <ul> <li> <p> <code>SYMMETRIC_DEFAULT</code> (AES-256-GCM)</p> </li> </ul> </li> <li> <p>Asymmetric RSA key pairs</p> <ul> <li> <p> <code>RSA_2048</code> </p> </li> <li> <p> <code>RSA_3072</code> </p> </li> <li> <p> <code>RSA_4096</code> </p> </li> </ul> </li> <li> <p>Asymmetric NIST-recommended elliptic curve key pairs</p> <ul> <li> <p> <code>ECC_NIST_P256</code> (secp256r1)</p> </li> <li> <p> <code>ECC_NIST_P384</code> (secp384r1)</p> </li> <li> <p> <code>ECC_NIST_P521</code> (secp521r1)</p> </li> </ul> </li> <li> <p>Other asymmetric elliptic curve key pairs</p> <ul> <li> <p> <code>ECC_SECG_P256K1</code> (secp256k1), commonly used for cryptocurrencies.</p> </li> </ul> </li> </ul>\"\
        },\
        \"Origin\":{\
          \"shape\":\"OriginType\",\
          \"documentation\":\"<p>The source of the key material for the CMK. You cannot change the origin after you create the CMK. The default is <code>AWS_KMS</code>, which means AWS KMS creates the key material.</p> <p>When the parameter value is <code>EXTERNAL</code>, AWS KMS creates a CMK without key material so that you can import key material from your existing key management infrastructure. For more information about importing key material into AWS KMS, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">Importing Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>. This value is valid only for symmetric CMKs.</p> <p>When the parameter value is <code>AWS_CLOUDHSM</code>, AWS KMS creates the CMK in an AWS KMS <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> and creates its key material in the associated AWS CloudHSM cluster. You must also use the <code>CustomKeyStoreId</code> parameter to identify the custom key store. This value is valid only for symmetric CMKs.</p>\"\
        },\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Creates the CMK in the specified <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> and the key material in its associated AWS CloudHSM cluster. To create a CMK in a custom key store, you must also specify the <code>Origin</code> parameter with a value of <code>AWS_CLOUDHSM</code>. The AWS CloudHSM cluster that is associated with the custom key store must have at least two active HSMs, each in a different Availability Zone in the Region.</p> <p>This parameter is valid only for symmetric CMKs. You cannot create an asymmetric CMK in a custom key store.</p> <p>To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p> <p>The response includes the custom key store ID and the ID of the AWS CloudHSM cluster.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p>\"\
        },\
        \"BypassPolicyLockoutSafetyCheck\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag to indicate whether to bypass the key policy lockout safety check.</p> <important> <p>Setting this value to true increases the risk that the CMK becomes unmanageable. Do not set this value to true indiscriminately.</p> <p>For more information, refer to the scenario in the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default-allow-root-enable-iam\\\">Default Key Policy</a> section in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> </important> <p>Use this parameter only when you include a policy in the request and you intend to prevent the principal that is making the request from making a subsequent <a>PutKeyPolicy</a> request on the CMK.</p> <p>The default value is false.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagList\",\
          \"documentation\":\"<p>One or more tags. Each tag consists of a tag key and a tag value. Both the tag key and the tag value are required, but the tag value can be an empty (null) string.</p> <p>When you add tags to an AWS resource, AWS generates a cost allocation report with usage and costs aggregated by tags. For information about adding, changing, deleting and listing tags for CMKs, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/tagging-keys.html\\\">Tagging Keys</a>.</p> <p>Use this parameter to tag the CMK when it is created. To add tags to an existing CMK, use the <a>TagResource</a> operation.</p>\"\
        }\
      }\
    },\
    \"CreateKeyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyMetadata\":{\
          \"shape\":\"KeyMetadata\",\
          \"documentation\":\"<p>Metadata associated with the CMK.</p>\"\
        }\
      }\
    },\
    \"CustomKeyStoreHasCMKsException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the custom key store contains AWS KMS customer master keys (CMKs). After verifying that you do not need to use the CMKs, use the <a>ScheduleKeyDeletion</a> operation to delete the CMKs. After they are deleted, you can delete the custom key store.</p>\",\
      \"exception\":true\
    },\
    \"CustomKeyStoreIdType\":{\
      \"type\":\"string\",\
      \"max\":64,\
      \"min\":1\
    },\
    \"CustomKeyStoreInvalidStateException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because of the <code>ConnectionState</code> of the custom key store. To get the <code>ConnectionState</code> of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p> <p>This exception is thrown under the following conditions:</p> <ul> <li> <p>You requested the <a>CreateKey</a> or <a>GenerateRandom</a> operation in a custom key store that is not connected. These operations are valid only when the custom key store <code>ConnectionState</code> is <code>CONNECTED</code>.</p> </li> <li> <p>You requested the <a>UpdateCustomKeyStore</a> or <a>DeleteCustomKeyStore</a> operation on a custom key store that is not disconnected. This operation is valid only when the custom key store <code>ConnectionState</code> is <code>DISCONNECTED</code>.</p> </li> <li> <p>You requested the <a>ConnectCustomKeyStore</a> operation on a custom key store with a <code>ConnectionState</code> of <code>DISCONNECTING</code> or <code>FAILED</code>. This operation is valid for all other <code>ConnectionState</code> values.</p> </li> </ul>\",\
      \"exception\":true\
    },\
    \"CustomKeyStoreNameInUseException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified custom key store name is already assigned to another custom key store in the account. Try again with a custom key store name that is unique in the account.</p>\",\
      \"exception\":true\
    },\
    \"CustomKeyStoreNameType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":1\
    },\
    \"CustomKeyStoreNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because AWS KMS cannot find a custom key store with the specified key store name or ID.</p>\",\
      \"exception\":true\
    },\
    \"CustomKeyStoresList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"CustomKeyStoresListEntry\"}\
    },\
    \"CustomKeyStoresListEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>A unique identifier for the custom key store.</p>\"\
        },\
        \"CustomKeyStoreName\":{\
          \"shape\":\"CustomKeyStoreNameType\",\
          \"documentation\":\"<p>The user-specified friendly name for the custom key store.</p>\"\
        },\
        \"CloudHsmClusterId\":{\
          \"shape\":\"CloudHsmClusterIdType\",\
          \"documentation\":\"<p>A unique identifier for the AWS CloudHSM cluster that is associated with the custom key store.</p>\"\
        },\
        \"TrustAnchorCertificate\":{\
          \"shape\":\"TrustAnchorCertificateType\",\
          \"documentation\":\"<p>The trust anchor certificate of the associated AWS CloudHSM cluster. When you <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/initialize-cluster.html#sign-csr\\\">initialize the cluster</a>, you create this certificate and save it in the <code>customerCA.crt</code> file.</p>\"\
        },\
        \"ConnectionState\":{\
          \"shape\":\"ConnectionStateType\",\
          \"documentation\":\"<p>Indicates whether the custom key store is connected to its AWS CloudHSM cluster.</p> <p>You can create and use CMKs in your custom key stores only when its connection state is <code>CONNECTED</code>.</p> <p>The value is <code>DISCONNECTED</code> if the key store has never been connected or you use the <a>DisconnectCustomKeyStore</a> operation to disconnect it. If the value is <code>CONNECTED</code> but you are having trouble using the custom key store, make sure that its associated AWS CloudHSM cluster is active and contains at least one active HSM.</p> <p>A value of <code>FAILED</code> indicates that an attempt to connect was unsuccessful. The <code>ConnectionErrorCode</code> field in the response indicates the cause of the failure. For help resolving a connection failure, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html\\\">Troubleshooting a Custom Key Store</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"ConnectionErrorCode\":{\
          \"shape\":\"ConnectionErrorCodeType\",\
          \"documentation\":\"<p>Describes the connection error. This field appears in the response only when the <code>ConnectionState</code> is <code>FAILED</code>. For help resolving these errors, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html#fix-keystore-failed\\\">How to Fix a Connection Failure</a> in <i>AWS Key Management Service Developer Guide</i>.</p> <p>Valid values are:</p> <ul> <li> <p> <code>CLUSTER_NOT_FOUND</code> - AWS KMS cannot find the AWS CloudHSM cluster with the specified cluster ID.</p> </li> <li> <p> <code>INSUFFICIENT_CLOUDHSM_HSMS</code> - The associated AWS CloudHSM cluster does not contain any active HSMs. To connect a custom key store to its AWS CloudHSM cluster, the cluster must contain at least one active HSM.</p> </li> <li> <p> <code>INTERNAL_ERROR</code> - AWS KMS could not complete the request due to an internal error. Retry the request. For <code>ConnectCustomKeyStore</code> requests, disconnect the custom key store before trying to connect again.</p> </li> <li> <p> <code>INVALID_CREDENTIALS</code> - AWS KMS does not have the correct password for the <code>kmsuser</code> crypto user in the AWS CloudHSM cluster. Before you can connect your custom key store to its AWS CloudHSM cluster, you must change the <code>kmsuser</code> account password and update the key store password value for the custom key store.</p> </li> <li> <p> <code>NETWORK_ERRORS</code> - Network errors are preventing AWS KMS from connecting to the custom key store.</p> </li> <li> <p> <code>SUBNET_NOT_FOUND</code> - A subnet in the AWS CloudHSM cluster configuration was deleted. If AWS KMS cannot find all of the subnets that were configured for the cluster when the custom key store was created, attempts to connect fail. To fix this error, create a cluster from a backup and associate it with your custom key store. This process includes selecting a VPC and subnets. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html#fix-keystore-failed\\\">How to Fix a Connection Failure</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> </li> <li> <p> <code>USER_LOCKED_OUT</code> - The <code>kmsuser</code> CU account is locked out of the associated AWS CloudHSM cluster due to too many failed password attempts. Before you can connect your custom key store to its AWS CloudHSM cluster, you must change the <code>kmsuser</code> account password and update the key store password value for the custom key store.</p> </li> <li> <p> <code>USER_LOGGED_IN</code> - The <code>kmsuser</code> CU account is logged into the the associated AWS CloudHSM cluster. This prevents AWS KMS from rotating the <code>kmsuser</code> account password and logging into the cluster. Before you can connect your custom key store to its AWS CloudHSM cluster, you must log the <code>kmsuser</code> CU out of the cluster. If you changed the <code>kmsuser</code> password to log into the cluster, you must also and update the key store password value for the custom key store. For help, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html#login-kmsuser-2\\\">How to Log Out and Reconnect</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> </li> <li> <p> <code>USER_NOT_FOUND</code> - AWS KMS cannot find a <code>kmsuser</code> CU account in the associated AWS CloudHSM cluster. Before you can connect your custom key store to its AWS CloudHSM cluster, you must create a <code>kmsuser</code> CU account in the cluster, and then update the key store password value for the custom key store.</p> </li> </ul>\"\
        },\
        \"CreationDate\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The date and time when the custom key store was created.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about each custom key store in the custom key store list.</p>\"\
    },\
    \"CustomerMasterKeySpec\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"RSA_2048\",\
        \"RSA_3072\",\
        \"RSA_4096\",\
        \"ECC_NIST_P256\",\
        \"ECC_NIST_P384\",\
        \"ECC_NIST_P521\",\
        \"ECC_SECG_P256K1\",\
        \"SYMMETRIC_DEFAULT\"\
      ]\
    },\
    \"DataKeyPairSpec\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"RSA_2048\",\
        \"RSA_3072\",\
        \"RSA_4096\",\
        \"ECC_NIST_P256\",\
        \"ECC_NIST_P384\",\
        \"ECC_NIST_P521\",\
        \"ECC_SECG_P256K1\"\
      ]\
    },\
    \"DataKeySpec\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AES_256\",\
        \"AES_128\"\
      ]\
    },\
    \"DateType\":{\"type\":\"timestamp\"},\
    \"DecryptRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CiphertextBlob\"],\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>Ciphertext to be decrypted. The blob includes metadata.</p>\"\
        },\
        \"EncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Specifies the encryption context to use when decrypting the data. An encryption context is valid only for cryptographic operations with a symmetric CMK. The standard asymmetric encryption algorithms that AWS KMS uses do not support an encryption context.</p> <p>An <i>encryption context</i> is a collection of non-secret key-value pairs that represents additional authenticated data. When you use an encryption context to encrypt data, you must specify the same (an exact case-sensitive match) encryption context to decrypt the data. An encryption context is optional when encrypting with a symmetric CMK, but it is highly recommended.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Specifies the customer master key (CMK) that AWS KMS will use to decrypt the ciphertext. Enter a key ID of the CMK that was used to encrypt the ciphertext.</p> <p>If you specify a <code>KeyId</code> value, the <code>Decrypt</code> operation succeeds only if the specified CMK was used to encrypt the ciphertext.</p> <p>This parameter is required only when the ciphertext was encrypted under an asymmetric CMK. Otherwise, AWS KMS uses the metadata that it adds to the ciphertext blob to determine which CMK was used to encrypt the ciphertext. However, you can use this parameter to ensure that a particular CMK (of any kind) is used to decrypt the ciphertext.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"EncryptionAlgorithm\":{\
          \"shape\":\"EncryptionAlgorithmSpec\",\
          \"documentation\":\"<p>Specifies the encryption algorithm that will be used to decrypt the ciphertext. Specify the same algorithm that was used to encrypt the data. If you specify a different algorithm, the <code>Decrypt</code> operation fails.</p> <p>This parameter is required only when the ciphertext was encrypted under an asymmetric CMK. The default value, <code>SYMMETRIC_DEFAULT</code>, represents the only supported algorithm that is valid for symmetric CMKs.</p>\"\
        }\
      }\
    },\
    \"DecryptResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The ARN of the customer master key that was used to perform the decryption.</p>\"\
        },\
        \"Plaintext\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>Decrypted plaintext data. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p>\"\
        },\
        \"EncryptionAlgorithm\":{\
          \"shape\":\"EncryptionAlgorithmSpec\",\
          \"documentation\":\"<p>The encryption algorithm that was used to decrypt the ciphertext.</p>\"\
        }\
      }\
    },\
    \"DeleteAliasRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"AliasName\"],\
      \"members\":{\
        \"AliasName\":{\
          \"shape\":\"AliasNameType\",\
          \"documentation\":\"<p>The alias to be deleted. The alias name must begin with <code>alias/</code> followed by the alias name, such as <code>alias/ExampleAlias</code>.</p>\"\
        }\
      }\
    },\
    \"DeleteCustomKeyStoreRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CustomKeyStoreId\"],\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Enter the ID of the custom key store you want to delete. To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p>\"\
        }\
      }\
    },\
    \"DeleteCustomKeyStoreResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DeleteImportedKeyMaterialRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies the CMK from which you are deleting imported key material. The <code>Origin</code> of the CMK must be <code>EXTERNAL</code>.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"DependencyTimeoutException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The system timed out while trying to fulfill the request. The request can be retried.</p>\",\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"DescribeCustomKeyStoresRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Gets only information about the specified custom key store. Enter the key store ID.</p> <p>By default, this operation gets information about all custom key stores in the account and region. To limit the output to a particular custom key store, you can use either the <code>CustomKeyStoreId</code> or <code>CustomKeyStoreName</code> parameter, but not both.</p>\"\
        },\
        \"CustomKeyStoreName\":{\
          \"shape\":\"CustomKeyStoreNameType\",\
          \"documentation\":\"<p>Gets only information about the specified custom key store. Enter the friendly name of the custom key store.</p> <p>By default, this operation gets information about all custom key stores in the account and region. To limit the output to a particular custom key store, you can use either the <code>CustomKeyStoreId</code> or <code>CustomKeyStoreName</code> parameter, but not both.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        }\
      }\
    },\
    \"DescribeCustomKeyStoresResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CustomKeyStores\":{\
          \"shape\":\"CustomKeyStoresList\",\
          \"documentation\":\"<p>Contains metadata about each custom key store.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"DescribeKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Describes the specified customer master key (CMK). </p> <p>If you specify a predefined AWS alias (an AWS alias with no key ID), KMS associates the alias with an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys\\\">AWS managed CMK</a> and returns its <code>KeyId</code> and <code>Arn</code> in the response.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"DescribeKeyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyMetadata\":{\
          \"shape\":\"KeyMetadata\",\
          \"documentation\":\"<p>Metadata associated with the key.</p>\"\
        }\
      }\
    },\
    \"DescriptionType\":{\
      \"type\":\"string\",\
      \"max\":8192,\
      \"min\":0\
    },\
    \"DisableKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"DisableKeyRotationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies a symmetric customer master key (CMK). You cannot enable automatic rotation of <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html#asymmetric-cmks\\\">asymmetric CMKs</a>, CMKs with <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">imported key material</a>, or CMKs in a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"DisabledException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified CMK is not enabled.</p>\",\
      \"exception\":true\
    },\
    \"DisconnectCustomKeyStoreRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CustomKeyStoreId\"],\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Enter the ID of the custom key store you want to disconnect. To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p>\"\
        }\
      }\
    },\
    \"DisconnectCustomKeyStoreResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"EnableKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"EnableKeyRotationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies a symmetric customer master key (CMK). You cannot enable automatic rotation of asymmetric CMKs, CMKs with imported key material, or CMKs in a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"EncryptRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"Plaintext\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"Plaintext\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>Data to be encrypted.</p>\"\
        },\
        \"EncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Specifies the encryption context that will be used to encrypt the data. An encryption context is valid only for cryptographic operations with a symmetric CMK. The standard asymmetric encryption algorithms that AWS KMS uses do not support an encryption context. </p> <p>An <i>encryption context</i> is a collection of non-secret key-value pairs that represents additional authenticated data. When you use an encryption context to encrypt data, you must specify the same (an exact case-sensitive match) encryption context to decrypt the data. An encryption context is optional when encrypting with a symmetric CMK, but it is highly recommended.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"EncryptionAlgorithm\":{\
          \"shape\":\"EncryptionAlgorithmSpec\",\
          \"documentation\":\"<p>Specifies the encryption algorithm that AWS KMS will use to encrypt the plaintext message. The algorithm must be compatible with the CMK that you specify.</p> <p>This parameter is required only for asymmetric CMKs. The default value, <code>SYMMETRIC_DEFAULT</code>, is the algorithm used for symmetric CMKs. If you are using an asymmetric CMK, we recommend RSAES_OAEP_SHA_256.</p>\"\
        }\
      }\
    },\
    \"EncryptResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The encrypted plaintext. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The ID of the key used during encryption.</p>\"\
        },\
        \"EncryptionAlgorithm\":{\
          \"shape\":\"EncryptionAlgorithmSpec\",\
          \"documentation\":\"<p>The encryption algorithm that was used to encrypt the plaintext.</p>\"\
        }\
      }\
    },\
    \"EncryptionAlgorithmSpec\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"SYMMETRIC_DEFAULT\",\
        \"RSAES_OAEP_SHA_1\",\
        \"RSAES_OAEP_SHA_256\"\
      ]\
    },\
    \"EncryptionAlgorithmSpecList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"EncryptionAlgorithmSpec\"}\
    },\
    \"EncryptionContextKey\":{\"type\":\"string\"},\
    \"EncryptionContextType\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"EncryptionContextKey\"},\
      \"value\":{\"shape\":\"EncryptionContextValue\"}\
    },\
    \"EncryptionContextValue\":{\"type\":\"string\"},\
    \"ErrorMessageType\":{\"type\":\"string\"},\
    \"ExpirationModelType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"KEY_MATERIAL_EXPIRES\",\
        \"KEY_MATERIAL_DOES_NOT_EXPIRE\"\
      ]\
    },\
    \"ExpiredImportTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified import token is expired. Use <a>GetParametersForImport</a> to get a new import token and public key, use the new public key to encrypt the key material, and then try the request again.</p>\",\
      \"exception\":true\
    },\
    \"GenerateDataKeyPairRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"KeyPairSpec\"\
      ],\
      \"members\":{\
        \"EncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Specifies the encryption context that will be used when encrypting the private key in the data key pair.</p> <p>An <i>encryption context</i> is a collection of non-secret key-value pairs that represents additional authenticated data. When you use an encryption context to encrypt data, you must specify the same (an exact case-sensitive match) encryption context to decrypt the data. An encryption context is optional when encrypting with a symmetric CMK, but it is highly recommended.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Specifies the symmetric CMK that encrypts the private key in the data key pair. You cannot specify an asymmetric CMKs.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"KeyPairSpec\":{\
          \"shape\":\"DataKeyPairSpec\",\
          \"documentation\":\"<p>Determines the type of data key pair that is generated. </p> <p>The AWS KMS rule that restricts the use of asymmetric RSA CMKs to encrypt and decrypt or to sign and verify (but not both), and the rule that permits you to use ECC CMKs only to sign and verify, are not effective outside of AWS KMS.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"GenerateDataKeyPairResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PrivateKeyCiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The encrypted copy of the private key. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p>\"\
        },\
        \"PrivateKeyPlaintext\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>The plaintext copy of the private key. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p>\"\
        },\
        \"PublicKey\":{\
          \"shape\":\"PublicKeyType\",\
          \"documentation\":\"<p>The public key (in plaintext).</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the CMK that encrypted the private key.</p>\"\
        },\
        \"KeyPairSpec\":{\
          \"shape\":\"DataKeyPairSpec\",\
          \"documentation\":\"<p>The type of data key pair that was generated.</p>\"\
        }\
      }\
    },\
    \"GenerateDataKeyPairWithoutPlaintextRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"KeyPairSpec\"\
      ],\
      \"members\":{\
        \"EncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Specifies the encryption context that will be used when encrypting the private key in the data key pair.</p> <p>An <i>encryption context</i> is a collection of non-secret key-value pairs that represents additional authenticated data. When you use an encryption context to encrypt data, you must specify the same (an exact case-sensitive match) encryption context to decrypt the data. An encryption context is optional when encrypting with a symmetric CMK, but it is highly recommended.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Specifies the CMK that encrypts the private key in the data key pair. You must specify a symmetric CMK. You cannot use an asymmetric CMK. To get the type of your CMK, use the <a>DescribeKey</a> operation. </p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"KeyPairSpec\":{\
          \"shape\":\"DataKeyPairSpec\",\
          \"documentation\":\"<p>Determines the type of data key pair that is generated.</p> <p>The AWS KMS rule that restricts the use of asymmetric RSA CMKs to encrypt and decrypt or to sign and verify (but not both), and the rule that permits you to use ECC CMKs only to sign and verify, are not effective outside of AWS KMS.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"GenerateDataKeyPairWithoutPlaintextResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PrivateKeyCiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The encrypted copy of the private key. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p>\"\
        },\
        \"PublicKey\":{\
          \"shape\":\"PublicKeyType\",\
          \"documentation\":\"<p>The public key (in plaintext).</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Specifies the CMK that encrypted the private key in the data key pair. You must specify a symmetric CMK. You cannot use an asymmetric CMK. To get the type of your CMK, use the <a>DescribeKey</a> operation.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"KeyPairSpec\":{\
          \"shape\":\"DataKeyPairSpec\",\
          \"documentation\":\"<p>The type of data key pair that was generated.</p>\"\
        }\
      }\
    },\
    \"GenerateDataKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies the symmetric CMK that encrypts the data key.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"EncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Specifies the encryption context that will be used when encrypting the data key.</p> <p>An <i>encryption context</i> is a collection of non-secret key-value pairs that represents additional authenticated data. When you use an encryption context to encrypt data, you must specify the same (an exact case-sensitive match) encryption context to decrypt the data. An encryption context is optional when encrypting with a symmetric CMK, but it is highly recommended.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"NumberOfBytes\":{\
          \"shape\":\"NumberOfBytesType\",\
          \"documentation\":\"<p>Specifies the length of the data key in bytes. For example, use the value 64 to generate a 512-bit data key (64 bytes is 512 bits). For 128-bit (16-byte) and 256-bit (32-byte) data keys, use the <code>KeySpec</code> parameter.</p> <p>You must specify either the <code>KeySpec</code> or the <code>NumberOfBytes</code> parameter (but not both) in every <code>GenerateDataKey</code> request.</p>\"\
        },\
        \"KeySpec\":{\
          \"shape\":\"DataKeySpec\",\
          \"documentation\":\"<p>Specifies the length of the data key. Use <code>AES_128</code> to generate a 128-bit symmetric key, or <code>AES_256</code> to generate a 256-bit symmetric key.</p> <p>You must specify either the <code>KeySpec</code> or the <code>NumberOfBytes</code> parameter (but not both) in every <code>GenerateDataKey</code> request.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"GenerateDataKeyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The encrypted copy of the data key. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p>\"\
        },\
        \"Plaintext\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>The plaintext data key. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded. Use this data key to encrypt your data outside of KMS. Then, remove it from memory as soon as possible.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the CMK that encrypted the data key.</p>\"\
        }\
      }\
    },\
    \"GenerateDataKeyWithoutPlaintextRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the symmetric customer master key (CMK) that encrypts the data key.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"EncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Specifies the encryption context that will be used when encrypting the data key.</p> <p>An <i>encryption context</i> is a collection of non-secret key-value pairs that represents additional authenticated data. When you use an encryption context to encrypt data, you must specify the same (an exact case-sensitive match) encryption context to decrypt the data. An encryption context is optional when encrypting with a symmetric CMK, but it is highly recommended.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"KeySpec\":{\
          \"shape\":\"DataKeySpec\",\
          \"documentation\":\"<p>The length of the data key. Use <code>AES_128</code> to generate a 128-bit symmetric key, or <code>AES_256</code> to generate a 256-bit symmetric key.</p>\"\
        },\
        \"NumberOfBytes\":{\
          \"shape\":\"NumberOfBytesType\",\
          \"documentation\":\"<p>The length of the data key in bytes. For example, use the value 64 to generate a 512-bit data key (64 bytes is 512 bits). For common key lengths (128-bit and 256-bit symmetric keys), we recommend that you use the <code>KeySpec</code> field instead of this one.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"GenerateDataKeyWithoutPlaintextResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The encrypted data key. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the CMK that encrypted the data key.</p>\"\
        }\
      }\
    },\
    \"GenerateRandomRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"NumberOfBytes\":{\
          \"shape\":\"NumberOfBytesType\",\
          \"documentation\":\"<p>The length of the byte string.</p>\"\
        },\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Generates the random byte string in the AWS CloudHSM cluster that is associated with the specified <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>. To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p>\"\
        }\
      }\
    },\
    \"GenerateRandomResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Plaintext\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>The random byte string. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p>\"\
        }\
      }\
    },\
    \"GetKeyPolicyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"PolicyName\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"PolicyName\":{\
          \"shape\":\"PolicyNameType\",\
          \"documentation\":\"<p>Specifies the name of the key policy. The only valid name is <code>default</code>. To get the names of key policies, use <a>ListKeyPolicies</a>.</p>\"\
        }\
      }\
    },\
    \"GetKeyPolicyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Policy\":{\
          \"shape\":\"PolicyType\",\
          \"documentation\":\"<p>A key policy document in JSON format.</p>\"\
        }\
      }\
    },\
    \"GetKeyRotationStatusRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"GetKeyRotationStatusResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyRotationEnabled\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A Boolean value that specifies whether key rotation is enabled.</p>\"\
        }\
      }\
    },\
    \"GetParametersForImportRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"WrappingAlgorithm\",\
        \"WrappingKeySpec\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the symmetric CMK into which you will import key material. The <code>Origin</code> of the CMK must be <code>EXTERNAL</code>.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"WrappingAlgorithm\":{\
          \"shape\":\"AlgorithmSpec\",\
          \"documentation\":\"<p>The algorithm you will use to encrypt the key material before importing it with <a>ImportKeyMaterial</a>. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys-encrypt-key-material.html\\\">Encrypt the Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"WrappingKeySpec\":{\
          \"shape\":\"WrappingKeySpec\",\
          \"documentation\":\"<p>The type of wrapping key (public key) to return in the response. Only 2048-bit RSA public keys are supported.</p>\"\
        }\
      }\
    },\
    \"GetParametersForImportResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the CMK to use in a subsequent <a>ImportKeyMaterial</a> request. This is the same CMK specified in the <code>GetParametersForImport</code> request.</p>\"\
        },\
        \"ImportToken\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The import token to send in a subsequent <a>ImportKeyMaterial</a> request.</p>\"\
        },\
        \"PublicKey\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>The public key to use to encrypt the key material before importing it with <a>ImportKeyMaterial</a>.</p>\"\
        },\
        \"ParametersValidTo\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The time at which the import token and public key are no longer valid. After this time, you cannot use them to make an <a>ImportKeyMaterial</a> request and you must send another <code>GetParametersForImport</code> request to get new ones.</p>\"\
        }\
      }\
    },\
    \"GetPublicKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies the asymmetric CMK that includes the public key.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"GetPublicKeyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the asymmetric CMK from which the public key was downloaded.</p>\"\
        },\
        \"PublicKey\":{\
          \"shape\":\"PublicKeyType\",\
          \"documentation\":\"<p>The exported public key. </p> <p>The value is a DER-encoded X.509 public key, also known as <code>SubjectPublicKeyInfo</code> (SPKI), as defined in <a href=\\\"https://tools.ietf.org/html/rfc5280\\\">RFC 5280</a>. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p> <p/>\"\
        },\
        \"CustomerMasterKeySpec\":{\
          \"shape\":\"CustomerMasterKeySpec\",\
          \"documentation\":\"<p>The type of the of the public key that was downloaded.</p>\"\
        },\
        \"KeyUsage\":{\
          \"shape\":\"KeyUsageType\",\
          \"documentation\":\"<p>The permitted use of the public key. Valid values are <code>ENCRYPT_DECRYPT</code> or <code>SIGN_VERIFY</code>. </p> <p>This information is critical. If a public key with <code>SIGN_VERIFY</code> key usage encrypts data outside of AWS KMS, the ciphertext cannot be decrypted. </p>\"\
        },\
        \"EncryptionAlgorithms\":{\
          \"shape\":\"EncryptionAlgorithmSpecList\",\
          \"documentation\":\"<p>The encryption algorithms that AWS KMS supports for this key. </p> <p>This information is critical. If a public key encrypts data outside of AWS KMS by using an unsupported encryption algorithm, the ciphertext cannot be decrypted. </p> <p>This field appears in the response only when the <code>KeyUsage</code> of the public key is <code>ENCRYPT_DECRYPT</code>.</p>\"\
        },\
        \"SigningAlgorithms\":{\
          \"shape\":\"SigningAlgorithmSpecList\",\
          \"documentation\":\"<p>The signing algorithms that AWS KMS supports for this key.</p> <p>This field appears in the response only when the <code>KeyUsage</code> of the public key is <code>SIGN_VERIFY</code>.</p>\"\
        }\
      }\
    },\
    \"GrantConstraints\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"EncryptionContextSubset\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>A list of key-value pairs that must be included in the encryption context of the cryptographic operation request. The grant allows the cryptographic operation only when the encryption context in the request includes the key-value pairs specified in this constraint, although it can include additional key-value pairs.</p>\"\
        },\
        \"EncryptionContextEquals\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>A list of key-value pairs that must match the encryption context in the cryptographic operation request. The grant allows the operation only when the encryption context in the request is the same as the encryption context specified in this constraint.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Use this structure to allow cryptographic operations in the grant only when the operation request includes the specified <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">encryption context</a>.</p> <p>AWS KMS applies the grant constraints only when the grant allows a cryptographic operation that accepts an encryption context as input, such as the following.</p> <ul> <li> <p> <a>Encrypt</a> </p> </li> <li> <p> <a>Decrypt</a> </p> </li> <li> <p> <a>GenerateDataKey</a> </p> </li> <li> <p> <a>GenerateDataKeyWithoutPlaintext</a> </p> </li> <li> <p> <a>ReEncrypt</a> </p> </li> </ul> <p>AWS KMS does not apply the grant constraints to other operations, such as <a>DescribeKey</a> or <a>ScheduleKeyDeletion</a>.</p> <important> <p>In a cryptographic operation, the encryption context in the decryption operation must be an exact, case-sensitive match for the keys and values in the encryption context of the encryption operation. Only the order of the pairs can vary.</p> <p>However, in a grant constraint, the key in each key-value pair is not case sensitive, but the value is case sensitive.</p> <p>To avoid confusion, do not use multiple encryption context pairs that differ only by case. To require a fully case-sensitive encryption context, use the <code>kms:EncryptionContext:</code> and <code>kms:EncryptionContextKeys</code> conditions in an IAM or key policy. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/policy-conditions.html#conditions-kms-encryption-context\\\">kms:EncryptionContext:</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> </important>\"\
    },\
    \"GrantIdType\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1\
    },\
    \"GrantList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GrantListEntry\"}\
    },\
    \"GrantListEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier for the customer master key (CMK) to which the grant applies.</p>\"\
        },\
        \"GrantId\":{\
          \"shape\":\"GrantIdType\",\
          \"documentation\":\"<p>The unique identifier for the grant.</p>\"\
        },\
        \"Name\":{\
          \"shape\":\"GrantNameType\",\
          \"documentation\":\"<p>The friendly name that identifies the grant. If a name was provided in the <a>CreateGrant</a> request, that name is returned. Otherwise this value is null.</p>\"\
        },\
        \"CreationDate\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The date and time when the grant was created.</p>\"\
        },\
        \"GranteePrincipal\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The principal that receives the grant's permissions.</p>\"\
        },\
        \"RetiringPrincipal\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The principal that can retire the grant.</p>\"\
        },\
        \"IssuingAccount\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The AWS account under which the grant was issued.</p>\"\
        },\
        \"Operations\":{\
          \"shape\":\"GrantOperationList\",\
          \"documentation\":\"<p>The list of operations permitted by the grant.</p>\"\
        },\
        \"Constraints\":{\
          \"shape\":\"GrantConstraints\",\
          \"documentation\":\"<p>A list of key-value pairs that must be present in the encryption context of certain subsequent operations that the grant allows.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about an entry in a list of grants.</p>\"\
    },\
    \"GrantNameType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":1,\
      \"pattern\":\"^[a-zA-Z0-9:/_-]+$\"\
    },\
    \"GrantOperation\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Decrypt\",\
        \"Encrypt\",\
        \"GenerateDataKey\",\
        \"GenerateDataKeyWithoutPlaintext\",\
        \"ReEncryptFrom\",\
        \"ReEncryptTo\",\
        \"Sign\",\
        \"Verify\",\
        \"GetPublicKey\",\
        \"CreateGrant\",\
        \"RetireGrant\",\
        \"DescribeKey\",\
        \"GenerateDataKeyPair\",\
        \"GenerateDataKeyPairWithoutPlaintext\"\
      ]\
    },\
    \"GrantOperationList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GrantOperation\"}\
    },\
    \"GrantTokenList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GrantTokenType\"},\
      \"max\":10,\
      \"min\":0\
    },\
    \"GrantTokenType\":{\
      \"type\":\"string\",\
      \"max\":8192,\
      \"min\":1\
    },\
    \"ImportKeyMaterialRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"ImportToken\",\
        \"EncryptedKeyMaterial\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the symmetric CMK that receives the imported key material. The CMK's <code>Origin</code> must be <code>EXTERNAL</code>. This must be the same CMK specified in the <code>KeyID</code> parameter of the corresponding <a>GetParametersForImport</a> request.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"ImportToken\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The import token that you received in the response to a previous <a>GetParametersForImport</a> request. It must be from the same response that contained the public key that you used to encrypt the key material.</p>\"\
        },\
        \"EncryptedKeyMaterial\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The encrypted key material to import. The key material must be encrypted with the public wrapping key that <a>GetParametersForImport</a> returned, using the wrapping algorithm that you specified in the same <code>GetParametersForImport</code> request.</p>\"\
        },\
        \"ValidTo\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. You must omit this parameter when the <code>ExpirationModel</code> parameter is set to <code>KEY_MATERIAL_DOES_NOT_EXPIRE</code>. Otherwise it is required.</p>\"\
        },\
        \"ExpirationModel\":{\
          \"shape\":\"ExpirationModelType\",\
          \"documentation\":\"<p>Specifies whether the key material expires. The default is <code>KEY_MATERIAL_EXPIRES</code>, in which case you must include the <code>ValidTo</code> parameter. When this parameter is set to <code>KEY_MATERIAL_DOES_NOT_EXPIRE</code>, you must omit the <code>ValidTo</code> parameter.</p>\"\
        }\
      }\
    },\
    \"ImportKeyMaterialResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"IncorrectKeyException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified CMK cannot decrypt the data. The <code>KeyId</code> in a <a>Decrypt</a> request and the <code>SourceKeyId</code> in a <a>ReEncrypt</a> request must identify the same CMK that was used to encrypt the ciphertext.</p>\",\
      \"exception\":true\
    },\
    \"IncorrectKeyMaterialException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the key material in the request is, expired, invalid, or is not the same key material that was previously imported into this customer master key (CMK).</p>\",\
      \"exception\":true\
    },\
    \"IncorrectTrustAnchorException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the trust anchor certificate in the request is not the trust anchor certificate for the specified AWS CloudHSM cluster.</p> <p>When you <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/initialize-cluster.html#sign-csr\\\">initialize the cluster</a>, you create the trust anchor certificate and save it in the <code>customerCA.crt</code> file.</p>\",\
      \"exception\":true\
    },\
    \"InvalidAliasNameException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified alias name is not valid.</p>\",\
      \"exception\":true\
    },\
    \"InvalidArnException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because a specified ARN, or an ARN in a key policy, is not valid.</p>\",\
      \"exception\":true\
    },\
    \"InvalidCiphertextException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>From the <a>Decrypt</a> or <a>ReEncrypt</a> operation, the request was rejected because the specified ciphertext, or additional authenticated data incorporated into the ciphertext, such as the encryption context, is corrupted, missing, or otherwise invalid.</p> <p>From the <a>ImportKeyMaterial</a> operation, the request was rejected because AWS KMS could not decrypt the encrypted (wrapped) key material. </p>\",\
      \"exception\":true\
    },\
    \"InvalidGrantIdException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified <code>GrantId</code> is not valid.</p>\",\
      \"exception\":true\
    },\
    \"InvalidGrantTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified grant token is not valid.</p>\",\
      \"exception\":true\
    },\
    \"InvalidImportTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the provided import token is invalid or is associated with a different customer master key (CMK).</p>\",\
      \"exception\":true\
    },\
    \"InvalidKeyUsageException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected for one of the following reasons: </p> <ul> <li> <p>The <code>KeyUsage</code> value of the CMK is incompatible with the API operation.</p> </li> <li> <p>The encryption algorithm or signing algorithm specified for the operation is incompatible with the type of key material in the CMK <code>(CustomerMasterKeySpec</code>).</p> </li> </ul> <p>For encrypting, decrypting, re-encrypting, and generating data keys, the <code>KeyUsage</code> must be <code>ENCRYPT_DECRYPT</code>. For signing and verifying, the <code>KeyUsage</code> must be <code>SIGN_VERIFY</code>. To find the <code>KeyUsage</code> of a CMK, use the <a>DescribeKey</a> operation.</p> <p>To find the encryption or signing algorithms supported for a particular CMK, use the <a>DescribeKey</a> operation.</p>\",\
      \"exception\":true\
    },\
    \"InvalidMarkerException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the marker that specifies where pagination should next begin is not valid.</p>\",\
      \"exception\":true\
    },\
    \"KMSInternalException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because an internal exception occurred. The request can be retried.</p>\",\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"KMSInvalidSignatureException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the signature verification failed. Signature verification fails when it cannot confirm that signature was produced by signing the specified message with the specified CMK and signing algorithm.</p>\",\
      \"exception\":true\
    },\
    \"KMSInvalidStateException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the state of the specified resource is not valid for this request.</p> <p>For more information about how key state affects the use of a CMK, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p>\",\
      \"exception\":true\
    },\
    \"KeyIdType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":1\
    },\
    \"KeyList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"KeyListEntry\"}\
    },\
    \"KeyListEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Unique identifier of the key.</p>\"\
        },\
        \"KeyArn\":{\
          \"shape\":\"ArnType\",\
          \"documentation\":\"<p>ARN of the key.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about each entry in the key list.</p>\"\
    },\
    \"KeyManagerType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AWS\",\
        \"CUSTOMER\"\
      ]\
    },\
    \"KeyMetadata\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"AWSAccountId\":{\
          \"shape\":\"AWSAccountIdType\",\
          \"documentation\":\"<p>The twelve-digit account ID of the AWS account that owns the CMK.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The globally unique identifier for the CMK.</p>\"\
        },\
        \"Arn\":{\
          \"shape\":\"ArnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the CMK. For examples, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kms\\\">AWS Key Management Service (AWS KMS)</a> in the Example ARNs section of the <i>AWS General Reference</i>.</p>\"\
        },\
        \"CreationDate\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The date and time when the CMK was created.</p>\"\
        },\
        \"Enabled\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>Specifies whether the CMK is enabled. When <code>KeyState</code> is <code>Enabled</code> this value is true, otherwise it is false.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"DescriptionType\",\
          \"documentation\":\"<p>The description of the CMK.</p>\"\
        },\
        \"KeyUsage\":{\
          \"shape\":\"KeyUsageType\",\
          \"documentation\":\"<p>The cryptographic operations for which you can use the CMK.</p>\"\
        },\
        \"KeyState\":{\
          \"shape\":\"KeyState\",\
          \"documentation\":\"<p>The state of the CMK.</p> <p>For more information about how key state affects the use of a CMK, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects the Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"DeletionDate\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The date and time after which AWS KMS deletes the CMK. This value is present only when <code>KeyState</code> is <code>PendingDeletion</code>.</p>\"\
        },\
        \"ValidTo\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. This value is present only for CMKs whose <code>Origin</code> is <code>EXTERNAL</code> and whose <code>ExpirationModel</code> is <code>KEY_MATERIAL_EXPIRES</code>, otherwise this value is omitted.</p>\"\
        },\
        \"Origin\":{\
          \"shape\":\"OriginType\",\
          \"documentation\":\"<p>The source of the CMK's key material. When this value is <code>AWS_KMS</code>, AWS KMS created the key material. When this value is <code>EXTERNAL</code>, the key material was imported from your existing key management infrastructure or the CMK lacks key material. When this value is <code>AWS_CLOUDHSM</code>, the key material was created in the AWS CloudHSM cluster associated with a custom key store.</p>\"\
        },\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>A unique identifier for the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> that contains the CMK. This value is present only when the CMK is created in a custom key store.</p>\"\
        },\
        \"CloudHsmClusterId\":{\
          \"shape\":\"CloudHsmClusterIdType\",\
          \"documentation\":\"<p>The cluster ID of the AWS CloudHSM cluster that contains the key material for the CMK. When you create a CMK in a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>, AWS KMS creates the key material for the CMK in the associated AWS CloudHSM cluster. This value is present only when the CMK is created in a custom key store.</p>\"\
        },\
        \"ExpirationModel\":{\
          \"shape\":\"ExpirationModelType\",\
          \"documentation\":\"<p>Specifies whether the CMK's key material expires. This value is present only when <code>Origin</code> is <code>EXTERNAL</code>, otherwise this value is omitted.</p>\"\
        },\
        \"KeyManager\":{\
          \"shape\":\"KeyManagerType\",\
          \"documentation\":\"<p>The manager of the CMK. CMKs in your AWS account are either customer managed or AWS managed. For more information about the difference, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys\\\">Customer Master Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"CustomerMasterKeySpec\":{\
          \"shape\":\"CustomerMasterKeySpec\",\
          \"documentation\":\"<p>Describes the type of key material in the CMK.</p>\"\
        },\
        \"EncryptionAlgorithms\":{\
          \"shape\":\"EncryptionAlgorithmSpecList\",\
          \"documentation\":\"<p>A list of encryption algorithms that the CMK supports. You cannot use the CMK with other encryption algorithms within AWS KMS.</p> <p>This field appears only when the <code>KeyUsage</code> of the CMK is <code>ENCRYPT_DECRYPT</code>.</p>\"\
        },\
        \"SigningAlgorithms\":{\
          \"shape\":\"SigningAlgorithmSpecList\",\
          \"documentation\":\"<p>A list of signing algorithms that the CMK supports. You cannot use the CMK with other signing algorithms within AWS KMS.</p> <p>This field appears only when the <code>KeyUsage</code> of the CMK is <code>SIGN_VERIFY</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains metadata about a customer master key (CMK).</p> <p>This data type is used as a response element for the <a>CreateKey</a> and <a>DescribeKey</a> operations.</p>\"\
    },\
    \"KeyState\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\",\
        \"PendingDeletion\",\
        \"PendingImport\",\
        \"Unavailable\"\
      ]\
    },\
    \"KeyStorePasswordType\":{\
      \"type\":\"string\",\
      \"max\":32,\
      \"min\":7,\
      \"sensitive\":true\
    },\
    \"KeyUnavailableException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified CMK was not available. You can retry the request.</p>\",\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"KeyUsageType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"SIGN_VERIFY\",\
        \"ENCRYPT_DECRYPT\"\
      ]\
    },\
    \"LimitExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because a quota was exceeded. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/limits.html\\\">Quotas</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\",\
      \"exception\":true\
    },\
    \"LimitType\":{\
      \"type\":\"integer\",\
      \"max\":1000,\
      \"min\":1\
    },\
    \"ListAliasesRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Lists only aliases that refer to the specified CMK. The value of this parameter can be the ID or Amazon Resource Name (ARN) of a CMK in the caller's account and region. You cannot use an alias name or alias ARN in this value.</p> <p>This parameter is optional. If you omit it, <code>ListAliases</code> returns all aliases in the account and region.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 100, inclusive. If you do not include a value, it defaults to 50.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        }\
      }\
    },\
    \"ListAliasesResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Aliases\":{\
          \"shape\":\"AliasList\",\
          \"documentation\":\"<p>A list of aliases.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"ListGrantsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 100, inclusive. If you do not include a value, it defaults to 50.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"ListGrantsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Grants\":{\
          \"shape\":\"GrantList\",\
          \"documentation\":\"<p>A list of grants.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"ListKeyPoliciesRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 1000, inclusive. If you do not include a value, it defaults to 100.</p> <p>Only one policy can be attached to a key.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        }\
      }\
    },\
    \"ListKeyPoliciesResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PolicyNames\":{\
          \"shape\":\"PolicyNameList\",\
          \"documentation\":\"<p>A list of key policy names. The only valid value is <code>default</code>.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"ListKeysRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 1000, inclusive. If you do not include a value, it defaults to 100.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        }\
      }\
    },\
    \"ListKeysResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Keys\":{\
          \"shape\":\"KeyList\",\
          \"documentation\":\"<p>A list of customer master keys (CMKs).</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"ListResourceTagsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 50, inclusive. If you do not include a value, it defaults to 50.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p> <p>Do not attempt to construct this value. Use only the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        }\
      }\
    },\
    \"ListResourceTagsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Tags\":{\
          \"shape\":\"TagList\",\
          \"documentation\":\"<p>A list of tags. Each tag consists of a tag key and a tag value.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p> <p>Do not assume or infer any information from this value.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"ListRetirableGrantsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"RetiringPrincipal\"],\
      \"members\":{\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 100, inclusive. If you do not include a value, it defaults to 50.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        },\
        \"RetiringPrincipal\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The retiring principal for which to list grants.</p> <p>To specify the retiring principal, use the <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Name (ARN)</a> of an AWS principal. Valid AWS principals include AWS accounts (root), IAM users, federated users, and assumed role users. For examples of the ARN syntax for specifying a principal, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam\\\">AWS Identity and Access Management (IAM)</a> in the Example ARNs section of the <i>Amazon Web Services General Reference</i>.</p>\"\
        }\
      }\
    },\
    \"MalformedPolicyDocumentException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified policy is not syntactically or semantically correct.</p>\",\
      \"exception\":true\
    },\
    \"MarkerType\":{\
      \"type\":\"string\",\
      \"max\":1024,\
      \"min\":1,\
      \"pattern\":\"[\\\\u0020-\\\\u00FF]*\"\
    },\
    \"MessageType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"RAW\",\
        \"DIGEST\"\
      ]\
    },\
    \"NotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified entity or resource could not be found.</p>\",\
      \"exception\":true\
    },\
    \"NumberOfBytesType\":{\
      \"type\":\"integer\",\
      \"max\":1024,\
      \"min\":1\
    },\
    \"OriginType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AWS_KMS\",\
        \"EXTERNAL\",\
        \"AWS_CLOUDHSM\"\
      ]\
    },\
    \"PendingWindowInDaysType\":{\
      \"type\":\"integer\",\
      \"max\":365,\
      \"min\":1\
    },\
    \"PlaintextType\":{\
      \"type\":\"blob\",\
      \"max\":4096,\
      \"min\":1,\
      \"sensitive\":true\
    },\
    \"PolicyNameList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PolicyNameType\"}\
    },\
    \"PolicyNameType\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1,\
      \"pattern\":\"[\\\\w]+\"\
    },\
    \"PolicyType\":{\
      \"type\":\"string\",\
      \"max\":131072,\
      \"min\":1,\
      \"pattern\":\"[\\\\u0009\\\\u000A\\\\u000D\\\\u0020-\\\\u00FF]+\"\
    },\
    \"PrincipalIdType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":1,\
      \"pattern\":\"^[\\\\w+=,.@:/-]+$\"\
    },\
    \"PublicKeyType\":{\
      \"type\":\"blob\",\
      \"max\":8192,\
      \"min\":1\
    },\
    \"PutKeyPolicyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"PolicyName\",\
        \"Policy\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"PolicyName\":{\
          \"shape\":\"PolicyNameType\",\
          \"documentation\":\"<p>The name of the key policy. The only valid value is <code>default</code>.</p>\"\
        },\
        \"Policy\":{\
          \"shape\":\"PolicyType\",\
          \"documentation\":\"<p>The key policy to attach to the CMK.</p> <p>The key policy must meet the following criteria:</p> <ul> <li> <p>If you don't set <code>BypassPolicyLockoutSafetyCheck</code> to true, the key policy must allow the principal that is making the <code>PutKeyPolicy</code> request to make a subsequent <code>PutKeyPolicy</code> request on the CMK. This reduces the risk that the CMK becomes unmanageable. For more information, refer to the scenario in the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default-allow-root-enable-iam\\\">Default Key Policy</a> section of the <i>AWS Key Management Service Developer Guide</i>.</p> </li> <li> <p>Each statement in the key policy must contain one or more principals. The principals in the key policy must exist and be visible to AWS KMS. When you create a new AWS principal (for example, an IAM user or role), you might need to enforce a delay before including the new principal in a key policy because the new principal might not be immediately visible to AWS KMS. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot_general.html#troubleshoot_general_eventual-consistency\\\">Changes that I make are not always immediately visible</a> in the <i>AWS Identity and Access Management User Guide</i>.</p> </li> </ul> <p>The key policy cannot exceed 32 kilobytes (32768 bytes). For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/resource-limits.html\\\">Resource Quotas</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"BypassPolicyLockoutSafetyCheck\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag to indicate whether to bypass the key policy lockout safety check.</p> <important> <p>Setting this value to true increases the risk that the CMK becomes unmanageable. Do not set this value to true indiscriminately.</p> <p>For more information, refer to the scenario in the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default-allow-root-enable-iam\\\">Default Key Policy</a> section in the <i>AWS Key Management Service Developer Guide</i>.</p> </important> <p>Use this parameter only when you intend to prevent the principal that is making the request from making a subsequent <code>PutKeyPolicy</code> request on the CMK.</p> <p>The default value is false.</p>\"\
        }\
      }\
    },\
    \"ReEncryptRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CiphertextBlob\",\
        \"DestinationKeyId\"\
      ],\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>Ciphertext of the data to reencrypt.</p>\"\
        },\
        \"SourceEncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Specifies the encryption context to use to decrypt the ciphertext. Enter the same encryption context that was used to encrypt the ciphertext.</p> <p>An <i>encryption context</i> is a collection of non-secret key-value pairs that represents additional authenticated data. When you use an encryption context to encrypt data, you must specify the same (an exact case-sensitive match) encryption context to decrypt the data. An encryption context is optional when encrypting with a symmetric CMK, but it is highly recommended.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"SourceKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the CMK that is used to decrypt the ciphertext before it reencrypts it using the destination CMK.</p> <p>This parameter is required only when the ciphertext was encrypted under an asymmetric CMK. Otherwise, AWS KMS uses the metadata that it adds to the ciphertext blob to determine which CMK was used to encrypt the ciphertext. However, you can use this parameter to ensure that a particular CMK (of any kind) is used to decrypt the ciphertext before it is reencrypted.</p> <p>If you specify a <code>KeyId</code> value, the decrypt part of the <code>ReEncrypt</code> operation succeeds only if the specified CMK was used to encrypt the ciphertext.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"DestinationKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the CMK that is used to reencrypt the data. Specify a symmetric or asymmetric CMK with a <code>KeyUsage</code> value of <code>ENCRYPT_DECRYPT</code>. To find the <code>KeyUsage</code> value of a CMK, use the <a>DescribeKey</a> operation.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"DestinationEncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Specifies that encryption context to use when the reencrypting the data.</p> <p>A destination encryption context is valid only when the destination CMK is a symmetric CMK. The standard ciphertext format for asymmetric CMKs does not include fields for metadata.</p> <p>An <i>encryption context</i> is a collection of non-secret key-value pairs that represents additional authenticated data. When you use an encryption context to encrypt data, you must specify the same (an exact case-sensitive match) encryption context to decrypt the data. An encryption context is optional when encrypting with a symmetric CMK, but it is highly recommended.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"SourceEncryptionAlgorithm\":{\
          \"shape\":\"EncryptionAlgorithmSpec\",\
          \"documentation\":\"<p>Specifies the encryption algorithm that AWS KMS will use to decrypt the ciphertext before it is reencrypted. The default value, <code>SYMMETRIC_DEFAULT</code>, represents the algorithm used for symmetric CMKs.</p> <p>Specify the same algorithm that was used to encrypt the ciphertext. If you specify a different algorithm, the decrypt attempt fails.</p> <p>This parameter is required only when the ciphertext was encrypted under an asymmetric CMK.</p>\"\
        },\
        \"DestinationEncryptionAlgorithm\":{\
          \"shape\":\"EncryptionAlgorithmSpec\",\
          \"documentation\":\"<p>Specifies the encryption algorithm that AWS KMS will use to reecrypt the data after it has decrypted it. The default value, <code>SYMMETRIC_DEFAULT</code>, represents the encryption algorithm used for symmetric CMKs.</p> <p>This parameter is required only when the destination CMK is an asymmetric CMK.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"ReEncryptResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The reencrypted data. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p>\"\
        },\
        \"SourceKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Unique identifier of the CMK used to originally encrypt the data.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Unique identifier of the CMK used to reencrypt the data.</p>\"\
        },\
        \"SourceEncryptionAlgorithm\":{\
          \"shape\":\"EncryptionAlgorithmSpec\",\
          \"documentation\":\"<p>The encryption algorithm that was used to decrypt the ciphertext before it was reencrypted.</p>\"\
        },\
        \"DestinationEncryptionAlgorithm\":{\
          \"shape\":\"EncryptionAlgorithmSpec\",\
          \"documentation\":\"<p>The encryption algorithm that was used to reencrypt the data.</p>\"\
        }\
      }\
    },\
    \"RetireGrantRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GrantToken\":{\
          \"shape\":\"GrantTokenType\",\
          \"documentation\":\"<p>Token that identifies the grant to be retired.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the CMK associated with the grant. </p> <p>For example: <code>arn:aws:kms:us-east-2:444455556666:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p>\"\
        },\
        \"GrantId\":{\
          \"shape\":\"GrantIdType\",\
          \"documentation\":\"<p>Unique identifier of the grant to retire. The grant ID is returned in the response to a <code>CreateGrant</code> operation.</p> <ul> <li> <p>Grant ID Example - 0123456789012345678901234567890123456789012345678901234567890123</p> </li> </ul>\"\
        }\
      }\
    },\
    \"RevokeGrantRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"GrantId\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key associated with the grant.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"GrantId\":{\
          \"shape\":\"GrantIdType\",\
          \"documentation\":\"<p>Identifier of the grant to be revoked.</p>\"\
        }\
      }\
    },\
    \"ScheduleKeyDeletionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier of the customer master key (CMK) to delete.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"PendingWindowInDays\":{\
          \"shape\":\"PendingWindowInDaysType\",\
          \"documentation\":\"<p>The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the customer master key (CMK).</p> <p>This value is optional. If you include a value, it must be between 7 and 30, inclusive. If you do not include a value, it defaults to 30.</p>\"\
        }\
      }\
    },\
    \"ScheduleKeyDeletionResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier of the customer master key (CMK) for which deletion is scheduled.</p>\"\
        },\
        \"DeletionDate\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The date and time after which AWS KMS deletes the customer master key (CMK).</p>\"\
        }\
      }\
    },\
    \"SignRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"Message\",\
        \"SigningAlgorithm\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies an asymmetric CMK. AWS KMS uses the private key in the asymmetric CMK to sign the message. The <code>KeyUsage</code> type of the CMK must be <code>SIGN_VERIFY</code>. To find the <code>KeyUsage</code> of a CMK, use the <a>DescribeKey</a> operation.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"Message\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>Specifies the message or message digest to sign. Messages can be 0-4096 bytes. To sign a larger message, provide the message digest.</p> <p>If you provide a message, AWS KMS generates a hash digest of the message and then signs it.</p>\"\
        },\
        \"MessageType\":{\
          \"shape\":\"MessageType\",\
          \"documentation\":\"<p>Tells AWS KMS whether the value of the <code>Message</code> parameter is a message or message digest. The default value, RAW, indicates a message. To indicate a message digest, enter <code>DIGEST</code>.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"SigningAlgorithm\":{\
          \"shape\":\"SigningAlgorithmSpec\",\
          \"documentation\":\"<p>Specifies the signing algorithm to use when signing the message. </p> <p>Choose an algorithm that is compatible with the type and size of the specified asymmetric CMK.</p>\"\
        }\
      }\
    },\
    \"SignResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the asymmetric CMK that was used to sign the message.</p>\"\
        },\
        \"Signature\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The cryptographic signature that was generated for the message. </p> <ul> <li> <p>When used with the supported RSA signing algorithms, the encoding of this value is defined by <a href=\\\"https://tools.ietf.org/html/rfc8017\\\">PKCS #1 in RFC 8017</a>.</p> </li> <li> <p>When used with the <code>ECDSA_SHA_256</code>, <code>ECDSA_SHA_384</code>, or <code>ECDSA_SHA_512</code> signing algorithms, this value is a DER-encoded object as defined by ANS X9.62â2005 and <a href=\\\"https://tools.ietf.org/html/rfc3279#section-2.2.3\\\">RFC 3279 Section 2.2.3</a>. This is the most commonly used signature format and is appropriate for most uses. </p> </li> </ul> <p>When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.</p>\"\
        },\
        \"SigningAlgorithm\":{\
          \"shape\":\"SigningAlgorithmSpec\",\
          \"documentation\":\"<p>The signing algorithm that was used to sign the message.</p>\"\
        }\
      }\
    },\
    \"SigningAlgorithmSpec\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"RSASSA_PSS_SHA_256\",\
        \"RSASSA_PSS_SHA_384\",\
        \"RSASSA_PSS_SHA_512\",\
        \"RSASSA_PKCS1_V1_5_SHA_256\",\
        \"RSASSA_PKCS1_V1_5_SHA_384\",\
        \"RSASSA_PKCS1_V1_5_SHA_512\",\
        \"ECDSA_SHA_256\",\
        \"ECDSA_SHA_384\",\
        \"ECDSA_SHA_512\"\
      ]\
    },\
    \"SigningAlgorithmSpecList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"SigningAlgorithmSpec\"}\
    },\
    \"Tag\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TagKey\",\
        \"TagValue\"\
      ],\
      \"members\":{\
        \"TagKey\":{\
          \"shape\":\"TagKeyType\",\
          \"documentation\":\"<p>The key of the tag.</p>\"\
        },\
        \"TagValue\":{\
          \"shape\":\"TagValueType\",\
          \"documentation\":\"<p>The value of the tag.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A key-value pair. A tag consists of a tag key and a tag value. Tag keys and tag values are both required, but tag values can be empty (null) strings.</p> <p>For information about the rules that apply to tag keys and tag values, see <a href=\\\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html\\\">User-Defined Tag Restrictions</a> in the <i>AWS Billing and Cost Management User Guide</i>.</p>\"\
    },\
    \"TagException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because one or more tags are not valid.</p>\",\
      \"exception\":true\
    },\
    \"TagKeyList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"TagKeyType\"}\
    },\
    \"TagKeyType\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1\
    },\
    \"TagList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Tag\"}\
    },\
    \"TagResourceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"Tags\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the CMK you are tagging.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagList\",\
          \"documentation\":\"<p>One or more tags. Each tag consists of a tag key and a tag value.</p>\"\
        }\
      }\
    },\
    \"TagValueType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":0\
    },\
    \"TrustAnchorCertificateType\":{\
      \"type\":\"string\",\
      \"max\":5000,\
      \"min\":1\
    },\
    \"UnsupportedOperationException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because a specified parameter is not supported or a specified resource is not valid for this operation.</p>\",\
      \"exception\":true\
    },\
    \"UntagResourceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"TagKeys\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the CMK from which you are removing tags.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"TagKeys\":{\
          \"shape\":\"TagKeyList\",\
          \"documentation\":\"<p>One or more tag keys. Specify only the tag keys, not the tag values.</p>\"\
        }\
      }\
    },\
    \"UpdateAliasRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AliasName\",\
        \"TargetKeyId\"\
      ],\
      \"members\":{\
        \"AliasName\":{\
          \"shape\":\"AliasNameType\",\
          \"documentation\":\"<p>Identifies the alias that is changing its CMK. This value must begin with <code>alias/</code> followed by the alias name, such as <code>alias/ExampleAlias</code>. You cannot use UpdateAlias to change the alias name.</p>\"\
        },\
        \"TargetKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies the CMK to associate with the alias. When the update operation completes, the alias will point to this CMK. </p> <p>The CMK must be in the same AWS account and Region as the alias. Also, the new target CMK must be the same type as the current target CMK (both symmetric or both asymmetric) and they must have the same key usage. </p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p> <p>To verify that the alias is mapped to the correct CMK, use <a>ListAliases</a>.</p>\"\
        }\
      }\
    },\
    \"UpdateCustomKeyStoreRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CustomKeyStoreId\"],\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Identifies the custom key store that you want to update. Enter the ID of the custom key store. To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p>\"\
        },\
        \"NewCustomKeyStoreName\":{\
          \"shape\":\"CustomKeyStoreNameType\",\
          \"documentation\":\"<p>Changes the friendly name of the custom key store to the value that you specify. The custom key store name must be unique in the AWS account.</p>\"\
        },\
        \"KeyStorePassword\":{\
          \"shape\":\"KeyStorePasswordType\",\
          \"documentation\":\"<p>Enter the current password of the <code>kmsuser</code> crypto user (CU) in the AWS CloudHSM cluster that is associated with the custom key store.</p> <p>This parameter tells AWS KMS the current password of the <code>kmsuser</code> crypto user (CU). It does not set or change the password of any users in the AWS CloudHSM cluster.</p>\"\
        },\
        \"CloudHsmClusterId\":{\
          \"shape\":\"CloudHsmClusterIdType\",\
          \"documentation\":\"<p>Associates the custom key store with a related AWS CloudHSM cluster. </p> <p>Enter the cluster ID of the cluster that you used to create the custom key store or a cluster that shares a backup history and has the same cluster certificate as the original cluster. You cannot use this parameter to associate a custom key store with an unrelated cluster. In addition, the replacement cluster must <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keystore.html#before-keystore\\\">fulfill the requirements</a> for a cluster associated with a custom key store. To view the cluster certificate of a cluster, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html\\\">DescribeClusters</a> operation.</p>\"\
        }\
      }\
    },\
    \"UpdateCustomKeyStoreResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"UpdateKeyDescriptionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"Description\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"DescriptionType\",\
          \"documentation\":\"<p>New description for the CMK.</p>\"\
        }\
      }\
    },\
    \"VerifyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"Message\",\
        \"Signature\",\
        \"SigningAlgorithm\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies the asymmetric CMK that will be used to verify the signature. This must be the same CMK that was used to generate the signature. If you specify a different CMK, the signature verification fails.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"Message\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>Specifies the message that was signed. You can submit a raw message of up to 4096 bytes, or a hash digest of the message. If you submit a digest, use the <code>MessageType</code> parameter with a value of <code>DIGEST</code>.</p> <p>If the message specified here is different from the message that was signed, the signature verification fails. A message and its hash digest are considered to be the same message.</p>\"\
        },\
        \"MessageType\":{\
          \"shape\":\"MessageType\",\
          \"documentation\":\"<p>Tells AWS KMS whether the value of the <code>Message</code> parameter is a message or message digest. The default value, RAW, indicates a message. To indicate a message digest, enter <code>DIGEST</code>.</p> <important> <p>Use the <code>DIGEST</code> value only when the value of the <code>Message</code> parameter is a message digest. If you use the <code>DIGEST</code> value with a raw message, the security of the verification operation can be compromised.</p> </important>\"\
        },\
        \"Signature\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The signature that the <code>Sign</code> operation generated.</p>\"\
        },\
        \"SigningAlgorithm\":{\
          \"shape\":\"SigningAlgorithmSpec\",\
          \"documentation\":\"<p>The signing algorithm that was used to sign the message. If you submit a different algorithm, the signature verification fails.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"VerifyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier for the asymmetric CMK that was used to verify the signature.</p>\"\
        },\
        \"SignatureValid\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A Boolean value that indicates whether the signature was verified. A value of <code>True</code> indicates that the <code>Signature</code> was produced by signing the <code>Message</code> with the specified <code>KeyID</code> and <code>SigningAlgorithm.</code> If the signature is not verified, the <code>Verify</code> operation fails with a <code>KMSInvalidSignatureException</code> exception. </p>\"\
        },\
        \"SigningAlgorithm\":{\
          \"shape\":\"SigningAlgorithmSpec\",\
          \"documentation\":\"<p>The signing algorithm that was used to verify the signature.</p>\"\
        }\
      }\
    },\
    \"WrappingKeySpec\":{\
      \"type\":\"string\",\
      \"enum\":[\"RSA_2048\"]\
    }\
  },\
  \"documentation\":\"<fullname>AWS Key Management Service</fullname> <p>AWS Key Management Service (AWS KMS) is an encryption and key management web service. This guide describes the AWS KMS operations that you can call programmatically. For general information about AWS KMS, see the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/\\\"> <i>AWS Key Management Service Developer Guide</i> </a>.</p> <note> <p>AWS provides SDKs that consist of libraries and sample code for various programming languages and platforms (Java, Ruby, .Net, macOS, Android, etc.). The SDKs provide a convenient way to create programmatic access to AWS KMS and other AWS services. For example, the SDKs take care of tasks such as signing requests (see below), managing errors, and retrying requests automatically. For more information about the AWS SDKs, including how to download and install them, see <a href=\\\"http://aws.amazon.com/tools/\\\">Tools for Amazon Web Services</a>.</p> </note> <p>We recommend that you use the AWS SDKs to make programmatic API calls to AWS KMS.</p> <p>Clients must support TLS (Transport Layer Security) 1.0. We recommend TLS 1.2. Clients must also support cipher suites with Perfect Forward Secrecy (PFS) such as Ephemeral Diffie-Hellman (DHE) or Elliptic Curve Ephemeral Diffie-Hellman (ECDHE). Most modern systems such as Java 7 and later support these modes.</p> <p> <b>Signing Requests</b> </p> <p>Requests must be signed by using an access key ID and a secret access key. We strongly recommend that you <i>do not</i> use your AWS account (root) access key ID and secret key for everyday work with AWS KMS. Instead, use the access key ID and secret access key for an IAM user. You can also use the AWS Security Token Service to generate temporary security credentials that you can use to sign requests.</p> <p>All AWS KMS operations require <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html\\\">Signature Version 4</a>.</p> <p> <b>Logging API Requests</b> </p> <p>AWS KMS supports AWS CloudTrail, a service that logs AWS API calls and related events for your AWS account and delivers them to an Amazon S3 bucket that you specify. By using the information collected by CloudTrail, you can determine what requests were made to AWS KMS, who made the request, when it was made, and so on. To learn more about CloudTrail, including how to turn it on and find your log files, see the <a href=\\\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/\\\">AWS CloudTrail User Guide</a>.</p> <p> <b>Additional Resources</b> </p> <p>For more information about credentials and request signing, see the following:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-security-credentials.html\\\">AWS Security Credentials</a> - This topic provides general information about the types of credentials used for accessing AWS.</p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html\\\">Temporary Security Credentials</a> - This section of the <i>IAM User Guide</i> describes how to create and use temporary security credentials.</p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html\\\">Signature Version 4 Signing Process</a> - This set of topics walks you through the process of signing a request using an access key ID and a secret access key.</p> </li> </ul> <p> <b>Commonly Used API Operations</b> </p> <p>Of the API operations discussed in this guide, the following will prove the most useful for most applications. You will likely perform operations other than these, such as creating keys and assigning policies, by using the console.</p> <ul> <li> <p> <a>Encrypt</a> </p> </li> <li> <p> <a>Decrypt</a> </p> </li> <li> <p> <a>GenerateDataKey</a> </p> </li> <li> <p> <a>GenerateDataKeyWithoutPlaintext</a> </p> </li> </ul>\"\
}\
";
}

@end
