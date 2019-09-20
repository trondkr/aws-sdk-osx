import os, sys
import glob
import fileinput
import re
directory_in_str="."

# This script is used to convert all of the paths in the AWS iOS 
# SDK dopwnloaded from Github into a correct format for 
# creating a local Macos framework.
# Run this before you manually edit all of tyhe UIKit references.
# Trond Kristiansen, Rask Dev LLC, 10.04.2019
#  
# Loop over all .h and .m files in subfolders and replace strings 
fpathH='{}/**/*.h'.format(directory_in_str)
fpathM='{}/**/*.m'.format(directory_in_str)

fpaths=[fpathH,fpathM]

doUIKIT=True

#import "AWSServiceEnum.h"
#import "AWSIdentityProvider.h"
fromstrings=['#import <AWSS3/AWSS3.h>',
'#import <AWSCore/AWSFMDB.h>',
'#import <AWSCore/AWSURLRequestRetryHandler.h>',
'#import <AWSCore/AWSService.h>',
'#import <AWSCore/AWSCore.h>',
'#import <AWSCore/AWSNetworking.h>',
'#import <AWSCore/AWSModel.h>',
'#import <AWSCore/AWSCategory.h>',
'#import <AWSCore/AWSBolts.h>',
'#import <AWSCore/AWSSignature.h>',
'#import <AWSCore/AWSCocoaLumberjack.h>',
'#import <AWSCore/AWSSynchronizedMutableDictionary.h>',
'#import <AWSCore/AWSFMDB.h>',
'#import <AWSCore/AWSURLRequestSerialization.h>',
'#import <AWSCore/AWSURLResponseSerialization.h>',
'#import <AWSCore/AWSURLRequestRetryHandler.h>',
'#import <AWSCore/AWSTMCache.h>',
'#import <UIKit/UIKit.h>',
'#import <AWSCore/AWSModel.h>',
             '#import <AWSFMDB/AWSFMDB.h>',
             '#import "AWSDDASLLogCapture.h"',
             '#import "AWSDDASLLogger.h"',
             '#import "AWSLogging.h"',
             '#import "AWSFMDB+AWSHelpers.h"','#import <AWSCore/AWSXMLDictionary.h>']

tostrings=['#import "AWSS3.h"',
'#import "AWSFMDB.h"',
'#import "AWSURLRequestRetryHandler.h"',
'#import "AWSService.h"',
'#import "AWSCore.h"',
'#import "AWSNetworking.h"',
'#import "AWSModel.h"',
'#import "AWSCategory.h"',
'#import "AWSSignature.h"',
'#import "AWSCocoaLumberjack.h"',
'#import "AWSBolts.h"',
'#import "AWSSynchronizedMutableDictionary.h"',
'#import "AWSFMDB.h"',
'#import "AWSURLRequestSerialization.h"',
'#import "AWSURLResponseSerialization.h"',
'#import "AWSURLRequestRetryHandler.h"',
'#import "AWSTMCache.h"',
'#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR\n#import <UIKit/UIKit.h>\n#else\n#import <Cocoa/Cocoa.h>\n#endif',
           '#import "AWSModel.h"','#import "AWSFMDB.h"',
           '','','','',
           '#import "AWSXMLDictionary.h"']

def replaceAll(infilepath,outfilepath,fromstring,tostring):
    with open(infilepath) as infile,  open(outfilepath, 'w') as outfile:
        for line in infile:
            outfile.write(line.replace(fromstring, tostring))

for fpath in fpaths:

    for fromstring, tostring in zip(fromstrings,tostrings):
        for src in glob.glob(fpath,recursive=True):
            
            dst="tmp"
            if (tostring=='#import <UIKit/UIKit.h>' and doUIKIT) or  (tostring!='#import <UIKit/UIKit.h>'):
                replaceAll(src,dst,fromstring,tostring)
                if "Resources" in fpath:
                    addlibstring=''"#import "AWSCocoaLumberjack.h"'
                    srcfile=open(src,'a')
                    lines=src.readlines()
                    lines.insert(0,addlibstring)
                    src.close()
                    dstfile=open(dst,'a')
                    dstfile.writelines(lines)
                    dst.close()
            
                os.rename(dst,src)


                print("CLOSED: {}".format(src))
