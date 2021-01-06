%% written by Sungu Kim 1/5/2021
clear
clc
close all

lineWidth = 2;
markerSize = 12;

tic
%% 0minializing 
icpImProc = ICPIMPROC;

%% GFP masking and drop size for analysis 
icpImProc.masking('GFP_0min','texRed_0min');
icpImProc.masking('GFP_final','texRed_final');
dropSize_0min = icpImProc.imIntSum('texRed_0min','bw');
dropSize_final = icpImProc.imIntSum('texRed_final','bw');

%% GFP average intensity, 0min
intSum_GFP_0min = icpImProc.imIntSum('GFP_0min','bgOut');
avgInt_GFP_0min = intSum_GFP_0min/dropSize_0min;

%% GFP increased intensity, ICP off 
icpImProc.masking('GFP_final_ICP','texRed_final');
GFP_diff_final = icpImProc.imSubtract('GFP_final','bgOut','GFP_0min','bgOut');
GFP_diff_final_avg = sum(GFP_diff_final(:))/dropSize_final;
GFP_EF_mean = 1+GFP_diff_final_avg/avgInt_GFP_0min;

%% max GFP EF, ICP on
% 5 min
icpImProc.masking('GFP_ICP_5min','texRed_5min');
GFP_ICP_diff_5min = icpImProc.imSubtract('GFP_ICP_5min','bgOut','GFP_0min','bgOut');
GFP_ICP_EF_5min_max = 1+double(max(max(GFP_ICP_diff_5min)))/avgInt_GFP_0min;

% 10 min
icpImProc.masking('GFP_ICP_10min','texRed_10min');
GFP_ICP_diff_10min = icpImProc.imSubtract('GFP_ICP_10min','bgOut','GFP_0min','bgOut');
GFP_ICP_EF_10min_max = 1+double(max(max(GFP_ICP_diff_10min)))/avgInt_GFP_0min;

% 15 min
icpImProc.masking('GFP_ICP_15min','texRed_15min');
GFP_ICP_diff_15min = icpImProc.imSubtract('GFP_ICP_15min','bgOut','GFP_0min','bgOut');
GFP_ICP_EF_15min_max = 1+double(max(max(GFP_ICP_diff_15min)))/avgInt_GFP_0min;

GFP_ICP_diff_final = icpImProc.imSubtract('GFP_final_ICP','bgOut','GFP_0min','bgOut');
GFP_ICP_EF_final_max = 1+double(max(max(GFP_ICP_diff_final)))/avgInt_GFP_0min; 

%% out of ICP zone droplet 
%final
icpImProc.masking('GFP_noICP_final','texRed_noICP_final');
dropSize_noICP_final = icpImProc.imIntSum('texRed_noICP_final','bw');
intSum_GFP_noICP_final = icpImProc.imIntSum('GFP_noICP_final','bgOut');
avgInt_GFP_noICP_final = intSum_GFP_noICP_final/dropSize_noICP_final;
EF_GFP_noICP_final = avgInt_GFP_noICP_final/avgInt_GFP_0min;

%% plots
%EF
t = [0 5 10 15 20];
EF_ICP = [1 GFP_ICP_EF_5min_max GFP_ICP_EF_10min_max GFP_ICP_EF_15min_max ...
    GFP_ICP_EF_final_max];

plot(t,EF_ICP,'-o','LineWidth',lineWidth,'MarkerSize',markerSize), hold on
plot([0 20],[GFP_EF_mean GFP_EF_mean],'-x','LineWidth',lineWidth,...
    'MarkerSize',markerSize)
plot([0 20],[EF_GFP_noICP_final EF_GFP_noICP_final],'-*',...
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

