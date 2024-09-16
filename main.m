#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include <dlfcn.h>

@interface UIStatusBarServer : NSObject
@end
@implementation UIStatusBarServer(hook)
+ (void)runServer {
    // FIXME: PreBoard doesn't call this
}
@end

void FBSystemShellInitialize(id block);

int main(int argc, char **argv) {
    FBSystemShellInitialize(nil);
    return UIApplicationMain(argc, argv, @"UISystemShellApplication", NSStringFromClass(AppDelegate.class));
}
