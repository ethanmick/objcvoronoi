//
//  CircleEvent.m
//  objcvoronoi
//

#import "CircleEvent.h"
#import "Beachsection.h"
#import "Site.h"

@implementation CircleEvent
@synthesize rbNext, rbPrevious, rbParent, rbRight, rbLeft, rbRed, arc, site, ycenter;



- (void)setCoord:(CGPoint)tempCoord
{
    coord = tempCoord;
}

- (CGPoint)coord
{
    return coord;
}

- (void)setCoordAsValue:(NSValue *)valueWithCoord
{
    coord = [valueWithCoord CGPointValue];
}

- (NSValue *)coordAsValue
{
    return [NSValue valueWithCGPoint:coord];
}

- (void)setX:(float)tempX
{
    [self setCoord:CGPointMake(tempX, coord.y)];
}

- (float)x
{
    return coord.x;
}

- (void)setY:(float)tempY
{
    [self setCoord:CGPointMake(coord.x, tempY)];
}

- (float)y
{
    return coord.y;
}

@end
