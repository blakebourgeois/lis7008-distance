## Import all our data
$libraries = import-csv c:\scripts\geo\library.csv
$brec = import-csv c:\scripts\geo\brec.csv
$school = import-csv C:\scripts\geo\school.csv

Add-Type -AssemblyName System.Device
 
## leftover test code from web example
#$BNA = New-Object System.Device.Location.GeoCoordinate 36.12, -86.67
#$LAX = New-Object System.Device.Location.GeoCoordinate 33.94, -118.40

#$BNA.GetDistanceTo( $LAX ) / 1000


## Set our counts. I'm lazy so instead of doing function we're copy pasting
$count = 0
$count2 = 0

## LIBRARIES TO BREC
## going to break down code once
## our count starts at 0, we want to contine WHILE count is under the total length of the data in libraries list
while($count -lt $libraries.length){
    ## we use count to increment through each library
    ## we are going to use a SECOND count to increment through each park
    while($count2 -lt $brec.length){
        # create the item that houses the lat and long for the library
        # the count is used to select the correct index
        # when the count is increased later, the library will change
        $item1 = New-Object System.Device.Location.GeoCoordinate $libraries[$count].lat, $libraries[$count].long
        # create the item that houses the lat and long for the park
        $item2 = New-Object System.Device.Location.GeoCoordinate $brec[$count2].lat, $brec[$count2].long
        # uses the built in function getdistanceto to get the distance
        # converts that distance to km
        # converts KM to miles
        # rounds result to 2 decimal places
        $dist = [math]::Round((($item1.GetDistanceTo($item2) / 1000) * 0.621371),2)
        # create a csv from each data point
        $libraries[$count].address + "," + $brec[$count2].address + "," + $dist | out-file C:\scripts\geo\libtobrec.csv -Append
        # increment second count
        # will increment until we're out of parks
        $count2 = $count2 + 1
        }
   # when we finish each park we'll move to the next library
   $count = $count + 1
   # reset count so the park loop runs again
   $count2 = 0
}

## LIBRARIES TO SCHOOL
$count = 0
$count2 = 0

while($count -lt $libraries.length){
    $count
    while($count2 -lt $school.length){
        $item1 = New-Object System.Device.Location.GeoCoordinate $libraries[$count].lat, $libraries[$count].long
        $item2 = New-Object System.Device.Location.GeoCoordinate $school[$count2].lat, $school[$count2].long
        $libraries[$count].address
        $school[$count2].address
        $dist = [math]::Round((($item1.GetDistanceTo($item2) / 1000) * 0.621371),2)
        $dist
        write-host "---"
        $libraries[$count].address + "," + $school[$count2].address + "," + $dist | out-file C:\scripts\geo\libtoschool.csv -Append
        $count2 = $count2 + 1
        }
   $count = $count + 1
   $count2 = 0
}

## BREC TO LIBRARIES
$count = 0
$count2 = 0

while($count -lt $brec.length){
    $count
    while($count2 -lt $libraries.length){
        $item1 = New-Object System.Device.Location.GeoCoordinate $brec[$count].lat, $brec[$count].long
        $item2 = New-Object System.Device.Location.GeoCoordinate $libraries[$count2].lat, $libraries[$count2].long
        $brec[$count].address
        $libraries[$count2].address
        $dist = [math]::Round((($item1.GetDistanceTo($item2) / 1000) * 0.621371),2)
        $dist
        write-host "---"
        $brec[$count].address + "," + $libraries[$count2].address + "," + $dist | out-file C:\scripts\geo\brectolib.csv -Append
        $count2 = $count2 + 1
        }
   $count = $count + 1
   $count2 = 0
}

## BREC TO SCHOOLS
$count = 0
$count2 = 0

while($count -lt $brec.length){
    $count
    while($count2 -lt $school.length){
        $item1 = New-Object System.Device.Location.GeoCoordinate $brec[$count].lat, $brec[$count].long
        $item2 = New-Object System.Device.Location.GeoCoordinate $school[$count2].lat, $school[$count2].long
        $brec[$count].address
        $school[$count2].address
        $dist = [math]::Round((($item1.GetDistanceTo($item2) / 1000) * 0.621371),2)
        $dist
        write-host "---"
        $brec[$count].address + "," + $school[$count2].address + "," + $dist | out-file C:\scripts\geo\brectoschool.csv -Append
        $count2 = $count2 + 1
        }
   $count = $count + 1
   $count2 = 0
}

## SCHOOLS TO LIBRARIES
$count = 0
$count2 = 0

while($count -lt $school.length){
    $count
    while($count2 -lt $libraries.length){
        $item1 = New-Object System.Device.Location.GeoCoordinate $school[$count].lat, $school[$count].long
        $item2 = New-Object System.Device.Location.GeoCoordinate $libraries[$count2].lat, $libraries[$count2].long
        $school[$count].address
        $libraries[$count2].address
        $dist = [math]::Round((($item1.GetDistanceTo($item2) / 1000) * 0.621371),2)
        $dist
        write-host "---"
        $school[$count].address + "," + $libraries[$count2].address + "," + $dist | out-file C:\scripts\geo\schooltolib.csv -Append
        $count2 = $count2 + 1
        }
   $count = $count + 1
   $count2 = 0
}

## SCHOOLS TO BREC

$count = 0
$count2 = 0

while($count -lt $school.length){
    $count
    while($count2 -lt $brec.length){
        $item1 = New-Object System.Device.Location.GeoCoordinate $school[$count].lat, $school[$count].long
        $item2 = New-Object System.Device.Location.GeoCoordinate $brec[$count2].lat, $brec[$count2].long
        $school[$count].address
        $brec[$count2].address
        $dist = [math]::Round((($item1.GetDistanceTo($item2) / 1000) * 0.621371),2)
        $dist
        write-host "---"
        $school[$count].address + "," + $brec[$count2].address + "," + $dist | out-file C:\scripts\geo\schooltobrec.csv -Append
        $count2 = $count2 + 1
        }
   $count = $count + 1
   $count2 = 0
}