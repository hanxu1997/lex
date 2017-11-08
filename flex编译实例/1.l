%{
int wordCount = 0;
int whiteCount = 0;
int numCount = 0;
%}
letter [a-zA-Z]
letters {letter}+
numbers ([0-9])+
whitespaces ([\t\n ])+
%%
{letters} {wordCount++;}   //当匹配letters的正则表达式时执行的动作，一般动作都是结合yacc并返回给语法分析器一个词法单元和属性值，此处把lex作为一个独立的工具使用
{numbers} {numCount++;}
{whitespaces} {whiteCount++;}
%%
void main()
{
	yylex();  //开始解析语句,内置函数
	printf("单词数：%d\n",wordCount);
	printf("空白数：%d\n",whiteCount);
	printf("数字数：%d\n",numCount);
}
int yywrap()
{
	return 1;
}