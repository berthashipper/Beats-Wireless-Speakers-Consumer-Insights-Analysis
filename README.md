# Consumer Insights Data Analysis for Beats By Dr. Dre


# Key Objectives:
This project involves analyzing customer feedback on wireless speakers to understand usage patterns, preferences, and areas for improvement. The analysis includes data cleaning, exploratory data analysis (EDA), and visualization of various aspects related to speaker usage and customer satisfaction. Additionally, I analyze consumer feedback data to gain insights into customer preferences and improve product features, performing clustering to segment customers, sentiment analysis to understand feedback, and visualize various aspects of the data to identify trends.


# Data Cleaning and Analysis

## 1. Age Data Processing

- **Ordered Factor Conversion**:
  Converted the `age` column to an ordered factor with defined levels.

- **Age Distribution Plot**:
  Created a bar plot to visualize age distribution. Saved as `age_distribution_plot.png`.

## 2. Usage Frequency Data Processing

- **Ordered Factor Conversion**:
  Set the levels for `usage_freq` and converted it to a factor.

- **Usage Frequency Plot**:
  Visualized speaker usage frequency with a bar plot. Saved as `usage_freq_plot.png`.

## 3. Income Data Processing

- **Ordered Factor Conversion**:
  Defined and converted the `income` column to a factor with specified levels.

- **Income Distribution Plot**:
  Generated a bar plot for income distribution. Saved as `income_plot.png`.

## 4. Satisfaction by Age

- **Data Summarization**:
  Summarized satisfaction ratings by age group and calculated proportions.

- **Enhanced Satisfaction Plot**:
  Visualized satisfaction ratings by age group with proportions. Saved as `satisfaction_plot_age_enhanced.png`.

## 5. Speaker Usage Activities

- **Data Expansion and Proportion Calculation**:
  Expanded multiple speaker usage activities into separate rows and calculated proportions.

- **Usage Distribution Plot**:
  Created a plot for the distribution of speaker usage activities. Saved as `usage_distributions.png`.

## 6. Customer Segmentation

- **Data Preparation**:
  Selected relevant columns, converted categorical variables to numeric, and scaled the data.

- **Elbow Method**:
  Used the Elbow Method to determine the optimal number of clusters. Plotted results.

- **K-means Clustering**:
  Performed k-means clustering and added cluster assignments to the dataset.

- **Cluster Analysis**:
  Analyzed clusters by calculating mean values for attributes and assigned meaningful names.

- **Cluster Visualization**:
  Visualized customer segments based on the importance of sound and battery. Saved as `customer_segmentation_plot.png`.

## 7. Feedback Sentiment Analysis

- **Feedback Processing**: 
  Converted `sound_quality_feedback` from a list column to a character vector and created a dataframe for analysis.

- **Sentiment Analysis**: 
  Tokenized feedback words, calculated sentiment scores using the Bing lexicon, and summarized the sentiment.

- **Sentiment Distribution Plot**: 
  Created a histogram to visualize the distribution of sentiment scores. Saved as `feedback_sentiment_distribution.png`.

## 8. Amount Spent Analysis

- **Amount Spent Frequency**: 
  Converted `amount_spent` to a factor with ordered levels and plotted its frequency distribution. Saved as `amount_spent_distribution.png`.

- **Sentiment vs. Spending Plot**: 
  Calculated and plotted the average sentiment score for each spending category.

## 9. Keyword Analysis for Improvement Suggestions

- **Text Data Cleaning**: 
  Cleaned and tokenized `improve_speaker` text data, categorized keywords, and summarized counts by category.

- **Keyword Categories Plot**: 
  Created a bar plot to visualize the distribution of keywords across improvement categories. Saved as `improvement_keyword_themes.png`.

- **Word Cloud for Sound Quality**: 
  Generated a word cloud for keywords related to "Sound Quality" to visualize frequent terms. Saved as `improvements_wordcloud.png`.

## 10. Purchase Factors Analysis

- **Standardizing Ratings**: 
  Applied a function to standardize ratings across various purchase factors to ensure consistency.

- **Purchase Factors Boxplot**: 
  Created boxplots to show the distribution of different purchase factors based on their median importance rating. Saved as `purchase_factors_plot.png`.


# Installation
- Clone the repository
  - git clone [https://github.com/berthashipper/Beats-Wireless-Speakers-Consumer-Insights-Analysis.git](https://github.com/berthashipper/Beats-Wireless-Speakers-Consumer-Insights-Analysis.git)

- Navigate to the project directory
  - cd speaker-analysis

- Install required R packages
  - see setup.R
