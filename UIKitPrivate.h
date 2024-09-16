#import <UIKit/UIKit.h>

@interface UIWindow(private)
- (instancetype)_initWithFrame:(CGRect)frame attached:(BOOL)attached;
- (void)orderFront:(id)arg1;
@end

@interface UIScreen(private)
- (CGRect)_referenceBounds;
@end

@interface UIScenePresentationBinder : NSObject
- (void)addScene:(id)scene;
@end

@interface UIRootWindowScenePresentationBinder : UIScenePresentationBinder
- (instancetype)initWithPriority:(int)pro displayConfiguration:(id)c;
@end

// FrontBoard

@interface FBScene : NSObject
@end

@interface FBDisplayManager : NSObject
+ (instancetype)sharedInstance;
- (id)mainConfiguration;
@end

@interface FBSSceneClientIdentity : NSObject
+ (instancetype)localIdentity;
@end

@interface FBSSceneSpecification : NSObject
+ (instancetype)specification;
@end

@interface UIApplicationSceneSpecification : FBSSceneSpecification
@end

@interface FBSSceneIdentity : NSObject
+ (instancetype)identityForIdentifier:(NSString *)id;
@end

// FBSSceneSettings
@interface UIMutableApplicationSceneSettings : NSObject
@property(nonatomic, assign) BOOL deviceOrientationEventsEnabled;
- (CGRect)frame;
- (NSMutableSet *)ignoreOcclusionReasons;
- (void)setDisplayConfiguration:(id)c;
- (void)setForeground:(BOOL)f;
- (void)setFrame:(CGRect)frame;
- (void)setInterfaceOrientation:(NSInteger)o;
@end

@interface UIMutableApplicationSceneClientSettings : NSObject
@property(nonatomic, assign) NSInteger interfaceOrientation;
@property(nonatomic, assign) NSInteger statusBarStyle;
@end

@interface FBSSceneParameters : NSObject
@property(nonatomic, copy) UIMutableApplicationSceneSettings *settings;
@property(nonatomic, copy) UIMutableApplicationSceneClientSettings *clientSettings;
+ (instancetype)parametersForSpecification:(FBSSceneSpecification *)spec;
//- (void)updateSettingsWithBlock:(id)block;
@end

@interface FBSMutableSceneParameters : FBSSceneParameters
//- (void)updateClientSettingsWithBlock:(id)block;
@end

@interface FBSMutableSceneDefinition : NSObject
@property(nonatomic, copy) FBSSceneClientIdentity *clientIdentity;
@property(nonatomic, copy) FBSSceneIdentity *identity;
@property(nonatomic, copy) FBSSceneSpecification *specification;
+ (instancetype)definition;
@end

@interface FBSceneManager : NSObject
+ (instancetype)sharedInstance;
- (FBScene *)createSceneWithDefinition:(id)def initialParameters:(id)params;
@end
