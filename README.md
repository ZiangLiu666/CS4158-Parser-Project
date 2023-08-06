# CS4158-Parser-Project
Steps: How to build and run my lexer?
flex lexer.l
gcc lex.yy.c
then run a.exe

Examples:

![image](https://github.com/ZiangLiu666/CS4158-Parser-Project/assets/91567702/5ea68b77-2106-4bc0-8ba9-b15cfa3eabcc)

![image](https://github.com/ZiangLiu666/CS4158-Parser-Project/assets/91567702/991cacf3-aba1-4565-9846-23ac3a468403)

![image](https://github.com/ZiangLiu666/CS4158-Parser-Project/assets/91567702/8efabb64-49ad-41ab-9a56-2169823fe5f6)

![image](https://github.com/ZiangLiu666/CS4158-Parser-Project/assets/91567702/6940efe5-6fc4-42ed-83de-381e16179bd8)

![image](https://github.com/ZiangLiu666/CS4158-Parser-Project/assets/91567702/7aab20ce-6c3c-4dfe-b698-8a546e4179a5)

![image](https://github.com/ZiangLiu666/CS4158-Parser-Project/assets/91567702/12725e2a-362f-49b3-8ea3-1a90a65c519d)

Steps: How to build and run my parser?

1.Download lexer.l and parser.y file then use the following commands in order:
1)flex lexer.l
2)bison -d parser.y
3)gcc lex.yy.c parser.tab.c
4)a.exe

2.Well-formed program:

![image](https://github.com/ZiangLiu666/CS4158-Parser-Project/assets/91567702/74493a1e-9b97-4ef5-947f-1a385f9f0cf3)

3.If a program tried to ‘MOVE 500000 TO _Y’ a warning flag should be raised (as _Y is only declared as ‘SSSS’) :

![image](https://github.com/ZiangLiu666/CS4158-Parser-Project/assets/91567702/d58d63b5-4525-4709-bfa3-e062f122279c)

4. The parser can detect if, when you move a value from an identifier 1 to an identifier 2, identifier 1 is declared to be larger than identifier 2 and issue a warning. (in the example above 'MOVE Z to XY-1' should cause this).

![image](https://github.com/ZiangLiu666/CS4158-Parser-Project/assets/91567702/3b0024b5-5d3c-4022-8b89-0e8095fff518)






