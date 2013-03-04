//
//  ViewController.h
//  Voronoi-iOS
//
//  Created by Ethan Mick on 3/3/13.
//  Copyright (c) 2013 Ethan Mick. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Voronoi;
@class VoronoiResult;
@class VoronoiView;

@interface ViewController : UIViewController {

    Voronoi *voronoi;
    VoronoiResult *activeResult;
    IBOutlet VoronoiView *voronoiview;
    IBOutlet UITextField *numSitesEntry;
    IBOutlet UITextField *marginEntry;
    IBOutlet UIButton *drawButton;
    IBOutlet UIButton *relaxButton;

    NSMutableArray *randomPoints;
    float xMax;
    float yMax;
}

@property (assign, readwrite) float xMax;
@property (assign, readwrite) float yMax;

- (IBAction)relaxWithLloyd:(id)sender;

- (void)calculateVoronoi;

- (IBAction)newVoronoi:(id)sender;
- (void)newVoronoiWithNewSites:(NSMutableArray *)newSites;

@end
