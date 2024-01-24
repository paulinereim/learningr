# Loading packages --------------------------------------------------------

library(tidyverse)
library(NHANES)

glimpse(NHANES)
str(NHANES)


# Select specific columns -------------------------------------------------

select(NHANES, Age, Weight, BMI)
select(NHANES, -HeadCirc)
select(NHANES, starts_with("BP"))
select(NHANES, ends_with("Day"))
select(NHANES, contains("Age"))


# Renaming all columns ----------------------------------------------------

rename_with(NHANES, snakecase::to_snake_case)

NHANES_snakecase <- rename_with(NHANES, snakecase::to_snake_case)


# Renaming specific columns -----------------------------------------------

NHANES <- rename(NHANES, sex = Gender)
NHANES_snakecase <- rename(NHANES_snakecase, sex = gender)
NHANES_snakecase
view(NHANES_snakecase)


# Chaining the functions with the pipe ------------------------------------

colnames(NHANES_snakecase)
NHANES_snakecase %>%
  colnames()

NHANES_snakecase %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)


# Exercise 7.8 ------------------------------------------------------------

NHANES_snakecase %>%
  select(bp_sys_ave, education)

NHANES_snakecase %>%
  rename(bp_sys = bp_sys_ave, bp_dia = bp_dia_ave)

NHANES_snakecase %>%
  select(bmi, contains("age"))

NHANES_snakecase %>%
  select(contains("bp")) %>%
  rename(bp_systolic = bp_sys_ave)
