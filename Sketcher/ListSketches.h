//
//  ListSketches.h
//  Sketcher
//
//  Created by Sanjay Shekhawat on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListSketches : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *list;
    NSURLConnection *_connection;
    NSXMLParser *xmlParser;
    NSMutableData *webData;
}


@end
