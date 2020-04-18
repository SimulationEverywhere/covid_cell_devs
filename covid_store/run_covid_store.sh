#!bin/bash
mkdir results
../cd++ -m"covid_store.ma" -l"results/covid_store.log"
cp results/covid_store.log01 ./covid_store.log
rm -r results

