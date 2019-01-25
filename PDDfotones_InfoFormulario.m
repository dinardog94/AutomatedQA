function datos = PDDfotones_InfoFormulario
global ResultStruct Variables PlotNumber

   
try
    data_Table1=Variables.Functions.PDDfotones.PDDfotonesResult.Data1;
    data_Table2=Variables.Functions.PDDfotones.PDDfotonesResult.Data2;
    PlotNumber=Variables.Functions.PDDfotones.PlotNumber;
catch
    data_Table1=cell(6,4);
    data_Table1{1,1}=80;
    data_Table1{1,2}=10;
    data_Table2=cell(1,1);
end

ColumnName_Table1={'%dosis','z(mm)','Numerador','Denominador'};
InfoFormulario.ColumnName_Table1=ColumnName_Table1;

RowName_Table1={'numbered'};
InfoFormulario.RowName_Table1=RowName_Table1;

ColumnEditable_Table1=[true,true,true,true];
InfoFormulario.ColumnEditable_Table1=ColumnEditable_Table1;

Razones={' ' '%D1' '%D2' '%D3' '%D4' '%D5' '%D6' 'Z1' 'Z2' 'Z3' 'Z4' 'Z5' 'Z6'};
ColumnFormat_Table1={'numeric','numeric', Razones, Razones};
InfoFormulario.ColumnFormat_Table1=ColumnFormat_Table1;

InfoFormulario.data_Table1=data_Table1;

Visible_Table1='On';
InfoFormulario.Visible_Table1=Visible_Table1;

ColumnName_Table2={'Perfil PDD'};
InfoFormulario.ColumnName_Table2=ColumnName_Table2;

RowName_Table2={''};
InfoFormulario.RowName_Table2=RowName_Table2;

ColumnEditable_Table2=[true];
InfoFormulario.ColumnEditable_Table2=ColumnEditable_Table2;

fn=fieldnames(ResultStruct.perfiles);
Perfiles=cell(1,length(fn));
Perfiles(1)={' '};
for i=2:length(fn)
    Perfiles(i)=ResultStruct.perfiles.(char(fn(i))).nombre;
end

ColumnFormat_Table2={Perfiles};
InfoFormulario.ColumnFormat_Table2=ColumnFormat_Table2;

InfoFormulario.data_Table2=data_Table2;

Visible_Table2='On';
InfoFormulario.Visible_Table2=Visible_Table2;

ColumnName_Table3={'Nombre','Si/No','Valor obtenido','Valor esperado','T1','T2','Diferencia'};
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