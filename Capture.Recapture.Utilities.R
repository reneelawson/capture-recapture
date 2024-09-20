#Capture.Recapture.Utilities
#Description: Utility file containing functions used to simulate a capture-recapture method fish population study. 


#tag.population function takes the estimated fish population and the number of fish that should be tagged as arguments, outputting a vector representing the fish that were tagged using random sampling.
tag.population <- function(fish.pop, fish.to.tag){
	result <- sample(fish.pop, size = fish.to.tag, replace = TRUE)
	return(result)
}

#catch.fish function takes the tagged population vector, the estimated fish population, and the number of tagged fish to be recaptured to calculate how many catches it would take to catch the specified amount of tagged fish.
catch.fish <- function(tagged.pop, fish.pop, tagged.fish.to.catch){
	
	#two variables are created to count the total amount of fish caught and the total amont of tagged fish caught
	total.catch <- 0
	total.tagged.catch <- 0

	#loop will stop running after the specified number of tagged fish are caught
	while (total.tagged.catch < tagged.fish.to.catch){
		
		#if the randomly sampled fish is equal to one of the fish in the tagged population vector, it will be counted under the total tagged fish caught variable.
		if (sample(fish.pop, 1) %in% tagged.pop) 
		total.tagged.catch <- total.tagged.catch + 1

	#if the randomly sampled fish is not equal to one of the fish in the tagged population vector, it will be counted under the total fish caught variable.	
	else (sample(fish.pop, 1))
		total.catch <- total.catch + 1
		
	}
	#returns the value for the total fish caught
	return(total.catch)
}


#calc.N function takes the number of fish originally tagged, the number of tagged fish to be recaptured, and the number of catches it took to catch that specified number of tagged fish as arguments to calculated the estimated fish population.
calc.N <- function(fish.to.tag, need.to.catch, tagged.fish.to.catch){
	result <- (fish.to.tag*need.to.catch)/tagged.fish.to.catch
	return(result)
}

#simulate.pops combines the three functions above to create on overall function that simulates all three steps of the capture-recaptur fish population study. It takes the fish population, number of fish to be tagged, and the number of tagged fish to be recaptured as arguments.
simulate.pops <- function(fish.pop, fish.to.tag, tagged.fish.to.catch){
	
	tagged.pop <- tag.population(fish.pop, fish.to.tag)
	need.to.catch <- catch.fish(tagged.pop, fish.pop, tagged.fish.to.catch)
	result <- calc.N(fish.to.tag, need.to.catch, tagged.fish.to.catch)
	
	#returns the estimated population of fish after conducting all three steps of the capture-recapture method.
	return(result)
}
