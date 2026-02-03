#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
#include "snail.h"

int main(int c,char**v){FILE*f=fopen(v[1],"rb");fseek(f,0,2);int n=ftell(f);rewind(f);s=malloc(n+1);fread(s,1,n,f);s[n]=0;fclose(f);q=0;nt();A*h=NULL,**p=&h;if(is('{'))h=K();else while(!is(Q)){*p=S();p=&(*p)->n;}H*g=ne(NULL);df(g,"outn",(V){0,(A*)1,0});blk(h,g);return 0;}
