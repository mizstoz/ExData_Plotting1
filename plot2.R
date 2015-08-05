Plot2 <- function()
{
        # Determine if raw data file exist
        if(!file.exists("household_power_consumption.txt")) 
        {
                # Download and extract the raw data file
                temp <- tempfile()
                message("Starting file download...")
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
                message("File downloaded, extracting raw data file...")
                file <- unzip(temp)
                unlink(temp)
                message("Raw data file extracted.")
        }else
        {
                message("Raw data file alread exists.")
        }
        
        # Read raw data file into memory
        message("Reading data into memory...")
        data <- read.table(file, header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
        
        # Subset data to extract data from the dates 2007-02-01 and 2007-02-02
        message("Filter data from the dates 2007-02-01 and 2007-02-02")
        data_of_interest <- data[data$Date %in% c("1/2/2007","2/2/2007"), ]
        
        # Merge Date and Time as one variable call date_time
        date_time <- strptime(paste(data_of_interest$Date, data_of_interest$Time, sep = " "), "%d/%m/%Y %H:%M:%S") 
        
        # Creating the required Plot
        message("Display plot on screen.")
        par(mfrow = c(1, 1))
        plot(date_time, data_of_interest$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab = "")
        
        # Create the plot in PNG format
        message("Saving plot in working folder")
        dev.copy(png, file = "plot2.png", width = 480, height = 480)
        dev.off()
        message("Plot created. Function terminated.")
}