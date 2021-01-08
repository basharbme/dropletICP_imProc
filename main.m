%% written by Sungu Kim 1/5/2021
clear
clc
close all

tic

lineWidth = 2;
markerSize = 12;

%% class initializing  
icpImProc = ICPIMPROC;

%% 0 min
% in ICP zone
icpImProc.masking('GFP_0min','texRed_0min');
dropSize_0min = icpImProc.imIntSum('texRed_0min','bw');

% out of ICP zone
icpImProc.masking('GFP_noICP_0min','texRed_noICP_0min');
dropSize_noICP_0min = icpImProc.imIntSum('texRed_noICP_0min','bw');
intSum_GFP_noICP_0min = sum(sum(icpImProc.getIm('GFP_noICP_0min','bgOut')));
dropSize_texRed_noICP_0min = sum(sum(icpImProc.getIm('texRed_noICP_0min','bw')));
avgInt_GFP_noICP_0min = intSum_GFP_noICP_0min/dropSize_texRed_noICP_0min;



%% 5 min 
% ICPOn 
icpImProc.masking('GFP_ICP_5min','texRed_ICP_5min');
GFP_ICP_diff_5min = icpImProc.imSubtract('GFP_ICP_5min','bgOut','GFP_0min','bgOut');
GFP_ICP_diff_5min = GFP_ICP_diff_5min.*uint16(bwareaopen(GFP_ICP_diff_5min, 1000)); % remove artificial peaks 
maxEF_GFP_ICP_5min = 1+double(max(max(GFP_ICP_diff_5min)))/avgInt_GFP_noICP_0min;

% ICPOff
icpImProc.masking('GFP_ICPOff_5min','texRed_ICPOff_5min');
dropSize_ICPOff_5min = icpImProc.imIntSum('texRed_ICPOff_5min','bw');
GFP_ICPOff_diff_5min = icpImProc.imSubtract('GFP_ICPOff_5min','bgOut','GFP_0min','bgOut');
GFP_ICPOff_diff_5min = GFP_ICP_diff_5min.*uint16(bwareaopen(GFP_ICPOff_diff_5min, 1000)); % remove artificial peaks 
GFP_ICPOff_meanDiff_5min = sum(GFP_ICPOff_diff_5min(:))/dropSize_ICPOff_5min;
meanEF_GFP_ICPOff_5min = 1+GFP_ICPOff_meanDiff_5min/avgInt_GFP_noICP_0min;

%% 10 min 
% ICPOn 
icpImProc.masking('GFP_ICP_10min','texRed_ICP_10min');
GFP_ICP_diff_10min = icpImProc.imSubtract('GFP_ICP_10min','bgOut','GFP_0min','bgOut');
GFP_ICP_diff_10min = GFP_ICP_diff_10min.*uint16(bwareaopen(GFP_ICP_diff_10min, 1000)); % remove artificial peaks 
maxEF_GFP_ICP_10min = 1+double(max(max(GFP_ICP_diff_10min)))/avgInt_GFP_noICP_0min;

% ICPOff
icpImProc.masking('GFP_ICPOff_10min','texRed_ICPOff_10min');
dropSize_ICPOff_10min = icpImProc.imIntSum('texRed_ICPOff_10min','bw');
GFP_ICPOff_diff_10min = icpImProc.imSubtract('GFP_ICPOff_10min','bgOut','GFP_0min','bgOut');
GFP_ICPOff_diff_10min = GFP_ICPOff_diff_10min.*uint16(bwareaopen(GFP_ICPOff_diff_10min, 1000)); % remove artificial peaks 
GFP_ICPOff_meanDiff_10min = sum(GFP_ICPOff_diff_10min(:))/dropSize_ICPOff_10min;
meanEF_GFP_ICPOff_10min = 1+GFP_ICPOff_meanDiff_10min/avgInt_GFP_noICP_0min;

%% 15 min 
% ICPOn 
icpImProc.masking('GFP_ICP_15min','texRed_ICP_15min');
GFP_ICP_diff_15min = icpImProc.imSubtract('GFP_ICP_15min','bgOut','GFP_0min','bgOut');
GFP_ICP_diff_15min = GFP_ICP_diff_15min.*uint16(bwareaopen(GFP_ICP_diff_15min, 1000)); % remove artificial peaks 
maxEF_GFP_ICP_15min = 1+double(max(max(GFP_ICP_diff_15min)))/avgInt_GFP_noICP_0min;

% ICPOff
icpImProc.masking('GFP_ICPOff_15min','texRed_ICPOff_15min');
dropSize_ICPOff_15min = icpImProc.imIntSum('texRed_ICPOff_15min','bw');
GFP_ICPOff_diff_15min = icpImProc.imSubtract('GFP_ICPOff_15min','bgOut','GFP_0min','bgOut');
GFP_ICPOff_diff_15min = GFP_ICPOff_diff_15min.*uint16(bwareaopen(GFP_ICPOff_diff_15min, 1000)); % remove artificial peaks 
GFP_ICPOff_meanDiff_15min = sum(GFP_ICPOff_diff_15min(:))/dropSize_ICPOff_15min;
meanEF_GFP_ICPOff_15min = 1+GFP_ICPOff_meanDiff_15min/avgInt_GFP_noICP_0min;

%% 20 min 
% ICPOn 
icpImProc.masking('GFP_ICP_20min','texRed_ICP_20min');
GFP_ICP_diff_20min = icpImProc.imSubtract('GFP_ICP_20min','bgOut','GFP_0min','bgOut');
GFP_ICP_diff_20min = GFP_ICP_diff_20min.*uint16(bwareaopen(GFP_ICP_diff_20min, 1000)); % remove artificial peaks 
maxEF_GFP_ICP_20min = 1+double(max(max(GFP_ICP_diff_20min)))/avgInt_GFP_noICP_0min;

% ICPOff
icpImProc.masking('GFP_ICPOff_20min','texRed_ICPOff_20min');
dropSize_ICPOff_20min = icpImProc.imIntSum('texRed_ICPOff_20min','bw');
GFP_ICPOff_diff_20min = icpImProc.imSubtract('GFP_ICPOff_20min','bgOut','GFP_0min','bgOut');
GFP_ICPOff_diff_20min = GFP_ICPOff_diff_20min.*uint16(bwareaopen(GFP_ICPOff_diff_20min, 1000)); % remove artificial peaks 
GFP_ICPOff_meanDiff_20min = sum(GFP_ICPOff_diff_20min(:))/dropSize_ICPOff_20min;
meanEF_GFP_ICPOff_20min = 1+GFP_ICPOff_meanDiff_20min/avgInt_GFP_noICP_0min;

% out of ICP zone
icpImProc.masking('GFP_noICP_20min','texRed_noICP_20min');
dropSize_noICP_20min = icpImProc.imIntSum('texRed_noICP_20min','bw');
intSum_GFP_noICP_20min = icpImProc.imIntSum('GFP_noICP_20min','bgOut');
avgInt_GFP_noICP_20min = intSum_GFP_noICP_20min/dropSize_noICP_20min;
EF_GFP_noICP_20min = avgInt_GFP_noICP_20min/avgInt_GFP_noICP_0min;

%% plots
%EF
t = [0 5 10 15 20];
EF_ICP = [1 maxEF_GFP_ICP_5min maxEF_GFP_ICP_10min maxEF_GFP_ICP_15min ...
    maxEF_GFP_ICP_20min];
EF_ICPOff = [1 meanEF_GFP_ICPOff_5min meanEF_GFP_ICPOff_10min meanEF_GFP_ICPOff_15min ...
    meanEF_GFP_ICPOff_20min];

plot(t,EF_ICP,'-o','LineWidth',lineWidth,'MarkerSize',markerSize), hold on
plot(t,EF_ICPOff,'-x','LineWidth',lineWidth,...
    'MarkerSize',markerSize)
plot([0 20],[EF_GFP_noICP_20min EF_GFP_noICP_20min],'-*',...
    'LineWidth',lineWidth,'MarkerSize',markerSize)

%accessaries 
axis([-1 21 -inf inf])
xlabel('Time (min)','Interpreter','latex')
ylabel('Enrichment Factor','Interpreter','latex')
legend('Max EF w/ ICP', 'Droplet EF w/o ICP', 'EF ICP never experienced');

%save
print('EF','-dpng')

%%
toc

