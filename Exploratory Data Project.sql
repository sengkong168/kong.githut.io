-- Exploratory Data Analysis\

Select * 
From layoffs2;

Select MAX(total_laid_off), MAX(percentage_laid_off)
From layoffs2;

Select *
From layoffs2
Where percentage_laid_off = 1
Order by total_laid_off Desc;

Select MAX(`date`), MIN(`date`)
From layoffs2;

Select company, SUM(total_laid_off)
From layoffs2
Group by company
Order by 2;

Select MAX(`date`), MIN(`date`)
From layoffs2;

Select industry, SUM(total_laid_off)
From layoffs2
Group by industry
Order by 2 Desc;

Select country, SUM(total_laid_off)
From layoffs2
Group by country
Order by 2 Desc;

Select Year(`date`), SUM(total_laid_off)
From layoffs2
Group by Year(`date`)
Order by 2 Desc;

Select stage, SUM(total_laid_off)
From layoffs2
Group by stage
Order by 2 Desc;

Select company, AVG(percentage_laid_off)
From layoffs2
Group by company
Order by 2 Desc;

Select substring(`date`,1,7) as `Month`, Sum(total_laid_off) 
From layoffs2
GROUP BY `Month`
Having `Month`Is Not Null
Order by 1 ;

With Rolling_Total As
( Select substring(`date`,1,7) as `Month`, Sum(total_laid_off) As Total_LO
From layoffs2
GROUP BY `Month`
Having `Month`Is Not Null
Order by 1 
)
Select `Month`, Total_LO, SUM(Total_LO) Over (Order by `Month`) As Rolling_LO
From Rolling_Total; 

Select company, Year(`date`),  Sum(total_laid_off) As Total_laid_off
From layoffs2
Group by company, Year(`date`)
Order by 3 Desc;

With Company_Year (company,years, total_laid_off) As
(Select company, Year(`date`) ,  Sum(total_laid_off) As Total_laid_off
From layoffs2
Group by company, Year(`date`)
Order by 3 Desc
),
Company_year_rank AS
(Select *, DENSE_RANK()Over(Partition By years Order by total_laid_off DESC) as Rank_num
From Company_year
Where years is not null
Order by Rank_num ASC
)
Select *
From Company_year_rank
Where rank_num <=5 
Order by years;







