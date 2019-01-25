function CenterShift_Save_Tolerancias
global myhandles4 CenterShiftResult
DatosTabla=get(myhandles4.uitable3,'data');

try
CenterShiftResult.Xshift.SiNo=DatosTabla{1,2};
CenterShiftResult.Xshift.ValorEsperado=DatosTabla{1,4};
CenterShiftResult.Xshift.T1=DatosTabla{1,5};
CenterShiftResult.Xshift.T2=DatosTabla{1,6};

CenterShiftResult.Yshift.SiNo=DatosTabla{2,2};
CenterShiftResult.Yshift.ValorEsperado=DatosTabla{2,4};
CenterShiftResult.Yshift.T1=DatosTabla{2,5};
CenterShiftResult.Yshift.T2=DatosTabla{2,6};

CenterShiftResult.R.SiNo=DatosTabla{3,2};
CenterShiftResult.R.ValorEsperado=DatosTabla{3,4};
CenterShiftResult.R.T1=DatosTabla{3,5};
CenterShiftResult.R.T2=DatosTabla{3,6};

CenterShiftResult.S.SiNo=DatosTabla{4,2};
CenterShiftResult.S.ValorEsperado=DatosTabla{4,4};
CenterShiftResult.S.T1=DatosTabla{4,5};
CenterShiftResult.S.T2=DatosTabla{4,6};

CenterShiftResult.Tx.SiNo=DatosTabla{5,2};
CenterShiftResult.Tx.ValorEsperado=DatosTabla{5,4};
CenterShiftResult.Tx.T1=DatosTabla{5,5};
CenterShiftResult.Tx.T2=DatosTabla{5,6};

CenterShiftResult.Ty.SiNo=DatosTabla{6,2};
CenterShiftResult.Ty.ValorEsperado=DatosTabla{6,4};
CenterShiftResult.Ty.T1=DatosTabla{6,5};
CenterShiftResult.Ty.T2=DatosTabla{6,6};

catch
end


end