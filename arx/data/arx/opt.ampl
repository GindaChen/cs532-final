data;

set DATES := include "data/Dates.dat";
param: avg := include "data/McGuireAFB.dat";
let { d in DATES } day[d] := ord(d, DATES);

let x[0] := 60;
let x[1] := 0;
let x[2] := 20;
let x[3] := 20;
let x[4] := 0.01;
let x[5] := 0.01;
let x[6] := 1;

set DATES ordered;
param avg {DATES};
param day {DATES};
param pi := 4 * atan(1);

var a { j in 0..6 };
var dev {DATES} >= 0, := 1;

minimize sumdev: sum {d in DATES} dev[d];
subject to def_pos_dev {d in DATES}:
	x[0] + x[1] * day[d] 
		+ x[2] * cos(2*pi*day[d]/365.25)
		+ x[3] * sin(2*pi*day[d]/365.25)
		+ x[4] * cos(x[6]*2*pi*day[d]/(10.7*365.25))
		+ x[5] * sin(x[6]*2*pi*day[d]/(10.7*365.25))
		- avg[d]
	<= dev[d];

subject to def_neg_dev {d in DATES}:
	- dev[d] <= 
		x[0] + x[1] * day[d] 
		+ x[2] * cos(2*pi*day[d]/365.25)
		+ x[3] * sin(2*pi*day[d]/365.25)
		+ x[4] * cos(x[6]*2*pi*day[d]/(10.7*365.25))
		+ x[5] * sin(x[6]*2*pi*day[d]/(10.7*365.25))
		- avg[d];


