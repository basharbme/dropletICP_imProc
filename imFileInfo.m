texRed_init.name = 'texRed_init';
texRed_init.path = [pwd '\' 'initial'];
texRed_init.fileName = 'lysis&assay_initc3.tif';
texRed_init.path_n_filename = [texRed_init.path '\' texRed_init.fileName];
texRed_init.IM = [];

%%
GFP_init.name = 'GFP_init';
GFP_init.path = [pwd '\' 'initial'];
GFP_init.fileName = 'lysis&assay_initc2.tif';
GFP_init.path_n_filename = [GFP_init.path '\' GFP_init.fileName];
GFP_init.IM = [];

%%
texRed_final.name = 'texRed_final';
texRed_final.path = [pwd '\' '20min'];
texRed_final.fileName = 'lysis&assay_final_wo_icpc3.tif';
texRed_final.path_n_filename = [texRed_final.path '\' texRed_final.fileName];
texRed_final.IM = [];

%%
GFP_final.name = 'GFP_final';
GFP_final.path = [pwd '\' '20min'];
GFP_final.fileName = 'lysis&assay_final_wo_icpc2.tif';
GFP_final.path_n_filename = [GFP_final.path '\' GFP_final.fileName];
GFP_final.IM = [];

%%
GFP_final_ICP.name = 'GFP_final_ICP';
GFP_final_ICP.path = [pwd '\' '20min'];
GFP_final_ICP.fileName = 'lysis&assay_20min002c2.tif';
GFP_final_ICP.path_n_filename = [GFP_final_ICP.path '\' GFP_final_ICP.fileName];
GFP_final_ICP.IM = [];

%%
dataInfo = {texRed_init, texRed_final, GFP_init, GFP_final,GFP_final_ICP};
