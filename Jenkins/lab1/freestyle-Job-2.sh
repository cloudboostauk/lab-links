#!/bin/bash
if [[ ${ResultsInFile} == true ]]
then
	echo " My name is ${FirstName} ${LastName} and I am a ${Gender} " >> name.txt
else
	echo " No information found " >> name01.txt
fi