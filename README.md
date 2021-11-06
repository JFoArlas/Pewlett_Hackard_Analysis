# Pewlett-Hackard-Analysis

## Overview
Pewlett Hackard has many employees due to retire soon and therefore needs to plan to have experienced employees leave the company, in addition to training their replacements. The purpose of this analysis was to analyze HR data (e.g. employee birth dates, hire dates, titles, etc.) to determine the number of retiring employees per title, and to identify employees nearing retirment to mentor other employees to fill those soon-to-be vacant positions.

## Results
### Retiring Employees by Title
- A total of 90,398 employees meet Pewlett Hackard's definition of being of retirement age (i.e., born between 1952 and 1955). 
- Of that group, about 70% have "Senior," "Leader," or "Manager" in their title. That is a large % of retiring employees in leadership positions. This could mean there is opportunity to reduce salary expense by filling these positions with employees who do not yet have the same level of experience as the previous title (holder who likely had a higher salary due to more experience).

![image](https://github.com/JFoArlas/Pewlett_Hackard_Analysis/blob/main/Resources/retiring_titles.PNG)

### Mentorship Opportunities
The company wants to recruit experienced and successful employees nearing retirment to step back into a part-time role instead of retiring completely. Their new role in the company would be as a mentor to the newly hired folks. The criteria for this group was employees born in 1965.

- A total of 1,549 employees meet Pewlett Hackard's mentorship eligilibity criteria.
- Of that group, about 45% have "Senior," "Leader," or "Manager" in their title. This shows an imbalance between employees in leadership positions who are retiring and employees in leadership positions eligible to mentor employees to fill these roles.

![image](https://github.com/JFoArlas/Pewlett_Hackard_Analysis/blob/main/Resources/mentorship_eligibility.PNG)

## Summary

- 90,398 roles will need to be filled as a result of the "silver tsunami."
- There are not enough employees who meet Pewlett Hackard's current mentorship eligibility criteria to mentor the next generation of Pewlett Hackard employees given that each would need to mentor roughly 58 employees to cover all the roles that will need to be filled.

### Additional Queries
Given the above findings, I reccomend Pewlett Hackard expand its mentorship eligibility critera to increase the number of potential mentors. To do this, we can adjust the original code to include employees born between 1962 to 1965, instead of just employees born in 1965.

```
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility_expanded
FROM employees as e
LEFT JOIN dept_emp as de
ON e.emp_no = de.emp_no
LEFT JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1962-01-01' AND '1965-12-31')
ORDER BY emp_no;
```

This query results in 56,859 employees eligible to mentor, which is less than 2 employee to 1 mentor. This allows potential mentors to more successfully mentor the employees they are assigned to, and gives a buffer between those eligible to mentor and those who actually accept the role of a mentor. As the company begins offering this mentor opportunity to their employees, they may need to adjust the date span for potential mentors based on the % of them who accept.

It would also be helpful to understand the % of employees retiring in each department to allow Pewlett Hackard to identify if any departments have a higher percentage of employees retiring soon. When you compare the two tables, about 30% of each department is retiring soon with just 2 departments at 31%. 

![image](https://github.com/JFoArlas/Pewlett_Hackard_Analysis/blob/main/Resources/unique_retirement_depts_table.PNG)

![image](https://github.com/JFoArlas/Pewlett_Hackard_Analysis/blob/main/Resources/unique_all_depts_table.png)

Given the retirement % is consistent accross departments, I reccomend Pewlett Hackard allocate resources to the mentorship program based on the total number of employees retiring soon vs. the % of employees retiring soon. The Development and Production departments (d005 and d004, respectively) have the most employees and therefore the most empoyees retiring soon. Those two departments combined make up about half of the employees retiring, so the company should put about half their resources finding mentors in those two departments.
