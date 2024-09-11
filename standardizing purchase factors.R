# Function to standardize the advertising ratings
standardize_ratings <- function(value) {
  if (is.numeric(value)) {
    return(value)  # Return numeric values directly
  } else if (grepl("^1", value)) {
    return(1)  # "1 (Not Important)"
  } else if (grepl("^2", value)) {
    return(2)  # "2 (Somewhat Important)"
  } else if (grepl("^3", value)) {
    return(3)  # "3 (Important, but not a deal breaker)"
  } else if (grepl("^4", value)) {
    return(4)  # "4 (Important)"
  } else if (grepl("^5", value)) {
    return(5)  # "5 (Very Important)"
  } else {
    return(NA)  # Return NA for unexpected formats
  }
}

# Apply the function to all relevant purchase columns
data_clean <- data_clean %>%
  mutate(
    purchase_recommendation = sapply(purchase_recommendation, standardize_ratings),
    purchase_reviews = sapply(purchase_reviews, standardize_ratings),
    purchase_expert = sapply(purchase_expert, standardize_ratings),
    purchase_brand = sapply(purchase_brand, standardize_ratings),
    purchase_price = sapply(purchase_price, standardize_ratings),
    purchase_features = sapply(purchase_features, standardize_ratings),
    purchase_advertising = sapply(purchase_advertising, standardize_ratings)
  )

# Check the updated structure
str(data_clean)

#####################

# Prepare the data in long format
purchase_factors_long <- clean_purchase_factors %>%
  pivot_longer(cols = everything(), 
               names_to = "factor", 
               values_to = "importance") %>%
  mutate(factor = recode(factor,
                         "purchase_recommendation" = "Recommendations",
                         "purchase_reviews" = "Customer Reviews",
                         "purchase_expert" = "Expert Reviews",
                         "purchase_brand" = "Brand",
                         "purchase_price" = "Price",
                         "purchase_features" = "Features",
                         "purchase_advertising" = "Advertising"))

# Summarize data for plotting
purchase_summary <- purchase_factors_long %>%
  group_by(factor, importance) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count)) %>%
  ungroup()

# Calculate total proportion of high importance levels (e.g., importance 5)
high_importance_order <- purchase_summary %>%
  filter(importance == 5) %>%
  group_by(factor) %>%
  summarise(high_importance_sum = sum(proportion)) %>%
  arrange(desc(high_importance_sum)) %>%
  pull(factor)

# Order the factors based on the calculated order
purchase_summary$factor <- factor(purchase_summary$factor, levels = high_importance_order)

# Create the stacked bar chart
purchase_factors_ranked <- ggplot(purchase_summary, aes(x = factor, y = proportion, fill = factor(importance))) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = scales::percent(proportion, accuracy = 1)), 
            position = position_stack(vjust = 0.5), 
            color = "black", 
            size = 3, 
            fontface = "bold", 
            check_overlap = TRUE) +  # Avoid overlapping text
  scale_y_continuous(labels = scales::percent_format()) +  # Show percentages on y-axis
  scale_fill_brewer(palette = "RdYlGn", direction = 1, name = "Importance Level", 
                    breaks = as.character(1:5),
                    labels = c("1 (Low Impact)", "2", "3", "4", "5 (High Impact)")) +  # Custom legend labels
  labs(title = "Ranked Importance of Factors that Influence Purchase",
       x = "Purchase Factor",
       y = "Proportion of Respondents",
       fill = "Importance Level") +
  theme_minimal() +
  theme(axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        plot.title = element_text(face = "bold", hjust = 0.5),
        legend.position = "right",
        legend.title = element_text(face = "bold"),
        legend.text = element_text(size = 10),
        axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),  # Rotate x-axis labels
        plot.margin = margin(10, 10, 10, 30))  # Increase bottom margin to space out labels

# Display the plot
print(purchase_factors_ranked)

# Save the plot
ggsave("purchase_ranked_plot.png", 
       plot = purchase_factors_ranked, 
       width = 8, 
       height = 6, 
       dpi = 300, 
       bg = "white")
