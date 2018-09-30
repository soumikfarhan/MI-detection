tic
clc
clear all
close all
load ('e0302m_full.mat')
tangent_value_store=zeros(60,1);

for time_value=0:10:50;

from_min=27;
from_sec=time_value;
to_min=27;
to_sec=time_value+10;
starting_min=from_min*15000+from_sec*250;
ending_min=to_min*15000+to_sec*250;
signal_to_highlight=3;
gain=200;

ecg=(val(starting_min:ending_min))/gain;%%%%%% 
raw_ecg=ecg;
fs=250;
gr=0;
% plot(ecg);grid on; title ('Raw Signal')
% figure;plot(ecg-mean(ecg));grid on; title ('mean signal')

ecg=ecg-mean(ecg);

f1=5; %cuttoff low frequency to get rid of baseline wander
f2=15; %cuttoff frequency to discard high frequency noise
Wn=[f1 f2]*2/fs; % cutt off based on fs
N = 3; % order of 3 less processing
[a,b] = butter(N,Wn); %bandpass filtering
ecg_h = filtfilt(a,b,ecg);
ecg_h = ecg_h/ max( abs(ecg_h));

% figure
% plot(ecg_h); grid on; title ('QRS on filtered signal')

st_segment=zeros(1,length(ecg_h));

[qrs_amp_raw,qrs_i_raw,delay]=pan_tompkin(raw_ecg,fs,0)
ST_Elevation_value_max=zeros(1,length(qrs_i_raw));
ST_Elevation_value_mean=zeros(1,length(qrs_i_raw));
ST_Elevation_value_std=zeros(1,length(qrs_i_raw));
ST_Elevation_value_varience=zeros(1,length(qrs_i_raw));
ST_Elevation_value_range=zeros(1,length(qrs_i_raw));

sample_value_begin=15;
sample_value_end=45;%%%%%45
k=sample_value_end-sample_value_begin;%%%30
value=zeros(length(qrs_i_raw),k+1);%%%8*30

% if w+st_seg<length



for i=1:length(qrs_i_raw) %      8
    for st_seg=sample_value_begin:sample_value_end%%%%no of samples   30
        w=qrs_i_raw(i);
        if w+st_seg > length(raw_ecg)
            display('Not enough input arguement')
        else
        st_segment(1,w+st_seg)=raw_ecg(1,w+st_seg);%%ecg_h is the filtered ECG; the raw_ecg is the unfiltered ECG
        
        value(i,(st_seg-(sample_value_begin-1)))=raw_ecg(1,w+st_seg);
        
        
        end
        
        
    end
    
%     ST_Elevation_value_max(1,i)=max(st_segment);
%     ST_Elevation_value_mean(1,i)=mean(st_segment);
%     ST_Elevation_value_std(1,i)=std(st_segment);
%     ST_Elevation_value_varience(1,i)=var(st_segment);
    ST_Elevation_value_max(1,i)=abs(max(value(i,:)));
    ST_Elevation_value_mean(1,i)=abs(mean(value(i,:)));
    ST_Elevation_value_std(1,i)=abs(std(value(i,:)));
    ST_Elevation_value_varience(1,i)=abs(var(value(i,:)));
    ST_Elevation_value_range(1,i)=abs((max(value(i,:)))-(min(value(i,:))));
        
    
    
    
    
    
end

% ST_Elevation_value_max
% ST_Elevation_value_mean
% ST_Elevation_value_std
% ST_Elevation_value_varience

Slope_value=zeros(length(qrs_i_raw),1);
tangent_value=zeros(length(qrs_i_raw),1);
for z=1:length(qrs_i_raw)
    v=value(z,:);
    Slope_value(z,1)=abs((v(1,31)-v(1,1))/(k+1));
    tangent_value(z,1)=atand(Slope_value(z,1));
end
%slope_value_std=std(Slope_value)
%figure;plot(raw_ecg);grid on; title ('Experimented signal and its st segment')
%hold on
%plot(st_segment,'r*');

bar_graph=[ST_Elevation_value_max;ST_Elevation_value_mean;ST_Elevation_value_std;ST_Elevation_value_varience;ST_Elevation_value_range];%%write ST_Elevation_value_varience for observing the varience.
[r,c]=size(bar_graph);
bar_graph_plot=zeros(c,r);
for y=1:r
    for u=1:c
        bar_graph_plot(u,y)=bar_graph(y,u);
    end
end

% figure;fig1=bar(bar_graph_plot);grid on; title('visual comparison of the statistical features') 
%fig1(signal_to_highlight).LineWidth=2;fig1(signal_to_highlight).EdgeColor='red';
% figure;bar(ST_Elevation_value_mean);grid on; title('ST Elevation value mean')


% figure;bar(ST_Elevation_value_std);grid on; title('ST Elevation value standard deviation') 
% figure;bar(ST_Elevation_value_range);grid on; title('ST Elevation value range') 
% figure;bar(ST_Elevation_value_varience);grid on; title('ST Elevation value varience') 
% 
% %legend(bar_graph_plot,'max','mean','STD')
% legend('show')


% figure;bar3(bar_graph_plot,'grouped');grid on; title('visual comparison of the statistical features') 
% 
% %legend(bar_graph_plot,'max','mean','STD')
% legend('show')

% figure;bar3(bar_graph_plot,'stacked');grid on; title('visual comparison of the statistical features') 
% 
% %legend(bar_graph_plot,'max','mean','STD')
% legend('show')

% figure;bar(bar_graph_plot,'stacked');grid on; title('visual comparison of the statistical features') 
% 
% %legend(bar_graph_plot,'max','mean','STD')
% legend('show')
% figure;bar(Slope_value);grid on;title('slope value')
% figure;bar(tangent_value);grid on;title('tangent value')
% toc

% Mean=std(ST_Elevation_value_mean)
% Varience=std(ST_Elevation_value_varience)
%Range_std=std(ST_Elevation_value_range)

%figure; bar(Slope_value); grid on; title('Slope value')
figure; bar(tangent_value); grid on; title('tangent value')

Mean_value_of_tangent=mean(tangent_value)
tangent_value_store(time_value+1,1)=mean(tangent_value);
%Mean_value_of_slope=mean(Slope_value)
save MI_angle_value_14.mat tangent_value_14 


end
tan_store=1:10:60;
main_tangent_value_store=zeros(6,1);
for ty=1:6
  main_tangent_value_store(ty,1)=tangent_value_store(tan_store(ty),1);
end


