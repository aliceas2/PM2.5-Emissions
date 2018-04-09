## Fetch 

# Read in test data
summary <- na.omit(readRDS("summarySCC_PM25.rds"))

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Use the base plotting system 
## make a plot showing the total PM2.5 emission from all sources for:
## each of the years 1999, 2002, 2005, and 2008.

x.sums <- tapply(summary$Emissions, summary$year, sum)

x.sums <- data.frame(c(1999,2002,2005,2008), x.sums)
names(x.sums) <- c("Year","Sum")
plot(x.sums, ylab="Total PM2.5")
mtext(side=3, text="Total Emissions", line=1.2, cex=1.5)

##Fit Line
fit1 <- lm(Sum~Year, data = x.sums)
abline(fit1, col = "red")

##Save Plot
dev.copy(png,'Plot1.png')
dev.off()
