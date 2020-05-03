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
            };
        }
    }else{
        return @[@"",@""];
    }
    return nil;
    
    
    
}
-(NSString *) prepareNumber: (NSString *) phoneNumber from: (NSArray *) countryArray{
    NSMutableString *tempstring = [NSMutableString new];
    [tempstring appendString:@"+"];
    for (int i = 0; i < [phoneNumber length]; i++) {
        if (i == 1){
            if ([countryArray[1] isEqual: @10]){
                [tempstring appendString:@" ("];
                [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
            }else{
                [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];            }
        }else{
            if (i == 3) {
                
                if (([countryArray[1] intValue] >= 8) && ( [countryArray[1] intValue] < 10)){
                    [tempstring appendString:@" ("];
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }else{
                    [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                }
                
            }else{
                if (i == 4) {
                    if (([countryArray[1] intValue] >= 8) && ( [countryArray[1] intValue] < 10)){
                  //      [tempstring appendString:@") "];
                        [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                        [tempstring appendString:@") "];
                        
                    }else if ([countryArray[1] isEqual: @10]) {
                        [tempstring appendString:@") "];
                        [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                    }else{
                        [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                    }
                }else {
                    if (i == 7) {
                        if (([countryArray[1] intValue] >= 8) && ( [countryArray[1] intValue] < 10)) {
                        //      [tempstring appendString:@") "];
                              [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                              [tempstring appendString:@"-"];
                              
                          }else if ([countryArray[1] isEqual: @10]) {
                              [tempstring appendString:@"-"];
                              [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                          }else{
                              [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                          }
                    }else{
                        if (i == 9){
                            if (([countryArray[1] intValue] > 8) && ( [countryArray[1] intValue] < 10)){
                            //      [tempstring appendString:@") "];
                                  [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                                  [tempstring appendString:@"-"];
                                  
                              }else if ([countryArray[1] isEqual: @10]) {
                                  [tempstring appendString:@"-"];
                                  [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                              }else{
                                  [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];
                              }
                            
                        }else{
                            [tempstring appendString:[phoneNumber substringWithRange:NSMakeRange(i, 1)]];                        }
                    }
                }
            }
            
        }
        
    }
    
    return tempstring;
}
- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string; {
    // good luck
    NSArray * array = [NSArray new];
    NSString *tempString = [NSString new];
    array = [self checkCountry:string];
    tempString = [self prepareNumber:string from:array];
    return @{KeyPhoneNumber: [self prepareNumber:string from:[self checkCountry:string]],
             KeyCountry: [self checkCountry:string][0]};
}
@end
