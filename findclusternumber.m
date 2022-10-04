clc
clear

Train = readtable('Train.csv','PreserveVariableNames',true);
Train = table2array(Train);

[m,n]=size(Train);
Jfinal=[];

for j=1:15
    s = randperm(m);
    centroids = Train(s(1:j),:);
    iteration=0;
    Jtotal=[]
    Jnewtotal=[]
    Jnew=[];

    while iteration<10
        groups = cell(j, 1) ;
        for i=1:160
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
                Jnewtotal=[Jnewtotal Jgroup];
            end
            Jnew=1/m*sum(Jnewtotal); 
            J=[J Jnew]
        end    
        iteration=iteration+1;
    end
    Jfinal=[Jfinal Jnew]
end

figure(1)
plot(Jfinal,'-*')
