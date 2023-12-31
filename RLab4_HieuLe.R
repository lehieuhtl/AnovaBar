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

#Perform one way anova
anova_result = anova_test(data = sat_data, dv = math, between = state)
print(anova_result)

#The anova is able to provide us with the important p value.
#P value basically lets us know about significance
#Below .5 commonly means its a significant difference, it is

summary_data_all = sat_data %>%
  group_by(state) %>%
  summarise(mean_math = mean(math),
            se_math = sd(math) / sqrt(n())
  )

#ggplot time
ggplot(summary_data_all, aes(x = state, y = mean_math, fill = state)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = mean_math - se_math, ymax = mean_math + se_math),
                position = position_dodge(width = 0.9), width = 0.25) +
  labs(y = "Mean Math Scores", title = "Mean Math Scores by State") +
  scale_fill_manual(values = c("Maryland" = "blue", "Texas" = "red",
                               "Minnesota" = "green"))




