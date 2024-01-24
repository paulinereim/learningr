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


# Filtering data by row ---------------------------------------------------

filter(NHANES_snakecase, phys_active == "No")

# or with piping
NHANES_snakecase %>%
    filter(phys_active == "No") %>%
    select(phys_active)

NHANES_snakecase %>%
    filter(phys_active != "No") %>%
    select(phys_active)

NHANES_snakecase %>%
    filter(bmi == "25") %>%
    select(bmi)

NHANES_snakecase %>%
    filter(bmi >= "25") %>%
    select(bmi)

TRUE & TRUE
TRUE & FALSE
FALSE & TRUE

TRUE | TRUE
TRUE | FALSE
FALSE | TRUE

NHANES_snakecase %>%
    filter(bmi == 25 & phys_active == "No") %>%
    select(bmi, phys_active)

NHANES_snakecase %>%
    filter(bmi == 25 | phys_active == "No") %>%
    select(bmi, phys_active)


# Arranging the rows ------------------------------------------------------

NHANES_snakecase %>%
    arrange(age)
# arranging numbers (int) from low to high

NHANES_snakecase %>%
    arrange(education) %>%
    select(education) %>%
    view()
# arranging chr in alphabetical order (though numbers come first)

NHANES_snakecase %>%
    arrange(desc(age)) %>%
    select(age)

NHANES_snakecase %>%
    arrange(age, education) %>%
    select(age, education)
NHANES_snakecase %>%
    arrange(education, age) %>%
    select(age, education)
NHANES_snakecase %>%
    arrange(desc(age), education) %>%
    select(age, education)


# Transform or add columns ------------------------------------------------

NHANES_snakecase %>%
    mutate(age = age * 12)

NHANES_snakecase %>%
    mutate(age = age * 12,
           logged_bmi = log(bmi)) %>%
    select(age, logged_bmi)

NHANES_snakecase %>%
    mutate(old = if_else(age >= 30, "Yes", "No")) %>%
    select(old)



# Exercise 7.12 -----------------------------------------------------------


# 1. BMI between 20 and 40 with diabetes
NHANES_snakecase %>%
    # Format should follow: variable >= number or character
    filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes") %>%
    select(bmi, diabetes)


# Pipe the data into mutate function and:
NHANES_modified <- NHANES_snakecase %>%
    mutate(mean_arterial_pressure = ((bp_dia_ave * 2) + bp_sys_ave)/3,
        young_child = if_else(age < 6, "Yes", "No"))

NHANES_modified %>%
    select(mean_arterial_pressure, young_child)
