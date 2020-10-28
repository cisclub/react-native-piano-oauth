#import "PianoOauth.h"

@import PianoOAuth;

static RCTResponseSenderBlock _didSignInHandler;
static RCTResponseSenderBlock _didSignOutHandler;
static RCTResponseSenderBlock _didCancelSignInHandler;

@interface RNPianoOauth(PianoIDdelegate)<PianoIDDelegate>

@end

@implementation RNPianoOauth

RCT_EXPORT_MODULE(PianoOAuth)

RCT_EXPORT_METHOD(signInWithAID:(NSString *)AID
                  endpointURL:(NSString *)endpointURL
                  widgetType:(int)widgetType
                  didSignInForTokenWithError:(RCTResponseSenderBlock)didSignInHandler
                  didCancelSignIn:(RCTResponseSenderBlock)didCancelSignInHandler)

{
    _didSignInHandler = didSignInHandler;
    _didCancelSignInHandler = didCancelSignInHandler;
    
    [PianoID.shared setAid:AID];
    [PianoID.shared setEndpointUrl:endpointURL];
    [PianoID.shared setWidgetType:widgetType];
    [PianoID.shared setSignUpEnabled:YES];
    [PianoID.shared setDelegate:self];
    
    [PianoID.shared signIn];
}

RCT_EXPORT_METHOD(signOutWithToken:(NSString *)token
                  didSignOutHandler:(RCTResponseSenderBlock)didSignOutHandler)
{
    _didSignOutHandler = didSignOutHandler;
    
    [PianoID.shared signOutWithToken:token];
}

-(void)pianoIDSignInDidCancel:(PianoID *)pianoID {
    _didCancelSignInHandler(@[]);
}

-(void)pianoID:(PianoID *)pianoID didSignOutWithError:(NSError *)error {
    _didSignOutHandler(@[error]);
}

-(void)pianoID:(PianoID *)pianoID didSignInForToken:(PianoIDToken *)token withError:(NSError *)error {
    _didSignInHandler(@[token, error]);
}


@end
