
# Load packages
library("dplyr")
library("ggplot2")

# Reading the input data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")


# Rolling up the required data
Emissions <- 
        NEI %>% 
        filter(fips == "24510") %>% # filter for baltimore city
        group_by(year,type) %>% # aggregate at yearly level
        summarise(PM = sum(Emissions)) # summarize the PM emission


# Open the graphics device
png("plot3.png")

# Plot the required graph
ggplot( data = Emissions, aes(x = year, y = PM, color=type)) + 
        geom_line() + 
        ylab(expression(paste('Total of PM'[2.5], ' Emissions'))) + 
        xlab('Year') + 
        ggtitle('Emissions by Type in Baltimore City, Maryland')

# Close the device connection
dev.off()
