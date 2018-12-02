# CS532 Final Project



## Model


$$
\min_{x_0, ..., x_6} \sum_{d \in D} |x_0 + x_1d \\
+ x_2 cos(2\pi d/T_y) + x_3 sin(2\pi d/T_y) \\
+ x_4 cos(2x_6\pi d/T_s) + x_5 sin(2x_6\pi d/T_s)|
$$

## Dataset

McGuire AFB data from 1955-2010, each day, average temperature.

- [McGuireAFB.data.csv](./data/McGuireAFB.data.csv) 
- [McGuireAFB.time.csv](./data/McGuireAFB.time.csv) 


The dataset used in the paper.



## Reference

[Proposal](https://docs.google.com/document/d/17-SN3CiIkT78NDMZJ8cvwmgNUnrevUbJImAVSYZd6rc/edit)

### Paper and Presentation

[Presentation: Local Warming - Is it real?](https://vanderbei.princeton.edu/tex/talks/WhartonStat11/LocalWarming.pdf)

### Data

#### Processed Data List

- [Data in the paper: 1955-2010 McGuire AFB Station Data (新泽西州伯灵顿郡的机场)](./data/data.csv) 

#### Data Also

[Data format and downloading instructions](ftp://ftp.ncdc.noaa.gov/pub/data/gsod/readme.txt )

[List of ∼9000 weather stations posted here](ftp://ftp.ncdc.noaa.gov/pub/data/gsod/ish-history.txt )

[(Others) UC-Irevine Data Source](https://archive.ics.uci.edu/ml/index.php)

