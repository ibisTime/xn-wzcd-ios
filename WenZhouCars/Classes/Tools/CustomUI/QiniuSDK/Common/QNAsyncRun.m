#import "QNAsyncRun.h"
#import <Foundation/Foundation.h>
void QNAsyncRun(QNRun run) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        run();
    });
}
void QNAsyncRunInMain(QNRun run) {
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        run();
    });
}
