%written by Sungu Kim 1/5/2021
classdef ICPIMPROC < handle
       
    properties %(SetAccess = 'public', GetAccess = 'public')
        texRed_init_ = struct([])
        texRed_final_ = struct([])
        GFP_init_ = struct([])
        GFP_final_ICP_ = struct([])
        GFP_final_ = struct([])
    end
    
    methods
        %constructor
        function obj=ICPIMPROC() 
            % load file info
            imFileInfo; 
            obj.texRed_init_=texRed_init;
            obj.texRed_final_=texRed_final;
            obj.GFP_init_=GFP_init;
            obj.GFP_final_=GFP_final;
            obj.GFP_final_ICP_=GFP_final_ICP; disp('ICPIMPROC properties set!')
            
            % initialize images
            props = properties(obj);
            for i = 1:length(props)
                obj.initIm(props{i});
            end
            disp('Images are initialized!')
        end
        
        function exist = ifProp(obj,str)
            checkProp = strcmp(properties(obj),str);
            numProp = sum(checkProp);
            if (numProp == 1)
                exist = true;
            else
                exist = false;
                error('Check experiment case name')
            end
        end
           
        function obj = initIm(obj,exp_case)
             if (obj.ifProp(exp_case))
                filename = obj.(exp_case).path_n_filename;
                I = imread(filename);
                Igr = medfilt2(I);
                Ibw = imbinarize(Igr);
                
                obj.(exp_case).IM.im = I;
                obj.(exp_case).IM.gr = Igr;
                obj.(exp_case).IM.bw = Ibw;
             end
        end
        
        function [bgOut] = masking(obj,exp_case_source,exp_case_mask)
            if(obj.ifProp(exp_case_source) && obj.ifProp(exp_case_mask))
                source = obj.(exp_case_source).IM.gr;
                mask = obj.(exp_case_mask).IM.bw;
                bgOut = source .* uint16(mask);
                obj.(exp_case_source).IM.bgOut = bgOut;
            end 
        end
        
        function testXCorel(obj)
            im1 = obj.GFP_init_.IM.bgOut;
            im2 = obj.GFP_final_.IM.bgOut;
            montage({im1*10,im2*10})
            
            c = normxcorr2(im2,im1);
            [ypeak,xpeak] = find(c==max(c(:)));
            
            imSize = size(im2);
            im2shift = imtranslate(im2,[xpeak(1)-imSize(1), ypeak(1)-imSize(2)]);
            figure()
            montage({im1*10,im2shift*10})
            
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

