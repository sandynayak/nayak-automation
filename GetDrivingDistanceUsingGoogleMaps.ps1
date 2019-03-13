
#This script invokes Google api with a "from" and "to" address.
#alternatives=false, means it would just return the first result
#The output is an XML parsed through Powershell for finding the value node which has the driving distance in meters. 
#<distance>
#   <value>8350</value>
#   <text>5.2 mi</text>
#</distance>
#In this example, I am converting the output distance on the XML from meters to miles.

# FYI: I am seeing the following message as of Jan 2019:
# Keyless access to Google Maps Platform is deprecated. Please use an API key with all your API calls to avoid service interruption. For further details please refer to http://g.co/dev/maps-no-account
# Will figure out a new way and update the file later.

Clear-Host

$FromAddress="7505 2000 S Las Vegas Blvd, Las Vegas, NV 89104"
$ToAddress="3799 S Las Vegas Blvd, Las Vegas, NV 89109"

(([xml]((Invoke-WebRequest -uri "http://maps.googleapis.com/maps/api/directions/xml?origin=$FromAddress&destination=$ToAddress&alternatives=false").content)).DirectionsResponse.route.leg.distance.value)/1609.34


