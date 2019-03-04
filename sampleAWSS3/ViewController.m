//
//  ViewController.m
//  sampleAWSS3
//
//  Created by Aryvart on 2/26/19.
//  Copyright © 2019 Aryvart. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AWSS3TransferUtility *transferUtility = [AWSS3TransferUtility defaultS3TransferUtility];
    AWSS3TransferUtilityDownloadExpression *expression = [[AWSS3TransferUtilityDownloadExpression alloc]init];
    [expression setProgressBlock:^(AWSS3TransferUtilityTask * _Nonnull task, NSProgress * _Nonnull progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%f", progress.fractionCompleted);
        });
    }];
    [transferUtility downloadDataFromBucket:@"tailor-store" key:@"uploads/order/image/image2018100113322712125369.png" expression:expression completionHandler:^(AWSS3TransferUtilityDownloadTask * _Nonnull task, NSURL * _Nullable location, NSData * _Nullable data, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *img =  [UIImage imageWithData:data];
            self.imgView.image = img;
        });
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   /*
    AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
    NSString *downloadFilePath = [NSTemporaryDirectory() stringByAppendingString:@"uploads/order/image/image2018100113322712125369.png"];
    NSURL *downloadFileURL = [NSURL fileURLWithPath:downloadFilePath];
    AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
    downloadRequest.bucket = @"tailor-store"; //changed name for security reasons
    downloadRequest.key = @"image2018100113322712125369.png";
    downloadRequest.downloadingFileURL = downloadFileURL;
    NSLog(@"About to start");
    // Download the file.
    [[transferManager download:downloadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor] withBlock:^id(AWSTask *task) {
        NSLog(@"Started task");
        if (task.error){
            NSLog(@"In if statement");
            if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                switch (task.error.code) {
                    case AWSS3TransferManagerErrorCancelled:
                    case AWSS3TransferManagerErrorPaused:
                        break;
                    default:
                        NSLog(@"Error: %@", task.error);
                        break;
                }
            } else {
                // Unknown error.
                NSLog(@"Error: %@", task.error);
            }
        }
        if (task.result) {
            AWSS3TransferManagerDownloadOutput *downloadOutput = task.result;
            //File downloaded successfully.
            NSLog(@"success");
        }
        return nil;
    }];
    self.imgView.image = [UIImage imageWithContentsOfFile:downloadFilePath];
    NSLog(@"%f", [UIImage imageWithContentsOfFile:downloadFilePath].size.width);
    */
}
@end
