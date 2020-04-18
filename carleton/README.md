# Disease Spread Model in Carleton Campus

This is a simple SIR model for spread disease in Carleton.

## Parameters:

**Neighborhood:** Von Neumann 
**Delay:** Transport
**Death Rate:** 0.01
**Transmission Rate:** 0.4

# How to run the model:
In a BASH terminal, simply run the main shell script:
```shell
> ./run_carleton.sh
```
The main output log file of the simulation will be stored in the `carleton.log` file. You can use this file, together with `carleton.ma`, `carleton.val`, and `covid.pal` for visualizing the outcome of your simulation in the [CD++ Cell DEVS Web Viewer](https://omarhesham.com/arslab/webviewer/).

