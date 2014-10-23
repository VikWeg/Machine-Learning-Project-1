function [X,T]=UnitTestStep()

X=(-1:2/100:1)';

T=-heaviside(X-0.5)+heaviside(X+0.5)+normrnd(0,0.1,[101,1]);

end