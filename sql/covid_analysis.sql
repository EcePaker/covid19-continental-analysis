SELECT iso_code, continent, location, "date", population, total_cases, new_cases, new_cases_smoothed, total_deaths, new_deaths, new_deaths_smoothed, total_cases_per_million, new_cases_per_million, new_cases_smoothed_per_million, total_deaths_per_million, new_deaths_per_million, new_deaths_smoothed_per_million, reproduction_rate, icu_patients, icu_patients_per_million, hosp_patients, hosp_patients_per_million, weekly_icu_admissions, weekly_icu_admissions_per_million, weekly_hosp_admissions, weekly_hosp_admissions_per_million
FROM CovidDeaths;

-- Query 1: Daily Cases Trend
SELECT 
    date,
    COALESCE(SUM(new_cases), 0) AS daily_new_cases,
    COALESCE(SUM(new_cases_smoothed), 0) AS daily_new_cases_smoothed
FROM CovidDeaths
WHERE location 
GROUP BY date
ORDER BY date;

-- Query 4: Case Fatality Rate
SELECT
location,
MAX(total_cases) AS total_cases,
MAX(total_deaths) AS total_deaths,
CASE 
	WHEN MAX(total_cases) > 0
	THEN MAX(total_deaths) * 100.0 / MAX(total_cases)
	ELSE 0
END AS case_fatality_rate
FROM CovidDeaths
GROUP BY location
ORDER BY case_fatality_rate DESC;

-- Query 3: Reproduction Rate
SELECT 
    AVG(reproduction_rate) AS avg_r0,
    location,
    date
FROM CovidDeaths 
WHERE reproduction_rate IS NOT NULL
GROUP BY date, location
ORDER BY date;

-- Query 2: Cases Deaths by Country
SELECT 
COALESCE(sum(total_cases),0) as total_patient,
location,
MAX(total_cases_per_million)as max_patient_per_million,
COALESCE(SUM(total_deaths),0) as total_died,
MAX(total_deaths_per_million)as max_died_per_million
FROM CovidDeaths 
group by location 
ORDER BY max_died_per_million DESC;
