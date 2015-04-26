
# Load packages
library("dplyr")

# Reading the input data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")


# Rolling up the required data
Emissions <- 
                NEI %>% 
                group_by(year) %>% # aggregate at yearly level
                summarise(PM = round(sum(Emissions)/1000,2)) # summarize the PM emission


# Open the graphics device
png("plot1.png")

# Plot the required graph
barplot(Emissions$PM,names.arg=Emissions$year, xlab = "Year",ylab=expression(paste("PM",''[2.5]," in kilotons")),main = expression('Total Emission of PM'[2.5]))

# Close the device connection
dev.off()
