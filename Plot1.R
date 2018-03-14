## Fetch 

# Read in test data
##sourceClass <- readRDS("Source_Classification_Code.rds")
summary <- na.omit(readRDS("summarySCC_PM25.rds"))

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Use the base plotting system 
## make a plot showing the total PM2.5 emission from all sources for:
## each of the years 1999, 2002, 2005, and 2008.

x.sums <- by(summary, summary$year, function(x){
        # caculate the sum of emissions, by year
        sums <- sum(x$Emissions)}
)

plot(x.sums, xlab="Year", ylab="Total PM2.5")
mtext(side=3, text="Total Emissions", line=1.2, cex=1.5)
