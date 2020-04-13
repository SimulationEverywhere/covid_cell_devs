# !bin/bash
mkdir -p logs
cd model
cd++ -m covid.ma -l ../logs/covid.log
cd ..
cat logs/*.log?* > covid.log
