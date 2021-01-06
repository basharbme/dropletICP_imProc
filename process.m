%% written by Sungu Kim 1/5/2021
clear
clc
close all

tic
%% initializing 
icpImProc = ICPIMPROC;

%% get average GFP increased
icpImProc.masking('GFP_init','texRed_init');
icpImProc.masking('GFP_final','texRed_final');

intSum_GFP_init = icpImProc.imIntSum('GFP_init','bgOut');
GFP_init_avg = sum(icpImProc.GFP_init_.IM.gr(:))/sum(icpImProc.GFP_init_.IM.bw(:));
GFP_diff = icpImProc.imSubtract('GFP_final','GFP_init');
GFP_diff_avg = sum(GFP_diff(:))/sum(icpImProc.texRed_final_.IM.bw(:));
GFP_EF_mean = 1+GFP_diff_avg/GFP_init_avg; 

%% get max GFP intensity with ICP
icpImProc.masking('GFP_final_ICP_','texRed_final_');
GFP_ICP_diff = icpImProc.imSubtract('GFP_final_ICP_','GFP_init_');
GFP_ICP_EF_max = 1+double(max(max(GFP_ICP_diff)))/GFP_init_avg; 

%%
toc

