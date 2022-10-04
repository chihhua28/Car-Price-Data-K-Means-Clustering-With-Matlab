Test = readtable('Test.csv','PreserveVariableNames',true);
Test = table2array(Test);

j=5;
[p,q]=size(Test);
testgroups = cell(j, 1) ;


for i=1:p
    dists=[];
    for k=1:j
        dist=norm(Test(i,:)-centroids(k,:));
        dists=[dists dist];  
    end
    group_id=find(dists==min(dists)); 
    testgroups{group_id}=[testgroups{group_id};Test(i,:)];  
end

Jtest=[];
for k=1:j
    Jgroup=(sum(sqrt(sum((testgroups{k}-centroids(k,:)).^2,2))));
    Jtest=[Jtest Jgroup]
end
Jtest=1/p*sum(Jtest)

group1=testgroups{1};
group2=testgroups{2};
group3=testgroups{3};
group4=testgroups{4};
group5=testgroups{5};



figure(4)
plot(group1(:,4),group1(:,5),'ro')
hold on;
plot(group2(:,4),group2(:,5),'bo')
plot(group3(:,4),group3(:,5),'go')
plot(group4(:,4),group4(:,5),'mo')
plot(group5(:,4),group5(:,5),'ko')
