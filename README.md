# awsosx - a version of AWS SDK iOS v.2.10 modified to work for macos.

**Updated 10.07.2019**

The original [AWS SDK iOS](https://github.com/aws-amplify/aws-sdk-ios) is downloaded locally and new files copied to the folder structure here. Then run the script **updateAWSFromRepository.py** to to convert all of the paths in the AWS iOS SDK dopwnloaded from Github into a correct format for creating a local Macos framework. Run this script prior to manually editing all of tyhe UIKit references.

finally, run the script **createAWSOSfile.py** which is used to generate the awsosx.h file. Run script at the root of the Xcode AWS SDK project and paste the output into the awsosx.h file


**Rask Dev LLC, 10.07.2019**
