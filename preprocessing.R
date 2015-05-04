
setwd('/Users/evansadler/Desktop/Programming/react map')

data <- read.csv('data.csv', stringsAsFactors=FALSE, fileEncoding="latin1")
data <- na.omit(data)
# Remove units and commas/ convert to numeric
data$X2013.land.area <- as.numeric(gsub("[^[:digit:]]", '', data$X2013.land.area))
data$X2013.population.density <- as.numeric(gsub("[^[:digit:]]", '', data$X2013.population.density))
data$City <- gsub("[^[:alpha:] ]", '', data$City)

# Split up Lat and Lon
list <- strsplit(data$Location, " ")
mat <- matrix(unlist(list), ncol=2, byrow=TRUE)
colnames(mat) <- c("lat", "lon")
df<- as.data.frame(mat)
data <- cbind(data, df)


# CLean Lat and Lon
data$lon <- as.numeric(gsub("[^[:digit:].]", '', data$lon))
data$lon <- -data$lon
data$lat <- as.numeric(gsub("[^[:digit:].]", '', data$lat))

data.growth <- data[, names(data) %in% c('City','State','lat','lon','Change')]

write.csv(data.growth, file = "growth.csv",row.names=FALSE)

data.population <- data[, names(data) %in% c('City','State','lat','lon','X2013.estimate')]


write.csv(data.population, file = "population.csv", row.names = FALSE)
