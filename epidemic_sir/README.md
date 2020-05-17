# Susceptible-Infected-Recovered Disease Spread Model

Yet another Cell-DEVS implementation of the cellular automata model presented by [Hoya White et al.](https://www.sciencedirect.com/science/article/pii/S0096300306009295).
However, rules have been re-interpreted by [Román Cárdenas](mailto:r.cardenas@upm.es).


## How to run the model:

For running the model with von Neumann neighborhood, in the linux terminal, type:  
```shell
> ../cd++ -msir_roman_von_neumann.ma -lresults_von_neumann/sir_roman.log
```

For running the model with Moore neighborhood, in the linux terminal, type:  
```shell
> ../cd++ -msir_roman_moore.ma -lresults_moore/sir_roman.log
```
