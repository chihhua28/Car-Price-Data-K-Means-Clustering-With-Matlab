clc
clear

A = importdata('Customers_clustering.csv');
Xraw=[A.data];
[N,d]=size(Xraw);
d=d+1;
Xraw=[zeros(N,2),Xraw];
for k=1:N
    Xraw(k,1)=str2double(A.textdata(k+1,1));
    if strcmp(A.textdata(k+1,2),'Male')
        Xraw(k,2)=0;
    else
        Xraw(k,2)=1;
    end
end    

Xraw = Xraw(1:200,2:5);
Xnorm = normalize(Xraw);
Xnorm = [ones(200,1) Xnorm];

plot(Xnorm(:,4),Xnorm(:,5),'bo')

[N,d]=size(Xnorm);
P = 0.80 ;
idx = randperm(N)  ;
Train = Xnorm(idx(1:round(P*N)),:); 
Test = Xnorm(idx(round(P*N)+1:end),:);

writematrix(Train,'Train.csv') 
writematrix(Test,'Test.csv') 