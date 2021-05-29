* This is the main program for the sample

public gu_UseText
* In my real applications, this variable is loaded as a user-dependent preference
* (edited in the user-management form)
* Variable would be public, in this case, too.

public gcCurrentPrinter				&& default printer for reports
gcCurrentPrinter = set("printer",2)	&& default = windows default printer

public gnFromPage, gnToPage, gnNumCopies
gnFromPage = 1
gnToPage = 9999
gnNumCopies = 1

set procedure to MyFunctions
set classlib to reports, MyClasses

* The array will hold timer objects, one for each text report.
* The timers erase the temp files after a specified time.
public gaTempFileName(1)
gaTempFileName(1) = NULL

do form ReportInvoice
read events
