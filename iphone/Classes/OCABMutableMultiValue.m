//
//  OCABMutableMultiValue.m
//  PhoneGap
//
//  Created by shazron on 29/05/09.
//  Copyright 2009 Atimi Software Inc.. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import "OCCFObject.h"
#import "OCABMutableMultiValue.h"

@implementation OCABMutableMultiValue

- (ABMutableMultiValueRef) ABMutableMultiValueRef
{
	return (ABMutableMultiValueRef)__baseRef;
}

- (CFIndex) count
{
	return ABMultiValueGetCount([self ABMutableMultiValueRef]);
}

- (NSString*) labelAt:(CFIndex)index
{
	return [(id)ABMultiValueCopyLabelAtIndex([self ABMutableMultiValueRef], index) autorelease];
}

- (NSString*) localizedLabelAt:(CFIndex)index
{
	return [(id)ABAddressBookCopyLocalizedLabel((CFStringRef)[self labelAt:index]) autorelease];
}

- (NSString*) valueAt:(CFIndex)index
{
	return [(id)ABMultiValueCopyValueAtIndex([self ABMutableMultiValueRef], index) autorelease];
}

- (NSString*) JSONValue
{
	NSMutableString* json =  [[[NSMutableString alloc] initWithString:@"{"] autorelease];
	NSString* pair = nil;
	CFIndex count = [self count];
	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init]; 
	for (CFIndex i = 0; i < count; i++)
	{
		pair = [[[NSString alloc] initWithFormat:@"%@:'%@'", [self localizedLabelAt:i], [self valueAt:i]] autorelease];
		[json appendString:pair];
		
		if (i+1 != count) {
			[json appendString:@","];
		}
	}
	[pool release];

	[json appendString:@"}"];
	return json;
}

@end