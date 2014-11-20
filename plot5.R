## Assumes you have downloaded and extracted the data from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## and that the extracted files ("summarySCC_PM25.rds" and "Source_Classification_code.rds")
## are in your R working directory. 

## Answers question 5 by producing a PNG plot (Q5.png) to the working directory.  
## Question 5:
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
## Upload a PNG file containing your plot addressing this question.

## Note:  'motor vehicle sources', for the purpose of this exercise, is defined as anything that has a motor
##         and is used for transportation.

## Reads the files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsets SCC data frame into Mobile Vehicle Related data
SCCs <- SCC[grep("*Mobile*", SCC$EI.Sector),]

## Subsets NEI data frame into Vehicle related data. 
df <- NEI[which(NEI$SCC %in% SCCs$SCC),]

## Subsets Vehicle related data frame further into Baltimore City, MD data. 
df <- subset(df, df$fips == "24510")  ##Baltimore City subset

## Subsets df data frame by Source Type then Year
point <- subset(df, df$type == "POINT")
nonpoint <- subset(df, df$type == "NONPOINT")
onroad <- subset(df, df$type == "ON-ROAD")
nonroad <- subset(df, df$type == "NON-ROAD")

point99 <- subset(point, point$year == 1999)
nonpoint99 <- subset(nonpoint, nonpoint$year == 1999)
onroad99 <- subset(onroad, onroad$year == 1999)
nonroad99 <- subset(nonroad, nonroad$year == 1999)

point02 <- subset(point, point$year == 2002)
nonpoint02 <- subset(nonpoint, nonpoint$year == 2002)
onroad02 <- subset(onroad, onroad$year == 2002)
nonroad02 <- subset(nonroad, nonroad$year == 2002)

point05 <- subset(point, point$year == 2005)
nonpoint05 <- subset(nonpoint, nonpoint$year == 2005)
onroad05 <- subset(onroad, onroad$year == 2005)
nonroad05 <- subset(nonroad, nonroad$year == 2005)

point08 <- subset(point, point$year == 2008)
nonpoint08 <- subset(nonpoint, nonpoint$year == 2008)
onroad08 <- subset(onroad, onroad$year == 2008)
nonroad08 <- subset(nonroad, nonroad$year == 2008)


## Sums of PM2.5 emissions per type per year
point99sum <- sum(point99$Emissions)
nonpoint99sum <- sum(nonpoint99$Emissions)
onroad99sum <- sum(onroad99$Emissions)
nonroad99sum <- sum(nonroad99$Emissions)

point02sum <- sum(point02$Emissions)
nonpoint02sum <- sum(nonpoint02$Emissions)
onroad02sum <- sum(onroad02$Emissions)
nonroad02sum <- sum(nonroad02$Emissions)

point05sum <- sum(point05$Emissions)
nonpoint05sum <- sum(nonpoint05$Emissions)
onroad05sum <- sum(onroad05$Emissions)
nonroad05sum <- sum(nonroad05$Emissions)

point08sum <- sum(point08$Emissions)
nonpoint08sum <- sum(nonpoint08$Emissions)
onroad08sum <- sum(onroad08$Emissions)
nonroad08sum <- sum(nonroad08$Emissions)

## Create data frame with PM2.5 totals from each type for each year
sums <- c(point99sum, nonpoint99sum, onroad99sum, nonroad99sum, point02sum, nonpoint02sum, onroad02sum,
          nonroad02sum, point05sum, nonpoint05sum, onroad05sum, nonroad05sum, point08sum, nonpoint08sum,
          onroad08sum, nonroad08sum)
sums <- round(sums, digits=2)
years <- c(1999, 2002, 2005, 2008)
data <- data.frame(sums, c("point", "nonpoint", "onroad", "nonroad"), rep(years, each=4))
colnames(data) <- c("Total PM2.5", "Type", "Year")

## creates matrix for stacked bar plot
data_ordered <- matrix(data$Total,ncol = 4)
colnames(data_ordered) = unique(data$Year)
rownames(data_ordered) = unique(data$Type)


## Plots the graph to PNG file
png ("Q5.png", width=480, height=480)
barplot(data_ordered, col = topo.colors(length(rownames(data_ordered))), 
        main="Motor Vehicle Related PM2.5 Emissions in Baltimore City, MD", xlab="Year", 
        ylab="PM2.5")
legend(title = "Type", "topright", fill = topo.colors(length(rownames(data_ordered))), legend = rownames(data_ordered))
dev.off()

## As of 2008, Total Motor Vehicle Emissions for Baltimore City, MD have decreased since 1999. A further look into the 
## emissions source shows that both onroad and nonroad pollutant levels have decreased over that time period, though
## a sudden appearance of nonpoint source emissions in 2008 might have an effect on the reclassification of source type.  

