 #Run.Capture.Recapture
#Description: Driver script that sources utility script simulate.pops function to output 1000 trials of the capture recapture study. A histogram is created to visualize the distribution of the data collected.

#commandine arguments should put in the following order after sourcing the Rscript from a bash terminal: total fish population, number to fish to be tagged, number of tagged fish to be recaptured.
args <- commandArgs(trailingOnly = TRUE)


#error message for when no arguments are given to the commandline.
if (length(args) == 0) {
	cat("Error: Specify value of fish population, number of fish to be tagged, and number of tagged fish to be recaptured.", "\n")
	cat("Usage Example: Rscript Run.Capture.Recapture.R 100 10 5", "\n")
	quit()
}

#error message for when less or greater than 3 arguments are given to the commandline
if (length(args) != 3) {
	cat("Error: Three arguments must be provided to the command-line.", "\n")
	cat("Usage Example: Rscript Run.Capture.Recapture.R 100 10 5", "\n")
	quit()
}

#added function to ensure that all arguments are recognized by the script as numeric
numeric.args <- as.numeric(args)

#error message for when arguments are not numeric integers.
if (all(is.na(numeric.args) == TRUE)) {
	cat("Error: All arguments must be numeric integers.", "\n")
	cat("Usage Example: Rscript Run.Capture.Recapture.R 100 10 5", "\n")
	quit()
}


#error message for when arguments are not positive numeric integers.
if ((numeric.args[1] & numeric.args[2] & numeric.args[3] < 0 ) == TRUE) {
	cat("Error: All arguments must be positive integers.", "\n")
	cat("Usage Example: Rscript Run.Capture.Recapture.R 100 10 5", "\n")
	quit()
}

#error message for when number of fish to be tagged or number of tagged fish to be recaptured is greater than the given fish population value.
if ((numeric.args[2] & numeric.args[3] >= numeric.args[1]) == TRUE) {
	cat("Error: Fish population must be greater than number of fish tagged and tagged fish to be recaptured.", "\n")
	cat("Usage Example: Rscript Run.Capture.Recapture.R 100 10 5", "\n")
	quit()
}

#error message for when the number of tagged fish is less than the number of tagged fish that need to be recaptured.
if (numeric.args[2] < numeric.args[3]) {
	cat("Error: Number of tagged fish must be greater than number of fish to be recaptured.", "\n")
	cat("Usage Example: Rscript Run.Capture.Recapture.R 100 10 5", "\n")
	quit()
}

#commandline message to indicate that simulate.pops function is running to calculate the 1000 trials of estimated fish populations
cat("Calculating estimated fish populations...", "\n")

#sourcing the utility file with the required functions for the capture-recapture simulation.
source("Capture.Recapture.Utilities.R")

#creating a new vector that allows the study to be run 1000 times, generating a vector of population estimates from each trial.
estimated.fish.pops <- rep(numeric.args[1], 1000)

#simulate.pops function is run 1000 times using the arguments supplied when sourcing the Rscript in the bash commandline.
result <- sapply(estimated.fish.pops, simulate.pops, numeric.args[2], numeric.args[3])

#commandline message to indicate that histogram is being generated for the data
cat("Generating histogram of data...", "\n")

#histogram will be generated as a pdf in the current working directory, displaying the distribution of the estimated population values.
hist(result, main = "Histogram of Estimated Fish Population Data", xlab = "Estimated Fish Population", ylab = "Frequency")


#commandline message to indicate that all portions of the driver script have been completed.
cat("Done.", "\n")

