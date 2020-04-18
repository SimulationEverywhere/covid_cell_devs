# Disease Spread Model in a Store

This is a simple SIR model for spread disease inside a store.

## Parameters:

** Neighborhood: ** Von Neumann 
** Delay: ** Transport
** Death Rate: ** 0.01
** Transmission Rate: ** 0.4

# How to run the model:
In a BASH terminal, simply run the main shell script:
```shell
> ./run_covid_store.sh
```
The main output log file of the simulation will be stored in the `covid_store.log` file. You can use this file, together with `covid_store.ma`, `covid_store.val`, and `covid.pal` for visualizing the outcome of your simulation in the [CD++ Cell DEVS Web Viewer](https://omarhesham.com/arslab/webviewer/).

