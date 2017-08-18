# PhysicsTool
Mathematica Tool Package
## DynamicPlot
From https://mathematica.stackexchange.com/questions/131665/dynamically-update-a-plot-of-a-function-that-evaluates-slowly

When a time-consuming function is applied on a number list, DynamicPlot allows the visualization during the function runs, thus easier to identify any useful feature through a low-resolution version of the final graph before the calculation finishes.

Support Options:

    PlotRange (Also controls the horizontal ploting region, default = {{0,2Pi}, All}})
    PlotStyle
    MaxRecursion (default = 3)
    PlotPoints (default = 9)
    Reference (default = 0)
        When output of the function is a d-dimension vector, specify which dimension is used to determine the recursion depth. Setting this to 0 in the vector case will cause a significant delay as each point will be calculated d times.
