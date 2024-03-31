#!/bin/sh 

echo Introduceti numele de familie cu litere mari
read FAM
echo Salut $FAM,
echo Suntem in data $(date) la adresa IP $(hostname -I)                                     
                                                                                
for os in Linux Windows Mac 
do                                                  
  echo $os                                                                      
done         
