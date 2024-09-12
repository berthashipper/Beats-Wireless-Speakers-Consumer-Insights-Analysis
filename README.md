# Consumer Insights Data Analysis for Beats By Dr. Dre

This project focuses on analyzing customer feedback on wireless speakers to uncover usage patterns, preferences, and areas for product improvement. By leveraging data cleaning, exploratory data analysis (EDA), and advanced visualization techniques, the project provides actionable insights to enhance speaker features and customer satisfaction. Key analytical methods include clustering for customer segmentation, sentiment analysis to decode feedback, and comprehensive visualizations to highlight trends.


# Key Objectives:
- **Data Cleaning, Analysis, and Visualization:** Transform and explore data to understand customer demographics, usage habits, and satisfaction levels.
- **Consumer Feedback Analysis:** Extract insights from feedback to identify key themes, improve product features, and better understand customer preferences.


# Detailed Analysis:

### Age Data Processing
- Converted age data into an ordered factor to represent defined levels.
- Created a bar plot to visualize the distribution of ages ([`age_distribution_plot.png`](age_distribution_plot.png)).

### Usage Frequency Analysis
- Defined usage frequency levels and converted data into a factor for analysis.
- Visualized the frequency of speaker usage with a bar plot ([`usage_freq_plot.png`](usage_freq_plot.png)).

### Income Data Processing
- Transformed the income data into an ordered factor with specified levels.
- Generated a bar plot to display income distribution among users ([`income_plot.png`](income_plot.png)).

### Feature Importance Analysis
- Transformed the importance ratings of various speaker features into a long format for analysis.
- Summarized the data to calculate the proportion of each importance level for every feature.
- Ordered the features based on the total proportion of high importance levels (importance ratings of 5 and 6) to identify which features are most valued by respondents.
- Created a stacked bar chart to visualize the distribution of importance levels across different features, highlighting the proportion of respondents who rated each feature as highly important ([`importance_ranked.png`](importance_ranked.png)).

### Satisfaction by Age Group
- Summarized satisfaction ratings across age groups and calculated proportional data.
- Enhanced visualization of satisfaction ratings segmented by age ([`satisfaction_plot_age_enhanced.png`](satisfaction_plot_age_enhanced.png)).

### Speaker Usage Activities
- Expanded multi-use activities into separate data rows and calculated usage proportions.
- Plotted the distribution of speaker usage activities ([`usage_distributions.png`](usage_distributions.png)).

### Customer Segmentation
- Prepared data by selecting relevant columns, converting categorical variables to numeric, and scaling the data.
- Used the Elbow Method to determine optimal clustering and performed k-means clustering to segment customers into the top aspects they valued.
- Analyzed and visualized customer segments based on how they ranked sound and battery importance ([`customer_segmentation__by_values_plot.png`](customer_segmentation__by_values_plot.png)).

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


# Installation
- Clone the repository
  - git clone [https://github.com/berthashipper/Beats-Wireless-Speakers-Consumer-Insights-Analysis.git](https://github.com/berthashipper/Beats-Wireless-Speakers-Consumer-Insights-Analysis.git)

- Navigate to the project directory
  - cd speaker-analysis

- Install required R packages
  - see setup.R
