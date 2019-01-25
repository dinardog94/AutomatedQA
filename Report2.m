function Report2(report2_data)

    d = dialog('Position',[300 300 250 150],'Name','Reporte Resultados');
       
    list_W = uicontrol('Parent',d,'Style','listbox','Position',[75 70 100 25],'String',report2_data);
    list_FDT = uicontrol('Parent',d,'Style','listbox','Position',[75 70 100 25],'String',report2_data(:,2));
    
    % Wait for d to close before running to completion
    uiwait(d);
  
end