//
//  NSDate+ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 11/3/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//
//  Contains Source Code From:
//  NSDate+ABDates.h
//  Created by Adam Kirk on 4/21/11.
//  Copyright 2011 Mysterious Trousers, LLC. All rights reserved.

#import <Foundation/Foundation.h>

#pragma mark - Custom Types
typedef enum {
	ABDateWeekNumberingSystemUS		= 1, //First week contains January 1st.
	ABDateWeekNumberingSystemISO	= 4, //First week contains January 4th.
} ABDateWeekNumberingSystem;

typedef enum {
	ABDateHourFormat24Hour,
	ABDateHourFormat12Hour
} ABDateHourFormat;


@interface NSDate (ABFramework)

//Global Config
+(void) setLocale:(NSLocale*)locale;
+(void) setTimeZone:(NSTimeZone*)timeZone;
+(void) setFirstDayOfWeek:(NSUInteger)firstDay; // Sunday: 1, Saturday: 7
+(void) setWeekNumberingSystem:(ABDateWeekNumberingSystem)system;


//Contructors
+(NSDate *) dateFromISOString:(NSString*)ISOString;

+(NSDate *) dateFromString:(NSString*)string
               usingFormat:(NSString *)format;

+(NSDate *) dateFromYear:(NSUInteger)year
                   month:(NSUInteger)month
                     day:(NSUInteger)day;

+(NSDate *) dateFromYear:(NSUInteger)year
                   month:(NSUInteger)month
                     day:(NSUInteger)day
                    hour:(NSUInteger)hour
                  minute:(NSUInteger)minute;

+(NSDate *) dateFromYear:(NSUInteger)year
                   month:(NSUInteger)month
                     day:(NSUInteger)day
                    hour:(NSUInteger)hour
                  minute:(NSUInteger)minute
                  second:(NSUInteger)second;

+(NSDate *) dateFromYear:(NSUInteger)year
                    week:(NSUInteger)week
                 weekDay:(NSUInteger)weekDay;

+(NSDate *) dateFromYear:(NSUInteger)year
                    week:(NSUInteger)week
                 weekDay:(NSUInteger)weekDay
                    hour:(NSUInteger)hour
                  minute:(NSUInteger)minute;

+(NSDate *) dateFromYear:(NSUInteger)year
                    week:(NSUInteger)week
                 weekDay:(NSUInteger)weekDay
                    hour:(NSUInteger)hour
                  minute:(NSUInteger)minute
                  second:(NSUInteger)second;

-(NSDate *) dateByAddingYears:(NSInteger)years
                       months:(NSInteger)months
                        weeks:(NSInteger)weeks
                         days:(NSInteger)days
                        hours:(NSInteger)hours
                      minutes:(NSInteger)minutes
                      seconds:(NSInteger)seconds;

+(NSDate *) dateFromComponents:(NSDateComponents *)components;


//Symbols
+(NSArray*) shortWeekdaySymbols;
+(NSArray*) weekdaySymbols;
+(NSArray*) veryShortWeekdaySymbols;
+(NSArray*) shortMonthlySymbols;
+(NSArray*) monthlySymbols;
+(NSArray*) veryShortMonthlySymbols;


//Components
-(NSUInteger) year;
-(NSUInteger) weekOfYear;
-(NSUInteger) weekDayOfWeek;
-(NSUInteger) monthOfYear;
-(NSUInteger) dayOfMonth;
-(NSUInteger) hourOfDay;
-(NSUInteger) minuteOfHour;
-(NSUInteger) secondOfMinute;
-(NSTimeInterval) secondsIntoDay;
-(NSDateComponents*) components;


//Relatives
+(ABDateDescriptor*) smallestDateDescriptorUntil:(NSDate*)date;


//Years
-(NSDate*) startOfPreviousYear;
-(NSDate*) startOfCurrentYear;
-(NSDate*) startOfNextYear;

-(NSDate*) endOfPreviousYear;
-(NSDate*) endOfCurrentYear;
-(NSDate*) endOfNextYear;

-(NSDate*) oneYearPrevious;
-(NSDate*) oneYearNext;

-(NSDate*) dateYearsBefore:(NSUInteger)years;
-(NSDate*) dateYearsAfter:(NSUInteger)years;

-(NSInteger) yearsSinceDate:(NSDate*)date;
-(NSInteger) yearsUntilDate:(NSDate*)date;


//Months
-(NSDate*) startOfPreviousMonth;
-(NSDate*) startOfCurrentMonth;
-(NSDate*) startOfNextMonth;

-(NSDate*) endOfPreviousMonth;
-(NSDate*) endOfCurrentMonth;
-(NSDate*) endOfNextMonth;

-(NSDate*) oneMonthPrevious;
-(NSDate*) oneMonthNext;

-(NSDate*) dateMonthsBefore:(NSUInteger)months;
-(NSDate*) dateMonthsAfter:(NSUInteger)months;

-(NSInteger) monthsSinceDate:(NSDate*)date;
-(NSInteger) monthsUntilDate:(NSDate*)date;


//Weeks
-(NSDate*) startOfPreviousWeek;
-(NSDate*) startOfCurrentWeek;
-(NSDate*) startOfNextWeek;

-(NSDate*) endOfPreviousWeek;
-(NSDate*) endOfCurrentWeek;
-(NSDate*) endOfNextWeek;

-(NSDate*) oneWeekPrevious;
-(NSDate*) oneWeekNext;

-(NSDate*) dateWeeksBefore:(NSUInteger)weeks;
-(NSDate*) dateWeeksAfter:(NSUInteger)weeks;

-(NSInteger) weeksSinceDate:(NSDate*)date;
-(NSInteger) weeksUntilDate:(NSDate*)date;

//Days
-(NSDate*) startOfPreviousDay;
-(NSDate*) startOfCurrentDay;
-(NSDate*) startOfNextDay;

-(NSDate*) endOfPreviousDay;
-(NSDate*) endOfCurrentDay;
-(NSDate*) endOfNextDay;

-(NSDate*) oneDayPrevious;
-(NSDate*) oneDayNext;

-(NSDate*) dateDaysBefore:(NSUInteger)days;
-(NSDate*) dateDaysAfter:(NSUInteger)days;

-(NSInteger) daysSinceDate:(NSDate*)date;
-(NSInteger) daysUntilDate:(NSDate*)date;


//Hours
-(NSDate*) startOfPreviousHour;
-(NSDate*) startOfCurrentHour;
-(NSDate*) startOfNextHour;

-(NSDate*) endOfPreviousHour;
-(NSDate*) endOfCurrentHour;
-(NSDate*) endOfNextHour;

-(NSDate*) oneHourPrevious;
-(NSDate*) oneHourNext;

-(NSDate*) dateHoursBefore:(NSUInteger)hours;
-(NSDate*) dateHoursAfter:(NSUInteger)hours;

-(NSInteger) hoursSinceDate:(NSDate*)date;
-(NSInteger) hoursUntilDate:(NSDate*)date;


//Minutes
-(NSInteger) minutesUntilDate:(NSDate*)date;
-(NSDate*) dateMinutesBefore:(NSUInteger)minutes;


//Seconds
-(NSInteger) secondsUntilDate:(NSDate*)date;


//Compares
-(BOOL) isAfter:(NSDate*)date;
-(BOOL) isBefore:(NSDate*)date;
-(BOOL) isOnOrAfter:(NSDate*)date;
-(BOOL) isOnOrBefore:(NSDate*)date;
-(BOOL) isWithinSameYear:(NSDate*)date;
-(BOOL) isWithinSameMonth:(NSDate*)date;
-(BOOL) isWithinSameWeek:(NSDate*)date;
-(BOOL) isWithinSameDay:(NSDate*)date;
-(BOOL) isWithinSameHour:(NSDate*)date;
-(BOOL) isBetweenDate:(NSDate*)date1 andDate:(NSDate*)date2;


//Strings
-(NSString*) stringFromDateWithHourAndMinuteFormat:(ABDateHourFormat)format;
-(NSString*) stringFromDateWithShortMonth;
-(NSString*) stringFromDateWithFullMonth;
-(NSString*) stringFromDateWithAMPMSymbol;
-(NSString*) stringFromDateWithShortWeekdayTitle;
-(NSString*) stringFromDateWithFullWeekdayTitle;
-(NSString*) stringFromDateWithFormat:(NSString*)format;	//http://unicode.org/reports/tr35/tr35-10.html#Date_Format_Patterns
-(NSString*) stringFromDateWithISODateTime;
-(NSString*) stringFromDateWithGreatestComponentsForSecondsPassed:(NSTimeInterval)interval;


//Unix
+(NSNumber*) unixTimestampForDate:(NSDate*)date;
+(NSNumber*) unixTimestampForCurrentDate;


//Misc
-(NSDate*) midnight;
+(NSDate*) localDateForDate:(NSDate*)date;
+(NSArray*) datesCollectionFromDate:(NSDate*)startDate untilDate:(NSDate*)endDate;
-(NSArray*) hoursInCurrentDayAsDatesCollection;
-(BOOL) isInAM;
-(BOOL) isStartOfAnHour;
-(NSUInteger) weekdayStartOfCurrentMonth;
-(NSUInteger) daysInCurrentMonth;
-(NSUInteger) daysInPreviousMonth;
-(NSUInteger) daysInNextMonth;

@end

//Common Date Formats
//For use with stringFromDateWithFormat:
extern NSString *const ABDatesFormatDefault;			// Sat Jun 09 2007 17:46:21
extern NSString *const ABDatesFormatShortDate;			// 6/9/07
extern NSString *const ABDatesFormatMediumDate;			// Jun 9, 2007
extern NSString *const ABDatesFormatLongDate;			// June 9, 2007
extern NSString *const ABDatesFormatFullDate;			// Saturday, June 9, 2007
extern NSString *const ABDatesFormatShortTime;			// 5:46 PM
extern NSString *const ABDatesFormatMediuABime;			// 5:46:21 PM
extern NSString *const ABDatesFormatLongTime;			// 5:46:21 PM EST
extern NSString *const ABDatesFormatISODate;			// 2007-06-09
extern NSString *const ABDatesFormatISOTime;			// 17:46:21
extern NSString *const ABDatesFormatISODateTime;		// 2007-06-09T17:46:21
