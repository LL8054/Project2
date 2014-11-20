## Assumes you have downloaded and extracted the data from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## and that the extracted files ("summarySCC_PM25.rds" and "Source_Classification_code.rds")
## are in your R working directory. 

## Answers question 4 by producing a PNG plot (Q4.png) to the working directory.  
## Question 4:
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## Reads the files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsets SCC data frame into SCCs that are coal combustion related
SCCs <- SCC[grep("*Coal", SCC$EI.Sector),]

## Subsets NEI data frame into coal combustion related data.  note, i do NOT include combustion labelled OTHER
df <- NEI[which(NEI$SCC %in% SCCs$SCC),]

## Subsets df data frame by Source Type
point <- subset(df, df$type == "POINT")
nonpoint <- subset(df, df$type == "NONPOINT")

point99 <- subset(point, point$year == 1999)
nonpoint99 <- subset(nonpoint, nonpoint$year == 1999)

point02 <- subset(point, point$year == 2002)
nonpoint02 <- subset(nonpoint, nonpoint$year == 2002)

point05 <- subset(point, point$year == 2005)
nonpoint05 <- subset(nonpoint, nonpoint$year == 2005)

point08 <- subset(point, point$year == 2008)
nonpoint08 <- subset(nonpoint, nonpoint$year == 2008)


## Sums of PM2.5 emissions per type per year
point99sum <- sum(point99$Emissions)
nonpoint99sum <- sum(nonpoint99$Emissions)

point02sum <- sum(point02$Emissions)
nonpoint02sum <- sum(nonpoint02$Emissions)

point05sum <- sum(point05$Emissions)
nonpoint05sum <- sum(nonpoint05$Emissions)

point08sum <- sum(point08$Emissions)
nonpoint08sum <- sum(nonpoint08$Emissions)

## Create data frame with PM2.5 totals from each type for each year
sums <- c(point99sum/100000, nonpoint99sum/100000, point02sum/100000, nonpoint02sum/100000, point05sum/100000, 
          nonpoint05sum/100000, point08sum/100000, nonpoint08sum/100000)
sums <- round(sums, digits=2)
years <- c(1999, 2002, 2005, 2008)
data <- data.frame(sums, c("point", "nonpoint"), rep(years, each=2))
colnames(data) <- c("Total PM2.5", "Type", "Year")

## creates matrix for stacked bar plot
data_ordered <- matrix(data$Total,ncol = 4)
colnames(data_ordered) = unique(data$Year)
rownames(data_ordered) = unique(data$Type)


## Plots the graph to PNG file
png ("Q4.png", width=480, height=480)


#par(mar = c(5.1, 4.1, 4.1, 7.1), xpd = TRUE)
barplot(data_ordered, col = heat.colors(length(rownames(data_ordered))), 
        main="Total Coal Combustion Related PM2.5 Emissions", xlab="Year", ylab="PM2.5 (per 100,000)")
legend(title = "Type", "topright", fill = heat.colors(length(rownames(data_ordered))), legend = rownames(data_ordered))
dev.off()

##Total PM2.5 Emissions from Coal Combustion sources across the US have gradually declined from 1999 - 2008. 



