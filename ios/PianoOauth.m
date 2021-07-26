#import "PianoOauth.h"

@import PianoOAuth;
@import UIKit;

@interface RNPianoOauth(PianoIDdelegate)<PianoIDDelegate>

@end

@implementation RNPianoOauth

@synthesize didSignInHandler;
@synthesize didCancelSignInHandler;
@synthesize didSignOutHandler;

RCT_EXPORT_MODULE(PianoOAuth)

RCT_EXPORT_METHOD(initWithAID:(NSString *)AID endpointURL:(NSString *)endpointURL) {
    [PianoID.shared setDelegate:self];
    
    [PianoID.shared setAid:AID];
    [PianoID.shared setEndpointUrl:endpointURL];
}
                  
RCT_EXPORT_METHOD(signInWithGoogleCID:(NSString *)GCID
                  widgetType:(int)widgetType
                  didSignInForTokenWithError:(RCTResponseSenderBlock)didSignInHandler
                  didCancelSignIn:(RCTResponseSenderBlock)didCancelSignInHandler)

{
    [self setDidSignInHandler:didSignInHandler];
    [self setDidCancelSignInHandler:didCancelSignInHandler];
    
    [PianoID.shared setWidgetType:widgetType];
    [PianoID.shared setSignUpEnabled:YES];
    [PianoID.shared setGoogleClientId:GCID];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *topViewController = [RNPianoOauth topMostController];
        [PianoID.shared setPresentingViewController:topViewController];
    });
    
    [PianoID.shared signIn];
}

RCT_EXPORT_METHOD(signOutWithToken:(NSString *)token
                  didSignOutHandler:(RCTResponseSenderBlock)didSignOutHandler)
{
    [self setDidSignOutHandler:didSignOutHandler];
    
    [PianoID.shared signOutWithToken:token];
}


#pragma mark - Helper methods

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}


#pragma mark - PianoIDDelegate

-(void)signInResult:(PianoIDSignInResult *)result withError:(NSError *)error {
    if (error) { // Failed
        NSMutableDictionary *errorInfo = error.userInfo.mutableCopy;
        [errorInfo setObject:error.domain forKey:@"domain"];
        self.didSignInHandler(@[@{@"error": errorInfo}]);
    } else if (result.token) { // Success
        self.didSignInHandler(@[result.token.accessToken]);
    }
}

-(void)signOutWithError:(NSError *)error {
    self.didSignOutHandler(@[error? error : [NSNull null]]);
}

-(void)cancel {
    self.didCancelSignInHandler(@[]);
}


@end
