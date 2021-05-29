#define XOR #
#define XNOR =

#define TRUE	.T.
#define FALSE	.F.
#define YES		.T.
#define NO		.F.

#define CRLF		chr(13) + chr(10)
#define CRLF2		CRLF + CRLF
#define PAGEBREAK	chr(12)

* PRINTER CODES
#define PC_ESC chr(27)
#define PC_UNIDIR PC_ESC + "U"
	* unidirectional printing, to improve quality on old printers. User must add chr(1) (on) or chr(0) (off).
#define PC_PAGELENGTH PC_ESC + "C"
	* page length. Actual length has to be added, like this: PC_PAGELENGTH + chr(66) (for 66 lines)

* condensed on and off
#define PC_CONDENSED	chr(15)
#define PC_NONCONDENSED	chr(18)

* character-per-inch settings
#define PC_10CPI	PC_ESC + "P" + PC_NONCONDENSED
#define PC_12CPI	PC_ESC + "M" + PC_NONCONDENSED
#define PC_15CPI	PC_ESC + "g" + PC_NONCONDENSED
* #define PC_12CPI	PC_17CPI
* #define PC_15CPI	PC_17CPI
#define PC_17CPI	PC_ESC + "P" + PC_CONDENSED

* draft or NLQ
#define PC_NLQ		PC_ESC + "x" + chr(1)
#define PC_DRAFT	PC_ESC + "x" + chr(0)

* line spacing
#define PC_SPACINGNORMAL	PC_ESC + "2"
#define PC_SPACING88		PC_ESC + "0"

* Special effects
#define PC_BOLDON			PC_ESC + "E"
#define PC_BOLDOFF			PC_ESC + "F"
#define PC_ITALICON			PC_ESC + "4"
#define PC_ITALICOFF		PC_ESC + "5"
#define PC_DOUBLEWIDEON		PC_ESC + "W" + chr(1)
#define PC_DOUBLEWIDEOFF	PC_ESC + "W" + chr(0)
#define PC_DOUBLEHIGHTON	PC_ESC + "w" + chr(1)
#define PC_DOUBLEHIGHTOFF	PC_ESC + "w" + chr(0)

* reset to a certain standard
#define PC_RESET	PC_PAGELENGTH + chr(66) + PC_10CPI + PC_DRAFT + PC_SPACINGNORMAL + PC_BOLDOFF + PC_ITALICOFF + PC_DOUBLEHIGHTOFF

* Half page
#DEFINE PC_HALFPAGE				PC_PAGELENGTH + chr(33)
* standard options; "wide" and "narrow" here refer to the page width.
#define PC_WIDE132FAST			PC_RESET
#define PC_NARROW132FAST		PC_RESET + PC_17CPI
#define PC_WIDE132FAST88LINES	PC_RESET + PC_SPACING88 + PC_PAGELENGTH + chr(88)
#define PC_NARROW132FAST88LINES	PC_RESET + PC_17CPI + PC_SPACING88 + PC_PAGELENGTH + chr(88)


* Codes for use in temporary text file
#define TC_BOLDON			"<B>"
#define TC_BOLDOFF			"</B>"
#define TC_ITALICON			"<I>"
#define TC_ITALICOFF		"</I>"
#define TC_DOUBLEWIDEON		"<<DOUBLEWIDEON>>"
#define TC_DOUBLEWIDEOFF	"<<DOUBLEWIDEOFF>>"
#define TC_10CPI			"<<10 CPI>>"
#define TC_12CPI			"<<12 CPI>>"
#define TC_15CPI			"<<15 CPI>>"
#define TC_17CPI			"<<17 CPI>>"


* Standard paper definitions, for informing the user about required paper changes
#define PAPER_STANDARD		"Letter size, 8 1/2 x 11"
#define PAPER_WIDE			"Wide paper, 14 7/8 x 11"


* Excel
#define XLTRUE			-1
#define XLFALSE			0
#define xlCenter		-4108
#define xlLeft			-4131
#define xlTop			-4160
#define xlContinuous	1
#define xlEdgeTop		8
#define xlMedium		-4138

#define CURRENTCELL This.oSheet.Cells(This.nRow, This.nCol)
#define NEXTROW	This.nRow = This.nRow + 1
#define NEXTCOL This.nCol = This.nCol + 1

* Copied from foxpro.h:
*-- MessageBox parameters
#DEFINE MB_OK                   0       && OK button only
#DEFINE MB_OKCANCEL             1       && OK and Cancel buttons
#DEFINE MB_ABORTRETRYIGNORE     2       && Abort, Retry, and Ignore buttons
#DEFINE MB_YESNOCANCEL          3       && Yes, No, and Cancel buttons
#DEFINE MB_YESNO                4       && Yes and No buttons
#DEFINE MB_RETRYCANCEL          5       && Retry and Cancel buttons

#DEFINE MB_ICONSTOP             16      && Critical message
#DEFINE MB_ICONQUESTION         32      && Warning query
#DEFINE MB_ICONEXCLAMATION      48      && Warning message
#DEFINE MB_ICONINFORMATION      64      && Information message

#DEFINE MB_APPLMODAL            0       && Application modal message box
#DEFINE MB_DEFBUTTON1           0       && First button is default
#DEFINE MB_DEFBUTTON2           256     && Second button is default
#DEFINE MB_DEFBUTTON3           512     && Third button is default
#DEFINE MB_SYSTEMMODAL          4096    && System Modal

*-- MsgBox return values
#DEFINE IDOK            1       && OK button pressed
#DEFINE IDCANCEL        2       && Cancel button pressed
#DEFINE IDABORT         3       && Abort button pressed
#DEFINE IDRETRY         4       && Retry button pressed
#DEFINE IDIGNORE        5       && Ignore button pressed
#DEFINE IDYES           6       && Yes button pressed
#DEFINE IDNO            7       && No button pressed
