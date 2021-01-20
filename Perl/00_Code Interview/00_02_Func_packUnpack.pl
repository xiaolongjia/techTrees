#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;
use IO::Handle;


函数名 pack 
调用语法 formatstr = pack(packformat, list); 
解说 把一个列表或数组以在实际机器存贮格式或C等编程语言使用的格式转化（包装）到一个简单变量中。参数packformat包含一个或多个格式字符，列表中每个元素对应一个，各格式字符间可用空格或tab隔开，因为pack忽略空格。
  除了格式a、A和@外，重复使用一种格式多次可在其后加个整数，如：
   $twoints = pack ("i2", 103, 241);
  把同一格式应用于所有的元素则加个*号，如：
   $manyints = pack ("i*", 14, 26, 11, 83);
  对于a和A而言，其后的整数表示要创建的字符串长度，重复方法如下：
   $strings = pack ("a6" x 2, "test1", "test2");
  格式@的情况比较特殊，其后必须加个整数，该数表示字符串必须的长度，如果长度不够，则用空字符(null)补足，如：
   $output = pack ("a @6 a", "test", "test2");
  pack函数最常见的用途是创建可与C程序交互的数据，例如C语言中字符串均以空字符(null)结尾，创建这样的数据可以这样做：
   $Cstring = pack ("ax", $mystring);
  下表是一些格式字符与C中数据类型的等价关系：

字符    等价C数据类型 
C char 
d double 
f float 
i int 
I unsigned int (or unsigned) 
l long 
L unsigned long 
s short 
S unsigned short 

  完整的格式字符见下表。  


格式字符    描述 
a 用空字符(null)补足的字符串 
A 用空格补足的字符串 
b 位串，低位在前 
B 位串，高位在前 
c 带符号字符（通常-128~127） 
C 无符号字符（通常8位） 
d 双精度浮点数 
f 单精度浮点数 
h 十六进制数串，低位在前 
H 十六进制数串，高位在前 
i 带符号整数 
I 无符号整数 
l 带符号长整数 
L 无符号长整数 
n 网络序短整数 
N 网络序长整数 
p 字符串指针 
s 带符号短整数 
S 无符号短整数 
u 转化成uuencode格式 
v VAX序短整数 
V VAX序长整数 
x 一个空字节 
X 回退一个字节 
@ 以空字节(null)填充 


函数名 unpack 
调用语法 @list = unpack (packformat, formatstr); 
解说 unpack与pack功能相反，将以机器格式存贮的值转化成Perl中值的列表。其格式字符与pack基本相同（即上表），不同的有：A格式将机器格式字符串转化为Perl字符串并去掉尾部所有空格或空字符；x为跳过一个字节；@为跳过一些字节到指定的位置，如@4为跳过4个字节。下面看一个@和X合同的例子：    $longrightint = unpack ("@* X4 L", $packstring);
  此语句将最后四个字节看作无符号长整数进行转化。下面看一个对uuencode文件解码的例子：

1 : #!/usr/local/bin/perl
2 : 
3 : open (CODEDFILE, "/u/janedoe/codefile") ||
4 : die ("Can't open input file");
5 : open (OUTFILE, ">outfile") ||
6 : die ("Can't open output file");
7 : while ($line = <CODEDFILE>) {
8 : $decoded = unpack("u", $line);
9 : print OUTFILE ($decoded);
10: }
11: close (OUTFILE);
12: close (CODEDFILE); 
  当将pack和unpack用于uuencode时，要记住，虽然它们与UNIX中的uuencode、uudecode工具算法相同，但并不提供首行和末行，如果想用uudecode对由pack的输出创建的文件进行解码，必须也把首行和末行输出（详见UNIX中uuencode帮助）。
 
