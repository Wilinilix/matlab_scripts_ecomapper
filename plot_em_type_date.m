%
% function [] = plot_em_type_date(dd, mm, yyyy, data_type, data_path_prefix, location)
%   function to plot data from mat file, 
%     create mat file from EcoMapper log file using compile_all_type.m
%   choosing a specific date (specify via dd, mm, yyyy)
%  data_type, options are: odo, chl, water_depth, water_depth_dvl, sp_cond, sal, pH, bga
%  default data_path_prefix: '~/data_em/logs/'
%  default location: 'puddingstone
%
% Author: Stephanie Kemna
% Institution: University of Southern California
% Date: Apr 22, 2015
%
function [] = plot_em_type_date(dd, mm, yyyy, data_type, data_path_prefix, location)

%% input/preparation
if nargin < 3
    disp('Error! Usage: plot_em_type_date(dd, mm, yyyy, data_type, data_path_prefix, location)')
end
if nargin < 4
    disp('Error! No data_type defined')
    disp('Options are: odo, chl, water_depth, water_depth_dvl, sp_cond, sal, pH, bga')
    return
end
if nargin < 5
    data_path_prefix = '~/data_em/logs/';
    location = 'puddingstone';
end

% prepare labels
run em_prepare_labels

%% read data
% load the data
filename = [data_path_prefix data_type '_' location '.mat'];
% create data file if necessary
if ~exist(filename,'file')
    disp('data file non-existent, calling compile_all_by_type');
    compile_all_by_type(data_type, data_path_prefix, location)
end
load(filename);

% extract data into logical names
longitude = data(:,1);
latitude = data(:,2);
desired_data = data(:,3);
time_datenum = data(:,4);
depth = data(:,5);

%% extract data by date
% construct desired date
date_desired = datestr([num2str(mm) '-' num2str(dd) '-' num2str(yyyy)])

cnt = 0;
for ( dep_idx = 1:length(depth) )
    % compare the date
    if ( strncmp(date_desired, datestr(time_datenum(dep_idx)), 11) )
        cnt = cnt + 1;
        nw_depth(cnt) = depth(dep_idx);
        nw_data(cnt) = desired_data(dep_idx);
        nw_time(cnt) = time_datenum(dep_idx);
    end
end

%% plot
if ( cnt > 0 )
    min_value = min(nw_data)
    max_value = max(nw_data)
    
    % prep figure
    figure('Position',[0 0 2000 1200])
    hold on

    % plot the data, colored by level of dissolved oxygen
    scatter(nw_time, -nw_depth, 30, nw_data, 'filled');

    % finish figure
    c = colorbar;

    set(get(c,'Title'),'String',type_string);
    if ( data_type == 'odo')
        caxis([0 20]);
        load('odo-cm.mat');
        colormap(cm)
    end

    xlabel('time (yymmdd)')
    ylabel('depth (m)')
    datetick('x','HH:MM:SS')

    h = title(['EM ' data_type ' vs depth and time for: ' date_desired]);
    set(h,'interpreter','none')

    set(gca,'FontSize',16);
    set(findall(gcf,'type','text'),'FontSize',16);
end

end