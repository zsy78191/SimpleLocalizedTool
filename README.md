# SimpleLocalizedTool

本地化自动摘取工具。

##使用方法

脱取文件进入拖放区域，自动在文件目录中生成Localizable.strings文件和其他对应的本地化文件。

支持的文件格式是 .m 和  .mm文件，支持的语法格式是

```
NSString* a = NSLocalizedString(@"这是一个测试", nil);
NSString* b = NSLocalizedString(@"第一条是普通本地化, 翻译写入Localizable.strings文件", nil);
NSString* c = NSLocalizedString(@"第二条是带注释的语句", @"这里是这条本地化语句的注释");
NSString* d = NSLocalizedStringFromTable(@"第三条是带表名的本地化语句，写在 XXX(表名).strings文件里", @"OtherFile",nil);
NSString* e = NSLocalizedStringFromTable( @"最后一条测试书写规范，空格，特殊符号(\"{@#$)等等"  ,   @"OtherFile"  ,   nil);
```

##生成的文件

```
//Localizable.strings

"这是一个测试" = "这是一个测试";
"第一条是普通本地化, 翻译写入Localizable.strings文件" = "第一条是普通本地化, 翻译写入Localizable.strings文件";
"第二条是带注释的语句" = "第二条是带注释的语句";


//OtherFile.strings

"第三条是带表名的本地化语句，写在 XXX(表名).strings文件里" = "第三条是带表名的本地化语句，写在 XXX(表名).strings文件里";
"最后一条测试书写规范，空格，特殊符号(\"{@#$)等等" = "最后一条测试书写规范，空格，特殊符号(\"{@#$)等等";
```


![](https://raw.githubusercontent.com/zsy78191/SimpleLocalizedTool/master/screen%20shot%201.png)

![](https://raw.githubusercontent.com/zsy78191/SimpleLocalizedTool/master/screen%20shot%202.png)

