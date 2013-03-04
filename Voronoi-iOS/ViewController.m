//
//  ViewController.m
//  Voronoi-iOS
//
//  Created by Ethan Mick on 3/3/13.
//  Copyright (c) 2013 Ethan Mick. All rights reserved.
//

#import "ViewController.h"
#import "Voronoi.h"
#import "VoronoiResult.h"
#import "VoronoiView.h"
#import "Site.h"
#import "Cell.h"
#import "ClayPathMaker.h"
#import "ClayRelaxer.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize xMax, yMax;

- (id)init
{
    self = [super init];
    if (self) {
        randomPoints = [[NSMutableArray alloc] init];
    }
    return self;
}

- (IBAction)relaxWithLloyd:(id)sender
{
    NSMutableArray *newSites = [ClayRelaxer relaxSitesInCells:[activeResult cells]];
    [self newVoronoiWithNewSites:newSites];
}

- (IBAction)newVoronoi:(id)sender
{
    if (!randomPoints) {
        randomPoints = [[NSMutableArray alloc] init];
    }
    
    [randomPoints removeAllObjects];
    activeResult = nil;
    
    int numSites = [[numSitesEntry text] intValue];
    int margin   = [[marginEntry   text] intValue];
    
    // Send in sites as CGPoints that have been converted to NSValue
    
    xMax = [voronoiview bounds].size.width;
    yMax = [voronoiview bounds].size.height;
    
    for (int i = 0; i < numSites; i++) {
        float x = margin + (arc4random() % ((int)xMax - margin*2));
        float y = margin + (arc4random() % ((int)yMax - margin*2));
        NSValue *v = [NSValue valueWithCGPoint:CGPointMake(x, y)];
        [randomPoints addObject:v];
    }
    
    [self calculateVoronoi];
}

- (void)newVoronoiWithNewSites:(NSMutableArray *)newSites
{
    // Clear the old
    [randomPoints removeAllObjects];
    randomPoints = nil;
    activeResult = nil;
    
    // Set the new points
    randomPoints = newSites;
    
    // Calculate the diagram
    [self calculateVoronoi];
}

- (void)calculateVoronoi
{
    
    voronoi = [[Voronoi alloc] init];
    activeResult = [voronoi computeWithSites:randomPoints andBoundingBox:[voronoiview bounds]];
    
    NSMutableArray *sitesFromCells = [[NSMutableArray alloc] init];
    
    for (Cell *c in [activeResult cells]) {
        Site *s = [c site];
        [sitesFromCells addObject:[s coordAsValue]];
    }
    
    [voronoiview setSites:sitesFromCells];
    [voronoiview setCells:[activeResult cells]];
    
    if ([randomPoints count] > 4) {
        
        NSValue *start = [NSValue valueWithCGPoint:CGPointMake(0, yMax * 0.5)];
        NSValue *end   = [NSValue valueWithCGPoint:CGPointMake(xMax, yMax * 0.5)];
        NSValue *midPoint = [NSValue valueWithCGPoint:CGPointMake(xMax * 0.33, 0)];
        NSValue *midPoint2 = [NSValue valueWithCGPoint:CGPointMake(xMax * 0.66, yMax)];
        
        NSMutableArray *pathNodes = [[NSMutableArray alloc] init];
        [pathNodes addObject:start];
        [pathNodes addObject:midPoint];
        [pathNodes addObject:midPoint2];
        [pathNodes addObject:end];
        
        ClayPathMaker *dij = [[ClayPathMaker alloc] initWithEdges:[activeResult edges]
                                                     nodesForPath:pathNodes
                                                        andBounds:[voronoiview bounds]];
        [voronoiview setDijkstraPathPoints:[dij pathNodes]];
    } else {
        [voronoiview setDijkstraPathPoints:nil];
    }
    
    [voronoiview setNeedsDisplay];
    
    [relaxButton setEnabled:YES];
    
}


@end
