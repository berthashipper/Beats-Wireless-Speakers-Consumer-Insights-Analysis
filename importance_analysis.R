# Prepare the data in long format
importance_data <- data_clean %>%
  dplyr::select(importance_sound, importance_battery, importance_design, 
                importance_connectivity, importance_durability, importance_price) %>%
  pivot_longer(cols = everything(), 
               names_to = "quality", 
               values_to = "importance") %>%
  mutate(quality = recode(quality,
                          "importance_sound" = "Sound Quality",
                          "importance_battery" = "Battery Life",
                          "importance_design" = "Design",
                          "importance_connectivity" = "Connectivity",
                          "importance_durability" = "Durability",
                          "importance_price" = "Price"))

# Summarize data for plotting
importance_summary <- importance_data %>%
  group_by(quality, importance) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count)) %>%
  ungroup()

# Calculate total proportion of high importance levels (e.g., importance 5 and 6)
high_importance_order <- importance_summary %>%
  filter(importance >= 5) %>%
  group_by(quality) %>%
  summarise(high_importance_sum = sum(proportion)) %>%
  arrange(desc(high_importance_sum)) %>%
  pull(quality)

# Order the qualities based on the calculated order
importance_summary$quality <- factor(importance_summary$quality, levels = high_importance_order)

# Create the stacked bar chart
importance_ranked_plot <- ggplot(importance_summary, aes(x = quality, y = proportion, fill = factor(importance))) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = scales::percent(proportion, accuracy = 1)), 
            position = position_stack(vjust = 0.5), 
            color = "black", 
            size = 3, 
            fontface = "bold", 
            check_overlap = TRUE) +  # Avoid overlapping text
  scale_y_continuous(labels = scales::percent_format()) +  # Show percentages on y-axis
  scale_fill_brewer(palette = "Greens", direction = 1, name = "Importance Level", 
                    breaks = as.character(1:6),
                    labels = c("1 (Low Importance)", "2", "3", "4", "5", "6 (High Importance)")) +  # Custom legend labels
  labs(title = "Ranked Importance of Speaker Features",
       x = "Feature",
       y = "Proportion of Respondents",
       fill = "Importance Level") +
  theme_minimal() +
  theme(axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        plot.title = element_text(face = "bold", hjust = 0.5),
        legend.position = "right",
        legend.title = element_text(face = "bold"),
        legend.text = element_text(size = 10))  # Adjust legend text size if needed

importance_ranked_plot


# Save the plot
ggsave("importance_ranked_plot.png", 
       plot = importance_ranked_plot, 
       width = 8, 
       height = 6, 
       dpi = 300, 
       bg = "white")
