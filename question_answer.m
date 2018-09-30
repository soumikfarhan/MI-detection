clc;clear all;close all

% Construct a questdlg with three options
answers=zeros(5,1);
choice = questdlg('Are you having pain or discomfort in chest?', ...
	'Question Session', ...
	'Severe','Mild','No, I think I am alright','No, I think I am alright');
% Handle response
switch choice
    case 'Severe'
        disp([choice '- contact emmergency service immediately'])
        dessert = 10;
        answers(1,1)=10
    case 'Mild'
        disp([choice ' -Please answer the next question.'])
        dessert = 5;
         answers(1,1)=5;
    case 'No, I think I am alright'
        disp('Please answer the next question')
        dessert = 0;
         answers(1,1)=0;
end


% Construct a questdlg with three options
choice = questdlg('Are you having Lightheadedness, Nausea or Vomitting?', ...
	'Question Session', ...
	'Severe','Mild','No, I think I am alright','No, I think I am alright');
% Handle response
switch choice
    case 'Severe'
        disp([choice '- contact emmergency service immediately'])
        dessert = 10;
         answers(2,1)=10;
    case 'Mild'
        disp([choice ' -Please answer the next question.'])
        dessert = 5;
        answers(2,1)=5;
    case 'No, I think I am alright'
        disp('Please answer the next question')
        dessert = 0;
        answers(2,1)=0;
end



% Construct a questdlg with three options
choice = questdlg('Are you having pain in Jaw, neck or in the Back?', ...
	'Question Session', ...
	'Severe','Mild','No, I think I am alright','No, I think I am alright');
% Handle response
switch choice
    case 'Severe'
        disp([choice '- contact emmergency service immediately'])
        dessert = 10;
        answers(3,1)=10;
    case 'Mild'
        disp([choice ' -Please answer the next question.'])
        dessert = 5;
         answers(3,1)=5;
    case 'No, I think I am alright'
        disp('Please answer the next question')
        dessert = 0;
         answers(3,1)=0;
end


% Construct a questdlg with three options
choice = questdlg('Are you having discomfort or pain in arm or shoulder?', ...
	'Question Session', ...
	'Severe','Mild','No, I think I am alright','No, I think I am alright');
% Handle response
switch choice
    case 'Severe'
        disp([choice '- contact emmergency service immediately'])
        dessert = 10;
         answers(4,1)=10;
    case 'Mild'
        disp([choice ' -Please answer the next question.'])
        dessert = 5;
        answers(4,1)=5;
    case 'No, I think I am alright'
        disp('Please answer the next question')
        dessert = 0;
        answers(4,1)=0;
end

choice = questdlg('Are you having shortness of breath?', ...
	'Question Session', ...
	'Severe','Mild','No, I think I am alright','No, I think I am alright');
% Handle response
switch choice
    case 'Severe'
        disp([choice '- contact emmergency service immediately'])
        dessert = 10;
         answers(5,1)=10;
    case 'Mild'
        disp([choice ' -Please answer the next question.'])
        dessert = 5;
        answers(5,1)=5;
    case 'No, I think I am alright'
        disp('Please answer the next question')
        dessert = 0;
        answers(5,1)=0;
end


if sum(answers)>=30
    disp('Please Contact emmergency services IMMEDIATELY')
elseif sum(answers)<20
    disp('Please contact immergency services, you may be expeiencing MI')
else sum(answers) <10
    disp('Dont worry. you are not having any cardiac arrest')
end    
    





