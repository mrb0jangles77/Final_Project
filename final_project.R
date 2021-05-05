#title: "ISTA 320 Final Project"
#author: "Steven Green"
#date: "Spring 2021"


library(knitr)
library(tidyverse)


"For my final project I will be working with the dataset 'Loan Prediction' which was downloaded from [Kaggle](https://www.kaggle.com/shaijudatascience/loan-prediction-practice-av-competition?select=train_csv.csv) This data set provides a total of 13 features (columns) for each respective record (row).

The research question I am interested in is How does features such as income,marriage status, and property area used in filling out a loan form affect whether a loan application gets approved or not?
  
  
  # Data Wrangling
  
In the next code block I plan to wrangle the data and complete the following tasks:
  
1. read 'data/loan_eligibility.csv' in using `read_csv()`
2. inspect data to get an idea of what it looks like
3. remove NA values
4. change data type of dependents column ('3+' dependents to just 3)"

loan_raw <- read_csv('data/loan_eligibility.csv')
glimpse(loan_raw)
summary(loan_raw)
loan_raw$Dependents = replace(loan_raw$Dependents, loan_raw$Dependents == '3+', 3)
loans = transform(loan_raw,Dependents = as.numeric(Dependents))
loans = na.omit(loans)

    # Data Visualization 1
# This first plot is a scatter plot of two numerical variables: Applicant's Income & The #Coapplicant's Income. 
married = loans %>%filter(Married == "Yes") %>%ggplot(aes(x = ApplicantIncome,y = CoapplicantIncome)) +geom_point()+ xlab("Applicant Income") + ylab("Co-Applicant Income")+ ggtitle("Income Levels of Applicant & Coapplicant Married Couples")

jpeg('income.jpg')
plot(married)
dev.off()

    # Data Visualization 2
# The second plot is a barplot showing the loan approval of married vs non-married #applicants based on the amount of loan requested.
approval = loans %>%ggplot(aes(x = Married,y = LoanAmount,fill = Loan_Status)) +geom_col(position = "dodge")+ xlab("Married") + ylab("Amount of Loan")+ ggtitle("Loan Approval of Married & Single Applicants") + labs(fill='Loan Approval')

jpeg('approval.jpg')
plot(approval)
dev.off()


# Data Visualization 3

# The third plot is a line plot showing the loan approval status based on the property #location and income levels.
property = loans %>%ggplot(aes(x = Property_Area,y = ApplicantIncome, color=Loan_Status)) +geom_line()+ xlab("Property Location") + ylab("Income")+ ggtitle("Approval of Loan based on Property & Income") + labs(fill='Loan Approval')

jpeg('property.jpg')
plot(property)
dev.off()
