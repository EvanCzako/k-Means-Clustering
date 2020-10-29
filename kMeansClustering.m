function [clusters, clusterCenters] = kMeansClustering(dataSet,numClusters,numIterations)

    % Simple implementation of k-means clustering algorithm with adjustable
    % number of clusters and iterations of the algorithm. Output 'clusters'
    % is a cell array containing each set of clustered data (e.g.
    % clusters{1} will yield the first cluster of data). Output 
    % 'clusterCenters' contains the average values of each of the clusters 
    % (e.g. clusterCenters(1,:) corresponds to the average point of all 
    % data points in cluters{1}).
    %
    % See example below for demonstration.
    %
    %
    % %% EXAMPLE
    %     % In this example, we look at a 2D data set that has 4 apparent clusters.
    % 
    %     clear all;
    %     close all;
    % 
    %     load kmeansdata.mat
    % 
    %     % kmeansdata.mat yields 4-dimensional data in matrix X. We select the last
    %     % two columns for our dataset so that we can visualize the outcome of the
    %     % algorithm.
    % 
    %     dataSet = X(:,3:4);
    % 
    %     numClusters = 4;
    %     numIterations = 50;
    %     [clusters, clusterCenters] = kMeansClustering(dataSet,numClusters,numIterations);
    % 
    %     colors = {'ro','bo','go','yo','mo','co','ko'};
    %     plot(clusterCenters(:,1),clusterCenters(:,2),'k*');
    %     hold on;
    %     for i = 1:numClusters
    %         currCluster = clusters{i};
    %         plot(currCluster(:,1),currCluster(:,2),colors{i});
    %     end
    %
    %
    %
    % Evan Czako, 10.29.2020.
    
    

    dataLength = size(dataSet,1);
    dataDim = size(dataSet,2);

    avgPoints = rand(numClusters,size(dataSet,2));
    for j = 1:dataDim
        avgPoints(:,j) = avgPoints(:,j)*(max(dataSet(:,j))-min(dataSet(:,j)))+min(dataSet(:,j));
    end
    
    for iter = 1:numIterations
        disp(strcat('Iteration:',{' '},string(iter)));
        dataSetAssignments = [dataSet ones(dataLength,1)];
        for i = 1:size(dataSetAssignments,1)
           minDist = norm(dataSetAssignments(i,1:dataDim).' - avgPoints(1,:).');
           minJ = 1;
           for j = 1:size(avgPoints,1)
               dist = norm(dataSetAssignments(i,1:dataDim).' - avgPoints(j,:).');
               if dist <= minDist
                   minJ = j;
                   minDist = dist;
               end
           end
           dataSetAssignments(i,dataDim+1) = minJ;
        end
        for i = 1:numClusters
            splitSet(:,:,i) = {dataSetAssignments(dataSetAssignments(:,dataDim+1)==i,1:dataDim)};
        end
        
        
        for i = 1:numClusters
            avg = mean(splitSet{i});
            avgPoints(i,:) = avg(1:dataDim);
        end
    end
    
    clusters = splitSet;
    clusterCenters = avgPoints;
    
end