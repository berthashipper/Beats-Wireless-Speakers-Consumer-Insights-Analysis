# Filter out rows with NA/NaN/Inf values in relevant columns
data_clean <- data_clean %>%
  filter(!is.na(age), !is.na(income), !is.na(importance_sound), !is.na(importance_battery), !is.na(importance_design))


# Select relevant columns for segmentation
data_segment <- data_clean %>%
  dplyr::select(age, income, usage_freq, importance_sound, importance_battery, importance_design)

# Convert categorical variables to numeric
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

# Create the plot with jitter to make trends visible
customer_segment_plot <- ggplot(data_clean, aes(x = importance_sound, y = importance_battery, color = cluster_name)) +
  geom_point(alpha = 0.7, size = 4, position = position_jitter(width = 0.6, height = 0.6)) +  # Increased jitter
  theme_minimal() +
  labs(title = "Customer Segmentation using K-means Clustering",
       x = "Ranked Importance of Sound",
       y = "Ranked Importance of Battery",
       color = "Customer Segment") +
  scale_color_manual(values = c("SOUND QUALITY" = "#E87D72", 
                                "PERFORMANCE" = "#53B74C", 
                                "LOOKS" = "#6E9AF8")) +
  scale_x_continuous(breaks = seq(1, 6, 1), 
                     labels = c("1 (Low)", "2", "3", "4", "5", "6 (High)")) +
  scale_y_continuous(breaks = seq(1, 6, 1), 
                     labels = c("1 (Low)", "2", "3", "4", "5", "6 (High)")) +
  theme(legend.position = "right",
        plot.title = element_text(face = "bold", hjust = 0.5),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14, face = "bold"))
customer_segment_plot

# Save the plot
ggsave("customer_segmentation_by_values_plot.png", 
       plot = customer_segment_plot, 
       width = 8, 
       height = 6, 
       dpi = 300, 
       bg = "white")




# Remove NA values from the dataset
clean_data <- data_clean %>%
  filter(!is.na(age) & !is.na(income) & !is.na(cluster))  # Adjust to include other relevant factors if needed

data_clean <- data_clean %>%
  mutate(cluster = factor(cluster))  # Ensure cluster is a factor for analysis

# Summary statistics by cluster for demographic variables
demographic_summary <- data_clean %>%
  group_by(cluster) %>%
  summarise(
    age_mean = mean(as.numeric(age), na.rm = TRUE),
    income_mean = mean(as.numeric(income_numeric), na.rm = TRUE),
    age_sd = sd(as.numeric(age), na.rm = TRUE),
    income_sd = sd(as.numeric(income_numeric), na.rm = TRUE),
    count = n()
  )
print(demographic_summary)

# Calculate percentages for income distribution
income_percentage <- clean_data %>%
  group_by(cluster, income) %>%
  summarise(count = n()) %>%
  group_by(cluster) %>%
  mutate(percentage = count / sum(count) * 100)

# Define custom x-axis labels
custom_labels <- c("<$25K", "$25K-$50K", "$50K-$75K", "$75K-$100K", ">$100K")

# Visualize income distribution by cluster
income_clusters <- ggplot(income_percentage, aes(x = income, y = percentage, fill = cluster)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            position = position_dodge(width = 0.9), 
            vjust = -0.5) +  # Adjust text position as needed
  scale_x_discrete(labels = custom_labels) +  # Apply custom labels
  labs(title = "Income Distribution by Cluster",
       x = "Income Range",
       y = "Percentage",
       fill = "Cluster") +
  theme_minimal()
income_clusters

# Calculate percentages for age distribution
age_percentage <- clean_data %>%
  group_by(cluster, age) %>%
  summarise(count = n()) %>%
  group_by(cluster) %>%
  mutate(percentage = count / sum(count) * 100)

# Visualize age distribution by cluster
age_clusters <- ggplot(age_percentage, aes(x = age, y = percentage, fill = cluster)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            position = position_dodge(width = 0.9), 
            vjust = -0.5) +  # Adjust text position as needed
  labs(title = "Age Distribution by Cluster",
       x = "Age Range",
       y = "Percentage",
       fill = "Cluster") +
  theme_minimal()
age_clusters

# Calculate percentages for usage frequency distribution
usage_freq_percentage <- clean_data %>%
  group_by(cluster, usage_freq) %>%
  summarise(count = n()) %>%
  group_by(cluster) %>%
  mutate(percentage = count / sum(count) * 100)

# Visualize usage frequency distribution by cluster
usage_freq_clusters <- ggplot(usage_freq_percentage, aes(x = usage_freq, y = percentage, fill = cluster)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            position = position_dodge(width = 0.9), 
            vjust = -0.5) +  # Adjust text position as needed
  labs(title = "Usage Frequency Distribution by Cluster",
       x = "Usage Frequency",
       y = "Percentage",
       fill = "Cluster") +
  scale_x_discrete(labels = c("Daily" = "Daily", 
                              "Several times a week" = "Several times a week", 
                              "Once a week" = "Once a week", 
                              "1-3 times a month" = "1-3 times a month", 
                              "Rarely (fewer than once a month)" = "Les than once a month")) +  # Rename x-axis labels
  theme_minimal() +
  theme(axis.text.x = element_text(margin = margin(t = 10)))  # Increase margin at the top of x-axis labels
usage_freq_clusters

# Visualize importance ratings for sound, battery, and design by cluster

# Plot importance ratings
sound_importance_clusters <- ggplot(clean_data, aes(x = factor(cluster), y = importance_sound, fill = factor(cluster))) +
  geom_boxplot(outlier.shape = NA) +  # Remove default outliers to better see jitter
  geom_jitter(width = 0.2, alpha = 0.5, size = 1.5) +  # Add jitter with transparency and size adjustment
  labs(title = "Importance of Sound by Cluster",
       x = "Cluster",
       y = "Importance Rating",
       fill = "Cluster") +
  theme_minimal()
sound_importance_clusters

battery_importance_clusters <- ggplot(clean_data, aes(x = factor(cluster), y = importance_battery, fill = factor(cluster))) +
  geom_boxplot(outlier.shape = NA) +  # Remove default outliers to better see jitter
  geom_jitter(width = 0.2, alpha = 0.5, size = 1.5) +  # Add jitter with transparency and size adjustment
  labs(title = "Importance of Battery by Cluster",
       x = "Cluster",
       y = "Importance Rating",
       fill = "Cluster") +
  theme_minimal()
battery_importance_clusters

design_importance_clusters <- ggplot(clean_data, aes(x = factor(cluster), y = importance_design, fill = factor(cluster))) +
  geom_boxplot(outlier.shape = NA) +  # Remove default outliers to better see jitter
  geom_jitter(width = 0.2, alpha = 0.5, size = 1.5) +  # Add jitter with transparency and size adjustment
  labs(title = "Importance of Design by Cluster",
       x = "Cluster",
       y = "Importance Rating",
       fill = "Cluster") +
  theme_minimal()
design_importance_clusters

ggsave("income_distribution_by_cluster.png", plot = income_clusters, width = 8, height = 6, dpi = 300, bg = "white")
ggsave("age_distribution_by_cluster.png", plot = age_clusters, width = 8, height = 6, dpi = 300, bg = "white")
ggsave("usage_frequency_distribution_by_cluster.png", plot = usage_freq_clusters, width = 8, height = 6, dpi = 300, bg = "white")
ggsave("importance_of_sound_by_cluster.png", plot = sound_importance_clusters, width = 8, height = 6, dpi = 300, bg = "white")
ggsave("importance_of_battery_by_cluster.png", plot = battery_importance_clusters, width = 8, height = 6, dpi = 300, bg = "white")
ggsave("importance_of_design_by_cluster.png", plot = design_importance_clusters, width = 8, height = 6, dpi = 300, bg = "white")
