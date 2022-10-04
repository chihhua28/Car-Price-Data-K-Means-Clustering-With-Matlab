clc
clear

Train = readtable('Train.csv','PreserveVariableNames',true);
Train = table2array(Train);

[m,n]=size(Train);
j=5;
s = randperm(m);
centroids = Train(s(1:j),:);
iteration=0;
Jtotal=[];
Jnewtotal=[];
Jnew=[];

while iteration<10
    groups = cell(j, 1) ;
    for i=1:m
        dists = [];
        for k=1:j
            dist=norm(Train(i,:)-centroids(k,:));
            dists=[dists dist];   
        end
        group_id=find(dists==min(dists)); 
        groups{group_id}=[groups{group_id};Train(i,:)];  
    end
    centroids=[];
    for k=1:j
        centroid=mean(groups{k});
        centroids=[centroids;centroid];
    end 
    Jtotal=[];
    Jnewtotal=[];
    if iteration==0
        for k=1:j
            Jgroup=(sum(sqrt(sum((groups{k}-centroids(k,:)).^2,2))));
            Jtotal=[Jtotal Jgroup];
        end
        J=1/m*sum(Jtotal)
    else
        for k=1:j
            Jgroup=(sum(sqrt(sum((groups{k}-centroids(k,:)).^2,2))));
            Jnewtotal=[Jnewtotal Jgroup]
        end
        Jnew=1/m*sum(Jnewtotal); 
        J=[J Jnew]
    end    
    iteration=iteration+1;
end

group1=groups{1};
group2=groups{2};
group3=groups{3};
group4=groups{4};
group5=groups{5};



figure(2)
plot(group1(:,4),group1(:,5),'ro')
hold on;
plot(group2(:,4),group2(:,5),'bo')
plot(group3(:,4),group3(:,5),'go')
plot(group4(:,4),group4(:,5),'mo')
plot(group5(:,4),group5(:,5),'ko')

figure(3)
plot3(group1(:,2),group1(:,4),group1(:,5),'ro')
hold on;
plot3(group2(:,2),group2(:,4),group2(:,5),'bo')
plot3(group3(:,2),group3(:,4),group3(:,5),'go')
plot3(group4(:,2),group4(:,4),group4(:,5),'mo')
plot3(group5(:,2),group5(:,4),group5(:,5),'ko')
