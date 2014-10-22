function PlotRegression(X,T,model,basis,M)

if strcmp('poly',basis)
xmin=min(X);
xmax=max(X);

xfit=(xmin:((xmax-xmin)/10):xmax)';

plot(X,T,'ro',xfit,DesignMatrix(xfit,basis,M)*model)

end
end