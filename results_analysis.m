clc;clear all; close all
load('data.mat')

thresholding_limit=.5;
p=mi>thresholding_limit;
Tp=sum(p)
Fn=14-Tp

q=non_mi<thresholding_limit;
Tn=sum(q)
Fp=14-Tn

%disp("the true positive",k)