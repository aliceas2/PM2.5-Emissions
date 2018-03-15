## Fetch 

# Read in test data
##sourceClass <- readRDS("Source_Classification_Code.rds")
summary <- na.omit(readRDS("summarySCC_PM25.rds"))

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland? 
## (fips == "24510") from 1999 to 2008
## Use the base plotting system to make a plot.

bmore <- summary[ which(summary$fips =="24510"), ]

## Y lim is set to 150 to make it easier to see lm line trend.
plot(bmore$year, bmore$Emissions, ylim = c(0,150), ylab = "Emissions", xlab = "Year")
mtext(side=3, text="Baltimore Emissions", line = 1.2, cex=1.5)

## Fit Line
fit1 <- lm(Emissions~year, data = bmore)
abline(fit1, col = "red")

##Save Plot
dev.copy(png,'Plot2.png')
dev.off()