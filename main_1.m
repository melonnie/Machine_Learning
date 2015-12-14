% function [test_Predicted_labels] = KNN(Xtrain,Ltrain,Xtest, K)
%% This is the matlab implemenatation for K nearest neighbors
% Input Arguments: 
% Xtrain : training data set
% Ltrain : Labels of training samples
% Xtest : test data set
% K : number of nearest neighbors 
% Output Arguments :
% TestLabel : Predicted labels of the output data set
% default value of K if not given by user is 8.


K = 8;

%Read training data
data = csvread('training_classification_regression_2015.csv');

%Split data into training data and validation data - 75/25 split
Xtrain= data(1:3750,:);
Xvalid=data(3751:end,:);

%Training labels
Ltrain=data(1:3750,end);


[N , ~] = size(Xtrain);
[Nvalid,~] = size(Xvalid);

distance = zeros(N,Nvalid);

% z1 = (query(1) - temp).^2;
% z2 = (query(2) - wind).^2;
% z3 = (query(3) - humidity).^2;
% 
% % disp(z1);
% 
% euclideanDistance = z1 + z2 + z3; %Euclidean distance in square units
% disp(euclideanDistance);
% 
% %End (0)
% 
% distance       = [euclideanDistance precipitation]; % Appending the output(precipitation) vector to distance.
% sortedDistance = sortrows(distance); % sort the distance vector based on the proximity to search query.
% scatterplot(euclideanDistance,precipitation);
% precipitation  = mode(sortedDistance(1:k,2));

% calculating the euclidean distance of the test samples from training
% samples
for i = 1: Nvalid
     for j = 1: N 
        distance(j,i) =(Xvalid(i,:)-Xtrain(j,:)).^2;
     end
end



% ascendingdistances stores all the distances of the test samples
% from the all training samples in cloumns
% Index will have indices of the corresponding training sample
[~,Index]= sort(distance,'ascend');




% consider only top K nearest neighbors to predict the label for test
% sample
Lvalid = zeros(K,Nvalid);
for i = 1:Nvalid
    for j=1:K
    Lvalid(j,i) = Ltrain(Index(j,i));
    end
end

valid_Predicted_labels = mode(Lvalid);
valid_Predicted_labels = valid_Predicted_labels';

scatterplot(Index,valid_Predicted_labels);

% matrix dimensions should be equal
[Lvalid,~] = size(valid_Predicted_labels);

count=0;
valid_labels=data(3751:end,end);

for i=1:Lvalid   
if(valid_labels(i,1)==valid_Predicted_labels(i,1))
    count = count+1;
end    
end

missPredictions = Lvalid - count;
Error = missPredictions / Lvalid;

disp(missPredictions);
disp(Error);

