% function removemarkers

loadpaths %load file path
loadsubj %subject list


for i = 1:length(subjlist)
subject = subjlist{i};    
load([filepath subject '.set'], '-mat')
    Count = 0; %counter for deleted markers
    n = 1;
     while n < length(EEG.event)   
        check = strcmp(EEG.event(n).type,EEG.event(n+1).type);
        %checks if two consecutive strings are the same
        if check == 1 && n < length(EEG.event)
%           EEG.event(n) = []; 
            EEG.event(n+1) = []; %if same, delete second one    
            Count = Count+1;
        else
            n = n+1;
        end  
     end
    
    numl = 'numl';
    back = 'back';
    nronuml = 0;
    nroback = 0;
    m = 1;
%counter for the number of numls and backs
     while m <= length(EEG.event) 
         check2 = strcmp(EEG.event(m).type,numl);
         check3 = strcmp(EEG.event(m).type,back);
         
         if check2 == 1 && m <= length(EEG.event)
            nronuml = nronuml + 1;
            m = m + 1;
         elseif check3 == 1 && m <= length(EEG.event)
            nroback = nroback + 1; 
            m = m + 1;
         else
            m = m+1;
         end
     end
     
     diff = nronuml - nroback; %difference of number of markers
     
            
save([filepath subject 'count.mat'], 'Count', 'diff');      
save([filepath subject '.set'], 'EEG');
end  
clear;


     
     
% m = (size(EEG.event,2)-1);
%     
%      for n = 1:m     
%         check = strcmp(EEG.event(n).type,EEG.event(n+1).type);
%        
%         if check == 1
%             EEG.event(n).type = 1;
%             EEG.event(n+1).type = 1;            
%         end  
%      end
%           
  

