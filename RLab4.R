library(tidyverse)
library(rstatix)

# Import dataset
sat_data = read_csv('SAT.csv')
#New data frame
maryland_minnesota_data = sat_data %>%
  filter(state %in% c("Maryland", "Minnesota"))
#Conduct t-test comparing the math scores
t_test_results = t_test(math ~ state, data = maryland_minnesota_data)
print(t_test_results)
