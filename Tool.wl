(* ::Package:: *)

BeginPackage["Tool`"]


Dprint[something___]:=If[debug==True,Print[something]];


DistributeList[list_]:=If[VectorQ[list[[1]][[2]]],Thread/@({First@Transpose[list],#}&/@Transpose@(Transpose[list][[2]])),list]
(*Transform a nested list {x,{y1,y2}} into {x,y1},{x,y2} and ListLinePlot-able*)


Clear[DynamicPlot];
Options[DynamicPlot]={PlotRange->{All,All},PlotPoints->9,MaxRecursion-> 3,PlotStyle->Large, Reference->0};
DynamicPlot[fun_,OptionsPattern[]]:=Module[{pts={},y,f},
xRange=First@OptionValue[PlotRange];
If[xRange==All,xRange={0,2Pi}];
f[x_]:=y=fun[x];
If[OptionValue[Reference]==0, g[x_]:=f[x], g[x_]:=f[x][[OptionValue[Reference]]]]
CellPrint@ExpressionCell[Dynamic@ListLinePlot[DistributeList[pts],PlotRange->OptionValue[PlotRange],Mesh->All,MeshStyle->Directive[PointSize[Medium]],PlotLabel->"Length: "<>ToString[Length[pts]]],"Output"];
Plot[g[x],{x,xRange[[1]],xRange[[2]]},PlotPoints->OptionValue[PlotPoints],PlotStyle-> OptionValue[PlotStyle],MaxRecursion->OptionValue[MaxRecursion],EvaluationMonitor:>(pts=Sort@Append[pts,{x,y}])];
pts
]


EndPackage[]
