#import "AppDelegate.h"
#import "ViewController.h"
#import "UIKitPrivate.h"
 
@interface AppDelegate()
@property(nonatomic) UIScenePresentationBinder *binder;
@end

@implementation AppDelegate

/*
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self createInitialAppScene];

    // UIDevice.currentDevice.orientation =
    // BKSHIDServicesLockRotation()
    // [application setStatusBarHidden:YES withAnimation:NO];
    // PBASecureWindow?????
    // UIWindowAccessibility????

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen.mainScreen _referenceBounds]];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    ViewController *vc = [[ViewController alloc] init];

    // presentDeviceUnlock: lock the screen back
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];

    // [AppDelegate _setupTapToWakeRecognition], reconfigureHomeButton
    // [_UIKeyboardArbiterHost launchAdvisorWithOmniscientDelegate:nil sceneDelegate:self]
    // TODO: [PBAAppDelegate _createInputUIScene]
    // [self sharedController] -> PBAHIDEventController
    // startReceivingEvents
    //[NSNotificationCenter defaultCenter] addObserver: displayDidBlank??? displayWillUnblank
    // dispatch_async some block

    // We're not safe yet, so auto exit
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        exit(0);
    });

    return YES;
}
*/

- (instancetype)init {
    self = [super init];
    [self createInitialAppScene];
    return self;
}

- (void)createInitialAppScene {
    // In [PBAAppDelegate application:didFinishLaunchingWithOptions:]:
    // [FBSceneWorkspace addWorkspaceObserver:self]
    // [FBSceneManager sharedInstance]
    // FBSDisplayConfiguration
    id displayConfig = [[FBDisplayManager sharedInstance] mainConfiguration];
    //[FBDisplayManager mainConfiguration];
    self.binder = [[UIRootWindowScenePresentationBinder alloc] initWithPriority:0 displayConfiguration:displayConfig];

    // In [PBAAppDelegate _createInitialAppScene]:
    FBSMutableSceneDefinition *definition = [FBSMutableSceneDefinition definition];
    definition.identity = [FBSSceneIdentity identityForIdentifier:NSBundle.mainBundle.bundleIdentifier];
    definition.clientIdentity = [FBSSceneClientIdentity localIdentity];
    definition.specification = [UIApplicationSceneSpecification specification];
    FBSMutableSceneParameters *parameters = [FBSMutableSceneParameters parametersForSpecification:definition.specification];

    UIMutableApplicationSceneSettings *settings = [UIMutableApplicationSceneSettings new];
    settings.displayConfiguration = displayConfig;
    settings.frame = [UIScreen.mainScreen _referenceBounds];
    //settings.level = ????
    settings.foreground = YES;
    settings.interfaceOrientation = UIInterfaceOrientationPortrait;
    settings.deviceOrientationEventsEnabled = YES;
    [settings.ignoreOcclusionReasons addObject:@"SystemApp"];
    parameters.settings = settings;
    //[parameters updateSettingsWithBlock:block];

        UIMutableApplicationSceneClientSettings *clientSettings = [UIMutableApplicationSceneClientSettings new];
    clientSettings.interfaceOrientation = UIInterfaceOrientationPortrait;
    clientSettings.statusBarStyle = 0;
    parameters.clientSettings = clientSettings;
    //[parameters updateClientSettingsWithBlock:block];

    FBScene *scene = [[FBSceneManager sharedInstance] createSceneWithDefinition:definition initialParameters:parameters];
    [self.binder addScene:scene];
}

#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

@end
