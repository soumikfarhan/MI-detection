clear all;close all
load('MI_value_angle_all.mat')
load('normal_value_angle_all.mat')

h1=histogram(MI_value_angle_all,'BinWidth',.001);grid on
hold on
h2=histogram(normal_value_angle_all,'BinWidth',.001)
hold off
%figure; plot(normal_value_angle_all);title('Normal value');grid on
%figure; plot(MI_value_angle_all);title('MI valaue');grid on

MI=h1.Values
NOR=h2.Values