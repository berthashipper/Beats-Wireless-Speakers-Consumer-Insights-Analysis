# Consumer Insights Data Analysis for Beats By Dr. Dre


# Installation
- Clone the repository
  - git clone [https://github.com/berthashipper/Beats-Wireless-Speakers-Consumer-Insights-Analysis.git](https://github.com/berthashipper/Beats-Wireless-Speakers-Consumer-Insights-Analysis.git)

- Navigate to the project directory
  - cd speaker-analysis

- Install required R packages
  - see setup.R





# Key Objectives:
This project involves analyzing customer feedback on wireless speakers to understand usage patterns, preferences, and areas for improvement. The analysis includes data cleaning, exploratory data analysis (EDA), and visualization of various aspects related to speaker usage and customer satisfaction. Additionally, I analyze consumer feedback data to gain insights into customer preferences and improve product features, performing clustering to segment customers, sentiment analysis to understand feedback, and visualize various aspects of the data to identify trends.


Visualizations
Elbow Method for K-means Clustering

Visualization Type: Line plot with points
Purpose: Determine the optimal number of clusters by plotting the Total Within-Cluster Sum of Squares (WSS) against the number of clusters.
Customer Segmentation Clustering

Visualization Type: Scatter plot
Purpose: Visualize clusters in the dataset based on customer attributes like importance of sound and battery. Colors represent different clusters.
Sentiment Scores Distribution

Visualization Type: Histogram
Purpose: Show the distribution of sentiment scores derived from customer feedback.
Frequency of Amount Spent

Visualization Type: Bar plot
Purpose: Visualize the frequency distribution of various spending categories.
Keyword Categories for Improvement

Visualization Type: Bar plot
Purpose: Display the distribution of categorized keywords related to areas of improvement, showing total counts by category.
Word Cloud for Improvement Keywords

Visualization Type: Word cloud
Purpose: Highlight the most frequent words related to improvements mentioned by customers, with a focus on sound quality.
Distribution of Purchase Factors

Visualization Type: Boxplot
Purpose: Visualize the distribution of various purchase factors like peer recommendations, customer reviews, and expert reviews. Boxplots show the range and variability of importance ratings.
Analyses
K-means Clustering Analysis

Steps:
Data scaling
Determination of the optimal number of clusters using the Elbow Method
Execution of K-means clustering
Analysis of cluster characteristics
Visualization of clusters
Sentiment Analysis

Steps:
Preparation and cleaning of feedback text
Tokenization and sentiment score calculation
Visualization of sentiment score distribution
Frequency and Keyword Analysis

Steps:
Analysis of spending amounts
Categorization of keywords and distribution analysis
Creation of a word cloud to visualize frequent keywords
Purchase Factors Analysis

Steps:
Standardization of ratings for various purchase factors
Visualization of purchase factor distributions through boxplots
