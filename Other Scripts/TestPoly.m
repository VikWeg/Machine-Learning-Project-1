function TestPoly(orders)

global TrainingData
DimTrain=size(TrainingData);

figure
tit='order=%d|#UnRedPar=%d|G=%4.1f|ev=%4.1f|L=%6.5f';

        j=orders(1,1);while j<=orders(1,2)
        
                        [prediction,evidence,alpha,beta,gamma,UnReducedParameters]=PolyPredict(j);
                        
                        subplot(3,3,j-orders(1,1)+1)
                        
                        hist(prediction,50:100:10000);                   
                        title(sprintf(tit,j,UnReducedParameters,gamma,evidence,alpha/beta))
                        
                        hold on                     
                        hist(TrainingData(1:DimTrain(1),DimTrain(2)),50:100:10000);
                        h=findobj(gca,'Type','patch');
                        set(h(1),'FaceColor','b','EdgeColor','w','facealpha',0.5)
                        set(h(2),'FaceColor','r','EdgeColor','w','facealpha',0.5)
                        hold off
                        
                        j=j+1;
                     end

end