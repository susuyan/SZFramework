//
//  SZLog.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#ifndef SZFramework_SZLog_h
#define SZFramework_SZLog_h

#define SZLog(fmt, ...) \
do { \
NSString *___FILENAME___ = [[[NSString stringWithCString:__FILE__ \
                                                encoding:NSUTF8StringEncoding] \
                                                componentsSeparatedByString:@"/"] lastObject]; \
                                                NSLog((@\
                                                "\n┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"\
                                                "文件:    %@\n" \
                                                "方法:    %s\n" \
                                                "行数:    %d\n" \
                                                "信息:    \n" fmt \
                                                "\n┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"), \
                                                ___FILENAME___, \
                                                __FUNCTION__, \
                                                __LINE__, \
                                                ##__VA_ARGS__);\
                                                } while(0);\

#define dVarName(name) (#name)

#define SZLogs(info) SZLog(@"%@",info)

#define StartLog SZLogs(@"+++++++METHOD START+++++++")
#define ___start_log___ SZLogs(@"+++++++METHOD START+++++++")

#define SZLogi1(info,var1) SZLog(@"%@ -> [I]%s = %d",info,dVarName(var1), var1)
#define SZLogi2(info,var1,var2) SZLog(@"%@ -> [I]%s = %d [I]%s = %d",info,dVarName(var1), var1,dVarName(var2), var2)
#define SZLogi3(info,var1,var2,var3) SZLog(@"%@ -> [I]%s = %d [I]%s = %d [I]%s = %d",info,dVarName(var1), var1,dVarName(var2), var2,dVarName(var3), var3)
#define SZLogi4(info,var1,var2,var3,var4) SZLog(@"%@ -> [I]%s = %d [I]%s = %d [I]%s = %d [I]%s = %d",info,dVarName(var1), var1,dVarName(var2), var2,dVarName(var3), var3,dVarName(var4), var4)

#define SZLogl1(info,var1) SZLog(@"%@ -> [L]%s = %ld",info,dVarName(var1), var1)
#define SZLogl2(info,var1,var2) SZLog(@"%@ -> [L]%s = %ld [L]%s = %ld",info,dVarName(var1), var1,dVarName(var2), var2)
#define SZLogl3(info,var1,var2,var3) SZLog(@"%@ -> [L]%s = %ld [L]%s = %ld [L]%s = %ld",info,dVarName(var1), var1,dVarName(var2), var2,dVarName(var3), var3)
#define SZLogl4(info,var1,var2,var3,var4) SZLog(@"%@ -> [L]%s = %ld [L]%s = %ld [L]%s = %ld [L]%s = %ld",info,dVarName(var1), var1,dVarName(var2), var2,dVarName(var3), var3,dVarName(var4), var4)

#define SZLogf1(info,var1) SZLog(@"%@ -> [F]%s = %f",info,dVarName(var1), var1)
#define SZLogf2(info,var1,var2) SZLog(@"%@ -> [F]%s = %f [F]%s = %f",info,dVarName(var1), var1,dVarName(var2), var2)
#define SZLogf3(info,var1,var2,var3) SZLog(@"%@ -> [F]%s = %f [F]%s = %f [F]%s = %f",info,dVarName(var1), var1,dVarName(var2), var2,dVarName(var3), var3)
#define SZLogf4(info,var1,var2,var3,var4) SZLog(@"%@ -> [F]%s = %f [F]%s = %f [F]%s = %f [F]%s = %f",info,dVarName(var1), var1,dVarName(var2), var2,dVarName(var3), var3,dVarName(var4), var4)

#define SZLogo1(info,var1) SZLog(@"%@ -> [O]%s = %@",info,dVarName(var1), var1)
#define SZLogo2(info,var1,var2) SZLog(@"%@ -> [O]%s = %@ [O]%s = %@",info,dVarName(var1), var1,dVarName(var2), var2)
#define SZLogo3(info,var1,var2,var3) SZLog(@"%@ -> [O]%s = %@ [O]%s = %@ [O]%s = %@",info,dVarName(var1), var1,dVarName(var2), var2,dVarName(var3), var3)
#define SZLogo4(info,var1,var2,var3,var4) SZLog(@"%@ -> [O]%s = %@ [O]%s = %@ [O]%s = %@ [O]%s = %@",info,dVarName(var1), var1,dVarName(var2), var2,dVarName(var3), var3,dVarName(var4), var4)

#define SZLoge(info,var1) SZLog(@"【Exception:】%s = %@ | %@",dVarName(var1), var1,info)

#else

//自定义格式化打印
#define SZLog(...);

//打印变量名称
#define dVarName(...);

//打印普通文本字符串
#define SZLogs(...);

//打印整数
#define SZLogi1(...);
#define SZLogi2(...);
#define SZLogi3(...);
#define SZLogi4(...);

//打印长整数
#define SZLogl1(...);
#define SZLogl2(...);
#define SZLogl3(...);
#define SZLogl4(...);

//打印浮点数
#define SZLogf1(...);
#define SZLogf2(...);
#define SZLogf3(...);
#define SZLogf4(...);

//打印对象
#define SZLogo1(...);
#define SZLogo2(...);
#define SZLogo3(...);
#define SZLogo4(...);

//打印错误日志
#define SZLoge(...);

#endif
