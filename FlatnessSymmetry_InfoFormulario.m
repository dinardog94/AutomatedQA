function datos = FlatnessSymmetry_InfoFormulario
global ResultStruct Variables PlotNumber

try
    data_Table1=Variables.Functions.FlatnessSymmetry.FlatnessSymmetryResult.Data1;
    data_Table2=Variables.Functions.FlatnessSymmetry.FlatnessSymmetryResult.Data2;
    PlotNumber=Variables.Functions.FlatnessSymmetry.PlotNumber;
catch
    data_Table1={50 50;80 80};
    data_Table2=cell(5,3);
end    

ColumnName_Table1={'X','Y'};
InfoFormulario.ColumnName_Table1=ColumnName_Table1;

RowName_Table1={'%Tamaño de campo', '%Área central'};
InfoFormulario.RowName_Table1=RowName_Table1;

ColumnEditable_Table1=[true true true true];
InfoFormulario.ColumnEditable_Table1=ColumnEditable_Table1;

ColumnFormat_Table1={'numeric','numeric'};
InfoFormulario.ColumnFormat_Table1=ColumnFormat_Table1;

InfoFormulario.data_Table1=data_Table1;

Visible_Table1='On';
InfoFormulario.Visible_Table1=Visible_Table1;

ColumnName_Table2={'Perfiles X','Perfiles Y','Áreas'};
InfoFormulario.ColumnName_Table2=ColumnName_Table2;

RowName_Table2={'numbered'};
InfoFormulario.RowName_Table2=RowName_Table2;

ColumnEditable_Table2=[true true true];
InfoFormulario.ColumnEditable_Table2=ColumnEditable_Table2;

fn=fieldnames(ResultStruct.perfiles);
Perfiles=cell(1,length(fn));
Perfiles(1)={' '};
for i=2:length(fn)
    Perfiles(i)=ResultStruct.perfiles.(char(fn(i))).nombre;
end
fn=fieldnames(ResultStruct.poligonos);
Poligonos=cell(1,length(fn));
Poligonos(1)={' '};
for i=2:length(fn)
    Poligonos(i)=ResultStruct.poligonos.(char(fn(i))).nombre;
end
ColumnFormat_Table2={Perfiles,Perfiles,Poligonos};
InfoFormulario.ColumnFormat_Table2=ColumnFormat_Table2;

InfoFormulario.data_Table2=data_Table2;

Visible_Table2='On';
InfoFormulario.Visible_Table2=Visible_Table2;

ColumnName_Table3={'Perfil/Área','Si/No','Valor obtenido','Valor esperado','T1','T2','Diferencia'};
InfoFormulario.ColumnName_Table3=ColumnName_Table3;

RowName_Table3={};
InfoFormulario.RowName_Table3=RowName_Table3;

ColumnEditable_Table3=[false true false true true true false];
InfoFormulario.ColumnEditable_Table3=ColumnEditable_Table3;

ColumnFormat_Table3={'char','logical','numeric','numeric','numeric','numeric','numeric'};
InfoFormulario.ColumnFormat_Table3=ColumnFormat_Table3;

data_Table3=cell(2,7);
InfoFormulario.data_Table3=data_Table3;

Visible_Table3='On';
InfoFormulario.Visible_Table3=Visible_Table3;

datos=InfoFormulario;
end