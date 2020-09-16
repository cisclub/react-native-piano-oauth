#import "PianoOauth.h"

@import PianoOAuth;

static RCTResponseSenderBlock _didSignInHandler;
static RCTResponseSenderBlock _didSignOutHandler;
static RCTResponseSenderBlock _didCancelSignInHandler;

@interface RNPianoOauth(PianoIDdelegate)<PianoIDDelegate>

@end

@implementation RNPianoOauth

RCT_EXPORT_MODULE(PianoOauth)

RCT_EXPORT_METHOD(signInWithAID:(NSString *)AID
                  endpointURL:(NSString *)endpointURL
                  didSignInForTokenWithError:(RCTResponseSenderBlock)didSignInHandler
                  didCancelSignIn:(RCTResponseSenderBlock)didCancelSignInHandler)

{
    _didSignInHandler = didSignInHandler;
    _didCancelSignInHandler = didCancelSignInHandler;
    
    PianoID.shared.aid = AID;
    PianoID.shared.endpointUrl = endpointURL;
    PianoID.shared.delegate = self;
    
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
