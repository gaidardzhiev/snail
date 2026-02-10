#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
#include "snail.h"

int main(int _,char**__){if (_ < 2) {printf("\x75\x73\x61\x67\x65\x3a\x20\x25\x73\x20\x3c\x73\x63\x72\x69\x70\x74\x2e\x73\x6e\x6c\x3e\n",__[0]);return 1;}FILE*f=fopen(__[1],"rb");fseek(f,0,2);int n=ftell(f);rewind(f);s=malloc(n+1);fread(s,1,n,f);s[n]=0;fclose(f);q=0;nt();A*h=NULL,**p=&h;if(is('{'))h=K();else while(!is(Q)){*p=S();p=&(*p)->n;}H*g=ne(NULL);df(g,"outn",(V){0,(A*)1,0});blk(h,g);return 0;}
