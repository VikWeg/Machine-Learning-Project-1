function ScatterPlot(data)

dim=size(data);

figure
i=1;while i<=dim(2)
    j=1;while j<=dim(2)
        subplot(dim(2),dim(2),j+(i-1)*dim(2))
        plot(data(1:dim(1),i),data(1:dim(1),j))
        j=j+1;
        end
    i=i+1;
    end
clearvars dim i j
end
