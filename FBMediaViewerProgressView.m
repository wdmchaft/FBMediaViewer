//
//  FBMediaViewerProgressView.m
//  FBMediaViewerProgressView
//
//  Created by Hiroshi Hashiguchi on 11/03/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FBMediaViewerProgressView.h"

@interface FBMediaViewerProgressView()
@property (nonatomic, strong) UIColor* color;
@property (nonatomic, assign) BOOL started;
@property (nonatomic, strong) UIBezierPath* outlinePath;
@end

@implementation FBMediaViewerProgressView

@synthesize color = color_;
@synthesize lineWidth = lineWidth_;
@synthesize progressViewStyle = progressViewStyle_;
@synthesize progress = progress_;
@synthesize hidesUntilStart = hidesUntilStart_;
@synthesize started;
@synthesize outlinePath;

#pragma mark -
#pragma mark Private Services
- (void)_createOutlinePath
{
    self.outlinePath = [UIBezierPath bezierPath];

    CGSize size = self.bounds.size;
    CGFloat unit = size.height/2.0 - self.lineWidth;

    CGPoint c1 = CGPointMake(unit+self.lineWidth, unit+self.lineWidth);
    [self.outlinePath addArcWithCenter:c1
                            radius:unit
                        startAngle:3*M_PI/2 endAngle:M_PI/2
                         clockwise:NO];
    
    [self.outlinePath addLineToPoint:CGPointMake(size.width - c1.x,
                                            size.height - self.lineWidth)];
    CGPoint c2 = CGPointMake(size.width - unit - self.lineWidth,
                             unit+self.lineWidth);
    [self.outlinePath addArcWithCenter:c2
                           radius:unit
                       startAngle:M_PI/2 endAngle:-M_PI/2
                        clockwise:NO];
    
    [self.outlinePath addLineToPoint:CGPointMake(c1.x, self.lineWidth)];
    
    [self.outlinePath setLineWidth:self.lineWidth];
   
}

- (void)_init
{
    self.progressViewStyle = FBMediaViewerProgressViewStyleDefault;
    self.lineWidth = 3.0;
    self.backgroundColor = [UIColor clearColor];
    [self _createOutlinePath];
    
    self.hidesUntilStart = YES;
    self.started = NO;
}


#define MARGIN_UNIT     3.0
- (void)_drawProgressBar
{
    CGFloat margin = self.lineWidth + MARGIN_UNIT;
    CGSize size = self.bounds.size;
    size.width -= margin*2;
    size.height -= margin*2;
    CGFloat unit = size.height/2.0;
    
    CGFloat progressWidth = size.width * self.progress;
    if (progressWidth < unit*2) {
        progressWidth = unit*2;
    }
    
    CGRect barRect = CGRectMake(margin,
                                margin,
                                progressWidth,
                                size.height);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:barRect
                                                    cornerRadius:unit];
    [path fill];
    
}


#pragma mark -
#pragma mark Initialization and deallocation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}


#pragma mark -
#pragma mark UIView

- (void)drawRect:(CGRect)rect
{
    if (!self.hidesUntilStart || self.started) {
        [self.color set];
        [self.outlinePath stroke];

        if (self.progress) {
            [self _drawProgressBar];
        }
    }
}


#pragma mark -
#pragma mark Properties
- (void)setProgressViewStyle:(FBMediaViewerProgressViewStyle)progressViewStyle
{
    progressViewStyle_ = progressViewStyle;

    switch (progressViewStyle) {
        case FBMediaViewerProgressViewStyleGray:
            self.color = [UIColor lightGrayColor];
            break;
            
        case FBMediaViewerProgressViewStyleWhite:
            self.color = [UIColor whiteColor];
            break;
            
        default:
            self.color = [UIColor lightGrayColor];
            break;
    }
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    lineWidth_ = lineWidth;
    [self _createOutlinePath];
}

- (void)setProgress:(CGFloat)progress
{
    if (progress > 1.0) {
        progress = 1.0;
    } else if (progress < 0.0) {
        progress = 0.0;
    }
    progress_ = progress;
    self.started = YES;

    [self setNeedsDisplay];
}

@end
