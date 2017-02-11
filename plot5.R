# Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Plot 4
# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

library(dplyr)
library(ggplot2)

SCC <- SCC[, c("SCC", "Short.Name")]
graphData <- NEI[, c("SCC", "Emissions", "year")]
graphData <- merge(graphData, SCC, by = "SCC")
graphData <- graphData %>% subset(grepl("Comb /", graphData$Short.Name))
graphData <- graphData %>% subset(grepl("Coal", graphData$Short.Name))
graphData$Emissions <- graphData$Emissions / 1000

png("plot4.png")

g <- ggplot(data = graphData, mapping = aes(as.factor(year), Emissions))
g + geom_col() +
	labs(x = "Year", y = "Total Emissions (thousands of tons)",
	     title = "Emissions from coal combustion-related\nsources in the United States")

dev.off()