(* ::Package:: *)

BeginPackage["Tool`"]


Dprint[something___]:=If[debug==True,Print[something]];


DistributeX[list_]:=If[VectorQ[list[[1]][[2]]],Thread/@({First@Transpose[list],#}&/@Transpose@(Transpose[list][[2]])),list]


DistributeVecX[list_]:=If[VectorQ[list[[2]]], Thread[List[list[[1]],#]]&/@list[[2]], list]
(*Transform a nested list {x,{y1,y2}} into {x,y1},{x,y2} and ListLinePlot-able*)


Clear[DynamicPlot];
Options[DynamicPlot]={PlotRange->{All,All},PlotPoints->9,MaxRecursion-> 3,PlotStyle->Large, Reference->0};
DynamicPlot[fun_,OptionsPattern[]]:=Module[{pts={},y,f},
xRange=First@OptionValue[PlotRange];
If[xRange==All,xRange={0,2Pi}];
f[x_]:=y=fun[x];
If[OptionValue[Reference]==0, g[x_]:=f[x], g[x_]:=f[x][[OptionValue[Reference]]]]
CellPrint@ExpressionCell[Dynamic@ListLinePlot[DistributeX[pts],PlotRange->OptionValue[PlotRange],Mesh->All,MeshStyle->Directive[PointSize[Medium]],PlotLabel->"Length: "<>ToString[Length[pts]]],"Output"];
Plot[g[x],{x,xRange[[1]],xRange[[2]]},PlotPoints->OptionValue[PlotPoints],PlotStyle-> OptionValue[PlotStyle],MaxRecursion->OptionValue[MaxRecursion],EvaluationMonitor:>(pts=Sort@Append[pts,{x,y}])];
pts
]

TeXify[exp_]:=Block[{texifyvar},
texifyvar[var_]:=If[StringLength[ToString[var]]>= 2,
Subscript[ToExpression[StringTake[ToString[var],{1,1}]], ToExpression[StringTake[ToString[var],{2,-1}]]],
var
];
CellPrint[TraditionalForm[exp/.(Rule[#,texifyvar[#]]&/@Variables[exp])]];
TeXForm[exp/.(Rule[#,texifyvar[#]]&/@Variables[exp])]
]


(* ::Input:: *)
(**)


GammaMatrix[1]=KroneckerProduct[PauliMatrix[1],PauliMatrix[1]];
GammaMatrix[2]=KroneckerProduct[PauliMatrix[2],PauliMatrix[1]];
GammaMatrix[3]=KroneckerProduct[PauliMatrix[3],PauliMatrix[1]];
GammaMatrix[4]=KroneckerProduct[PauliMatrix[0],PauliMatrix[2]];
GammaMatrix[5]=KroneckerProduct[PauliMatrix[0],PauliMatrix[3]];


EndPackage[]
