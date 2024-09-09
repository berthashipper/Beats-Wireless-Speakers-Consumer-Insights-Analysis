# Define the correct order for the age ranges
age_levels <- c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65+")

# Convert age to an ordered factor
data_clean <- data_clean %>%
  mutate(age = factor(age, levels = age_levels, ordered = TRUE)) %>%
  drop_na(age) # Remove rows with NA in the age column

# Calculate counts and percentages for each age group
age_distribution_counts <- data_clean %>%
  group_by(age) %>%
  summarize(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)

# Create the age distribution plot with percentage labels
age_distribution_plot <- ggplot(age_distribution_counts, aes(x = age, y = count)) +
  geom_bar(stat = "identity", fill = "blue", color = "white") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            vjust = -0.5, size = 3, color = "black") + # Add percentage labels
  theme_minimal() +
  labs(title = "Age Distribution of Customers",
       x = "Age Range",
       y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate labels
age_distribution_plot

# Save the plot
ggsave("age_distribution_plot.png", 
       plot = age_distribution_plot, 
       width = 8, 
       height = 6, 
       dpi = 300, 
       bg = "white")

#################################

# Define the desired order of levels
levels(data_clean$usage_freq)
desired_order <- c("Daily", "Several times a week", "Once a week", "1-3 times a month", "Rarely (fewer than once a month)")

# Set the factor levels in the specified order
data_clean$usage_freq <- factor(data_clean$usage_freq, levels = desired_order)

# Calculate counts and percentages for usage frequency
usage_freq_counts <- data_clean %>%
  group_by(usage_freq) %>%
  summarize(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)

# Create bar plot for usage frequency
usage_freq_plot <- ggplot(usage_freq_counts, aes(x = usage_freq, y = count)) +
  geom_bar(stat = "identity", fill = "lightgreen", color = "white") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            vjust = -0.5, size = 3, color = "black") + # Add percentage labels
  theme_minimal() +
  labs(title = "Speaker Usage Frequency of Customers",
       x = "Usage Frequency",
       y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate labels
usage_freq_plot

# Save the plot
ggsave("usage_freq_plot.png", 
       plot = usage_freq_plot, 
       width = 6, 
       height = 8, 
       dpi = 300, 
       bg = "white")

#################################

# Define the desired order of levels
levels(data_clean$income)
desired_order <- c("Less than $25,000", "$25,000-$50,000", "$50,000-$75,000", "$75,000-$100,000", "More than $100,000", "Prefer not to say")

# Set the factor levels for income in the specified order
data_clean$income <- factor(data_clean$income, levels = desired_order)

# Calculate the count and percentage for each income level
income_counts <- data_clean %>%
  group_by(income) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100) # Calculate percentages

# Create bar plot for income distribution with percentages
income_plot <- ggplot(income_counts, aes(x = income, y = count)) +
  geom_bar(stat = "identity", fill = "goldenrod", color = "white") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            vjust = -0.5, size = 3.5) + # Add percentages as labels
  theme_minimal() +
  labs(title = "Income Distribution of Customers",
       x = "Income Range",
       y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate labels
income_plot

# Save the plot
ggsave("income_plot.png", 
       plot = income_plot, 
       width = 6, 
       height = 8, 
       dpi = 300, 
       bg = "white")

#################################

# Create summarized dataset for better visualization by age
satisfaction_summary_age <- data_clean %>%
  group_by(satisfaction, age) %>%
  summarize(count = n(), .groups = 'drop') %>%
  group_by(age) %>%
  mutate(proportion = count / sum(count))  # Calculate proportions

# Create enhanced bar plot with proportions
satisfaction_plot_age_enhanced <- ggplot(satisfaction_summary_age, aes(x = factor(satisfaction), y = proportion, fill = age)) +
  geom_bar(stat = "identity", position = position_dodge()) +  # Use position_dodge for side-by-side bars
  theme_minimal() +
  labs(title = "Customer Satisfaction Ratings by Age Group (Proportional)",
       x = "Satisfaction Rating",
       y = "Proportion") +
  scale_fill_brewer(palette = "Set1", name = "Age Group") +  # Use a color palette for better differentiation
  theme(axis.text.x = element_text(hjust = 0.5))  # Center the x-axis labels without angle adjustment

# Save the plot
ggsave("satisfaction_plot_age_enhanced.png", 
       plot = satisfaction_plot_age_enhanced, 
       width = 8, 
       height = 6, 
       dpi = 300, 
       bg = "white")

#################################

# Define the levels of interest
levels_of_interest <- c("Listening to music", 
                        "Watching movies/TV shows", 
                        "Gaming", 
                        "Podcasts/Audiobooks", 
                        "Video/audio calls (work/personal)", 
                        "Work stuff (e.g., webinars, online meetings)")

# Split multiple activities into separate rows and calculate proportions
expanded_data <- data_clean %>%
  separate_rows(speaker_usage, sep = ", ") %>%
  filter(speaker_usage %in% levels_of_interest) %>%
  count(speaker_usage) %>%
  mutate(proportion = n / sum(n))

# Plot the distribution by proportion
usage_distributions <- ggplot(expanded_data, aes(x = reorder(speaker_usage, proportion), y = proportion, fill = speaker_usage)) +
  geom_bar(stat = "identity") +
  coord_flip() +  # Flip coordinates for better readability
  labs(title = "Distribution of Speaker Usage Activities",
       x = "Speaker Usage",
       y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        plot.title = element_text(face = "bold", hjust = 0.5))

# Save the plot
ggsave("usage_distributions.png", 
       plot = usage_distributions, 
       width = 10, 
       height = 6, 
       dpi = 300, 
       bg = "white")
