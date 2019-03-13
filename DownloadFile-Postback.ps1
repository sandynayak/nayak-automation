#Declare global variables
$url = "YOUR URL GOES HERE"	#***Give the website URL here***
$LocalFileName = "E:\Temp\LocalFileName.txt"	#***Give the full path of local file here***

#Clear the console
Clear-Host

#Make a first call to get 
#	(i) the session in a session variable 
#	(ii) page layout which contains the form to be posted
$FirstResponse = Invoke-WebRequest $url -SessionVariable 'session' 


#Get the form on the page for which we need to post a request
$PageForm = $FirstResponse.Forms['form1']			


#Modify the form to use the variable values passed from the dopostback on the webpage (use escape sequence)
$PageForm.Fields["__EVENTTARGET"] = "ctl00`$ContentPlaceHolder1`$lnkABC" #***Give the name of the HTML element used in the doPostback*** 
$PageForm.Fields["__EVENTARGUMENT"] = ""

#Post a request to download the file
$Response = Invoke-WebRequest -uri $url -method post -Body $PageForm.Fields -WebSession $session -Outfile $LocalFileName -PassThru 

#Log the response
Write-Host "Response status code - $($Response.StatusCode); Downloaded attachment - $($Response.Headers.'Content-Disposition'); File size - $($Response.RawContentLength) bytes"



