## Assumes you have downloaded and extracted the data from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## and that the extracted files ("summarySCC_PM25.rds" and "Source_Classification_code.rds")
## are in your R working directory. 

## Answers question 2 by producing a PNG bar plot (Q2.png) to the working directory.  
## Question 2:
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## Reads the files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsets NEI data frame first into Baltimore City then into years needed for plot
NEIs1 <- subset(NEI, NEI$fips == "24510")  ##Baltimore City subset
y1999bcma <- subset(NEIs1, NEIs1$year == 1999)
y2002bcma <- subset(NEIs1, NEIs1$year == 2002)
y2005bcma <- subset(NEIs1, NEIs1$year == 2005)
y2008bcma <- subset(NEIs1, NEIs1$year == 2008)

## Sums up total PM2.5 emissions per year
sum1999bcma <- sum(y1999bcma$Emissions)
sum2002bcma <- sum(y2002bcma$Emissions)
sum2005bcma <- sum(y2005bcma$Emissions)
sum2008bcma <- sum(y2008bcma$Emissions)

## Create data frame with totals from years
sums <- c(sum1999bcma, sum2002bcma, sum2005bcma, sum2008bcma)
sums <- round(sums, digits=2)
years <- c(1999, 2002, 2005, 2008)
totalPM2.5bcma <- data.frame(sums, years)
colnames(totalPM2.5bcma) <- c("totalPM2.5 for Baltimore City, MD", "year")

## Plots the graph to PNG file
png ("Q2.png", width=480, height=480)
barplot(totalPM2.5bcma$totalPM2.5, names.arg=totalPM2.5bcma$year, 
        main="Total PM2.5 for Baltimore City, MD -All Sources", 
        xlab="Year", ylab="PM2.5")
dev.off()

## Yes, total PM2.5 levels in Baltimore City, MD have decreased from 1999 to 2008. 




