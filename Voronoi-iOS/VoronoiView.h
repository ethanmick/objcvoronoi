//
//  VoronoiView.h
//  Voronoi-iOS
//
//  Created by Ethan Mick on 3/3/13.
//  Copyright (c) 2013 Ethan Mick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoronoiView : UIView {
    NSMutableArray *sites;
    NSMutableArray *cells;
    NSMutableArray *dijkstraPathPoints;
}

@property (retain, readwrite) NSMutableArray *sites;
@property (retain, readwrite) NSMutableArray *cells;
@property (retain, readwrite) NSMutableArray *dijkstraPathPoints;

@end
