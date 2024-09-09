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

#################################

# Define the order of categories from lowest to highest
amount_spent_levels <- c("Less than $50", "$50 to $100", "$100 to $200", "$200 to $300", "More than $300")
amount_spent_labels <- c("Less than $50", "$50 to $100", "$100 to $200", "$200 to $300", "More than $300")

# Convert amount_spent to a factor with the specified levels and filter out NAs
amount_spent_freq <- data_clean %>%
  filter(!is.na(amount_spent)) %>%  # Ensure NA values are excluded
  mutate(amount_spent = factor(amount_spent, levels = amount_spent_levels)) %>%  # Convert to factor with specified levels
  count(amount_spent) %>%
  arrange(amount_spent) %>%  # Ensure bars are ordered according to factor levels
  mutate(proportion = n / sum(n),  # Calculate proportions
         percentage_label = sprintf("%.1f%%", proportion * 100))  # Format proportions as percentages

# Remove any rows where amount_spent is NA (shouldn't be necessary if filtering is correct)
amount_spent_freq <- amount_spent_freq %>%
  filter(!is.na(amount_spent))

# Plot frequency distribution with ordered categories and percentage labels
amount_spent_distribution <- ggplot(amount_spent_freq, aes(x = amount_spent, y = n, fill = amount_spent)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = percentage_label), vjust = -0.5, size = 3.5) +  # Add percentage labels above bars
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
amount_spent_distribution

# Save the plot
ggsave("amount_spent_distribution.png", 
       plot = amount_spent_distribution, 
       width = 6, 
       height = 8, 
       dpi = 300, 
       bg = "white")

#################################

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

#################################

# Clean the improve_speaker data
cleaned_improve_speaker <- data_clean %>%
  pull(improve_speaker) %>%
  tolower() %>%
  str_replace_all("[[:punct:]]", "") %>%
  str_squish()  # Remove extra white spaces

# Create a tibble for text analysis
text_data <- tibble(improve_speaker = cleaned_improve_speaker)

# Tokenize the text and count occurrences
word_counts <- text_data %>%
  unnest_tokens(word, improve_speaker) %>%
  count(word, sort = TRUE) %>%
  filter(!word %in% stop_words$word)  # Remove common stop words

filtered_word_counts <- word_counts %>%
  filter(word != "na")

# Define keyword categories with all relevant terms
# Create the keyword_categories tibble
keyword_categories <- tibble(
  word = c("battery", "sound", "life", "quality", "louder", "volume", "bass", "audio", "clarity", "crisp",
           "loud", "loudness", "noise", "clearer", "enhanced", "improve", "improved", "better", "perfect",
           "charging", "charge", "lasted", "lasting", "durable", "design", "build", "size", "compact",
           "resistant", "handle", "bulky", "waterproof", "heavy", "portability",
           "connectivity", "wireless", "bluetooth", "connection", "features", "device", "connecting",
           "compatibility", "systems", "control", "options", "easy", "portable", "travel", "multi-use",
           "settings", "comfortable", "easier", "happy", "experience",
           "improvement", "increased", "increase", "multiple", "brand", "color", "aesthetic", "stylish",
           "price", "cheaper", "affordable", "expensive", "worth"),
  category = c(rep("Sound Quality", 19),
               rep("Battery and Charging", 4),
               rep("Durability and Design", 11),
               rep("Connectivity and Features", 15),
               rep("User Experience", 14),
               rep("Price", 4))
)

# Display the tibble
print(keyword_categories)

# Join the keyword categories with filtered_word_counts
categorized_word_counts <- filtered_word_counts %>%
  left_join(keyword_categories, by = "word") %>%
  group_by(category) %>%
  summarise(count = sum(n, na.rm = TRUE)) %>%
  arrange(desc(count))

# Remove rows where category is NA
categorized_word_counts_clean <- categorized_word_counts %>%
  filter(!is.na(category))

# Display the cleaned data
print(categorized_word_counts_clean)

# Plot the distribution of categories
improvement_keyword_themes <- ggplot(categorized_word_counts_clean, aes(x = reorder(category, count), y = count, fill = category)) +
  geom_bar(stat = "identity") +
  coord_flip() +  # Flip coordinates for better readability
  labs(title = "Distribution of Keywords of Categories for Improvement",
       x = "Category",
       y = "Total Count",
       fill = "Category") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        plot.title = element_text(face = "bold", hjust = 0.5))

# Save the plot
ggsave("improvement_keyword_themes.png", 
       plot = improvement_keyword_themes, 
       width = 8, 
       height = 6, 
       dpi = 300, 
       bg = "white")

#################################

# Filter words for a specific category, for example, "Sound Quality"
sound_quality_words <- filtered_word_counts %>%
  filter(word %in% keyword_categories$word[keyword_categories$category == "Sound Quality"]) %>%
  left_join(keyword_categories, by = "word") %>%
  filter(category == "Sound Quality")

# Save the word cloud as an image
png("improvements_wordcloud.png", width = 8 * 300, height = 8 * 300, res = 300)  # Set width, height, and resolution
wordcloud(words = sound_quality_words$word, freq = sound_quality_words$n, 
          scale = c(5, 0.3),  # Adjust scale for better differentiation
          min.freq = 2,       # Set minimum frequency to 2 for more significant words
          max.words = 100,    # Limit the number of words to include
          colors = brewer.pal(9, "Paired"),  # Use a more diverse color palette
          random.order = FALSE, 
          rot.per = 0.4)      # Adjust rotation percentage
dev.off()  # Close the graphics device
