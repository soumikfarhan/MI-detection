clc
clear all
close all
load ('s0021arem.mat')
signal_no=1;%%%%%No of lead. I am taking V4 usually
ecg=val(signal_no,:);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%the data matrix should be changd
raw_ecg=ecg;
fs=1000;
gr=1;

plot(ecg);grid on; title ('Raw Signal')
figure;plot(ecg-mean(ecg));grid on; title ('mean signal')


qrs_c =[]; %amplitude of R
qrs_i =[]; %index
SIG_LEV = 0; 
nois_c =[];
nois_i =[];
delay = 0;
skip = 0; % becomes one when a T wave is detected
not_nois = 0; % it is not noise when not_nois = 1
selected_RR =[]; % Selected RR intervals
m_selected_RR = 0;
mean_RR = 0;
qrs_i_raw =[];
qrs_amp_raw=[];
ser_back = 0; 
test_m = 0;
SIGL_buf = [];
NOISL_buf = [];
THRS_buf = [];
SIGL_buf1 = [];
NOISL_buf1 = [];
THRS_buf1 = [];
ax = zeros(1,6);


ecg = ecg - mean(ecg);

f1=5; %cuttoff low frequency to get rid of baseline wander
f2=15; %cuttoff frequency to discard high frequency noise
Wn=[f1 f2]*2/fs; % cutt off based on fs
N = 3; % order of 3 less processing
[a,b] = butter(N,Wn); %bandpass filtering
ecg_h = filtfilt(a,b,ecg);
ecg_h = ecg_h/ max( abs(ecg_h));


plot(ecg_h); grid on; title ('QRS on filtered signal')
% figure;
% plotATM('e0107m_1min')

[qrs_amp_raw,qrs_i_raw,delay]=pan_tompkin(val(signal_no,:),fs,1)


% figure; plot(ecg_h(1:2500),'g*'); grid on; title ('First 10 sec of the signal')
% hold on
% plot(ecg_h(1:1000))
% hold off

st_segment=ones(1,length(ecg_h));
% for p=1:9%%%the first initial values of qrs_i_raw
%     for st_seg=15:25
%         st_segment(1,p+st_seg)=ecg_h(1,p+st_seg);
%     end
% end




for t=1:length(qrs_i_raw)
    for st_seg=60:180%%%%%usually 20-25 samples are needed for first flactuation; 65 to 80 for second flactuations
        w=qrs_i_raw(t);
        st_segment(1,w+st_seg)=raw_ecg(1,w+st_seg);
    end
end

% figure;plot(ecg);grid on; title ('First 10 sec of the signal')
% hold on
% plot(st_segment,'r*');
% from_min=28;
% from_sec=54;
% to_min=29;
% to_sec=0;
% from=from_min*15000+from_sec*250;
% to=to_min*15000+to_sec*250;
% ecg_1=raw_ecg(from:to);%250 samples per second; 15000 per min
% st_segment_1=st_segment(from:to);




ecg_1=raw_ecg;%250 samples per second; 15000 per min
st_segment_1=st_segment;


figure;plot(ecg_1);grid on; title ('visualize')
hold on
plot(st_segment_1,'r*');
        
        
        
        
        
        
        
