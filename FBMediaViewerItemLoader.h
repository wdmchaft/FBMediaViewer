//
//  FBMediaViewerDownloader.h
//  FBMediaViewer
//
//  Created by Hiroshi Hashiguchi on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FBMediaViewerContentLoaderLoadingBlock)(NSUInteger loadedSize);
typedef void (^FBMediaViewerContentLoaderCompletionBlock)(BOOL canceled);
typedef void (^FBMediaViewerContentLoaderFailedBlock)(void);

typedef enum
{
    FBMeditViewerItemLoaderModeLoadFromRemote = 0,
    FBMeditViewerItemLoaderModeLoadFromLocal,
    FBMeditViewerItemLoaderModeLoadFromCache
} FBMeditViewerItemLoaderMode;

@protocol FBMediaViewerItem;

@protocol FBMediaViewerItemLoader <NSObject>

- (void)loadWithMediaViewerItem:(id <FBMediaViewerItem>)mediaViewerItem
                           mode:(FBMeditViewerItemLoaderMode)mode
                        loading:(FBMediaViewerContentLoaderLoadingBlock)loadingBlock
                     completion:(FBMediaViewerContentLoaderCompletionBlock)completionBlock
                         failed:(FBMediaViewerContentLoaderFailedBlock)failedBlock;

- (void)cancelAllItems;
- (void)cancelWithMediaViewerItem:(id <FBMediaViewerItem>)mediaViewerItem;

@end
