

import os

# Script used to generate awsosx.h file. Run script at the root of the Xcode AWS SDK project and paste the output
# into the awsosx.h file

# NOTE!
# Does not work unless you delete the build folder in the aws-sdk-macos directory!!!!!
for root, dirs, files in os.walk("/Users/trondkr/Dropbox/Projects/Syncsolution/aws-sdk-osx"):
    
    for file in files:
        if file.endswith(".h"):
            print("#import <awsosx/{}>".format(file))
