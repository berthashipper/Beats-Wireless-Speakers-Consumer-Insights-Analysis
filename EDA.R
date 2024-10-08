head(data)
glimpse(data)

data <- data %>% 
  clean_names()

# Rename columns with simpler names
data <- data %>%
  rename(
    timestamp = timestamp,
    email = email_address,
    owns_speaker = do_you_own_a_wireless_speaker,
    usage_freq = how_often_do_you_use_your_wireless_speaker,
    sound_quality = how_would_you_rate_the_sound_quality_of_your_wireless_speaker,
    sound_quality_feedback = please_tell_us_a_bit_more_about_your_rating_of_the_sound_quality_of_your_wireless_speaker,
    importance_sound = whats_most_important_to_you_in_a_wireless_speaker_sound_quality,
    importance_battery = whats_most_important_to_you_in_a_wireless_speaker_battery_life,
    importance_design = whats_most_important_to_you_in_a_wireless_speaker_design_looks,
    importance_connectivity = whats_most_important_to_you_in_a_wireless_speaker_connectivity_options_e_g_bluetooth_wi_fi,
    importance_durability = whats_most_important_to_you_in_a_wireless_speaker_durability,
    importance_price = whats_most_important_to_you_in_a_wireless_speaker_price,
    brands_used = which_brands_of_wireless_speakers_do_you_own_or_have_used_before_select_all_that_apply,
    purchase_recommendation = what_made_you_buy_your_current_wireless_speaker_rate_each_factor_from_1_to_5_where_1_is_not_important_and_5_is_very_important_recommendation_from_friends_family,
    purchase_reviews = what_made_you_buy_your_current_wireless_speaker_rate_each_factor_from_1_to_5_where_1_is_not_important_and_5_is_very_important_online_reviews_from_other_customers,
    purchase_expert = what_made_you_buy_your_current_wireless_speaker_rate_each_factor_from_1_to_5_where_1_is_not_important_and_5_is_very_important_expert_reviews,
    purchase_brand = what_made_you_buy_your_current_wireless_speaker_rate_each_factor_from_1_to_5_where_1_is_not_important_and_5_is_very_important_brand_reputation,
    purchase_price = what_made_you_buy_your_current_wireless_speaker_rate_each_factor_from_1_to_5_where_1_is_not_important_and_5_is_very_important_price,
    purchase_features = what_made_you_buy_your_current_wireless_speaker_rate_each_factor_from_1_to_5_where_1_is_not_important_and_5_is_very_important_specific_features,
    purchase_advertising = what_made_you_buy_your_current_wireless_speaker_rate_each_factor_from_1_to_5_where_1_is_not_important_and_5_is_very_important_advertising,
    satisfaction = how_happy_are_you_with_your_wireless_speaker,
    improve_speaker = what_would_make_your_wireless_speaker_better,
    speaker_usage = what_do_you_mostly_use_your_wireless_speaker_for_select_all_that_apply,
    lifestyle_changes = have_any_other_lifestyle_changes_in_the_past_year_changed_how_you_use_wireless_speakers_select_all_that_apply,
    amount_spent = how_much_did_you_spend_on_your_wireless_speaker_us_dollars,
    buy_new = how_likely_are_you_to_buy_a_new_wireless_speaker_in_the_next_12_months,
    purchase_location = where_do_you_like_to_buy_wireless_speakers,
    price_thoughts = how_do_you_think_about_and_evaluate_the_price_when_buying_a_wireless_speaker,
    age = how_old_are_you,
    gender = what_is_your_gender,
    income = whats_your_annual_household_income,
    feedback = thanks_a_bunch_for_completing_our_survey_your_feedback_is_super_valuable_and_will_help_us_understand_what_consumers_want_if_you_have_any_extra_comments_or_feedback_please_share_them_below,
    score = score
  )

# Preview the cleaned and simplified column names
colnames(data)

#remove unnecessary columns
data <- data %>%
  select(-score,-timestamp,-email,-owns_speaker)

#cleaning
colSums(is.na(data))
data_clean <- data %>%
  drop_na()

#set appropriate data structures to factors
data_clean <- data_clean %>%
  mutate(
    usage_freq = as.factor(usage_freq),
    sound_quality = as.factor(sound_quality),
    speaker_usage = as.factor(speaker_usage),
    lifestyle_changes = as.factor(lifestyle_changes),
    amount_spent = as.factor(amount_spent),
    purchase_location = as.factor(purchase_location),
    age = as.factor(age),
    gender = as.factor(gender),
    income = as.factor(income)
  )

#EDA
table(data_clean$usage_freq)
prop.table(table(data_clean$usage_freq))

table(data_clean$usage_freq, data_clean$age)

aov_results <- aov(importance_sound ~ usage_freq, data = data_clean)
summary(aov_results)

#likelihood to buy new as an ordinal
data_clean$buy_new <- ordered(data_clean$buy_new)
