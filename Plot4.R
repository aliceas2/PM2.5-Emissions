## Fetch 

## Read in test data
sourceClass <- readRDS("Source_Classification_Code.rds")
summary <- na.omit(readRDS("summarySCC_PM25.rds"))

## Across the United States, 
## how have emissions from coal combustion-related sources changed from 1999-2008?

library(ggplot2)
library(reshape2)
library(dplyr)

##Trim SourceClass
sourceTrim <- sourceClass[,1:3]
sourceTrim$Data.Category <- NULL

emission <- merge(summary, sourceTrim, by.y = "SCC")

data <- subset(emission, grepl("Coal", emission$Short.Name, fixed = TRUE))

gd <- data %>% group_by(year) %>% summarise(Emissions = mean(Emissions))

##Plot it!
p <- ggplot(gd, aes(x = year, y = Emissions)) + geom_bar(stat = "identity")
p <- p + xlab("Year") + ylab("Emissions (tons)") + ggtitle("Coal Emissions")
p <- p + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

print(p)