# !bin/bash
function scd {
    mkdir -p logs;
    cd++ -m $1.ma -l logs/$1.log;
    cat logs/*.log?* > $1.log;
}

function scdt {
    mkdir -p logs;
    cd++ -m $1.ma -t 00:00:$2:000 -l logs/$1.log;
    cat logs/*.log?* > $1.log;
}

scd covid_death
