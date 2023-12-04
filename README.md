# R scripts for a reproducible analysis of logistic growth

### **Question 1**

I analysed "experiment1.csv". This dataset contained a series of population sizes (N) at given times (t). We wanted to condense all these data down into a single logistic growth function, with only three terms: K (carrying capacity), N0 (starting population size), and r (intrinsic growth rate). This function should produce a smooth curve which fits to the dataset. Our goal is to find the values of these terms (K, N0, and r) in order to produce this function. 

In order to do find these three terms, we first divided all the data into two subsets. We will fit a linear regression model to the first data subset to find N0 and r. We will fit a linear regression model to the second data subset to find K. 

The *first data subset* should contain all the values for N and t where t < 1700. This contains all the data at the early time points where the population is growing exponetially, before it appears to grow linearly: i.e., where K is much greater than N0 and t is small. Then, we transform this data subset into a log scale, which turns the relationship between N and t into an increasing linear relationship rather than an exponetially growing one. This is important because it allows you to fit a linear regression model to the data subset, as linearity is one of its assumptions. 

By looking at a summary of this linear model, we can find the N0 and r terms of our overall logistic growth function. The exponent of the y-intercept of the linear model will be N0 (the starting population size). It needs to be the exponent of the y-intercept because we need to back-transform population sizes from a log scale. It's important that we find N0 using this method rather than just looking at the value for N at t=0, because it considers potential noise or imperfections in the data and provides a more robust characterization of the initial population size. Then, the slope of the linear model will be the r term of the overall function, because it determines quickly the population grows over time. 

The *second data subset* should contain values for N and t at any time after the population size has plateaued, at the later time points: where t > 3000. This data does not need to be transformed because it is already linear, meeting the assumption of linearity for a linear model. The purpose of this data subset is purely to find K, the carrying capacity, which will be the Y-intercept of the linear model fitted to this data subset, so the timepoint can be placed anywhere within the plateau, where t is high. Again, it is important that we find K using this method, rather than estimating where the population size plateaus, to account for noise and imperfections in the data and to give a more robust estimate. 

See below for a visual representation of where the two data subsets are divided. The first subset is all the data before the first dashed line, where t < 1700. The second subset is all the data after the second dashed line, where t > 3000. 

![t_moment](https://github.com/ashsilvv/logistic_growth/assets/150149935/352c1b32-0fa9-40e6-b840-575b7efbf7b6)

These are the values of N0, r, and K that I found using the summaries of these two data subsets' linear models. 

$N_0$ = 1020.292878

$r$ = 0.009944

$K$ = 6e+10


### **Question 2**

Assuming the population grows exponentially, population size at t=4980 is **3.276982e+24**, where N <- N0 * exp(r * t). 
Assuming the population follows a logistic growth pattern, population size at t=4980 is **6e+10**, which is the carrying capacity (K), which makes sense given that the time specified is within the population size plateau - after it stops growing and reaches an equilibrium. 

The population size estimate under exponential growth is considerably larger than under logistic growth. This makes sense given that no carrying capacity is specified under exponential growth: therefore, there is no maximum population size, and the population size can continue to grow indefinitely. 


### **Question 3** 

Below is the code which produced this graph. I added a limit on the y-axis so you can see the logistic growth curve. The code can also be found as a file in my repository: it is called "logistic_exponential_curve_comparison.R". 

```
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
```
![Graph comparing exponential and logistic population growth curve](https://github.com/ashsilvv/logistic_growth/blob/main/exponential%20logistic%20curves.png?raw=true)
