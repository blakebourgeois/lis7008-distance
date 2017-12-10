##Distance Calculation 2.0

## Import all our data

## For 2.0 we're still reading from local files
## For use replace $path with whatever works for your env
## End goal is to create a function
## get-distancecalculation -file1 path -file2 path

$path = "C:\Users\Blake\Documents\GitHub\lis7008-distance"
$file1 = import-csv "$path\file1.csv"
$file2 = import-csv "$path\file2.csv"

Add-Type -AssemblyName System.Device

## Set our counts outside of loops
$count = 0
$count2 = 0
$bigMaster = @()

## New Function
## Instead of the 6 iterations of this in v1 we only need a single observation
## Real use case would be a 1 to 1 file comparison.

## FILE1 to FILE2
## our count starts at 0, we want to contine WHILE count is under the total length of the data in file1
while($count -lt $file1.length){
    ## we use count to increment through each geolocation in file1
    ## we are going to use a SECOND count to increment through each geolocation in file2
    $minDist = 1000
    $littleMaster = @()
    while($count2 -lt $file2.length){

        # create the item that houses the lat and long for item in file1
        # the count is used to select the correct index
        # when the count is increased later, the file1 list item will change
        $item1 = New-Object System.Device.Location.GeoCoordinate $file1[$count].lat, $file1[$count].long
        # create the item that houses the lat and long for the park
        $item2 = New-Object System.Device.Location.GeoCoordinate $file2[$count2].lat, $file2[$count2].long
        # uses the built in function getdistanceto to get the distance
        # converts that distance to km
        # converts KM to miles
        # rounds result to 2 decimal places
        $dist = [math]::Round((($item1.GetDistanceTo($item2) / 1000) * 0.621371),2)
        
        
        # create a csv from each data point
        # actually please don't this is awful and it doesn't work
        # I wrote this because I needed the shortest of each comparison only
        #$file1[$count].address + "," + $file2[$count2].address + "," + $dist | out-file C:\scripts\geo\libtobrec.csv -Append

        # testing...is this better?
        $address1 = $file1[$count].address
        $address2 = $file2[$count2].address
        #$comparison = $dist + "," + $file1[$count].address + "," + $file2[$count2].address
        $comparison = "$dist,$address1,$address2"
        write-host "this comparison is:"
        $comparison
        write-host "before update, the mindist is:"
        $minDist

        if($dist -lt $minDist)
            {write-host "minDist has been updated..."
            $minDist = $dist
            $minDist
            $littlemaster = $littleMaster + $comparison}
        
        # increment second count
        # will increment until we're out of items in file2
        $count2 = $count2 + 1
        }
   # when we finish comparing each item in file1 to file2 we'll move to the next in file1 and repeat
   $count = $count + 1
   $littleMaster
   $bigMaster = $bigMaster + $littleMaster

   # reset count so the file2 loop runs again
   $count2 = 0
   $littleMaster = @()
}

$bigMaster

