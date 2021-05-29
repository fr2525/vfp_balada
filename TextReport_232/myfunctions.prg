* This file contains general-use functions, which may be useful for any system.
* Therefore, this file should be shared, preferably through source control, so that
* corrections are available in all projects.

#INCLUDE textreport.h





********************************************************************************
FUNCTION AddTempFileTimer(tcFileName)
	* Add name of temp file to list of timers (so temp file gets erased after specified
	* period of time, or at program exit).
	local lnIndex
	lnIndex = ascan(gaTempFileName, NULL)
	if lnIndex = 0
		dimension gaTempFileName(alen(gaTempFileName) + 1)
		lnIndex = alen(gaTempFileName)
	endif
	gaTempFileName(lnIndex) = CreateObject("cTimerTempFile", tcFileName)
ENDFUNC




********************************************************************************
FUNCTION ConvertToChar(txPar)
	* Simplified version of the function I use in the real application
	return transform(txPar)
ENDFUNC





********************************************************************************
FUNCTION PrintTextFile(tcFileName, tcSetupString, tnPrint, tcPaperMessage, tcReportName)
* additional parameter: tnLeftMargin
	* Preview or Print a textfile

	* PARAMETERS:
	* FileName: TextFile that should be shown in preview or printed.
	* tcSetupString: setup string for printer.
	* tnPrint: .T. or 1 for printing, .F. or 0 for preview, 2 for preview, then print
	* tcPaperMessage: message to prepare a certain paper
	* tnLeftMargin: left margin to add for printing (but not for preview)

	* Note: the public variable glOmitPageBreaks is used to solve certain problems in printing
	* cupons. Apparently, the printer used doesn't recognize the codes to change page length.
	* This is only required in reports which don't have the standard 11" page length.
	* Also, this can only be done if page breaks are replace with sufficient line-feeds.
	local llUseBrowser
	llUseBrowser = type("gu_UseText") = "U" or not gu_UseText

	if vartype(tnPrint) = "L"
		tnPrint = iif(tnPrint, 1, 0)
	endif

*	if empty(tnLeftMargin)
		tnLeftMargin = 0
*	endif
	local tcMargin
	tcMargin = space(tnLeftMargin)

	if tnPrint = 1	&& output: printer
		* Ask for paper before EVERY report. Otherwise, another user might have changed
		* paper.
	*!*		* Use public variable to keep track of last paper used (so user doesn't see the same
	*!*		* message twice in a row, when no paper change is required)
	*!*		local llOkToPrint
	*!*		if type("gcPaperMessage") = "U"
	*!*			public gcPaperMessage
	*!*			gcPaperMessage = ""
	*!*		endif
	*!*		if empty(tcPaperMessage) or tcPaperMessage == gcPaperMessage
	*!*			llOkToPrint = .T.
	*!*		else
			if MessageBox("Load the paper:" + CRLF;
					+ tcPaperMessage + CRLF + "(Wait for the printer to finish printing" + CRLF;
					+ [then change the paper and click on "OK".)],;
					MB_OKCANCEL + MB_ICONINFORMATION, "Load paper") = IDOK
				llOkToPrint = .T.
			else	&& user cancelled
				llOkToPrint = .F.
			endif
	*!*		endif
		if llOkToPrint
			gcPaperMessage = tcPaperMessage
			set printer to name (gcCurrentPrinter)
			local lcOnError, llError
			lcOnError = on("error")
			on error llError = .T.
			??? tcSetupString + PC_UNIDIR + chr(iif(gu_unidir, 1, 0))
			local lcFileInRam
			lcFileInRam = FileToStr(tcFileName)
			lcFileInRam = strtran(lcFileInRam, TC_BOLDON,    PC_BOLDON   )
			lcFileInRam = strtran(lcFileInRam, TC_BOLDOFF,   PC_BOLDOFF  )
			lcFileInRam = strtran(lcFileInRam, TC_ITALICON,  PC_ITALICON )
			lcFileInRam = strtran(lcFileInRam, TC_ITALICOFF, PC_ITALICOFF)
			lcFileInRam = strtran(lcFileInRam, TC_10CPI,     PC_10CPI)
			lcFileInRam = strtran(lcFileInRam, TC_12CPI,     PC_12CPI)
			lcFileInRam = strtran(lcFileInRam, TC_15CPI,     PC_15CPI)
			lcFileInRam = strtran(lcFileInRam, TC_17CPI,     PC_17CPI)
			if glOmitPageBreaks
				lcFileInRam = strtran(lcFileInRam, chr(12), "")
			endif
			lcFileInRam = tcMargin + strtran(CpConvert(1252, 437, lcFileInRam),;
				CRLF, CRLF + tcMargin)
			for i = 1 to gnNumCopies
				??? lcFileInRam
			next
			??? PC_RESET
			on error &lcOnError
			if llError
				MessageBox("Can't access the printer.", 16, "Error")
			endif
			set printer to
		endif
	else	&& tnPrint = 0 or 2. Output: print preview, on screen
		local lcPreviewFileName		&& separate copy of temp file for preview (changes are made
									&& to improve readability; not applicable for printing)
		local lcTempFile, lnNumPagesSelected, lcFileInRam
		lcPreviewFileName = TempFileName() + iif(llUseBrowser, ".HTM", ".TXT")
		lcTempFile = FileToStr(tcFileName)
		lnNumPagesSelected = occurs(chr(12), lcTempFile)
		lcFileInRam = iif(lnNumPagesSelected > 0, "[" + alltrim(str(lnNumPagesSelected));
			+ space(1) + iif(lnNumPagesSelected = 1, "page", "pages") + " / ";
			+ tcPaperMessage + "]" + CRLF + CRLF, "");
			+ StrTran(lcTempFile, chr(12),;
			replicate(CRLF,4) + padc(" PAGE ", 80, "=") + CRLF)
		if not llUseBrowser
			lcFileInRam = strtran(lcFileInRam, TC_BOLDON,    "")
			lcFileInRam = strtran(lcFileInRam, TC_BOLDOFF,   "")
			lcFileInRam = strtran(lcFileInRam, TC_ITALICON,  "")
			lcFileInRam = strtran(lcFileInRam, TC_ITALICOFF, "")
		endif
		lcFileInRam = strtran(lcFileInRam, TC_10CPI,     "")
		lcFileInRam = strtran(lcFileInRam, TC_12CPI,     "")
		lcFileInRam = strtran(lcFileInRam, TC_15CPI,     "")
		lcFileInRam = strtran(lcFileInRam, TC_17CPI,     "")
		if llUseBrowser
			lcFileInRam = "<html>" + CRLF + "<head>" + CRLF;
				+ "<title>" + tcReportName + "</title>" + CRLF + "</head>" + CRLF;
				+ "<body>" + CRLF + [<pre><font size="2">] + CRLF;
				+ lcFileInRam;
				+ "</font></pre>" + CRLF + "</body>" + CRLF + "</html>" + CRLF

		endif
		StrToFile(lcFileInRam, lcPreviewFileName)
		local lcError, llError
		lcError = on("error")
		on error llError = .T.
		RunDoc(lcPreviewFileName)
		* run /n3 &gu_TextEditor &lcPreviewFileName
		on error &lcError
		if llError
			MessageBox("Can't open editor.")
		endif
		AddTempFileTimer(lcPreviewFileName)
		* modify command (tcFileName) noedit range 1,1

		* print after preview
		if tnPrint = 2 and UserConfirm("Print now?", "Print")
			PrintTextFile(@tcFileName, @tcSetupString, 1, @tcPaperMessage, @tcReportName)
		endif
	endif
ENDFUNC && PrintTextFile





********************************************************************************
* Copied (and adapted) from the UniversalThread (FAQ#190, by Gérald Santerre)
* According to the author, opens an HTML document or mail.
* Actually helps to open *any* document with its default association.

FUNCTION RunDoc(tlDocument)
	local lnResult

	DECLARE INTEGER ShellExecute ;
		IN SHELL32.dll ;
		INTEGER nWinHandle, ;
		STRING cOperation, ;
		STRING cFileName, ;
		STRING cParameters, ;
		STRING cDirectory, ;
		INTEGER nShowWindow

	**retreive the main VFP window handle (this handle is used by ShellExecute)

	DECLARE INTEGER FindWindow ;
		IN WIN32API ;
		STRING cNull, ;
		STRING cWinName

	lnResult=ShellExecute(FindWindow( 0, _SCREEN.caption), "Open", tlDocument, "", "c:\temp\", 1)

	**Error messages if the return value is < 32
	IF lnResult < 32
		DO CASE
		CASE lnResult=2
			Wait wind "Invalid association or URL."
		CASE lnResult=31
			Wait wind "Missing association."
		CASE lnResult=29
			Wait wind "Can't start the application."
		CASE lnResult=30
			Wait wind "The application is already open."
		ENDCASE
	ENDIF
ENDFUNC





********************************************************************************
FUNCTION StripPrinterCodes(tcString)
	* Return tcString, eliminating temporary printer codes (currently defined as an
	* identifier between "<<" and ">>", for example, "<<BOLD_ON>>").

	* Return immediately, if no eliminating is required. Added for efficiency (most common case).
	if not "<<" $ tcString
		return tcString
	endif

	local lcReturnValue, lnPos1, lnPos2
	lcReturnValue = ""
	do while "<<" $ tcString
		lnPos1 = at("<<", tcString)
		lnPos2 = at(">>", tcString)
		lcReturnValue = lcReturnValue + left(tcString, lnPos1 - 1)
		tcString = substr(tcString, lnPos2 + 2)
	enddo
	lcReturnValue = lcReturnValue + tcString
	return lcReturnValue
ENDFUNC && StripPrinterCodes





********************************************************************************
FUNCTION TempFileName()
	* Return unique filename, located on the TEMP path.
	return sys(2023) + "\" + sys(2015)
ENDFUNC && TempFileName





********************************************************************************
FUNCTION TextOutput(tcFileName, llAdditive)
	* sends output to specified filename, and changes some options
	if not empty(tcFileName)
		if llAdditive
			set alternate to (tcFileName) additive
		else
			set alternate to (tcFileName)
		endif
		set alternate on
		set console off
	else
		set alternate off
		set alternate to
		set console on
	endif
ENDFUNC && TextOutput





**********************************************************************
FUNCTION UserConfirm(tcMessage, tcTitle, tlDefault)
	* Wrapper for a common use of MessageBox(): have user confirm something.
	* Parameters:
	* tcMessage: The message displayed to the user
	* tcTitle: Window title for MessageBox()
	* tlDefault: Default button; .T. for "yes" (first button), .F. for "no" (2nd. button)

	if empty(tcTitle)
		tcTitle = "Confirmación"
	endif

	return MessageBox(tcMessage, MB_YESNO + MB_ICONQUESTION +;
		iif(tlDefault, MB_DEFBUTTON1, MB_DEFBUTTON2), tcTitle) = IDYES
ENDFUNC && UserConfirm





********************************************************************************
FUNCTION User_Interrupt
	* Check (and clear) entire type-ahead buffer, until Alt-X is found.
	* Alt-X signifies that the user wants to interrupt current procedure.
	local lnKeyPressed
	do while .T.
		lnKeyPressed = inkey()
		if inlist(lnKeyPressed, 0, 45)
			exit
		endif
	enddo
	if lnKeyPressed = 45
		messagebox("Proceso interrumpido por el usuario.", 48, "Interrumpido")
		return .T.
	else
		return .F.
	endif
ENDFUNC && User_Interrupt
