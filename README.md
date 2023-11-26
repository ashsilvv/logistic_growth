# R scripts for a reproducible analysis of logistic growth

**Question 1**

*I used "experiment1.csv".*

In this analysis, we took an existing dataset containing a series of population sizes (N) at given times (t). We wanted to condense all these data down into a single logistic growth function with only three terms: K (carrying capacity), N0 (starting population size), and r (growth rate). This function should produce a smooth curve which fits to the dataset. Our goal is to find the values of these terms (K, N0, and r) in order to produce this function. 
In order to do find these three terms, we first divided all the data into two subsets. 
The first data subset will be used to find N0 and r. 
The second data subset will be used to find K. 

*Data subset 1*

The first data subset should contain all the values for N and t before the point where t = ~1700. This contains all the data at the early time points where the population is growing exponetially, before it appears to grow linearly. Then, we transform this data subset into a log scale, which turns the relationship between N and t into an increasing linear relationship rather than an exponetially growing one. This is important because it allows you to fit a linear model to the data subset, as linearity is one of its assumptions. 

By looking at a summary of this linear model, we can find the N0 and r terms of our overall logistic growth function. The exponent of the y-intercept of the linear model will be N0 (the starting population size). It needs to be the exponent of the y-intercept because population sizes are currently in a log scale. It's important that we find N0 using this method rather than just looking at the value for N at t=0, because it considers potential noise or imperfections in the data and provides a more robust characterization of the initial population size. Then, the slope of the linear model will be the r term of the overall function, because it determines quickly the population grows over time. 

*Data subset 2*

The second data subset should contain values for N and t at any time after the population size has plateaued: e.g., all data after t=3000. This data does not need to be transformed because it is already linear, meeting the assumption of linearity for a linear model. The purpose of this data subset is purely to find K, the carrying capacity, which will be the Y-intercept of the linear model fitted to this data subset. Again, it is important that we find K using this method, rather than estimating where the population size plateaus, to account for noise and imperfections in the data and to give a more robust estimate. 

These are the values of N0, r, and K that I found using the summaries of these two data subsets' linear models. 

$N_0$ = 1020.292878

$r$ = 0.009944

$K$ = 6e+10


**Question 2**
Assuming the population grows exponentially, population size at t=4980 is **3.276982e+24**, where N <- N0 * exp(r * t). 
Assuming the population follows a logistic growth pattern, population size at t=4980 is **6e+10**, which is the carrying capacity (K), which makes sense given that the time specified is within the population size plateau - after it stops growing and reaches an equilibrium. 
The population size estimate under exponential growth is considerably larger than under logistic growth. This makes sense given that no carrying capacity is specified under exponential growth: therefore, there is no maximum population size, and the population size can continue to grow indefinitely. 


**Question 3** 
