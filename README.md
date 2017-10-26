# lis7008-distance

I put this together for a LIS 7008 project at LSU.
All the data was taken from the OpenData BR website.

Comments are in the Powershell code.

I don't really have much of an extended need for this to go further with it.

Ideally I'd wrap it up in a single function that accepts the two csv to compare instead of all the redundant manual code.

Also it doesn't actually create a usable CSV in the end so that needs to be fixed too.

Last, I was most interested in finding the shortest distances out of each pair. I could have done this with a variable that took the smallest item by comparing present value to the variable and updating if present is less, but I didn't implement that either. Instead I just used SQL to do it faster.

# Files

DistanceCalculation.ps1 is the workhorse

brec.csv, library.csv, and school.csv are the data files from OpenData BR. It's the address or some other identifier plus the geolocation tags I pulled from the database.

It's good for test data, otherwise pull in your own CSV and update the variables and import-csv commands at top of the script.