DECLARE INTEGER GetPrivateProfileString IN WIN32API;
	STRING Seccion,;
	STRING Clave,;
	STRING PorDefecto,;
	STRING @CadenaRetorno,;
	INTEGER longitud,;
	STRING NombreFichero

PUBLIC m.pnivel,m.data,gOperador, gDesenv
PUBLIC m.gEmpresa
PUBLIC m.gpalavra
PUBLIC m.gImpresso 
PUBLIC gSenha 
PUBLIC gDivcupom 
PUBLIC gMensa1 
PUBLIC gMensa2 
PUBLIC gDemo
PUBLIC lcdatabase

M.DATA = DATE() 
gOperador = 'MASTER' 
gNivel=1
gSenha = .T.
gDesenv = .T.
gEmpresa = "Empresa Demo"
gPalavra = "Orçamento"
gImpresso = "80"
gDivcupom = .F. 
gMensa1 = "Mensagem 1"
gMensa2 = "Mensagem 2"

gDemo = .F.

*!*	SET DEFA TO
*!*	letra = INPUTBOX("Digite a letra do Pen Drive: ")
*!*	letra = letra + ":"
*!*	SET DEFAULT TO (letra)
*!*	vPath = letra + "\aplics\vfp9\balada"
*!*	*vPath = "\aplics\vfp9\balada"

*!*	vPath = ""
*!*	vPATH = letra + "\aplics\vfp9\balada;" + sys(5) + "\aplics\bitmaps;" 
*!*	vPath = vPath + sys(5) + "\aplics\vfp9\classes;" + sys(5) + "\aplics\vfp9\balada\forms;"
*!*	vPath = vPath + sys(5) + "\aplics\vfp9\balada\menus;"   + sys(5) +  "\aplics\vfp9\balada\prgs;" 
*!*	vPath = vPath + sys(5) + "\aplics\vfp9\balada\rpts;" + + sys(5) +  "\aplics\vfp9\balada\dados;" 
*!*	SET PATH TO  &vPath

SET CLASSLIB TO reposito ADDITIVE

*SET STEP ON

*: Establecemos los path con la creación del objeto configuración:*
*	goconfig = CREATEOBJECT('configura','')
	*goConfig.pcini = GETENV("windir") + "dbsMG.INI"

*!*	*{ Abertura da base de dados }*


*	lcdatabase = goconfig.pdatabasepath + 'Dbsgl.dbc'

*!*	*lcdatabase = SYS(5) + SYS(2003) +"\Dados\" +  'dbsmg.dbc'
*!*	*SET DEFA TO &goconfig.pdatabasepath
*!*	*OPEN DATABASE Dbsgl.mdb SHARED 
*!*	OPEN DATABASE (lcdatabase)
*!*	*SET DATABASE TO (lcdatabase)

SET DATE BRITI
SET CENTURY ON
SET CURRENCY TO 'R$'
SET SEPARATOR TO '.'
SET POINT TO ','
SET ENGINEBEHAVIOR 70

*SET CLOCK ON
*SET PROCEDURE TO funcoes.prg

