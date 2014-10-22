function X = ExtractX(data,selection)
%returns Nx(# of features)
    dim=size(data);
    if isempty(selection)
    X=data(1:dim(1),1:(dim(2)-1));
    else
    X=data(1:dim(1),selection);
    end
end