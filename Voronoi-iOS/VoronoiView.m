//
//  VoronoiView.m
//  Voronoi-iOS
//
//  Created by Ethan Mick on 3/3/13.
//  Copyright (c) 2013 Ethan Mick. All rights reserved.
//

#import "VoronoiView.h"
#import "Cell.h"
#import "Halfedge.h"
#import "Edge.h"
#import "Site.h"
#import "Vertex.h"

@implementation VoronoiView
@synthesize sites, cells, dijkstraPathPoints;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void)drawRect:(CGRect)dirtyRect
{
    //    [NSGraphicsContext saveGraphicsState];
    //    UIGraphicsGetCurrentContext();
    
    // Fill the background white
    [[UIColor whiteColor] set];
    [UIBezierPath bezierPathWithRect:[self bounds]];
    
    
    [[UIColor redColor] set];
    
    for (NSValue *v in sites) {
        UIBezierPath *p = [[UIBezierPath alloc] init];
        [p addArcWithCenter:[v CGPointValue] radius:0.8 startAngle:0 endAngle:360 clockwise:YES];
        [p fill];
        
    }
    
    [[UIColor blackColor] set];
    
    for (Cell *c in cells) {
        for (Halfedge *he in [c halfedges]) {
            CGPoint p1 = [[[he edge] va] coord];
            CGPoint p2 = [[[he edge] vb] coord];
            UIBezierPath *p = [[UIBezierPath alloc] init];
            [p setLineWidth:0.3];
            [p moveToPoint:p1];
            [p addLineToPoint:p2];
            [p stroke];
        }
    }
    
    // Draw Dijkstra path
    [[UIColor redColor] set];
    
    UIBezierPath *dij = [[UIBezierPath alloc] init];
    [dij setLineWidth:2];
    [dij moveToPoint:[[dijkstraPathPoints objectAtIndex:0] CGPointValue]];
    
    for (int i = 1; i < [dijkstraPathPoints count]; i++) {
        CGPoint p = [[dijkstraPathPoints objectAtIndex:i] CGPointValue];
        [dij addLineToPoint:p];
    }
    
    [dij stroke];
    
}


@end
