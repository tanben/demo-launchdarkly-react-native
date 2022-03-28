#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "LaunchdarklyReactNativeClient-Bridging-Header.h"

FOUNDATION_EXPORT double launchdarkly_react_native_client_sdkVersionNumber;
FOUNDATION_EXPORT const unsigned char launchdarkly_react_native_client_sdkVersionString[];

