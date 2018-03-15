## Fetch 

## Read in test data
## sourceClass <- readRDS("Source_Classification_Code.rds")
##summary <- na.omit(readRDS("summarySCC_PM25.rds"))

##How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
library(ggplot2)
library(reshape2)
library(dplyr)

bmore <- summary[ which(summary$fips =="24510"), ]

##Trim SourceClass
sourceTrim <- sourceClass[,1:3]
sourceTrim$Data.Category <- NULL

emissionBmore <- merge(bmore, sourceTrim, by.y = "SCC")

data <- subset(emissionBmore, grepl("Vehicle", emissionBmore$Short.Name, fixed = TRUE))

##Plot it!
p <- ggplot(data, aes(x = year, y = Emissions)) + geom_bar(stat = "identity")
p <- p + xlab("Year") + ylab("Emissions (tons)") + ggtitle("Vehicle Emissions in Baltimore City")
p <- p + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

print(p)