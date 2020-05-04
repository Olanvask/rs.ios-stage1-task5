#import "Converter.h"

// Do not change
NSString *KeyPhoneNumber = @"phoneNumber";
NSString *KeyCountry = @"country";

@implementation PNConverter
-(NSArray *)checkCountry: (NSString *) string{
    NSDictionary * dicCountries = [NSDictionary new];
    NSDictionary *lengthsOfCodes = [NSDictionary new];
    
    dicCountries = @{ @"373":@[@"MD",@8],
                      @"374":@[@"AM",@8],
                      @"375":@[@"BY",@9],
                      @"380":@[@"UA",@9],
                      @"992":@[@"TJ",@9],
                      @"993":@[@"TM",@8],
                      @"994":@[@"AZ",@9],
                      @"996":@[@"KG",@9],
                      @"998":@[@"UZ",@9]
                      
    };
    if ([string length] > 0) {
        if ([[string substringWithRange:NSMakeRange(0, 1)]  isEqual: @"7"]) {
            if ([string length]>1) {
                if ([[string substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"7"])  {
                    return @[@"KZ",@10];
                }else{
                    return @[@"RU",@10];
                }
            }else{
                return @[@"RU",@10];
            }
        }else{
            if ([string length]>2) {
                if (!(dicCountries[[string substringWithRange:NSMakeRange(0, 3)]] == nil)) {
                    return @[dicCountries[[string substringWithRange:NSMakeRange(0, 3)]][0],dicCountries[[string substringWithRange:NSMakeRange(0, 3)]][1]];
                }
            }else{
                return @[@"",@0];
            };
        }
    }else{
        return @[@"",@0];
    }
    return @[@"",@0];
    
    
    
}
-(NSString *) prepareNumber: (NSString *) phoneNumber from: (NSArray *) countryArray{
    NSInteger numberLength;
    BOOL rukz = NO;
    BOOL otherCountry = NO;
    
    NSMutableString *tempstring = [NSMutableString new];
    
    
    if ([countryArray[1] isEqual:@10]) {
        numberLength = [countryArray[1] intValue] + 1;
        rukz = YES;
    }else if (([countryArray[1] intValue] >= 8) && ([countryArray[1] intValue] < 10)) {
        numberLength = [countryArray[1] intValue] + 3;
        otherCountry = YES;
    }else{
        numberLength = 12;
        
    }
    if (!([[phoneNumber substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"])){
        [tempstring appendString:@"+"];
        
    }else{
        numberLength ++;
    }
    
    for (int i = 0; (i < numberLength) && (i < [phoneNumber length]); i++) {
        
        switch (i) {
         /*   case 0:
                if ([[phoneNumber substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"]) {
                    break;
                
                }*/
            case 1:
                
                if (rukz) {
                    [tempstring appendString:@" ("];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }else{
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                    
                }
                break;
            case 3:
                if (otherCountry){
                    [tempstring appendString:@" ("];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }else{
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }
                break;
            case 4:
                if (otherCountry){
                    //      [tempstring appendString:@") "];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                    //     [tempstring appendString:@") "];
                    
                }else if (rukz) {
                    [tempstring appendString:@") "];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }else{
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }
                break;
            case 5:
                if (otherCountry){
                    [tempstring appendString:@") "];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }else{
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }
                break;
            case 7:
                if (rukz){
                    [tempstring appendString:@"-"];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                                                    
                }else{
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                    
                }
                    break;
            case 8:
                if (otherCountry){
                    [tempstring appendString:@"-"];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                    
                }else{
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                    
                }
                break;
                case 9:
                if (rukz) {
                    [tempstring appendString:@"-"];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }else{
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                    
                }
                break;
                case 10:
                if ((otherCountry) && ([countryArray[1] intValue] != 8)) {
                    [tempstring appendString:@"-"];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }else{
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                    
                }
                break;
                case 11:
                if (rukz) {
                    [tempstring appendString:@"-"];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }else{
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                    
                }
                break;
            default:
                [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                break;
        }
        
        
        
        
    }
    
    return tempstring;
}
- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string; {
    // good luck
    NSArray * array = [NSArray new];
    NSString *tempString = [NSString new];
    if ([string length] == 0) {
        return @{KeyPhoneNumber:@"",
                 KeyCountry:@"" };
        
    }
    array = [self checkCountry:string];
    
    tempString = [self prepareNumber:string from:array];
    return @{KeyPhoneNumber: [self prepareNumber:string from:[self checkCountry:string]],
             KeyCountry: [self checkCountry:string][0]};
}
@end
