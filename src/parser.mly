%{ open Ast %}

%token PLUS MINUS TIMES MOD DIVIDE LPAREN RPAREN SEMI COLON EQUAL
%token LBRACKET RBRACKET CARAT DOT COMMA GT LT GEQ LEQ NEQ OR AND
%token EQ ELSE WHILE INT IF FOR RETURN PRINT VOID
%token <int> INTLITERAL
%token <string> STRINGLITERAL
%token <string> ID
%token EOF

%nonassoc ELSE
%right EQUAL
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE

%start	program
%type <Ast.program> program

%%

program:
	/* nothing */						{ [] }
	| program fdef						{ $2 :: $1 }

fdef:
	dtype ID LPAREN formals_opt RPAREN LBRACKET stmt_list RBRACKET
										{ {
											return_type = $1;
											fname	= $2;
											formals = $4;
											locals = [];
											body	= List.rev $7	} }

stmt_list:
	/* Nothing */						{ [] }
	| stmt_list stmt 					{ $2 :: $1 }


stmt:
	expr SEMI							{ Expr ($1) }
	| LBRACKET stmt_list RBRACKET		{ Block(List.rev $2) }

expr:
	  INTLITERAL					{ IntLiteral($1) }
	| STRINGLITERAL					{ StringLiteral($1) }
	| expr PLUS expr 	{ Math($1, $3) }
	| ID						{ Id($1) }
	| PRINT LPAREN expr RPAREN		{ Print($3) }
	| ID LPAREN actuals_opt RPAREN	{ Call ($1, $3) }

formals_opt:
					{ [] }
	| formal_list	{ List.rev $1 }

formal_list:
	 formal				{ [$1] }
	| formal_list COMMA formal { $3 :: $1 }

formal:
	dtype ID { Formal ($1, $2) }

actuals_opt:
					{ [] }
	| actuals_list 	{ List.rev $1 }

actuals_list:
	expr 			{ [] }
	| actuals_list COMMA expr { $3 :: $1 }

dtype:
	VOID   { VoidType }