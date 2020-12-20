function resultplot(len_best,citys,r)
    subplot(1,2,1);
    scatter(citys(:,1),citys(:,2),'*')
    hold on
    plot(citys(r,1),citys(r,2),'-');
    hold on
    text(citys(r(1),1),citys(r(1),2),'  Start');
    text(citys(r(end),1),citys(r(end),2),'  Finish');
    for i = 1:size(citys,1)
        text(citys(i,1),citys(i,2),['  ' num2str(i)]);
    end
    title('Output of PSO');
    subplot(1,2,2);
    plot(1:size(len_best,2),len_best);
    legend('Min Distance');
    xlabel('Iteration Number');
    ylabel('Total Distance');
    title('Min Distance - Iteration');
end