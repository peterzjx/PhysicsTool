(* ::Package:: *)

BeginPackage["Tool`",{"ErrorBarPlots`"}]


tickFormat[xmin_,xmax_,digits_,divisions_: 10]:=Function[tickNumber,{tickNumber,
If[digits==0,
tickNumber,
PaddedForm[Round[tickNumber,0.00001],{Max@(Length@IntegerDigits@IntegerPart[#]&/@(10^digits {xmin,xmax})),digits}]
]
}]/@FindDivisions[{xmin,xmax},divisions];

Options[PublishPlot]=Join[{Color->"Default",Tick->{Automatic,Automatic}},Options@ListLinePlot];
PublishPlot[data_,opts:OptionsPattern[]]:=Module[{color,tick,tickFormatx,tickFormaty},
color=OptionValue[Color]/.{"Rainbow"-> ColorData[3,"ColorList"], "Smooth"-> ColorData[22,"ColorList"][[2;;]],"Default"->ColorData[97,"ColorList"]};
color=Directive[AbsoluteThickness[3],#]&/@color;
tick=OptionValue[Tick];
tickFormaty=If[tick[[1]]==Automatic, Automatic, (tickFormat[#1,#2,tick[[1,1]],tick[[1,2]]]&)];
tickFormatx=If[tick[[2]]==Automatic, Automatic, (tickFormat[#1,#2,tick[[2,1]],tick[[2,2]]]&)];
ListLinePlot[data,
FilterRules[{opts},Options@ListLinePlot],
AspectRatio->0.8,
ImageSize->Medium,
BaseStyle->{FontSize->24},
LabelStyle->{FontSize->24},
Frame->True,
ImagePadding->{{105,40},{65,20}},
FrameTicks->{{tickFormaty,None},{tickFormatx,None}},
PlotStyle->color
]
]


Options[MultiplePublishPlot]=Join[{Color->"Default",Legend->Automatic,EpilogPosition->{0.1,0.9}}];
SetAttributes[MultiplePublishPlot,HoldFirst]
Options[SubPlot]={Epilog->None};
MultiplePublishPlot[data_,opts:OptionsPattern[]]:=Module[{color,legend,data2,epilogPos,size},
size=Dimensions[data];
data2=Flatten[data];
color=OptionValue[Color]/.{"Rainbow"-> ColorData[3,"ColorList"], "Smooth"-> ColorData[22,"ColorList"][[2;;]],"Default"->ColorData[112,"ColorList"]};
epilogPos=OptionValue[EpilogPosition];
color=Directive[AbsoluteThickness[2.5],#]&/@color;
legend=LineLegend[color,OptionValue[Legend],LabelStyle->{FontSize->24}];
data2=Table[
Show[data2[[i]],Epilog->Text[Style[Alphabet[][[i]],25],Scaled[epilogPos]]]
,{i,Length[data2]}];
framed=Framed[#,FrameStyle->None,FrameMargins->{{0,0},{0,0}}]&/@data2;
combined=If[OptionValue[Legend]===Automatic,Grid@Partition[framed,size[[2]]],Legended[Grid@Partition[framed,size[[1]]],Placed[legend,Right]]]
]


NumericMatrixQ[mx_]:=AllTrue[Flatten@mx,NumericQ]


AverageListPlot[{x_,data_}, arg___]:=Module[{},
If[Length@Dimensions@data==3,
AverageMultiListPlot[{x, data}, arg],
AverageSingleListPlot[{x, data}, arg]
]
]


AverageSingleListPlot[{x_,data_},arg___]:=Module[{y=Mean[data],dy=StandardDeviation[data]/Sqrt[Length[data]]},
ErrorListPlot[Transpose@{Transpose@{x,y},ErrorBar/@dy},arg]
]


AverageMultiListPlot[{x_,data_},arg___]:=Module[{y=Mean/@data,dy=(StandardDeviation/@data)/Sqrt[Length[data[[1]]]]},
ErrorListPlot[
Table[
Transpose@{Transpose@{x,y[[i]]},ErrorBar/@dy[[i]]}
,{i,1,Length[y]}]
,arg]
]


AveragePlot[{x_,data_},arg___]:=Show[
AverageListPlot[{x,data},PlotMarkers->None,PlotLegends->None,arg],
AverageListPlot[{x,data},arg]
]


CleanData[data_]:=Module[{func},
func=Compile[{},data];
Return[func[]];
]


Dprint[something___]:=If[debug==True,Print[something]];


DistributeX[list_]:=If[VectorQ[list[[1]][[2]]],Thread/@({First@Transpose[list],#}&/@Transpose@(Transpose[list][[2]])),list]


DistributeVecX[list_]:=Thread[List[list[[1]],#]]&/@list[[2]]
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


(* ::Input:: *)
(**)


TeXify[exp_]:=Block[{texifyvar},
texifyvar[var_]:=If[StringLength[ToString[var]]>= 2,
Subscript[ToExpression[StringTake[ToString[var],{1,1}]], ToExpression[StringTake[ToString[var],{2,-1}]]],
var
];
CellPrint[TraditionalForm[exp/.(Rule[#,texifyvar[#]]&/@Variables[exp])]];
TeXForm[exp/.(Rule[#,texifyvar[#]]&/@Variables[exp])]
]


SolvePauli[Mx_]:=Module[{basis,fb,nrm},
basis=PauliMatrix@Range[0,3];
fb=Flatten[basis,{{1},{2,3}}];
nrm=Diagonal[fb.ConjugateTranspose[fb]];
Flatten[Mx].ConjugateTranspose[fb]/nrm
]


GammaMatrix[1]=KroneckerProduct[PauliMatrix[1],PauliMatrix[1]];
GammaMatrix[2]=KroneckerProduct[PauliMatrix[2],PauliMatrix[1]];
GammaMatrix[3]=KroneckerProduct[PauliMatrix[3],PauliMatrix[1]];
GammaMatrix[4]=KroneckerProduct[PauliMatrix[0],PauliMatrix[2]];
GammaMatrix[5]=KroneckerProduct[PauliMatrix[0],PauliMatrix[3]];


EndPackage[]
