# Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")

# Plot 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

library(dplyr)

graphData <- NEI[NEI$fips == "24510", c("Emissions", "year")]
graphData <- graphData %>% 
	group_by(year) %>% 
	summarize(sum(Emissions)) %>% 
	rename(totalEmissions = `sum(Emissions)`)

png(filename = "plot2.png")

with(graphData,
     plot(year, totalEmissions, type = "b", col = "darkolivegreen", lwd = 2,
          xaxp = c(1999, 2008, 3), ylim = c(0, max(totalEmissions)),
          xlab = "Year", ylab = "Total Emissions (tons)",
          main = "Total PM2.5 emissions\nin Baltimore City, MD")
     )


dev.off()
