# Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Plot 4
# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

library(dplyr)
library(ggplot2)

SCC <- SCC[, c("SCC", "Short.Name")]
graphData <- NEI[NEI$fips == "24510", c("SCC", "Emissions", "year")]
graphData <- merge(graphData, SCC, by = "SCC")

graphData <- graphData %>% subset(grepl("Motor|Vehicle", graphData$Short.Name))

png("plot5.png")

g <- ggplot(data = graphData, mapping = aes(as.factor(year), Emissions))
g + geom_col() +
	labs(x = "Year", y = "Total Emissions (tons)",
	     title = "Emissions from motor vehicle\nsources in Baltimore City")

dev.off()