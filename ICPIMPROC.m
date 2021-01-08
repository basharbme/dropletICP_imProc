%written by Sungu Kim 1/5/2021
classdef ICPIMPROC < handle
       
    properties %(SetAccess = 'public', GetAccess = 'public')
        dataInfo_ = {};
        caseList_ = {};
    end
    
    methods
        %constructor
        function obj=ICPIMPROC() 
            % load file info
            imFileInfo; 
            obj.dataInfo_ = dataInfo; 
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
           
        function obj = initIm(obj,exp_case)
            %find case from property
            idx = find(ismember(obj.caseList_, exp_case));
            assert(~isempty(idx),'Check case name')
            
            filename = obj.dataInfo_{idx}.path_n_filename;
            I = imread(filename);
            Igr = medfilt2(I); % median filter
            se = strel('disk',5);
            Igr = imopen(Igr,se); % for image opening and closing
            Igr = imclose(Igr,se); % for image opening and closing
            Ibw = imbinarize(Igr);
            Ibw = bwareaopen(Ibw, 1000); % remove small objects
            Ibw = bwareafilt(Ibw,1); % remove all drops except the largest
            
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
        
        function imSub = imSubtract(obj,exp_case_1,imType_1,exp_case_2,imType_2)
            idx_1 = find(ismember(obj.caseList_, exp_case_1));
            assert(~isempty(idx_1),'Check case name for 1')
            idx_2 = find(ismember(obj.caseList_, exp_case_2));
            assert(~isempty(idx_2),'Check case name for 2')
            
            % overlap image by cross-correlation
            im1 = obj.dataInfo_{idx_1}.IM.(imType_1);
            im2 = obj.dataInfo_{idx_2}.IM.(imType_2);
            c = normxcorr2(im2,im1);
            [ypeak,xpeak] = find(c==max(c(:)));
            imSize = size(im2);
            im2shift = imtranslate(im2,[xpeak(1)-imSize(1), ypeak(1)-imSize(2)]);
            imSub = im1-im2shift;
        end
        
        function intSum = imIntSum(obj,caseName,imType)
            I = obj.getIm(caseName,imType);
            intSum = sum(sum(I));
        end
        
        function I = getIm(obj,caseName,imType) 
            idx = find(ismember(obj.caseList_, caseName));
            assert(~isempty(idx),'Check case name')
            
            I = obj.dataInfo_{idx}.IM.(imType);
        end
        
        function imshow(obj,caseName,imType)
            I = obj.getIm(caseName,imType);
            imshow(I)
        end
    end  
end

