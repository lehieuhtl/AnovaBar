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

summary_data = maryland_minnesota_data %>% group_by(state) %>% 
  summarise(mean_math = mean(math),
            se_math = sd(math) / sqrt(n()))
#ggplot bar
ggplot(summary_data, aes(x = state, y = mean_math, fill = state)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = mean_math - se_math, ymax = mean_math + se_math),
                position = position_dodge(width = .9), width = .25) +
  labs(y = "Mean Math Scores", title = "Mean Math Scores by State")
