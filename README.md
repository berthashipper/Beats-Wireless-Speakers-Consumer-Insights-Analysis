# Consumer Insights Data Analysis for Beats By Dr. Dre
([`Link to final project slideshow`](https://docs.google.com/presentation/d/1ZILRGwL_6ZAjmUj4ldj11PehjKt2jLBOOXXOEABlnZ4/edit?usp=sharing)).

This project focuses on analyzing customer feedback on wireless speakers to uncover usage patterns, preferences, and areas for product improvement. By leveraging data cleaning, exploratory data analysis (EDA), and advanced visualization techniques, the project provides actionable insights to enhance speaker features and customer satisfaction. Key analytical methods include clustering for customer segmentation, sentiment analysis to decode feedback, and comprehensive visualizations to highlight trends.


# Key Objectives:
- **Data Cleaning, Analysis, and Visualization:** Transform and explore data to understand customer demographics, usage habits, and satisfaction levels.
- **Consumer Feedback Analysis:** Extract insights from feedback to identify key themes, improve product features, and better understand customer preferences.


# Detailed Analysis:

### Age Distribution Analysis
- Defined the correct order for age ranges and converted the `age` column into an ordered factor to maintain a logical sequence for plotting.
- Removed rows with missing values in the `age` column to ensure accuracy in the visual representation.
- Calculated counts and percentages for each age group, highlighting the distribution of customers by age.
- Created a bar plot to display the frequency and percentage of each age group, with labels showing precise percentages for clarity ([`age_distribution_plot.png`](age_distribution_plot.png)).

### Usage Frequency Analysis
- Defined specific levels for usage frequency and ordered them appropriately using factors, allowing for coherent and meaningful analysis.
- Computed counts and percentages for each usage frequency level to understand how often customers use their speakers.
- Developed a bar plot with rotated x-axis labels to ensure readability and added percentage labels directly on the bars to communicate the data effectively ([`usage_freq_plot.png`](usage_freq_plot.png)).

### Income Data Processing
- Specified the desired order of income ranges and converted the `income` column into a factor, excluding responses like "Prefer not to say" to focus on the most relevant data.
- Calculated counts and percentages for each income level, providing insights into the income distribution of the customer base.
- Generated a bar plot with custom labels for income ranges, ensuring the data is visually accessible and easy to interpret ([`income_plot.png`](income_plot.png)).

### Customer Satisfaction by Age Group
- Grouped customer satisfaction ratings by age, calculating proportions to understand how satisfaction varies across different age groups.
- Created a side-by-side bar plot using `position_dodge` to compare satisfaction ratings by age group, enhancing the interpretability of the data through proportional bars ([`satisfaction_plot_age_enhanced.png`](satisfaction_plot_age_enhanced.png)).

### Speaker Usage Activities
- Split list format answers with multiple activities into separate rows, filtered for relevant levels of interest, and calculated proportions to explore how customers use their speakers.
- Used a horizontal bar plot to represent the distribution of usage activities, with percentage labels for clarity. Employed the `coord_flip()` function to make activity names more readable ([`usage_distributions.png`](usage_distributions.png)).

### Top Speaker Brands Analysis
- Separated list answers with multiple brands into individual rows, counted occurrences, and arranged them in descending order to identify the most popular brands among customers.
- Focused on the top 5 most frequently mentioned brands, calculating and displaying their respective percentages.
- Produced a horizontal bar plot of the top 5 brands, enhancing readability with flipped coordinates and clear percentage labels to showcase the most preferred brands ([`top_brands_plot.png`](top_brands_plot.png)).

### Satisfaction Levels Analysis
- Summarized the satisfaction levels by grouping the data based on the `satisfaction` column and calculating the count and proportion for each level.
- Used custom labels to define satisfaction levels, where `1` represents "Very Unhappy" and `5` represents "Very Happy."
- Created a bar plot to visualize the distribution of satisfaction levels, maintaining the x-axis as 1-5 for clarity. Added percentage labels directly on the bars to indicate the proportion of respondents for each level ([`overall_satisfaction.png`](overall_satisfaction.png)).

### Feature Importance Analysis
- Prepared the data in long format by selecting key features related to speaker importance, including sound quality, battery life, design, connectivity, durability, and price. Recoded the variable names to more descriptive labels, making the analysis more accessible and understandable.
- Grouped the data by feature (`quality`) and importance level (`importance`), summarizing the counts and calculating proportions to visualize how respondents rated the importance of each feature.
- Ranked the features based on the total proportion of high importance ratings (levels 5 and 6). This ordering allowed for an intuitive presentation where the most critical features (as perceived by users), were prominently displayed.
- Created a stacked bar chart that illustrates the distribution of importance levels for each feature. The plot employs a green color palette to visually differentiate the importance levels, with percentage labels directly on the bars to communicate the data effectively. Carefully positioned text labels to avoid overlap, enhancing readability and portraying the proportion of respondents who rated each feature as highly important ([`importance_ranked_plot.png`](importance_ranked_plot.png)).

### Customer Segmentation
- Selected relevant variables for segmentation, including age, income, usage frequency, and importance ratings for sound, battery, and design. Converted categorical variables (age, income, usage frequency) into numeric factors, allowing for standardized scaling and meaningful cluster analysis.
- Scaled the selected data to standardize the ranges, ensuring that each feature contributes equally to the clustering process.
- Applied the Elbow Method to determine the optimal number of clusters, evaluating the total within-cluster sum of squares for cluster counts from 1 to 10. This approach helped identify the point of diminishing returns, guiding the choice of three clusters for final segmentation.
- Performed K-means clustering with three clusters, using a seed for reproducibility. Added cluster assignments to the original data and analyzed the clusters by computing the mean importance ratings for sound, battery, and design within each cluster. This analysis provided insights into the characteristics of each segment.
- Created a scatter plot to visualize the clusters based on the importance of sound and battery. Applied jitter to the points to make trends visible, highlighting how respondents within each cluster prioritize different features ([`customer_segmentation_by_values_plot.png`](customer_segmentation_by_values_plot.png)).
- Visualized income, age, and usage frequency distributions by cluster using bar plots with percentages.
  - ([`importance_of_battery_by_cluster.png`](importance_of_battery_by_cluster.png)), ([`importance_of_design_by_cluster.png`](importance_of_design_by_cluster.png)), ([`importance_of_sound_by_cluster.png`](importance_of_sound_by_cluster.png)), ([`income_distribution_by_cluster.png`](income_distribution_by_cluster.png)), ([`income_distribution_by_cluster.png`](income_distribution_by_cluster.png)), ([`usage_frequency_distribution_by_cluster.png`](usage_frequency_distribution_by_cluster.png)), 

### Sentiment Analysis of Feedback
- Efficiently converted the list column containing feedback into a character vector using `mutate` and `map_chr`, facilitating easier text processing.
- Utilized `unnest_tokens` to break down feedback into individual words and applied `anti_join` with stopwords, ensuring a cleaner dataset for sentiment analysis.
- Merged feedback words with the Bing sentiment lexicon and calculated sentiment scores by subtracting negative counts from positive counts, providing a straightforward metric for sentiment evaluation.
- Calculated average sentiment and standard deviation, offering insights into the overall sentiment and variability of customer feedback about sound quality.
- Synthesized into a detailed histogram with percentage labels to visualize the spread of sentiment scores, aiding in understanding the range and concentration of customer sentiments ([`feedback_sentiment_distribution.png`](feedback_sentiment_distribution.png)).

### Spending Analysis
- Converted spending data into ordered factors to maintain logical progression, enhancing interpretability in subsequent analyses.
- Computed counts and proportions of each spending level, making the data easily comparable.
- Developed a bar plot with percentage labels directly on the bars, providing a clear representation of how much customers spend on their speakers, with intuitive category labels ([`amount_spent_distribution.png`](amount_spent_distribution.png)).

### Average Sentiment by Spending Category
- Combined feedback and sentiment scores with spending data, leveraging `left_join` to enrich the dataset and enable a detailed comparison.
- Grouped the data by spending categories and calculated average sentiment scores, revealing patterns between customer spending and their feedback sentiment.
- Maintained consistency in categorical ordering, ensuring the plot accurately reflects the logical progression of spending levels.
- Created a bar plot illustrating average sentiment scores across different spending categories, with x-axis labels adjusted for clarity ([`sentiment_vs_spending_plot.png`](sentiment_vs_spending_plot.png)).

### Analysis of Improvement Feedback Keywords
- Applied comprehensive cleaning steps including lowercase conversion, punctuation removal, and whitespace trimming, resulting in a tidy dataset ready for keyword analysis.
- Used `unnest_tokens` to tokenize feedback and filtered out common stopwords, focusing the analysis on meaningful terms.
- Developed a detailed keyword categorization system that linked common feedback terms to predefined categories, allowing for a structured analysis of feedback themes.
- Aggregated keyword counts by category and visualized the distribution using a horizontal bar plot with percentage labels, clearly communicating the key areas for speaker improvement based on customer feedback ([`improvement_keyword_themes.png`](improvement_keyword_themes.png)).

### Word Cloud for Sound Quality Feedback
- Specifically targeted keywords related to sound quality, ensuring that the word cloud emphasizes the most relevant feedback in this category.
- Adjusted word cloud parameters such as word scaling, frequency thresholds, and rotation to enhance readability and aesthetic appeal, making it an engaging and informative visual representation of customer feedback ([`improvements_wordcloud.png`](improvements_wordcloud.png)).

### Standardization of Advertising Ratings
-Developed a custom function `standardize_ratings` to standardize advertising ratings by converting textual ratings into numeric values. This ensures consistency across the dataset.
- Applied the `standardize_ratings` function to multiple columns related to purchase factors, effectively cleaning and standardizing the data for accurate analysis.
- Used `str(data_clean)` to verify the updated structure of the dataset, ensuring that all ratings were correctly transformed.

### Analysis of Motivating Purchase Factors
- Converted data into a long format using `pivot_longer`, facilitating the analysis of various purchase factors by consolidating them into a single column.
- Summarized the data by calculating counts and proportions for each level of importance, which allowed for a clear comparison of factors influencing purchases.
- Identified and ordered factors based on the total proportion of high importance ratings, ensuring that the most critical factors were prominently featured in the analysis.
- Created a stacked bar chart to visualize the proportion of respondents rating each factor at different levels of importance. Added percentage labels to each bar for clarity and customized the color palette and legend for better readability ([`purchase_factors_ranked.png`](purchase_factors_ranked.png)).


# Installation
- Clone the repository
  - git clone [https://github.com/berthashipper/Beats-Wireless-Speakers-Consumer-Insights-Analysis.git](https://github.com/berthashipper/Beats-Wireless-Speakers-Consumer-Insights-Analysis.git)
  
- Install required R packages
  - see [`setup.R`](setup.R)
