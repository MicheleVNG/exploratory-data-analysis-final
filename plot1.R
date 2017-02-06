# Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
df <- merge(NEI, SCC, by = "SCC")

# Plot 1

library(dplyr)

graphData <- NEI[, c("Emissions", "year")]
# graphData$year <- as.factor(graphData$year)

graphData <- graphData %>% 
	tbl_df %>% 
	group_by(year) %>% 
	summarise(sum(Emissions)) %>% 
	rename(totalEmissions = `sum(Emissions)`)

graphData$totalEmissions <- graphData$totalEmissions / 1000


png(filename = "plot1.png")

with(graphData,
     plot(year, totalEmissions, type = "l", col = "navy", lwd = 2, xaxp = c(1999, 2008, 3),
          xlab = "Year", ylab = "Total Emissions (thousands of tons)",
          main = "Total PM2.5 emissions", ylim = c(0, max(totalEmissions)))
     )

dev.off()
