# Countries by income classification - Data package

This data package contains the data that powers the chart ["Countries by income classification"](https://ourworldindata.org/grapher/countries-by-income-classification?v=1&csvType=full&useColumnShortNames=false) on the Our World in Data website.

## CSV Structure

The high level structure of the CSV file is that each row is an observation for an entity (usually a country or region) and a timepoint (usually a year).

The first two columns in the CSV file are "Entity" and "Code". "Entity" is the name of the entity (e.g. "United States"). "Code" is the OWID internal entity code that we use if the entity is a country or region. For normal countries, this is the same as the [iso alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) code of the entity (e.g. "USA") - for non-standard countries like historical countries these are custom codes.

The third column is either "Year" or "Day". If the data is annual, this is "Year" and contains only the year as an integer. If the column is "Day", the column contains a date string in the form "YYYY-MM-DD".

The remaining columns are the data columns, each of which is a time series. If the CSV data is downloaded using the "full data" option, then each column corresponds to one time series below. If the CSV data is downloaded using the "only selected data visible in the chart" option then the data columns are transformed depending on the chart type and thus the association with the time series might not be as straightforward.

## Metadata.json structure

The .metadata.json file contains metadata about the data package. The "charts" key contains information to recreate the chart, like the title, subtitle etc.. The "columns" key contains information about each of the columns in the csv, like the unit, timespan covered, citation for the data etc..

## About the data

Our World in Data is almost never the original producer of the data - almost all of the data we use has been compiled by others. If you want to re-use data, it is your responsibility to ensure that you adhere to the sources' license and to credit them correctly. Please note that a single time series may have more than one source - e.g. when we stich together data from different time periods by different producers or when we calculate per capita metrics using population data from a second source.

### How we process data at Our World In Data
All data and visualizations on Our World in Data rely on data sourced from one or several original data providers. Preparing this original data involves several processing steps. Depending on the data, this can include standardizing country names and world region definitions, converting units, calculating derived indicators such as per capita measures, as well as adding or adapting metadata such as the name or the description given to an indicator.
[Read about our data pipeline](https://docs.owid.io/projects/etl/)

## Detailed information about each time series


## Number of high-income countries
Number of countries classified as high income by the World Bank.
Last updated: July 29, 2024  
Next update: July 2025  
Date range: 1987–2023  


### How to cite this data

#### In-line citation
If you have limited space (e.g. in data visualizations), you can use this abbreviated in-line citation:  
World Bank (2024) – with major processing by Our World in Data

#### Full citation
World Bank (2024) – with major processing by Our World in Data. “Number of high-income countries” [dataset]. World Bank, “Income Classifications” [original data].
Source: World Bank (2024) – with major processing by Our World In Data

### What you should know about this data
* The World Bank creates a yearly classification of countries by income, for all countries with population over 30,000.
* This classification stays the same throughout the fiscal year (from July 1 to June 30) even if the income data for a country changes.
* Low-income countries are those with a gross national income (GNI) per capita of $1,145 or less in 2023.
* Lower-middle-income countries are those with a GNI per capita between $1,146 and $4,515 in 2023.
* Upper-middle-income countries are those with a GNI per capita between $4,516 and $14,005 in 2023.
* High-income countries are those with a GNI per capita of more than $14,005 in 2023.

### How is this data described by its producer - World Bank (2024)?
For the current 2025 fiscal year, low-income economies are defined as those with a GNI per capita, calculated using the [World Bank Atlas method](https://datahelpdesk.worldbank.org/knowledgebase/articles/378832-what-is-the-world-bank-atlas-method), of $1,145 or less in 2023; lower middle-income economies are those with a GNI per capita between $1,146 and $4,515; upper middle-income economies are those with a GNI per capita between $4,516 and $14,005; high-income economies are those with more than a GNI per capita of $14,005.

Please note: Regions in this table include economies at all income levels. The term country, used interchangeably with economy, does not imply political independence but refers to any territory for which authorities report separate social or economic statistics. Click [here](https://datahelpdesk.worldbank.org/knowledgebase/articles/378834-how-does-the-world-bank-classify-countries) for information about how the World Bank classifies countries.

### Source

#### World Bank – Income Classifications
Retrieved on: 2024-07-29  
Retrieved from: https://datahelpdesk.worldbank.org/knowledgebase/articles/906519-world-bank-country-and-lending-groups  

#### Notes on our processing step for this indicator
We count the countries in each income group and also calculate the total population in them by using a long-run dataset [mantained by Our World in Data](https://ourworldindata.org/population-sources).


## Number of upper-middle-income countries
Number of countries classified as upper-middle income by the World Bank.
Last updated: July 29, 2024  
Next update: July 2025  
Date range: 1987–2023  


### How to cite this data

#### In-line citation
If you have limited space (e.g. in data visualizations), you can use this abbreviated in-line citation:  
World Bank (2024) – with major processing by Our World in Data

#### Full citation
World Bank (2024) – with major processing by Our World in Data. “Number of upper-middle-income countries” [dataset]. World Bank, “Income Classifications” [original data].
Source: World Bank (2024) – with major processing by Our World In Data

### What you should know about this data
* The World Bank creates a yearly classification of countries by income, for all countries with population over 30,000.
* This classification stays the same throughout the fiscal year (from July 1 to June 30) even if the income data for a country changes.
* Low-income countries are those with a gross national income (GNI) per capita of $1,145 or less in 2023.
* Lower-middle-income countries are those with a GNI per capita between $1,146 and $4,515 in 2023.
* Upper-middle-income countries are those with a GNI per capita between $4,516 and $14,005 in 2023.
* High-income countries are those with a GNI per capita of more than $14,005 in 2023.

### How is this data described by its producer - World Bank (2024)?
For the current 2025 fiscal year, low-income economies are defined as those with a GNI per capita, calculated using the [World Bank Atlas method](https://datahelpdesk.worldbank.org/knowledgebase/articles/378832-what-is-the-world-bank-atlas-method), of $1,145 or less in 2023; lower middle-income economies are those with a GNI per capita between $1,146 and $4,515; upper middle-income economies are those with a GNI per capita between $4,516 and $14,005; high-income economies are those with more than a GNI per capita of $14,005.

Please note: Regions in this table include economies at all income levels. The term country, used interchangeably with economy, does not imply political independence but refers to any territory for which authorities report separate social or economic statistics. Click [here](https://datahelpdesk.worldbank.org/knowledgebase/articles/378834-how-does-the-world-bank-classify-countries) for information about how the World Bank classifies countries.

### Source

#### World Bank – Income Classifications
Retrieved on: 2024-07-29  
Retrieved from: https://datahelpdesk.worldbank.org/knowledgebase/articles/906519-world-bank-country-and-lending-groups  

#### Notes on our processing step for this indicator
We count the countries in each income group and also calculate the total population in them by using a long-run dataset [mantained by Our World in Data](https://ourworldindata.org/population-sources).


## Number of lower-middle-income countries
Number of countries classified as lower-middle income by the World Bank.
Last updated: July 29, 2024  
Next update: July 2025  
Date range: 1987–2023  


### How to cite this data

#### In-line citation
If you have limited space (e.g. in data visualizations), you can use this abbreviated in-line citation:  
World Bank (2024) – with major processing by Our World in Data

#### Full citation
World Bank (2024) – with major processing by Our World in Data. “Number of lower-middle-income countries” [dataset]. World Bank, “Income Classifications” [original data].
Source: World Bank (2024) – with major processing by Our World In Data

### What you should know about this data
* The World Bank creates a yearly classification of countries by income, for all countries with population over 30,000.
* This classification stays the same throughout the fiscal year (from July 1 to June 30) even if the income data for a country changes.
* Low-income countries are those with a gross national income (GNI) per capita of $1,145 or less in 2023.
* Lower-middle-income countries are those with a GNI per capita between $1,146 and $4,515 in 2023.
* Upper-middle-income countries are those with a GNI per capita between $4,516 and $14,005 in 2023.
* High-income countries are those with a GNI per capita of more than $14,005 in 2023.

### How is this data described by its producer - World Bank (2024)?
For the current 2025 fiscal year, low-income economies are defined as those with a GNI per capita, calculated using the [World Bank Atlas method](https://datahelpdesk.worldbank.org/knowledgebase/articles/378832-what-is-the-world-bank-atlas-method), of $1,145 or less in 2023; lower middle-income economies are those with a GNI per capita between $1,146 and $4,515; upper middle-income economies are those with a GNI per capita between $4,516 and $14,005; high-income economies are those with more than a GNI per capita of $14,005.

Please note: Regions in this table include economies at all income levels. The term country, used interchangeably with economy, does not imply political independence but refers to any territory for which authorities report separate social or economic statistics. Click [here](https://datahelpdesk.worldbank.org/knowledgebase/articles/378834-how-does-the-world-bank-classify-countries) for information about how the World Bank classifies countries.

### Source

#### World Bank – Income Classifications
Retrieved on: 2024-07-29  
Retrieved from: https://datahelpdesk.worldbank.org/knowledgebase/articles/906519-world-bank-country-and-lending-groups  

#### Notes on our processing step for this indicator
We count the countries in each income group and also calculate the total population in them by using a long-run dataset [mantained by Our World in Data](https://ourworldindata.org/population-sources).


## Number of low-income countries
Number of countries classified as low income by the World Bank.
Last updated: July 29, 2024  
Next update: July 2025  
Date range: 1987–2023  


### How to cite this data

#### In-line citation
If you have limited space (e.g. in data visualizations), you can use this abbreviated in-line citation:  
World Bank (2024) – with major processing by Our World in Data

#### Full citation
World Bank (2024) – with major processing by Our World in Data. “Number of low-income countries” [dataset]. World Bank, “Income Classifications” [original data].
Source: World Bank (2024) – with major processing by Our World In Data

### What you should know about this data
* The World Bank creates a yearly classification of countries by income, for all countries with population over 30,000.
* This classification stays the same throughout the fiscal year (from July 1 to June 30) even if the income data for a country changes.
* Low-income countries are those with a gross national income (GNI) per capita of $1,145 or less in 2023.
* Lower-middle-income countries are those with a GNI per capita between $1,146 and $4,515 in 2023.
* Upper-middle-income countries are those with a GNI per capita between $4,516 and $14,005 in 2023.
* High-income countries are those with a GNI per capita of more than $14,005 in 2023.

### How is this data described by its producer - World Bank (2024)?
For the current 2025 fiscal year, low-income economies are defined as those with a GNI per capita, calculated using the [World Bank Atlas method](https://datahelpdesk.worldbank.org/knowledgebase/articles/378832-what-is-the-world-bank-atlas-method), of $1,145 or less in 2023; lower middle-income economies are those with a GNI per capita between $1,146 and $4,515; upper middle-income economies are those with a GNI per capita between $4,516 and $14,005; high-income economies are those with more than a GNI per capita of $14,005.

Please note: Regions in this table include economies at all income levels. The term country, used interchangeably with economy, does not imply political independence but refers to any territory for which authorities report separate social or economic statistics. Click [here](https://datahelpdesk.worldbank.org/knowledgebase/articles/378834-how-does-the-world-bank-classify-countries) for information about how the World Bank classifies countries.

### Source

#### World Bank – Income Classifications
Retrieved on: 2024-07-29  
Retrieved from: https://datahelpdesk.worldbank.org/knowledgebase/articles/906519-world-bank-country-and-lending-groups  

#### Notes on our processing step for this indicator
We count the countries in each income group and also calculate the total population in them by using a long-run dataset [mantained by Our World in Data](https://ourworldindata.org/population-sources).


    