//
//  FBMediaViewerInnerView.h
//  FBMediaViewer
//
//  Created by Hiroshi Hashiguchi on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBMediaViewerRenderer.h"
#import "FBMediaViewerItemLoader.h"

@protocol FBMediaViewerItem;
@class FBMediaViewerView;

@interface FBMediaViewerInnerView : UIView

// API (Properties)
@property (nonatomic, strong) id <FBMediaViewerItem> mediaViewerItem;
@property (nonatomic, assign, readonly) FBMediaViewerView* mediaViewerView;

// API (Factroies)
- (id)initWithMediaViewerView:(FBMediaViewerView*)view frame:(CGRect)frame;


// API
- (void)loadWithMode:(FBMeditViewerItemLoaderMode)mode;
- (void)cancel;
- (void)willAppear;
- (void)willDisAppear;

@end
