%written by Sungu Kim 1/5/2021
classdef ICPIMPROC < handle
       
    properties %(SetAccess = 'public', GetAccess = 'public')
        dataInfo_ = {};
        caseList_ = {};
%         texRed_init_ = struct([])
%         texRed_final_ = struct([])
%         GFP_init_ = struct([])
%         GFP_final_ICP_ = struct([])
%         GFP_final_ = struct([])
    end
    
    methods
        %constructor
        function obj=ICPIMPROC() 
            % load file info
            imFileInfo; 
            obj.dataInfo_ = dataInfo;
%             obj.texRed_init_=texRed_init;
%             obj.texRed_final_=texRed_final;
%             obj.GFP_init_=GFP_init;
%             obj.GFP_final_=GFP_final;
%            obj.GFP_final_ICP_=GFP_final_ICP; 
            disp('Data info loaded!')
            
            % initialize images
            for i = 1:length(obj.dataInfo_)
                obj.caseList_{i} = obj.dataInfo_{i}.name;
            end
            for i = 1:length(obj.caseList_)
                obj.initIm(obj.caseList_{i});
            end
            disp('Images are initialized!')
        end
        
        function exist = ifProp(obj,str)
            checkProp = strcmp(obj.caseList_,str);
            numProp = sum(checkProp);
            if (numProp == 1)
                exist = true;
            else
                exist = false;
                error('Check experiment case name')
            end
        end
           
        function obj = initIm(obj,exp_case)
            %find case from property
            idx = find(ismember(obj.caseList_, exp_case));
            assert(~isempty(idx),'Check case name')
            
            filename = obj.dataInfo_{idx}.path_n_filename;
            I = imread(filename);
            Igr = medfilt2(I); % median filter
            Ibw = imbinarize(Igr);
            
            % udpate image data
            obj.dataInfo_{idx}.IM.im = I;
            obj.dataInfo_{idx}.IM.gr = Igr;
            obj.dataInfo_{idx}.IM.bw = Ibw;
        end
        
        function [bgOut] = masking(obj,exp_case_source,exp_case_mask)
            %find case from property
            idx_src = find(ismember(obj.caseList_, exp_case_source));
            assert(~isempty(idx_src),'Check case name for source')
            idx_mask = find(ismember(obj.caseList_, exp_case_mask));
            assert(~isempty(idx_mask),'Check case name for mask')
            
            source = obj.dataInfo_{idx_src}.IM.gr;
            mask = obj.dataInfo_{idx_mask}.IM.bw;
            bgOut = source .* uint16(mask);
            obj.dataInfo_{idx_src}.IM.bgOut = bgOut;
        end
        
        function imSub = imSubtract(obj,exp_case_1,exp_case_2)
            if(obj.ifProp(exp_case_1) && obj.ifProp(exp_case_2))
                % overlap image by cross-correlation 
                im1 = obj.(exp_case_1).IM.bgOut;
                im2 = obj.(exp_case_2).IM.bgOut;
                c = normxcorr2(im2,im1);
                [ypeak,xpeak] = find(c==max(c(:)));
                imSize = size(im2);
                im2shift = imtranslate(im2,[xpeak(1)-imSize(1), ypeak(1)-imSize(2)]);
                imSub = im1-im2shift;
            end
        end
    end  
end

