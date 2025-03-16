-- Cleaning Data

Use emplyee_layoff;
Select *
from layoffs;

Create table layoff_1
Like layoffs;

Select *
From layoff_1;

Insert Into layoff_1
Select *
from layoffs;

Select *, 
ROW_NUMBER()OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage,country,funds_raised_millions) as row_num
From layoff_1;

With duplicate_cte As
( Select *, 
ROW_NUMBER()OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage,country,funds_raised_millions) as row_num
From layoff_1
)
Select *
From duplicate_cte
Where row_num > 1 ;

CREATE TABLE `layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Insert Into layoffs2
Select *, 
ROW_NUMBER()OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage,country,funds_raised_millions) as row_num
From layoff_1;

Delete
From layoffs2
WHERE row_num > 1;

Select * From layoffs2 Where row_num > 1;

-- Standardizing Data

Select company, Trim(company)
From layoffs2;

Update layoffs2
Set company = Trim(company);

Select Distinct industry
From layoffs2;

Select *
From layoffs2
Where industry like 'Crypto%';

Update layoffs2
Set industry  = 'Crypto'
Where industry like 'Crypto%';

Select DISTINCT Location
From layoffs2
Order by 1;
Select DISTINCT Country
From layoffs2
Order by 1;

Select *
From layoffs2 Where country Like 'United States%'
Order by country;

Select DISTINCT country , Trim(Trailing '.' From Country)
From layoffs2
ORDER BY 1;

Update layoffs2
Set country = Trim(Trailing '.' From Country)
Where country like 'United States%';

Select `date`,str_to_date(`date`, '%m/%d/%Y')
FROM layoffs2;

Update layoffs2
Set `date` = str_to_date(`date`, '%m/%d/%Y'); 

Alter Table layoffs2
Modify column `date`DATE;

-- Remove Nulls

Select *
From layoffs2
Where total_laid_off Is Null
And percentage_laid_off Is Null;

Select *
From layoffs2
Where industry is Null 
Or industry = '';

Select *
From layoffs2
Where company = 'Airbnb';

Update layoffs2
Set industry = NULL
Where industry = '';

Select *
From layoffs2 L1
Join layoffs2 L2
	On L1.company = L2.company
Where (L1.industry is Null or L1.industry = '')
And L2.industry is not null;

Update layoffs2 L1
Join layoffs2 L2
	On L1.company = L2.company
Set L1.industry = L2.industry
Where L1.industry is Null 
And L2.industry is not null;

Select* From layoffs2 where industry is null;
Select* From layoffs2 where total_laid_off is null and percentage_laid_off is null;

Delete 
From layoffs2 
where total_laid_off is null and percentage_laid_off is null;

Select * From layoffs2;

Alter Table layoffs2
Drop COLUMN row_num;









