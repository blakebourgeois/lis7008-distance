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
    ## Setting up a minimum distance. No two geo locations on earth should exceed this distance in miles so first run should always update this value
    ## The value resets when item1[0] is incremented to item1[1] etc
    ## Initalize a blank array to hold the description of the data (this may not be the best way to accomplish this step)
    $minDist = 15000
    $littleMaster = @()

    ## we use count to increment through each geolocation in file1
    ## we are going to use a SECOND count to increment through each geolocation in file2
    while($count2 -lt $file2.length){

        # create the item that houses the lat and long for item in file1
        # the count is used to select the correct index
        # when the count is increased later, the file1 list item will change
        $item1 = New-Object System.Device.Location.GeoCoordinate $file1[$count].lat, $file1[$count].long
        # create the item that houses the lat and long for file2
        $item2 = New-Object System.Device.Location.GeoCoordinate $file2[$count2].lat, $file2[$count2].long
        # uses the built in function getdistanceto to get the distance
        # converts that distance to km
        # converts KM to miles
        # rounds result to 2 decimal places
        # edit the math as is appropriate for your application
        $dist = [math]::Round((($item1.GetDistanceTo($item2) / 1000) * 0.621371),2)

        # Pull the addresses of each item for reference
        $address1 = $file1[$count].address
        $address2 = $file2[$count2].address
        
        # Build the comparison string for output
        # again this can be edited for your application as necessary, this made the most sense for my needs
        $comparison = "$dist,$address1,$address2"

        # the newly calcuated distance is compared against the mindist
        # on first run it should always be less than 15000 so minDist will hold the first comparison
        # when new distances are calculated, it will update minDist to the new short distance litteMaster to the new comparison string.
        if($dist -lt $minDist)
            {$minDist = $dist
            $littlemaster = $comparison}
        
        # increment second count
        # will increment until we're out of items in file2
        $count2 = $count2 + 1
        }

   # when we finish comparing each item in file1 to file2 we'll move to the next in file1 and repeat
   $count = $count + 1

   # output the shortest result for file1[x] here. This will repeat until file1 is exhausted giving a single response for each item
   $littleMaster
   # reset count so the file2 loop runs again
   $count2 = 0

   # we got what we wanted so we clear out that array for the next iteration
   $littleMaster = @()
}

