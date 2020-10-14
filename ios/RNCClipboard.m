#import "RNCClipboard.h"


#import <UIKit/UIKit.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>


@implementation RNCClipboard

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(setString:(NSString *)content)
{
  UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
  clipboard.string = (content ? : @"");
}

RCT_EXPORT_METHOD(getString:(RCTPromiseResolveBlock)resolve
                  reject:(__unused RCTPromiseRejectBlock)reject)
{
//  if (@available(iOS 14.0, *)) {
//    NSSet<UIPasteboardDetectionPattern> *detectionPatterns =
//        [NSSet setWithArray:@[ UIPasteboardDetectionPatternProbableWebURL ]];
//
//    [[UIPasteboard generalPasteboard]
//     detectValuesForPatterns:detectionPatterns completionHandler:^(NSDictionary<UIPasteboardDetectionPattern, id> * data, NSError * error) {
//      if (data[UIPasteboardDetectionPatternProbableWebURL] != nil) {
//        NSString *url = data[UIPasteboardDetectionPatternProbableWebURL];
//
//        resolve(url);
//      }
//    }];
//
//  } else {
    UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
    resolve((clipboard.string ? : @""));
//  }
}

RCT_EXPORT_METHOD(hasString:(RCTPromiseResolveBlock)resolve
                  reject:(__unused RCTPromiseRejectBlock)reject)
{
  BOOL stringPresent = YES;
  UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
  if (@available(iOS 10, *)) {
    stringPresent = clipboard.hasStrings;
  } else {
    NSString* stringInPasteboard = clipboard.string;
    stringPresent = [stringInPasteboard length] == 0;
  }

  resolve([NSNumber numberWithBool: stringPresent]);
}

@end
