# Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
df <- merge(NEI, SCC, by = "SCC")

# Plot 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

graphData <- NEI[NEI$fips == "24510", c("Emissions", "type", "year")]
# graphData <- graphData %>% 
# 	group_by(type, year) %>% 
# 	summarize(sum(Emissions)) %>% 
# 	rename(totalEmissions = `sum(Emissions)`)

png(filename = "plot3.png", width = 900, height = 400)

g <- ggplot(graphData, aes(as.factor(year), Emissions))
g <- g + geom_col() + facet_grid(. ~ type)
g + labs(x = "Year", y = "Total Emissions (tons)",
	 title = "Total PM2.5 Emissions in Baltimore City by source type") + theme_gray()

dev.off()
