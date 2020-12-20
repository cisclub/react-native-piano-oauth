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

RCT_EXPORT_METHOD(signInWithAID:(NSString *)AID
                  googleCID: (NSString *)GCID
                  endpointURL:(NSString *)endpointURL
                  widgetType:(int)widgetType
                  didSignInForTokenWithError:(RCTResponseSenderBlock)didSignInHandler
                  didCancelSignIn:(RCTResponseSenderBlock)didCancelSignInHandler)

{
    [self setDidSignInHandler:didSignInHandler];
    [self setDidCancelSignInHandler:didCancelSignInHandler];
    
    [PianoID.shared setDelegate:self];
    
    [PianoID.shared setAid:AID];
    [PianoID.shared setEndpointUrl:endpointURL];
    [PianoID.shared setWidgetType:widgetType];
    [PianoID.shared setSignUpEnabled:YES];
    [PianoID.shared setGoogleClientId:GCID];
    
    UIViewController *topViewController = [RNPianoOauth topMostController];
    [PianoID.shared setPresentingViewController:topViewController];
    
    [PianoID.shared signIn];
}

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    return topController;
}

RCT_EXPORT_METHOD(signOutWithToken:(NSString *)token
                  didSignOutHandler:(RCTResponseSenderBlock)didSignOutHandler)
{
    [self setDidSignOutHandler:didSignOutHandler];
    
    [PianoID.shared signOutWithToken:token];
}

-(void)pianoIDSignInDidCancel:(PianoID *)pianoID {
    self.didCancelSignInHandler(@[]);
}

-(void)pianoID:(PianoID *)pianoID didSignOutWithError:(NSError *)error {
    self.didSignOutHandler(@[error? error : [NSNull null]]);
}

-(void)pianoID:(PianoID *)pianoID didSignInForToken:(PianoIDToken *)token withError:(NSError *)error {
    if (token != nil) {
        self.didSignInHandler(@[token.accessToken]);
    } else if (error != nil) {
        NSMutableDictionary *errorInfo = error.userInfo.mutableCopy;
        [errorInfo setObject:error.domain forKey:@"domain"];
        self.didSignInHandler(@[@{@"error": errorInfo}]);
    }
}


@end
