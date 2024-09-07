# Select relevant columns for segmentation
data_segment <- data_clean %>%
  dplyr::select(age, income, usage_freq, importance_sound, importance_battery, importance_design)

# Convert categorical variables to numeric (if necessary)
data_segment$age <- as.numeric(factor(data_segment$age))
data_segment$income <- as.numeric(factor(data_segment$income))
data_segment$usage_freq <- as.numeric(factor(data_segment$usage_freq))

# Scale the data
data_scaled <- scale(data_segment)

# Determine the optimal number of clusters using the Elbow Method
wss <- sapply(1:10, function(k) {
  kmeans(data_scaled, centers = k, nstart = 10)$tot.withinss
})

# Plot the Elbow Method results
plot(1:10, wss, type = "b", pch = 19, 
     xlab = "Number of Clusters", 
     ylab = "Total Within-Cluster Sum of Squares",
     main = "Elbow Method")

# Set the number of clusters (e.g., 3)
set.seed(123)  # For reproducibility
k <- 3
kmeans_result <- kmeans(data_scaled, centers = k, nstart = 10)

# Add cluster assignments to the original data
data_clean$cluster <- as.factor(kmeans_result$cluster)

# Analyze the clusters
aggregate(data_clean[, c("importance_sound", "importance_battery", "importance_design")], 
          by = list(cluster = data_clean$cluster), 
          FUN = mean)

# Visualize the clusters
library(ggplot2)

ggplot(data_clean, aes(x = importance_sound, y = importance_battery, color = cluster)) +
  geom_point() +
  theme_minimal() +
  labs(title = "Customer Segmentation using K-means Clustering",
       x = "Importance of Sound",
       y = "Importance of Battery")

# Calculate means for each cluster
cluster_summary <- aggregate(data_clean[, c("importance_sound", "importance_battery", "importance_design")],
                             by = list(cluster = data_clean$cluster),
                             FUN = mean)

# Print the summary
print(cluster_summary)

# Assign meaningful names to the clusters in the dataset
data_clean$cluster_name <- case_when(
  data_clean$cluster == 1 ~ "SOUND QUALITY",
  data_clean$cluster == 2 ~ "PERFORMANCE",
  data_clean$cluster == 3 ~ "LOOKS"
)

# Create the plot with meaningful cluster names
customer_segment_plot <- ggplot(data_clean, aes(x = importance_sound, y = importance_battery, color = cluster_name)) +
  geom_point(alpha = 0.7) +
  theme_minimal() +
  labs(title = "Customer Segmentation using K-means Clustering",
       x = "Importance of Sound",
       y = "Importance of Battery",
       color = "Customer Segment") +
  scale_color_manual(values = c("SOUND QUALITY" = "blue", 
                                "PERFORMANCE" = "green", 
                                "LOOKS" = "orange")) +
  theme(legend.position = "right")

# Save the plot
ggsave("customer_segmentation_plot.png", plot = customer_segment_plot, width = 8, height = 6, dpi = 300)
![Customer Segmentation Plot](customer_segmentation_plot.png)
