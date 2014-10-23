function [X,T]=UnitTestSin()

X=(0:2*pi/100:2*pi)';

T=sin(X)+normrnd(0,0.1,[101,1]);

end