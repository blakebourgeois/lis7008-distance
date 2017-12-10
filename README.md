# Get-DistanceCalculation

This powershell function compares two specially formatted CSV files containing geolocation data.

The function reads from a list of locations in one file and compares each location to every other location in the second list.
The closest location for each comparison is output to the console. The results will be just as long as the first list.

This function can be used when attempting to find the centrality of an item to other items in the area.

Originally, the code was used to compare the distances between local parks, schools, and libraries to determine average distances between features and identify outliers and underrepresented areas in our community for a class project.

# Usage

Create your two CSV files with 4 columns. 
First column is a placeholder. In our application it was the type of feature we were looking at, but it is unused in this script but if I killed it I'd have to redo all my indexes and I'm not having it.
Second column is the address. It doesn't have to be an address, it can be a unique name or description of the record. This information, for both files, is output to the console in the end so you know which record you're looking at and what the closest item from the second list is.
Third column is latitude.
Fourth column is longitude. 

Use import-module to pull in the Get-DistanceCalculation or be lazy like me and just append your code to the bottom of the ps1 and run it from the Powershell IDE or whatever.

Get-DistanceCalculation -file1 [path to first file] -file2 [path to second file]
Using the -file1 and -file2 switches are optional; you can just put the paths directly.

Remember: file1 contains the features you want comparisons for. File2 is the list of other features you need each record in file1 to be compared to.
This script is NOT equipped to compare a file against itself.

I've included a file1.csv and file2.csv with format and sample data you can use for testing or building out your own csv files.

# Future Work

This function is to a point I'm pretty happy with compared to the first iteration. 

A new switch could be created to either find the shortest or the furthest distances. The code within the function would flip accordinly.

Second, for shortest distances, an update is needed to ignore same same comparisons and skip updating minDist/littleMaster in the event a point is within two datasets or you want to compare a file to itself.
If you submit the same file to itself twice it'll just 0 out everything as it reaches itself.