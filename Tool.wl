(* ::Package:: *)

BeginPackage["Tool`"]


Dprint[something___]:=If[debug==True,Print[something]];


Clear[DynamicPlot];
Options[DynamicPlot]={PlotRange->{All,All},PlotPoints->9,MaxRecursion-> 3,PlotStyle->Large};
DynamicPlot[fun_,OptionsPattern[]]:=Module[{pts={},y,f},
xRange=First@OptionValue[PlotRange];
If[xRange==All,xRange={0,2Pi}];
f[x_]:=y=fun[x];
CellPrint@ExpressionCell[Dynamic@ListLinePlot[pts,PlotRange->OptionValue[PlotRange],Mesh->All,MeshStyle->Directive[PointSize[Medium]],PlotLabel->"Length: "<>ToString[Length[pts]]],"Output"];
Plot[f[x],{x,xRange[[1]],xRange[[2]]},PlotPoints->OptionValue[PlotPoints],PlotStyle-> OptionValue[PlotStyle],MaxRecursion->OptionValue[MaxRecursion],EvaluationMonitor:>(pts=Sort@Append[pts,{x,y}])];
pts
]


EndPackage[]
