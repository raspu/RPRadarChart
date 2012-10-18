//
//  ViewController.m
//  RadarChart
//
//  Created by Juan Pablo Illanes Sotta on 06-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
{
    NSArray *colors;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    rc = [[RPRadarChart alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
    rc.backgroundColor = [UIColor whiteColor];
    
    colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor blueColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor greenColor], nil];
    
    rc.dataSource = self;
    rc.delegate = self;
    
    [self.view addSubview:rc];
}

-(IBAction)blue:(UIButton *)sender
{
    if([sender.titleLabel.text  isEqualToString:@"BLUE"])
    {
        rc.lineColor = [UIColor blueColor];
        rc.fillColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.2];
        rc.dotColor = [UIColor blueColor];
        [sender setTitle:@"RED" forState:UIControlStateNormal];
    }else {
        rc.lineColor = [UIColor redColor];
        rc.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
        rc.dotColor = [UIColor redColor];
        [sender setTitle:@"BLUE" forState:UIControlStateNormal];

    }
}
-(IBAction)V1:(id)sender
{
    rc.backLineWidth = 0.5f;
    rc.frontLineWidth = 1.5f;
    rc.dotRadius = 3;
}
-(IBAction)V2:(id)sender
{
    rc.backLineWidth = 1.5f;
    rc.frontLineWidth = 2.0f;
    rc.dotRadius = 4.5;
}
-(IBAction)showValues:(id)sender
{
    rc.showValues = !rc.showValues;
}

-(IBAction)GuideNumbers:(id)sender
{
    rc.showGuideNumbers = !rc.showGuideNumbers;
}

-(IBAction)GuideLines:(id)sender
{
    rc.drawGuideLines = !rc.drawGuideLines;
}

-(IBAction)fillArea:(id)sender
{
    rc.fillArea = !rc.fillArea;
}

-(IBAction)Delegate:(UIButton *)sender;
{
    sender.selected = !sender.selected;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark -- data chart data source

// get number of spokes in radar chart
- (NSInteger)numberOfSopkesInRadarChart:(RPRadarChart*)chart
{
    return 5;
}

// get number of datas
- (NSInteger)numberOfDatasInRadarChart:(RPRadarChart*)chart
{
    return 2;
}

// get max value for this radar chart
- (float)maximumValueInRadarChart:(RPRadarChart*)chart
{
    return 5;
}

// get title for each spoke
- (NSString*)radarChart:(RPRadarChart*)chart titleForSpoke:(NSInteger)atIndex
{
    return [NSString stringWithFormat:@"Spoke%d", atIndex];
}

// get data value for a specefic data item for a spoke
- (float)radarChart:(RPRadarChart*)chart valueForData:(NSInteger)dataIndex forSpoke:(NSInteger)spokeIndex
{
    float data1[] = {4, 5, 1, 3, 2};
    float data2[] = {1, 2, 3, 4, 5};
    
    switch (dataIndex) {
        case 0:
            return data1[spokeIndex];
        case 1:
            return data2[spokeIndex];
    }
    
    return 0;
}

// get color legend for a specefic data
- (UIColor*)radarChart:(RPRadarChart*)chart colorForData:(NSInteger)atIndex
{
    return colors[atIndex];
}

#pragma mark -- delegate for chart

- (void)radarChart:(RPRadarChart *)chart lineTouchedForData:(NSInteger)dataIndex atPosition:(CGPoint)point
{
    NSLog(@"Line %d touched at (%f,%f)", dataIndex, point.x, point.y);
}

@end
