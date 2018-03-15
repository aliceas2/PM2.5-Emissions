## Fetch 

## Read in test data
## sourceClass <- readRDS("Source_Classification_Code.rds")
summary <- na.omit(readRDS("summarySCC_PM25.rds"))

## of the point, nonpoint, onroad, nonroad source variable, 
## which has seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system

##load ggplot2 and reshape library
library(ggplot2)
library(reshape2)

##subset out baltimore city, keep Emissions, year, and type
bmore <- subset(summary, fips == "24510", c("Emissions", "year","type"))

bmore <- melt(bmore, id=c("year", "type"), measure.vars=c("Emissions"))
bmore <- dcast(bmore, year + type ~ variable, sum)

## Plot it~!
p <- ggplot(data=bmore, aes(x=year, y=Emissions, group=type, color=type)) 
p <- p + geom_smooth(method='lm', se = FALSE) + geom_point( size=4, shape=20) 
p <- p + xlab("Year") + ylab("Emissions (tons)") + ggtitle("Baltimore PM2.5 Values")
print(p)

##Save Plot
dev.copy(png,'Plot3.png')
dev.off()