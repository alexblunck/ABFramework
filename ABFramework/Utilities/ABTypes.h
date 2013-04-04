//
//  ABTypes.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/10/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

/*
 BLOCKS
 */
typedef void (^ABBlockVoid) ();
typedef void (^ABBlockObject) (id);
typedef void (^ABBlockBool) (BOOL);
typedef void (^ABBlockInteger) (NSInteger);
typedef void (^ABBlockString) (NSString *);

/*
 ENUMS
 */
typedef enum {
    ABShadowTypeNone,
    ABShadowTypeHard,
    ABShadowTypeSoft,
    ABShadowTypeLetterpress
} ABShadowType;
