## Fetch 

## Read in test data
sourceClass <- readRDS("Source_Classification_Code.rds")
summary <- na.omit(readRDS("summarySCC_PM25.rds"))

##Compare emissions from motor vehicle sources in: 
##Baltimore City with Los Angeles County, California (fips == "06037"). 
##Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
library(reshape2)
library(dplyr)

##Trim SourceClass
sourceTrim <- sourceClass[,1:3]
sourceTrim$Data.Category <- NULL

##merge summary and sourceClass by SCC
merged <- merge(summary, sourceTrim, by.y = "SCC")

##Subset Vehicle only causes
data <- subset(merged, grepl("Vehicle", merged$Short.Name, fixed = TRUE))

## Create Bmore and LA only vars
bmore <- data[ which(data$fips =="24510"), ]
bmore$city <- "Baltimore City"

LA <- data[ which(data$fips == "06037"), ]
LA$city <- "Los Angeles"

bmoreLA <- rbind(bmore,LA)

p <- ggplot(bmoreLA, aes(x=factor(year), y=Emissions, fill=city)) +
        geom_bar(stat="identity") +
        facet_grid(scales="free", space="free", .~city) +
        guides(fill=FALSE) + 
        labs(x="Year", y=expression("Total PM"[2.5]*" Emission")) + 
        labs(title=expression("Vehicle Emissions in Baltimore City and LA County"))
print(p)

##Save Plot
dev.copy(png,'Plot6.png')
dev.off()