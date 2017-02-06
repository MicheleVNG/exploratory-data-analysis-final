# Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")

# Plot 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all
# sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

graphData <- NEI[, c("Emissions", "year")]
graphData <- graphData %>% 
	group_by(year) %>% 
	summarise(sum(Emissions)) %>% 
	rename(totalEmissions = `sum(Emissions)`)

graphData$totalEmissions <- graphData$totalEmissions / 1000

png(filename = "plot1.png")

with(graphData,
     plot(year, totalEmissions, type = "b", col = "navy", lwd = 2, xaxp = c(1999, 2008, 3),
          xlab = "Year", ylab = "Total Emissions (thousands of tons)",
          main = "Total PM2.5 emissions", ylim = c(0, max(totalEmissions)))
     )

dev.off()
