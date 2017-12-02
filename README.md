# PhysicsTool
Mathematica Tool Package

## DistributeX
Make a nested list of {{x1, {y1, z1, w1}}, {x2, {y2, z2, w2} ...}} ListLinePlot-able.

## Distribute Vector X
Make a nested list of {{x1, x2, x3...}, {{y1, y2, y3 ...}, {z1, z2, z3 ...} ...}} ListLinePlot-able.

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

## TeXify
Turn an expression into neat latex. Variable names longer than 1 (e.g. sx) will be intepreted as s_x.

Note that the expression MAY be simplied or expanded due to the `ToExpression` command. Check the output `TraditionalFrom` first.

## GammaMatrix
Define the 4 dimensional basis Gamma Matrices.
