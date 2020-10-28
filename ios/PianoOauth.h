#import <React/RCTBridgeModule.h>

@interface RNPianoOauth : NSObject <RCTBridgeModule>

@property (nonatomic, strong) RCTResponseSenderBlock didSignInHandler;
@property (nonatomic, strong) RCTResponseSenderBlock didCancelSignInHandler;
@property (nonatomic, strong) RCTResponseSenderBlock didSignOutHandler;

@end
