This program offers a Ruby solution to the Acme Sensor Company job requirements copied below.

To run the command line application clone this repo and run:

    ruby acme_sensors.rb -d DIRECTORY_NAME

Notes: 
1) This program is robust to command line errors like forgetting the directory name or mistakenly entering a file name, but will not reject a badly formatted .csv file.
2) This app functions as a demo app and does not have the testing or, as implied above, error handling required for real-world solutions.



## Problem Statement
You work at Acme Sensor Co, a company that makes thermometers and hygrometers. You are in charge of quality control, and you get fed results of accuracy tests.
Based on the result for a given sensor, you will sell the sensor as either "pro-grade", "prosumer-grade", or "discount".

Two examples of files you might receive are:

Filename: therm1.csv
ID,Type,Test Date,Date Built,Expected Value,Measured Value
1,thermometer,2017-08-02,2017-07-25,12,-12.5
2,thermometer,2017-08-04,2017-07-22,84,85.1
3,thermometer,2017-08-01,2017-07-28,65.5,110
4,thermometer,2017-08-01,2017-07-28,65.8,25

Filename: hygro1.csv
ID,Type,Test Date,Date Built,Expected Value,Measured Value
1,hygrometer,2017-08-02,2017-07-25,75.1,75.1
2,hygrometer,2017-08-04,2017-07-22,12.4,12
3,hygrometer,2017-08-01,2017-07-28,75.1,90

Your task is to write a command-line program which can be provided a directory of these CSVs, and output a summary of results. For instance (using the above examples):
= hygro1.csv
No Thermometers
Hygrometers:
  2 Pro
  1 Prosumer
  0 Discount

= therm1.csv
Thermometers:
  1 Pro
  0 Prosumer
  3 Discount
No Hygrometers

The rules for determining what grade a sensor is are as follows:
- A thermometer is "pro-grade" if it is within 1.5 of the expected value. It is "prosumer-grade" if it is within 10 of the expected value. It is "discount" otherwise.
- A hygrometer is "pro-grade" if it is within 4 of the expected value. It is "prosumer-grade" if it is within 15 of the expected value. It is "discount" otherwise. 
