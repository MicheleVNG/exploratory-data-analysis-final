data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!dir.exists("data")) { dir.create("data") }

download.file(data_url, destfile = "data/NEI_data.zip")
unzip("data/NEI_data.zip", exdir = "data")
file.remove("data/NEI_data.zip")