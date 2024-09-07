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



# Prepare the purchase factors data
purchase_factors <- data_clean %>%
  select(purchase_recommendation, purchase_reviews, purchase_expert, 
         purchase_brand, purchase_price, purchase_features, purchase_advertising)

# Melt the data for easier plotting
purchase_factors_melted <- melt(purchase_factors)

# Calculate medians and order factors from highest to lowest
medians <- purchase_factors_melted %>%
  group_by(variable) %>%
  summarize(median_value = median(value, na.rm = TRUE))

# Order purchase factors by median from highest to lowest
purchase_factors_melted$variable <- factor(purchase_factors_melted$variable, 
                                           levels = medians$variable[order(-medians$median_value)])

# Create boxplots for each purchase factor
purchase_factors_plot <- ggplot(purchase_factors_melted, aes(x = variable, y = value)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Distribution of Purchase Factors", 
       x = "Purchase Factor", 
       y = "Importance Rating") +
  scale_x_discrete(labels = c(
    "purchase_recommendation" = "Peer Recommendations",
    "purchase_reviews" = "Customer Reviews",
    "purchase_expert" = "Expert Reviews",
    "purchase_brand" = "Brand",
    "purchase_price" = "Price",
    "purchase_features" = "Features",
    "purchase_advertising" = "Advertising"
  )) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Adjust text angle for better visibility


# Save the plot
ggsave("purchase_factors_plot.png", 
       plot = purchase_factors_plot, 
       width = 6, 
       height = 8, 
       dpi = 300, 
       bg = "white")
