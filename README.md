# PhysicsTool
Mathematica Tool Package

## tickFormat[xmin, xmax, digits, divisions:10]
Return a tickFormat used in Ticks or FrameTicks

## MultiplePublishPlot
Accept a matrix with each element being a subplot. Automatically generate epilog caption (a, b...) within the subplot.
Support options: EpilogPosition, Color(a list of colors, e.g. ColorData[#, "ColorList"]) , Legend (same options as LineLegend) 

## NumericMatrixQ[mx]
Return True iff all elements of the matrix are numeric

## AveragePlot
Display a nested list of {vec_x, data} = {{x1, x2, x3...}, {{y1, y2, y3 ...}, {y1, y2, y3 ...} ...}} as the statistic mean and error of all y's. Accept options for ErrorListPlot.

data should have dimensions (number of configurations * len(x)) or (number of curves * number of configurations * len(x))

## CleanData
If a numerical matrix is generated through complicated pattern replacing (i.e. ArrayFlatten, ReplaceAll), the matrix performance could sometimes be very bad. Use this function to force a clean copy of structured data.

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
