function PicketFence_Save_Tolerancias
global myhandles4 PicketFenceResult
DatosTabla=get(myhandles4.uitable3,'data');

try
PicketFenceResult.PicketFence_Y_mean.SiNo=DatosTabla{1,2};
PicketFenceResult.PicketFence_Y_mean.ValorEsperado=DatosTabla{1,4};
PicketFenceResult.PicketFence_Y_mean.T1=DatosTabla{1,5};
PicketFenceResult.PicketFence_Y_mean.T2=DatosTabla{1,6};

PicketFenceResult.PicketFence_Y_max.SiNo=DatosTabla{2,2};
PicketFenceResult.PicketFence_Y_max.ValorEsperado=DatosTabla{2,4};
PicketFenceResult.PicketFence_Y_max.T1=DatosTabla{2,5};
PicketFenceResult.PicketFence_Y_max.T2=DatosTabla{2,6};

PicketFenceResult.PicketFence_Y_min.SiNo=DatosTabla{3,2};
PicketFenceResult.PicketFence_Y_min.ValorEsperado=DatosTabla{3,4};
PicketFenceResult.PicketFence_Y_min.T1=DatosTabla{3,5};
PicketFenceResult.PicketFence_Y_min.T2=DatosTabla{3,6};

if isfield(PicketFenceResult,'Perfil_PicketFenceX_datos')
for i=1:length(PicketFenceResult.Perfil_PicketFenceX_datos(:))
PicketFenceResult.Perfil_PicketFenceX_datos(i).SiNo=DatosTabla{3+i,2};
PicketFenceResult.Perfil_PicketFenceX_datos(i).ValorEsperado=DatosTabla{3+i,4};
PicketFenceResult.Perfil_PicketFenceX_datos(i).T1=DatosTabla{3+i,5};
PicketFenceResult.Perfil_PicketFenceX_datos(i).T2=DatosTabla{3+i,6};
end
end
catch
end


end