# Convert list column to a character vector
data_clean <- data_clean %>%
  mutate(sound_quality_feedback = map_chr(sound_quality_feedback, ~paste(.x, collapse = " ")))

# Create data frame
feedback_df <- data_clean %>%
  select(sound_quality_feedback) %>%
  mutate(id = row_number())

# Tokenize words from the feedback
feedback_words <- feedback_df %>%
  unnest_tokens(word, sound_quality_feedback) %>%
  anti_join(get_stopwords())

# Get sentiment lexicon
sentiment_lexicon <- get_sentiments("bing")

# Calculate sentiment scores
sentiment_scores <- feedback_words %>%
  inner_join(sentiment_lexicon, by = "word") %>%
  count(id, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment_score = positive - negative)

# Summarize sentiment scores
sentiment_summary <- sentiment_scores %>%
  summarise(
    avg_sentiment = mean(sentiment_score, na.rm = TRUE),
    sd_sentiment = sd(sentiment_score, na.rm = TRUE)
  )

print(sentiment_summary)
# The average sentiment score of 0.975 indicates that, on average,
# the feedback about sound quality is positive. This value is above 0,
#suggesting that the general sentiment in the feedback is leaning towards
#positive sentiments rather than negative ones.

#The standard deviation of 1.26 reflects the variability or dispersion of
#sentiment scores around the average. A higher standard deviation suggests
#that there is a substantial range of sentiment scores, meaning that while
#the average sentiment is positive, there are diverse opinions with some being
#more positive and others less positive or even negative.


# Visualize the distribution of sentiment scores
feedback_sentiment_distribution <- ggplot(sentiment_scores, aes(x = sentiment_score)) +
  geom_histogram(binwidth = 1) +
  labs(title = "Distribution of Sentiment Scores",
       x = "Sentiment Score",
       y = "Frequency")

# Save the plot
ggsave("feedback_sentiment_distribution.png", 
       plot = feedback_sentiment_distribution, 
       width = 8, 
       height = 6, 
       dpi = 300, 
       bg = "white")



# Define the order of categories from lowest to highest
amount_spent_levels <- c("Less than $50", "$50 to $100", "$100 to $200", "$200 to $300", "- More than $300")
amount_spent_labels <- c("Less than $50", "$50 to $100", "$100 to $200", "$200 to $300", "More than 300")

# Convert amount_spent to a factor with the specified levels and filter out NAs
amount_spent_freq <- data_clean %>%
  filter(!is.na(amount_spent)) %>%  # Ensure NA values are excluded
  count(amount_spent) %>%
  mutate(amount_spent = factor(amount_spent, levels = amount_spent_levels)) %>%
  arrange(amount_spent)  # Ensure bars are ordered according to factor levels

# Exclude NA from the dataframe
amount_spent_freq <- amount_spent_freq %>%
  filter(!is.na(amount_spent))

# Plot frequency distribution with ordered categories
amount_spent_distribution <- ggplot(amount_spent_freq, aes(x = amount_spent, y = n, fill = amount_spent)) +
  geom_bar(stat = "identity") +
  scale_x_discrete(labels = amount_spent_labels) +  # Update x-axis labels
  labs(title = "Distribution of Amount Spent",
       x = "Amount Spent",
       y = "Frequency",
       caption = "Number of occurrences for each spending category") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        plot.title = element_text(face = "bold", hjust = 0.5),
        plot.caption = element_text(hjust = 0.5))

# Save the plot
ggsave("amount_spent_distribution.png", 
       plot = amount_spent_distribution, 
       width = 6, 
       height = 8, 
       dpi = 300, 
       bg = "white")



feedback_df <- feedback_df %>%
  mutate(id = row_number())

data_clean <- data_clean %>%
  mutate(id = row_number())  # Ensure that an `id` column exists

# Recreate the feedback_df
feedback_df <- data_clean %>%
  select(id, sound_quality_feedback) %>%
  mutate(id = row_number())

# Merge sentiment scores with amount spent
feedback_with_amount <- feedback_df %>%
  left_join(data_clean %>% select(id, amount_spent), by = "id") %>%
  left_join(sentiment_scores, by = "id")

# Calculate average sentiment score for each amount spent category
average_sentiment_by_amount <- feedback_with_amount %>%
  filter(!is.na(sentiment_score) & !is.na(negative) & !is.na(positive)) %>%
  group_by(amount_spent) %>%
  summarise(avg_sentiment_score = mean(sentiment_score, na.rm = TRUE))

# Convert amount_spent to factor with specified levels
amount_spent_levels <- c("Less than $50", "$50 to $100", "$100 to $200", "$200 to $300", "More than $300")
average_sentiment_by_amount <- average_sentiment_by_amount %>%
  mutate(amount_spent = factor(amount_spent, levels = amount_spent_levels))

# Plot average sentiment score by spending category
sentiment_vs_spending_plot <- ggplot(average_sentiment_by_amount, aes(x = amount_spent, y = avg_sentiment_score, fill = amount_spent)) +
  geom_bar(stat = "identity") +
  scale_x_discrete(labels = amount_spent_labels) +
  labs(title = "Average Sentiment Score by Amount Spent",
       x = "Amount Spent",
       y = "Average Sentiment Score") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        plot.title = element_text(face = "bold", hjust = 0.5))
sentiment_vs_spending_plot
