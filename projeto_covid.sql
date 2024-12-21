-- 0) Criação da tabela covid_deaths:

CREATE TABLE covid_deaths (
	iso_code VARCHAR(3),	
	continent VARCHAR(50),	
	location VARCHAR(50),		
	date DATE,	
	total_cases INT,
	new_cases INT,	
	new_cases_smoothed FLOAT,
	total_deaths INT,	
	new_deaths INT,
	new_deaths_smoothed FLOAT,	
	total_cases_per_million FLOAT,	
	new_cases_per_million FLOAT,	
	new_cases_smoothed_per_million FLOAT,	
	total_deaths_per_million FLOAT,	
	new_deaths_per_million FLOAT,
	new_deaths_smoothed_per_million FLOAT,	
	reproduction_rate FLOAT,	
	icu_patients INT,	
	icu_patients_per_million FLOAT,	
	hosp_patients INT,	
	hosp_patients_per_million FLOAT,	
	weekly_icu_admissions INT,	
	weekly_icu_admissions_per_million FLOAT,	
	weekly_hosp_admissions INT,	
	weekly_hosp_admissions_per_million FLOAT,	
	new_tests INT,	
	total_tests	FLOAT,
	total_tests_per_thousand FLOAT,	
	new_tests_per_thousand FLOAT,
	new_tests_smoothed FLOAT,	
	new_tests_smoothed_per_thousand	FLOAT,
	positive_rate FLOAT,	
	tests_per_case FLOAT,	
	tests_units	VARCHAR(50),
	total_vaccinations INT,
	people_vaccinated INT,	
	people_fully_vaccinated INT,	
	new_vaccinations INT,	
	new_vaccinations_smoothed INT,	
	total_vaccinations_per_hundred FLOAT,	
	people_vaccinated_per_hundred FLOAT,	
	people_fully_vaccinated_per_hundred	FLOAT,
	new_vaccinations_smoothed_per_million INT,	
	stringency_index FLOAT,	
	population INT,	
	population_density FLOAT,	
	median_age FLOAT,	
	aged_65_older FLOAT, 	
	aged_70_older FLOAT,
	gdp_per_capita FLOAT,	
	extreme_poverty	FLOAT,
	cardiovasc_death_rate FLOAT,	
	diabetes_prevalence	FLOAT,
	female_smokers FLOAT,	
	male_smokers FLOAT,	
	handwashing_facilities FLOAT,	
	hospital_beds_per_thousand FLOAT,
	life_expectancy	FLOAT,
	human_development_index FLOAT

);


-- 1) Análise do impacto e da progressão da COVID-19

-- Total de casos e de mortes por país:

SELECT
	cd.location 
	, SUM(cd.new_cases) AS cases_total
	, SUM(cd.new_deaths) AS deaths_total
FROM covid_deaths cd
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY cd.location
ORDER BY deaths_total DESC; 

/* Os EUA têm o maior número de casos e de mortes, mas também é um país com grande população. Dessa forma, é importante também analisar
 a proporção de casos e mortes em relação à população do país. */


-- Total de casos e de mortes por continente:

SELECT
	cd.continent 
	, SUM(cd.new_cases) AS cases_total
	, SUM(cd.new_deaths) AS deaths_total
FROM covid_deaths cd
WHERE continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY cd.continent
ORDER BY deaths_total DESC; 

/* A Europa possui o maior número de casos e de mortes dentre os continentes. */


-- Variação da taxa de mortalidade ao longo do tempo por país:

SELECT
	cd.location
	, SUBSTR(cd.date, 1, 7) AS month_year
	, ROUND(100.00 * SUM(cd.total_deaths) / SUM(cd.total_cases), 2) AS percentage_deaths 
FROM covid_deaths cd 
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY location, month_year
ORDER BY location, cd.date ASC;

/* Diversos países tiveram um aumento no número de mortes ao longo dos meses, seguido de uma queda nos meses finais de análise. O que pode estar
 associado à vacinação, que se iniciou nos meses finais de análise. */


-- Variação da taxa de mortalidade ao longo do tempo por continente:

SELECT
	cd.continent 
	, SUBSTR(cd.date, 1, 7) AS month_year
	, ROUND(100.00 * SUM(cd.total_deaths) / SUM(cd.total_cases), 2) AS percentage_deaths 
FROM covid_deaths cd 
WHERE continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY continent, month_year
ORDER BY continent, cd.date ASC;

/* O percentual de mortalidade passa por um pico seguido de queda em todos os continentes, com exceção da Oceania, no qual o comportamento
 possui uma queda seguida de aumento. */


-- Probabilidade de morrer se contrair Covid em cada país:

SELECT
	cd.continent
	, cd.location 
	, ROUND(100.00 * SUM(cd.new_deaths) / SUM(cd.new_cases), 2) AS percentage_deaths 
FROM covid_deaths cd	
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY cd.location
HAVING percentage_deaths NOT NULL
ORDER BY percentage_deaths DESC; 

/* A maior probabilidade de morte ocorre em Vanuatu, na Oceania (25%), seguida do Yemen, na Ásia (19,41%). A partir do 3º colocado,
 os percentuais diminuem significativamente em comparação aos dois primeiros colocados.  */


-- Probabilidade de morrer se contrair Covid em cada continente:

SELECT
	cd.continent
	, ROUND(100.00 * SUM(cd.new_deaths) / SUM(cd.new_cases), 2) AS percentage_deaths 
FROM covid_deaths cd
WHERE continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY cd.continent
ORDER BY percentage_deaths DESC;

/* Apesar de a Europa possuir o maior número de casos e de mortes dentre os continentes, quando analisadas as mortes em relação aos casos, 
 as maiores probabilidades de morte se dão na América do Sul e na África. */


-- Probabilidade de morrer se contrair Covid em cada país por mês:

SELECT
	cd.location
	, SUBSTR(cd.date, 1, 7) AS month_year
	, ROUND(100.00 * SUM(cd.new_deaths) / SUM(cd.new_cases), 2) AS percentage_deaths 
FROM covid_deaths cd 
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY location, month_year
ORDER BY location, cd.date ASC;

/* Em alguns países a probabilidade de morrer se contrair covid-19 diminui ao final do período analisado. Isso não ocorre no Brasil, país onde os 
 dados passam por mais oscilações de crescimento e decrescimento  */


-- Probabilidade de morrer se contrair covid em cada continente por mês:

SELECT
	cd.continent 
	, SUBSTR(cd.date, 1, 7) AS month_year
	, ROUND(100.00 * SUM(cd.new_deaths) / SUM(cd.new_cases), 2) AS percentage_deaths 
FROM covid_deaths cd 
WHERE continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY continent, month_year
ORDER BY continent, cd.date ASC;

/* A probabilidade de se morrer de Covid oscila ao longo do tempo na África e na América do Sul, e diminui na Ásia. 
A Europa apresenta um pico de probabilidade de 11,66% no mês de 04/2020  e a Oceania de 16,25% no mês de 09/2020. 
Após um aumento, a probabilidade volta a diminuir na Europa, na Oceania e na América do Norte, oscilando levemente em alguns meses. */


-- Probabilidade de se infectar com Covid por país:

SELECT
	cd.location
	, ROUND(
			100.00 * SUM(cd.new_cases) / cd.population 
			, 2) AS percentage_infection
FROM covid_deaths cd
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY cd.location
HAVING percentage_infection NOT NULL
ORDER BY percentage_infection DESC; 

/* Em Andorra havia maior probabilidade de se contrair Covid no período analisado. */


-- Probabilidade de se infectar com Covid por país por mês:

SELECT
	cd.location
	, SUBSTR(cd.date, 1, 7) AS month_year
	, ROUND(100.00 * SUM(cd.new_cases) /cd.population, 2) AS percentage_deaths 
FROM covid_deaths cd
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY location, month_year 
ORDER BY location, cd.date ASC;

-- Probabilidade de se infectar com Covid por continente:

WITH country_pop AS
(
SELECT 
	cd.location
	, cd.continent 
	, cd.population
	, SUM(cd.new_cases) AS cases_total
FROM covid_deaths cd 
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY location
)
SELECT 
	continent
	, ROUND(
			100.00 * SUM(cases_total) / SUM(population)
			, 2) AS percentage_infection
FROM country_pop cp
GROUP BY continent
ORDER BY percentage_infection DESC; 

/* Na América do Norte, há maior probabilidade de se infectar com Covid no período analisado. */


-- Cinco países com as maiores taxas de morte:

SELECT
	cd.location 
	, ROUND(SUM(cd.new_deaths) / cd.population, 5) AS percentage_deaths 
FROM covid_deaths cd	
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY cd.location
HAVING percentage_deaths NOT NULL
ORDER BY percentage_deaths DESC
LIMIT 5;

/* A Hungria tem a maior taxa de morte em reação à população total do país no período analisado. */


-- Taxa de crescimento diário de novos casos e de novas mortes por país:

WITH growth_rate AS
(
	SELECT 
	    cd.continent,
	    cd.location,
	    cd.date,
	    cd.new_cases,
	    LAG(cd.new_cases) OVER (PARTITION BY cd.location ORDER BY date) AS previous_day_cases,
	    ROUND(
	    		(100.0 * (cd.new_cases - LAG(cd.new_cases) OVER (PARTITION BY cd.location ORDER BY date))) / 
	    																		NULLIF(LAG(cd.new_cases) OVER (PARTITION BY cd.location ORDER BY date), 0)
	    	  , 2) AS daily_cases_growth_rate,
	    cd.new_deaths,
	    LAG(cd.new_deaths) OVER (PARTITION BY cd.location ORDER BY date) AS previous_day_deaths,
	    ROUND(
	    		(100.0 * (cd.new_deaths - LAG(cd.new_deaths) OVER (PARTITION BY cd.location ORDER BY date))) / 
	    																		 NULLIF(LAG(cd.new_deaths) OVER (PARTITION BY cd.location ORDER BY date), 0)
	    	  , 2) AS daily_deaths_growth_rate
	FROM covid_deaths cd
	WHERE cd.location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
	ORDER BY cd.location, cd.date
)
SELECT
	continent
	, location
	, date
	, daily_deaths_growth_rate
FROM growth_rate

-- Média de casos e mortes por milhão de habitantes por país:

SELECT 
	cd.location
	, ROUND(AVG(cd.total_cases_per_million), 2) AS avg_cases_per_million
	, ROUND(AVG(cd.total_deaths_per_million), 2) AS avg_deaths_per_million
FROM covid_deaths cd 
GROUP BY cd.location 
ORDER BY avg_deaths_per_million DESC;

/* San Marino tem o maior média de mortes por milhão de habitantes e Andorra a maior média de casos. */


-- Pico de novos casos e novas mortes em cada país e em cada continente: 

SELECT 
    cd1.continent
    , cd1.location
    , MAX(cd1.new_cases) AS peak_new_cases
    , MAX(cd1.new_deaths) AS peak_new_deaths
    , MAX(
    	CASE 
	    	WHEN cd1.new_cases = (SELECT MAX(cd2.new_cases) FROM covid_deaths cd2 WHERE cd2.location = cd1.location) 
            THEN date 
        END
        ) AS date_peak_new_cases
   , MAX(
    	CASE 
	    	WHEN cd1.new_deaths = (SELECT MAX(cd3.new_deaths) FROM covid_deaths cd3 WHERE cd3.location = cd1.location) 
            THEN date 
        END
        ) AS date_peak_new_deaths
FROM covid_deaths AS cd1
WHERE cd1.location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
      AND cd1.continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY cd1.continent, cd1.location
ORDER BY peak_new_cases DESC;

/* O maior pico de casos em um dia ocorreu na Índia (401.993 novos casos em 30/04/2021) */


-- Média móvel de novos casos e mortes nos últimos 7 dias por país:

SELECT 
    cd.continent
    , cd.location
   , cd. date
    , ROUND(
    		AVG(cd.new_cases) OVER (PARTITION BY cd.location 
    								ORDER BY cd.date 
    								ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
    		, 2
    		) AS moving_avg_cases
    , ROUND(
    		AVG(cd.new_deaths) OVER (PARTITION BY cd.location 
    								 ORDER BY cd.date 
    								 ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
    		, 2
    		) AS moving_avg_deaths
FROM covid_deaths cd
WHERE cd.location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
	AND cd.continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
ORDER BY cd.continent, cd.location, cd.date;

/* A média móvel mostra se o número de casos e mortes diárias está aumentando, diminuindo ou estável considerando o invervalo de tempo de uma semana */


-- Maior número de casos e de mortes diárias até a data atual por país:

SELECT 
    cd.continent
    , cd.location
    , cd.date
    , MAX(cd.new_cases) OVER (PARTITION BY cd.location 
    						  ORDER BY cd.date 
    						  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS max_daily_cases
    , MAX(cd.new_deaths) OVER (PARTITION BY cd.location 
    						   ORDER BY cd.date 
    						   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS max_daily_deaths
FROM covid_deaths cd
WHERE cd.location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
	AND cd.continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
ORDER BY cd.location, cd.date;

-- Contribuição diária de cada país para o total de casos e de mortes de seu continente:

SELECT 
    cd.continent
    , cd.location
    , cd.date
    , cd.new_cases
    , SUM(cd.new_cases) OVER (PARTITION BY cd.continent, cd.date) AS total_cases_in_continent
    , ROUND(
    		(100.0 * cd.new_cases) / SUM(cd.new_cases) OVER (PARTITION BY cd.continent, cd.date)
    	    , 2
    	   ) AS pct_cases_in_continent
    , cd.new_deaths
    , SUM(cd.new_deaths) OVER (PARTITION BY cd.continent, date) AS total_deaths_in_continent
    , ROUND(
    		(100.0 * cd.new_deaths) / SUM(cd.new_deaths) OVER (PARTITION BY cd.continent, cd.date)
    		, 2
    		) AS pct_deaths_in_continent
FROM covid_deaths cd
WHERE cd.location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
	AND cd.continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
ORDER BY cd.continent, cd.date, cd.location;

-- Contribuição geral de cada país para o total de casos e de mortes de seu continente:

WITH total_cases_and_deaths AS
(
	SELECT 
	    cd.continent
	    , cd.location
	    , SUM(cd.new_cases) AS total_new_cases
	    , SUM(cd.new_deaths) AS total_new_deaths
	FROM covid_deaths cd
	WHERE cd.location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
		AND cd.continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
	GROUP BY cd.location
	ORDER BY cd.continent, cd.location
)
SELECT
	*
	, SUM(total_new_cases) OVER (PARTITION BY continent) AS total_cases_in_continent
	, ROUND(
    		   (100.0 * total_new_cases) / SUM(total_new_cases) OVER (PARTITION BY continent)
    	    , 2
    	   ) AS pct_cases_in_continent
    , SUM(total_new_deaths) OVER (PARTITION BY continent) AS total_deaths_in_continent
    , ROUND(
    		(100.0 * total_new_deaths) / SUM(total_new_deaths) OVER (PARTITION BY continent)
    		, 2
    		) AS pct_deaths_in_continent
FROM total_cases_and_deaths
ORDER BY continent, pct_deaths_in_continent DESC;

/* Maiores contribuições para as mortes do continente:
 - África: África do Sul (44.63%)
 - Ásia: Índia (40.72%)
 - Europa: Reino Unido (12.57%) 
 - América do Norte: Estados Unidos (67.96%)
 - Oceania: Austrália (87%)
 - América do Sul: Brasil (60.05%)  */


-- Tempo em dias que cada país demorou para alcançar 50% de seus casos totais:

WITH cumulative AS 
(
    SELECT 
        cd.location
        , cd.date
        , SUM(cd.new_cases) OVER (PARTITION BY cd.location 
        						  ORDER BY cd.date) AS cumulative_cases
        , SUM(cd.new_cases) OVER (PARTITION BY cd.location) AS total_cases
    FROM covid_deaths cd
    WHERE cd.location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
),
percentages AS
(	
	SELECT 
	    location
	    , date
	    , cumulative_cases
	    , total_cases
	    , ROUND((100.0 * cumulative_cases) / total_cases, 2) AS pct_of_total_cases
	FROM cumulative
	WHERE cumulative_cases >= 0.5 * total_cases
	ORDER BY location, date
)
SELECT 
	location
	, JULIANDAY((SELECT 
					MAX(date) 
				FROM covid_deaths cd
				WHERE percentages.location = cd.location
				GROUP BY location)) 
									- JULIANDAY(MIN(date)) AS days_untill_50_pct
FROM percentages
WHERE pct_of_total_cases IS NOT NULL
GROUP BY location
ORDER BY days_untill_50_pct DESC;

/* A China demorou mais tempo para atingir 50% de seus casos totais (442 dias) no período analisado. Como comparação, a Índia, país com maior
 contribuição para os casos registrados na Ásia, demorou apenas 147 dias. */


-- Tempo em dias que cada país demorou para alcançar 50% de suas mortes totais:

WITH cumulative AS 
(
    SELECT 
        cd.location
        , cd.date
        , SUM(cd.new_deaths) OVER (PARTITION BY cd.location 
        						   ORDER BY cd.date) AS cumulative_deaths
        , SUM(cd.new_deaths) OVER (PARTITION BY cd.location) AS total_deaths
    FROM covid_deaths cd
    WHERE cd.location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
),
percentages AS
(	
	SELECT 
	    location
	    , date
	    , cumulative_deaths
	    , total_deaths
	    , ROUND((100.0 * cumulative_deaths) / total_deaths, 2) AS pct_of_total_deaths
	FROM cumulative
	WHERE cumulative_deaths >= 0.5 * total_deaths
	ORDER BY location, date
)
SELECT 
	location
	, JULIANDAY((SELECT 
					MAX(date) 
				FROM covid_deaths cd
				WHERE percentages.location = cd.location
				GROUP BY location)) 
									- JULIANDAY(MIN(date)) AS days_untill_50_pct
FROM percentages
WHERE pct_of_total_deaths IS NOT NULL
GROUP BY location
ORDER BY days_untill_50_pct DESC;

/* A China demorou mais tempo para atingir 50% de de suas mortes totais (433 dias) no período analisado. Como comparação, a Índia, país com maior
 contribuição para as mortes registradas na Ásia, demorou apenas 204 dias. */


-- Variação da taxa de reprodução por país ao longo do tempo:

SELECT 
	cd.location 
	, SUBSTR(cd.date, 1, 7) AS month_year 
	, ROUND(AVG(cd.reproduction_rate), 2) AS avg_reproduction_rate
FROM covid_deaths cd
GROUP BY cd.location, month_year
ORDER BY location, month_year;

-- Média de ocupação hospitalar e de UTI por país:

SELECT
	cd.location 
	, ROUND(AVG(cd.icu_patients), 2) AS avg_icu_patients
	, ROUND(AVG(cd.hosp_patients), 2) AS avg_hosp_patients
FROM covid_deaths cd
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY cd.location
ORDER BY avg_icu_patients DESC;

/* Os EUA possuem o maior número médio de pacientes em UTI no período analisado. */


-- Média de ocupação hospitalar e de UTI por milhão de habitantes por país:

SELECT
	cd.location 
	, ROUND(AVG(cd.icu_patients_per_million), 2) AS avg_icu_patients_per_million
	, ROUND(AVG(cd.hosp_patients_per_million), 2) AS avg_hosp_patients_per_million
FROM covid_deaths cd
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY cd.location
ORDER BY avg_icu_patients_per_million DESC;

/* Quando consideramos a média de internações em UTI por milhão de habitantes, vemos que a República Checa tem a maior média. */


-- 2) Análise da Testagem e da Vacinação:

-- Porcentagem da população que recebeu pelo menos uma vacina contra Covid por país:

SELECT 
	cd.location 
	, ROUND(100 * SUM(cd.new_vaccinations) / cd.population, 2) AS percentage_vaccination
FROM covid_deaths cd
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY cd.location
ORDER BY percentage_vaccination DESC;

/* No período analisado, a população de Gibraltar possuia o maior percentual de recebimento de pelo menos uma dose de vacina. */


-- Porcentagem da população que recebeu pelo menos uma vacina contra Covid por continente:

WITH country_pop AS
(
SELECT 
	cd.location
	, cd.continent 
	, cd.population
	, SUM(cd.new_vaccinations) AS sum_vaccinations
FROM covid_deaths cd
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY location
)
SELECT 
	continent
	, ROUND(
			100*SUM(sum_vaccinations) / SUM(population)
			, 2) AS percentage_vaccination
FROM country_pop cp
GROUP BY continent
ORDER BY percentage_vaccination DESC;

/* A América do Norte possui o maior percentual de população que recebeeu pelo menos uma dose da vacina no período analisado.  */


-- Acumulado de vacina por país e por data:

SELECT 
	cd.location
	, cd.date 
	, SUM(cd.total_vaccinations) OVER (PARTITION BY cd.location
									   ORDER BY cd.date) AS total_acumulado
FROM covid_deaths cd 
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
ORDER BY location;

-- Comparativo de mortes e vacinações por mês por continente:

SELECT
	cd.continent 
	, SUBSTR(cd.date, 1, 7) AS month_year
	, SUM(cd.new_deaths) AS deaths
	, SUM(cd.new_vaccinations) AS vaccinations
FROM covid_deaths cd
WHERE continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY cd.continent, month_year 
ORDER BY cd.continent, cd.date ASC;

/* Na Europa, África e América do Norte, o total de mortes parece diminuir com o aumento do total de vacinações. 
   Na América do Sul e na Ásia, o número de mortes continua aumentando apesar do aumento de vacinações.  */


-- Relação entre o número de testes realizados e a média da taxa de positividade ao longo dos meses:

SELECT
	SUBSTR(cd.date, 1, 7) AS month_year
	, SUM(new_tests) AS tests_total
	, ROUND(AVG(cd.positive_rate), 3) AS avg_positive_rate
FROM covid_deaths cd 
GROUP BY month_year
ORDER BY month_year;

/* A princípio, não parece haver um padrão. A taxa de positividade média diminui ao longo do tempo, enquanto o total de testes oscila. */


-- Maiores médias de vacinação por população por país:

SELECT 
	cd.location 
	, ROUND(AVG(cd.total_vaccinations_per_hundred), 2) AS avg_total_vaccinations_per_hundred
	, ROUND(AVG(cd.people_vaccinated_per_hundred), 2) AS avg_people_vaccinated_per_hundred
	, ROUND(AVG(cd.people_fully_vaccinated_per_hundred), 2) AS avg_people_fully_vaccinated_per_hundred
FROM covid_deaths cd
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY cd.location
ORDER BY avg_people_fully_vaccinated_per_hundred DESC;

/* Gibraltar tem as maiores médias de vacinação no período analisado. */


-- Média diária de novas vacinações por país:

SELECT 
	cd.location 
	, ROUND(AVG(cd.new_vaccinations), 2) AS avg_new_vaccinations
FROM covid_deaths cd
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
GROUP BY cd.location 
ORDER BY avg_new_vaccinations DESC;

/* Os EUA têm a maior média de vacinações diárias no período analisado. */


-- Relação entre o número de vacinações, internações hospitalares e na UTI ao longo do tempo por continente:

SELECT 
	cd.continent 
	, SUBSTR(cd.date, 1, 7) AS month_year
	, SUM(cd.new_vaccinations) AS new_vaccinations_total 
	, SUM(cd.icu_patients) AS icu_patients_total
	, SUM(cd.hosp_patients) AS hosp_patients_total
FROM covid_deaths cd 
WHERE continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY cd.continent, month_year;

/* A princípio, não parece haver uma relação muito clara. */


-- Taxa de hospitalização e internação em UTI em relação ao número de casos por continente:

SELECT 
	cd.continent
	, ROUND(SUM(cd.hosp_patients)/SUM(cd.new_cases), 4) AS hosp_rate
	, ROUND(SUM(cd.icu_patients)/SUM(cd.new_cases), 4) AS icu_rate
FROM covid_deaths cd
WHERE continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY cd.continent
ORDER BY hosp_rate DESC;

/* A Europa apresenta a maior taxa de internação hospitalar, quando a América do Norte apresenta a maior taxa de internação em UTI.
  No período analisado, não há dados da América do Sul, Oceania e África. */


-- 3) Análise dos impactos socioeconômicos e demográficos:

-- Relação entre as políticas de restrição (stringency_index), novos casos e novas mortes:

SELECT 
	cd.continent 
	, SUBSTR(cd.date, 1, 7) AS month_year
	, ROUND(AVG(cd.stringency_index), 2) AS avg_stringency_index
	, SUM(cd.new_cases) AS new_cases_total
	, SUM(cd.new_deaths) AS new_deaths_total
FROM covid_deaths cd 
WHERE continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY cd.continent, month_year;

/* Não parece haver relação no período analisado. */

-- Índice de restrição média por continente comparado com o total de casos e mortes:

SELECT 
	cd.continent
	, ROUND(AVG(cd.stringency_index), 2) AS avg_stringency_index
	, SUM(cd.new_cases) AS new_cases_total
	, SUM(cd.new_deaths) AS new_deaths_total
FROM covid_deaths cd 
WHERE continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY cd.continent
ORDER BY new_deaths_total DESC;

/* Não parece haver uma relação durante o período analisado. */


-- Relação entre fatores demográficos/socioeconômicos e mortalidade por país:

SELECT 
    cd.continent
    , cd.location
    , ROUND(AVG(cd.total_deaths_per_million), 2) AS avg_deaths_per_million
    , ROUND(AVG(cd.median_age), 2) AS avg_median_age
    , ROUND(AVG(cd.gdp_per_capita), 2) AS avg_gdp_per_capita
    , ROUND(AVG(cd.extreme_poverty), 2) AS avg_extreme_poverty
    , ROUND(AVG(cd.life_expectancy), 2) AS avg_life_expectancy
    , ROUND(AVG(cd.aged_65_older), 2) AS avg_aged_65_older
    , ROUND(AVG(cd.aged_70_older), 2) AS avg_aged_70_older
    , ROUND(AVG(cd.hospital_beds_per_thousand), 2) AS avg_hospital_beds
    , ROUND(AVG(cd.handwashing_facilities), 2) AS avg_handwashing_facilities
    , ROUND(AVG(cd.human_development_index), 2) AS avg_hdi
FROM covid_deaths cd
WHERE location NOT IN ("World", "Europe", "North America", "European Union", "South America", "Asia", "Africa", "Oceania", "International")
      AND continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY cd.continent, cd.location
ORDER BY cd.continent, cd.location, avg_deaths_per_million DESC;

-- Relação entre fatores demográficos/socioeconômicos e mortalidade por continente:

SELECT 
    cd.continent
    , ROUND(AVG(cd.total_deaths_per_million), 2) AS avg_deaths_per_million
    , ROUND(AVG(cd.median_age), 2) AS avg_median_age
    , ROUND(AVG(cd.gdp_per_capita), 2) AS avg_gdp_per_capita
    , ROUND(AVG(cd.extreme_poverty), 2) AS avg_extreme_poverty
    , ROUND(AVG(cd.life_expectancy), 2) AS avg_life_expectancy
    , ROUND(AVG(cd.aged_65_older), 2) AS avg_aged_65_older
    , ROUND(AVG(cd.aged_70_older), 2) AS avg_aged_70_older
    , ROUND(AVG(cd.hospital_beds_per_thousand), 2) AS avg_hospital_beds
    , ROUND(AVG(cd.handwashing_facilities), 2) AS avg_handwashing_facilities
    , ROUND(AVG(cd.human_development_index), 2) AS avg_hdi
FROM covid_deaths cd
WHERE continent IN ("Europe", "North America", "South America", "Asia", "Africa", "Oceania")
GROUP BY cd.continent
ORDER BY avg_deaths_per_million DESC;

/* A Europa apresentou a maior média de mortes por milhão de habitantes, mesmo sendo um dos continentes com melhores índices socioeconômicos. */