%% written by Sungu Kim 1/5/2021
clear
clc
close all

tic
%% initializing 
icpImProc = ICPIMPROC;

%% GFP masking and drop size for analysis 
icpImProc.masking('GFP_init','texRed_init');
icpImProc.masking('GFP_final','texRed_final');
icpImProc.masking('GFP_final_ICP','texRed_final');
dropSize_init = icpImProc.imIntSum('texRed_init','bw');
dropSize_final = icpImProc.imIntSum('texRed_final','bw');

%% GFP average intensity, initial 
intSum_GFP_init = icpImProc.imIntSum('GFP_init','bgOut');
avgInt_GFP_init = intSum_GFP_init/dropSize_init;

%% GFP increased intensity, ICP off 
GFP_diff = icpImProc.imSubtract('GFP_final','bgOut','GFP_init','bgOut');
GFP_diff_avg = sum(GFP_diff(:))/dropSize_final;
GFP_EF_mean = 1+GFP_diff_avg/avgInt_GFP_init;

%% max GFP EF, ICP on
GFP_ICP_diff = icpImProc.imSubtract('GFP_final_ICP','bgOut','GFP_init','bgOut');
GFP_ICP_EF_max = 1+double(max(max(GFP_ICP_diff)))/avgInt_GFP_init; 

%%
toc

