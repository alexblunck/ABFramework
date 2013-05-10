//
//  ABViewSelectionProtocol.h
//  ABFramework
//
//  Created by Alexander Blunck on 4/21/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

@protocol ABViewSelectionProtocol <NSObject>

@required
//Save the default / original values in iVars here
-(void) defaultStyle;

//Use either the iVar values (default) or selected values
-(void) setSelectedStyle:(BOOL)selected;

@end