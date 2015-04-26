
# Load packages
library("dplyr")
library("ggplot2")

# Reading the input data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Rolling up the required data
Emissions <- 
        NEI %>% 
        filter(fips == "24510" & type=="ON-ROAD") %>% # filter for baltimore city
        group_by(year) %>% # aggregate at yearly level
        summarise(PM = sum(Emissions)) # summarize the PM emission


# Open the graphics device
png("plot5.png")

# Plot the required graph
ggplot( data = Emissions, aes(x =factor(year), y = PM)) + 
        geom_bar(aes(fill=year),stat='identity') + 
        ylab(expression(paste('PM'[2.5], ' Emissions'))) + 
        xlab('Year') + 
        guides(fill = F) +
        ggtitle('Emissions from motor vehicles in Baltimore, MD')

# Close the device connection
dev.off()


