# Consumer Insights Data Analysis for Beats By Dr. Dre

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
- Produced a horizontal bar plot of the top 5 brands, enhancing readability with flipped coordinates and clear percentage labels to showcase the most preferred brands ([`top_brands_plot.png`](top_brands_plot.png).


### Feature Importance Analysis
- Transformed the importance ratings of various speaker features into a long format for analysis.
- Summarized the data to calculate the proportion of each importance level for every feature.
- Ordered the features based on the total proportion of high importance levels (importance ratings of 5 and 6) to identify which features are most valued by respondents.
- Created a stacked bar chart to visualize the distribution of importance levels across different features, highlighting the proportion of respondents who rated each feature as highly important ([`importance_ranked.png`](importance_ranked.png)).

### Customer Segmentation
- Prepared data by selecting relevant columns, converting categorical variables to numeric, and scaling the data.
- Used the Elbow Method to determine optimal clustering and performed k-means clustering to segment customers into the top aspects they valued.
- Analyzed and visualized customer segments based on how they ranked sound and battery importance ([`customer_segmentation_by_values_plot.png`](customer_segmentation_by_values_plot.png)).

### Feedback Sentiment Analysis
- Processed and tokenized customer feedback on sound quality, applying the Bing lexicon to score sentiments.
- Visualized sentiment distribution with a histogram ([`feedback_sentiment_distribution.png`](feedback_sentiment_distribution.png)).

### Spending Analysis
- Converted spending data into ordered factors and visualized frequency distributions ([`amount_spent_distribution.png`](amount_spent_distribution.png)).
- Plotted sentiment scores against spending categories to explore spending influence on feedback.

### Improvement Suggestions Keyword Analysis
- Cleaned and tokenized improvement suggestion data, categorizing keywords for analysis.
- Visualized keyword distribution across improvement categories ([`improvement_keyword_themes.png`](improvement_keyword_themes.png)) and created a word cloud to highlight frequent terms related to sound quality ([`improvements_wordcloud.png`](improvements_wordcloud.png)).

### Purchase Factors Analysis
- Standardized ratings across various purchase factors for consistency.
- Created boxplots to showcase the distribution of ratings for different purchase factors ([`purchase_factors_ranked.png`](purchase_factors_ranked.png)).


## Key Highlights
- **Ordered Factors:** Consistently used ordered factors to maintain logical sequences, improving the accuracy and interpretability of visualizations.
- **Proportional Analysis:** Applied proportional calculations in various contexts to provide a more nuanced view of the data.
- **Custom Visual Enhancements:** Enhanced readability through rotated labels, customized margins, and appropriately adjusted text positions, ensuring that all plots effectively communicate the data insights.


# Installation
- Clone the repository
  - git clone [https://github.com/berthashipper/Beats-Wireless-Speakers-Consumer-Insights-Analysis.git](https://github.com/berthashipper/Beats-Wireless-Speakers-Consumer-Insights-Analysis.git)

- Navigate to the project directory
  - cd speaker-analysis

- Install required R packages
  - see setup.R
