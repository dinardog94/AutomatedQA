function datos = CenterShift_InfoFormulario
global Variables PlotNumber

try
    data_Table1=Variables.Functions.CenterShift.CenterShiftResult.Data1;
    data_Table2=Variables.Functions.CenterShift.CenterShiftResult.Data2;
    PlotNumber=Variables.Functions.CenterShift.PlotNumber;
catch
data_Table1={25};
data_Table2=cell(4,2);
end    

ColumnName_Table1={'Radio de análisis (mm)'};
InfoFormulario.ColumnName_Table1=ColumnName_Table1;

RowName_Table1={'numbered'};
InfoFormulario.RowName_Table1=RowName_Table1;

ColumnEditable_Table1=[true];
InfoFormulario.ColumnEditable_Table1=ColumnEditable_Table1;

ColumnFormat_Table1={'numeric'};
InfoFormulario.ColumnFormat_Table1=ColumnFormat_Table1;

InfoFormulario.data_Table1=data_Table1;

Visible_Table1='Off';
InfoFormulario.Visible_Table1=Visible_Table1;

ColumnName_Table2={'Perfiles'};
InfoFormulario.ColumnName_Table2=ColumnName_Table2;

RowName_Table2={'numbered'};
InfoFormulario.RowName_Table2=RowName_Table2;

ColumnEditable_Table2=[true];
InfoFormulario.ColumnEditable_Table2=ColumnEditable_Table2;


ColumnFormat_Table2={'numeric'};
InfoFormulario.ColumnFormat_Table2=ColumnFormat_Table2;

InfoFormulario.data_Table2=data_Table2;

Visible_Table2='Off';
InfoFormulario.Visible_Table2=Visible_Table2;

ColumnName_Table3={'Parámetro','Si/No','Valor obtenido (mm)','Valor esperado (mm)','T1','T2','Diferencia'};
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