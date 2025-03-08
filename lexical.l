
--ajouter  nombres pos neg 

%{

#include<stdio.h>
# include "syntax.tab.h"
int num_de_lignes = 1 ;

%}


lettre [a-zA-Z]
chiffre [0-9]
chaine \"[^\"]*\"
commentaire_une_ligne "<!-"[^\n]*"-!>"
commentaire_plusieurs_lignes "{--"(.|\n)*"--}" 
idf {lettre}([a-z0-9]*_?[a-z0-9])*



%%

\n {num_de_lignes++ ;}

MainPrgm {printf("mot cle : %s \n",yytext); return MainPrgm}
Var {printf("mot cle : %s \n",yytext); return var}
BeginPg {printf("mot cle : %s \n",yytext); return BeginPg}
EndPg {printf("mot cle : %s \n",yytext); return EndPg}
let {printf("mot cle : %s \n",yytext); return let}
AND {printf("operateur : %s \n",yytext); return AND}
OR {printf("operateur : %s \n",yytext); return OR}
if {printf("mot cle : %s \n",yytext); return if}
then {printf("mot cle : %s \n",yytext); return then}
step {printf("mot cle : %s \n",yytext); return step}
do {printf("mot cle : %s \n",yytext); return do}
while {printf("mot cle : %s \n",yytext); return while}
for {printf("mot cle : %s \n",yytext); return for}
from {printf("mot cle : %s \n",yytext); return from}
to {printf("mot cle : %s \n",yytext); return to}
else {printf("mot cle : %s \n",yytext); return else}
int {printf("mot cle : %s \n",yytext); return int}
float {printf("mot cle : %s \n",yytext); return float}
input {printf("mot cle : %s \n",yytext); return input}
output {printf("mot cle : %s \n",yytext); return output}
"@define const" {printf("declaration const \n"); return const}


{chiffre} {printf("chiffre \n"); return chiffre}
{chaine} {printf("chain de car: %s \n",yytext); return chaine}
{commentaire_une_ligne} {printf("un commentaire sur une ligne \n"); return comment_une}
{commentaire_plusieurs_lignes} {printf("un commentaire sur plusieurs lignes \n"); return comment_plsr}
{idf} { if (yyleng > 14) 
    {printf ("erreur lexicale : le IDF depasse 14 caracteres \n");}
    else{
    printf("idf : %s \n",yytext); return idf}
} 


! {printf("operateur : negation \n" ); return exclamation}
; {printf("pvg\n"); return pnt_virgul}
: {printf("deux points \n"); return deux_pnts}
, {printf("le vergule \n"); return virgul}
"("  {printf("parenthese_ouvrante \n"); return par_ouvr}
")" {printf("parenthese_fermante \n"); return par_ferm}  
"{" {printf("accolade_ouvrante \n"); return accolade_ouvr}
"}" {printf("accolade_fermante \n"); return accolade_ferm}
"-" {printf("soustract \n"); return soustract}
"+" {printf("addition \n"); return addition}
"*" {printf("multiplication \n"); return multipl}
"/" {printf("division \n"); return division}
":=" {printf("affectation \n"); return affect}
\"  {printf("Guillemets \n"); return Guillemets}
"[" {printf("corechets ouvrante \n");}
"]" {printf("corechets fermente \n");}



"<" {printf("inferieur \n"); return inf}
">" {printf("superieur \n"); return sup}
">=" {printf("superieur_ou_egale \n"); return sup_egal}
"<=" {printf("inferieur_ou_egae \n"); return inf_egal}
"==" {printf("egale \n"); return egal}
"!=" {printf("different_de \n"); return diff}


[ \t] {printf("espace \n"); }




. {printf("erreur lexicale a la ligne %d \n", num_de_lignes);} 

%%
int main(){
    yylex();
    return 0;
}