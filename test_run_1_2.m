
clear all
close all
load ('170v4.mat')

% from_min=4;
% from_sec=45;
% to_min=6;
% to_sec=50;
% starting_min=from_min*15000+from_sec*250;
% ending_min=to_min*15000+to_sec*250;
% signal_to_highlight=3;
gain=2000;

ecg=val/gain;%%%%%% 
raw_ecg=ecg;
fs=1000;
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

[qrs_amp_raw,qrs_i_raw,delay]=pan_tompkin(raw_ecg,fs,gr)

ST_Elevation_value_mean=zeros(1,length(qrs_i_raw));


sample_value_begin=60;
sample_value_end=180;%%%%%45
k=sample_value_end-sample_value_begin;%%%30
value=zeros(length(qrs_i_raw),k+1);%%%the matrix for initially storing the datas


for i=1:length(qrs_i_raw) %      8
    for st_seg=sample_value_begin:sample_value_end%%%%no of samples  15,16,17,.....45...total= 30
        w=qrs_i_raw(i);
        if w+st_seg > length(raw_ecg)
            break
        else
        st_segment(1,w+st_seg)=raw_ecg(1,w+st_seg);%%ecg_h is the filtered ECG; the raw_ecg is the unfiltered ECG
        
        value(i,(st_seg-(sample_value_begin-1)))=raw_ecg(1,w+st_seg);
        
        
        end
        
        
    end
    

    ST_Elevation_value_mean(1,i)=abs(mean(value(i,:)));    
    
end

Slope_value=zeros(length(qrs_i_raw),1);
tangent_value=zeros(length(qrs_i_raw),1);
for z=1:length(qrs_i_raw)
    v=value(z,:);
    Slope_value(z,1)=abs((v(1,121)-v(1,1))/(k+1));
    tangent_value(z,1)=atand(Slope_value(z,1));
end
slope_value_std=std(Slope_value)
figure;plot(raw_ecg);grid on; title ('Experimented signal and its st segment')
hold on
plot(st_segment,'r*');

Mean_value_of_tangent=mean(tangent_value)

















