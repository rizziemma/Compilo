/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tMAIN = 258,
    tOB = 259,
    tCB = 260,
    tOP = 261,
    tCP = 262,
    tRET = 263,
    tPRI = 264,
    tCST = 265,
    tINT = 266,
    tADD = 267,
    tSUB = 268,
    tMUL = 269,
    tDIV = 270,
    tEQ = 271,
    tINF = 272,
    tSUP = 273,
    tEQU = 274,
    tOR = 275,
    tAND = 276,
    tC = 277,
    tEI = 278,
    tIF = 279,
    tELS = 280,
    tVAL = 281,
    tID = 282
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tOB 259
#define tCB 260
#define tOP 261
#define tCP 262
#define tRET 263
#define tPRI 264
#define tCST 265
#define tINT 266
#define tADD 267
#define tSUB 268
#define tMUL 269
#define tDIV 270
#define tEQ 271
#define tINF 272
#define tSUP 273
#define tEQU 274
#define tOR 275
#define tAND 276
#define tC 277
#define tEI 278
#define tIF 279
#define tELS 280
#define tVAL 281
#define tID 282

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 8 "compiler.y" /* yacc.c:1909  */

    int nb;
    char * str;

#line 113 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
