

# Load packages
library("dplyr")
library("ggplot2")

# Reading the input data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Rolling up the required data
Emissions <- 
        NEI %>% 
        filter(fips %in% c("24510","06037") & type=="ON-ROAD") %>% # filter for baltimore and LA
        mutate(city = ifelse(fips == "06037","LA County","Baltimore City")) %>%
        group_by(city,year) %>% # aggregate at yearly level
        summarise(PM = sum(Emissions)) # summarize the PM emission


# Open the graphics device
png("plot6.png")

# Plot the required graph
ggplot( data = Emissions, aes(x =factor(year), y = PM)) + 
        facet_grid(. ~ city) +
        geom_bar(aes(fill=year),stat='identity') + 
        ylab(expression(paste('PM'[2.5], ' Emissions'))) + 
        xlab('Year') + 
        guides(fill = F) +
        ggtitle('Motor Vehicle Emissions - Baltimore, MD v/s LA County')

# Close the device connection
dev.off()



