% prepare em data type labels
if (strcmp(data_type,'odo') == 1)
    type_string = 'ODO mg/L';
    type_title_string = 'Dissolved Oxygen (mg/L)';
elseif (strcmp(data_type,'chl') == 1)
    type_string = 'Chl ug/L';
    type_title_string = 'Chlorophyll (ug/L)';
elseif (strcmp(data_type,'water_depth') == 1)
    type_string = 'Total Water Column (m)';
    type_title_string = 'Water Depth (m)';
elseif (strcmp(data_type,'water_depth_dvl') == 1)
    type_string = 'DVL -Water Column (m)';
    type_title_string = 'Water Depth from DVL (m)';
elseif (strcmp(data_type,'sp_cond') == 1)
    type_string = 'SpCond mS/cm';
    type_title_string = 'Conductivity mS/cm';
elseif (strcmp(data_type,'sal') == 1)
    type_string = 'Sal ppt';
    type_title_string = 'Salinity (ppt)';
elseif (strcmp(data_type,'pH') == 1)
    type_string = 'pH'; % note, this is not mV
    type_title_string = 'pH';
elseif (strcmp(data_type,'turb') == 1)
    type_string = 'Turbid+ NTU';
    type_title_string = 'Turbidity (NTU)';
elseif (strcmp(data_type,'bga') == 1)
    type_string = 'BGA-PC cells/mL';
    type_title_string = 'Blue-Green Algae (cells/mL)';
else
    disp('Unknown data type. Options are: odo, chl, water_depth, water_depth_dvl, sp_cond, sal, pH, bga')
    return
end