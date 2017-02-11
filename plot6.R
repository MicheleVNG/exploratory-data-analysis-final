# Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Plot 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips ==
# "06037"). Which city has seen greater changes over time in motor vehicle
# emissions?

library(dplyr)
library(ggplot2)

SCC <- SCC[, c("SCC", "Short.Name")]

graphData <- NEI[NEI$fips == "24510" | NEI$fips == "06037", c("SCC", "fips", "Emissions", "year")]
graphData <- merge(graphData, SCC, by = "SCC")
graphData <- graphData %>% subset(grepl("Motor|Vehicle", graphData$Short.Name))
graphData[graphData$fips == "06037", "fips"] <- "Los Angeles"
graphData[graphData$fips == "24510", "fips"] <- "Baltimore City"
graphData <- rename(graphData, location = fips)


png("plot6.png")

g <- ggplot(data = graphData, mapping = aes(as.factor(year), Emissions))
g + geom_col() + facet_grid(location ~ .) +
	labs(x = "Year", y = "Total Emissions (tons)",
	     title = "Emissions from motor vehicle\nsources in Baltimore City and Los Angeles")

dev.off()