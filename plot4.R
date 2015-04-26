
# Load packages
library("dplyr")
library("ggplot2")

# Reading the input data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Filtering data for coal related sources only
SCC_Coal <- SCC %>% filter(grepl("motor", SCC$Short.Name, ignore.case = TRUE))

# Rolling up the required data
Emissions <- 
        left_join(NEI,SCC_Coal) %>% 
        group_by(year) %>% # aggregate at yearly level
        summarise(PM = sum(Emissions)/1000) # summarize the PM emission


# Open the graphics device
png("plot4.png")

# Plot the required graph
ggplot( data = Emissions, aes(x = year, y = PM, col=PM)) + 
        geom_line() + 
        ylab(expression(paste('PM'[2.5], ' Emissions in kilotons'))) + 
        xlab('Year') + 
        scale_colour_gradient(low = 'black', high = 'red') +
        ggtitle('Emissions from Coal combustion related sources in US')

# Close the device connection
dev.off()

