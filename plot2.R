
# Load packages
library("dplyr")

# Reading the input data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")


# Rolling up the required data
Emissions <- 
        NEI %>% 
        filter(fips == "24510") %>% # filter for baltimore city
        group_by(year) %>% # aggregate at yearly level
        summarise(PM = sum(Emissions)) # summarize the PM emission


# Open the graphics device
png("plot2.png")

# Plot the required graph
barplot(Emissions$PM,names.arg=Emissions$year, xlab = "Year",ylab=expression(paste("PM",''[2.5])),
        main = expression(paste('Total Emission of PM',''[2.5]," in Baltimore, MD")))

# Close the device connection
dev.off()