#reading in the data
growth_data <- read.csv("experiment1.csv")

# creating logistic growth function
logistic_fun <- function(t) {
  N <- (N0*K*exp(r*t))/(K-N0+N0*exp(r*t))
  return(N)
}

#parameter estimates 
N0 <- 1020.292878
r <- 0.009944
K <- 6e+10

# population size estimate under logistic growth 
t_value <- 4980
population_size <- logistic_fun(t_value)
population_size

# creating an exponential growth function 
exponential_fun <- function(t) {
  N <- N0 * exp(r * t)
  return(N)
}

# population size estimate under exponential growth
population_size2 <- exponential_fun(t_value)
population_size2

# plotting both functions on one graph 
library(ggplot2)
ggplot(aes(t, N), data = growth_data) +
  geom_point() + # adding data points 
  stat_function(fun = logistic_fun, aes(colour = "Logistic"), linewidth = 0.7) +
  stat_function(fun = exponential_fun, aes(colour = "Exponential"), linewidth = 0.7) +
  labs(title = "Comparison of Logistic and Exponential Growth Curves", 
       x = "Time (t)", y = "Population size (N)") +
  scale_colour_manual(values = c("Logistic" = "red", "Exponential" = "blue")) + 
  ylim(0, 10e10) # adding a limit on y-axis so you can see the logistic growth curve


