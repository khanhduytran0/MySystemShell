#import "ViewController.h"
#include <dlfcn.h>
#include <mach/mach.h>
#include <sys/mman.h>

void showDialog(UIViewController *viewController, NSString* title, NSString* message) {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
        message:message
        preferredStyle:UIAlertControllerStyleAlert];
    //text.dataDetectorTypes = UIDataDetectorTypeLink;
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];

    [viewController presentViewController:alert animated:YES completion:nil];
}

@interface FLEXManager : NSObject
+ (FLEXManager *)sharedManager;
- (UIWindow *)explorerWindow;
- (void)showExplorer;
@end

@interface ViewController () {
}
- (UIWindow *)_window;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = UIColor.systemBackgroundColor;
    self.title = @"BaseApp";
    self.navigationItem.rightBarButtonItems = @[
        [[UIBarButtonItem alloc] initWithTitle:@"Exit" style:UIBarButtonItemStylePlain target:self action:@selector(test)],
        [[UIBarButtonItem alloc] initWithTitle:@"FLEX" style:UIBarButtonItemStylePlain target:self action:@selector(flex)]
    ];
}

- (void)flex {
    FLEXManager *manager = [NSClassFromString(@"FLEXManager") sharedManager];
    [manager showExplorer];
    manager.explorerWindow.windowScene = self._window.windowScene;
}

- (void)test {
    exit(0);
}

@end
