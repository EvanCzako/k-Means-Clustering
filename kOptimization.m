function clusterScores = kOptimization(dataSet,numIterations,lowerNumClusters,upperNumClusters)

    % Uses silhouette method to determine optimal number of clusters (k)
    % for a given data set (dataSet). Range of possible k values is set by
    % lowerNumClusters and upperNumClusters. Number of iterations of the
    % kMeansClustering3 algorithm per trial is set by numIterations.
    % Output clusterScores has two columns: the first column represents
    % each k-value, and the second column is the corresponding silhouette
    % score for that k-value. Higher scores indicate better k-values.
    %
    % See example below for demonstration.
    %
    %
    %% Example
    %     % In this example, we look at a 2D data set that has 4 apparent clusters.
    %     % kOptimization can confirm this. We set our number of iterations per trial
    %     % to 100, and vary our k-values from 2 to 7, scoring each value of k
    %     % independently.
    % 
    %     clear all;
    %     close all;
    % 
    %     load kmeansdata.mat
    % 
    %     dataSet = X(:,3:4);
    % 
    %     clusterScores = kOptimization(dataSet,100,2,7);
    %     disp(clusterScores);
    %
    %
    %
    % Evan Czako, 11.9.2020.    
 

    clusterScores = [];

    for numClusters = lowerNumClusters:upperNumClusters

        [clusters, clusterCenters] = kMeansClustering(dataSet,numClusters,numIterations);

        a_scores = [];
        b_scores = [];

        C_x_mean_scores = [];

        for x = 1:numClusters

            C_x = clusters{x};

            for i = 1:size(C_x,1)

                a_i = 1/(size(C_x,1)-1)*sum(sqrt(sum((C_x(i,:)-C_x).^2,2)));
                a_scores = [a_scores; a_i];

                b_i_list = [];
                for y = 1:numClusters
                    if y ~= x
                        C_y = clusters{y};
                        b_i = 1/(size(C_y,1))*sum(sqrt(sum((C_x(i,:)-C_y).^2,2)));
                        b_i_list = [b_i_list b_i];
                    end
                end
                b_i = min(b_i_list);
                b_scores = [b_scores; b_i];

            end

            C_x_scores = (b_scores-a_scores)./max(a_scores,b_scores);
            C_x_mean_scores = [C_x_mean_scores; mean(C_x_scores)];

        end

        clusterScores = [clusterScores; numClusters mean(C_x_mean_scores)];


            for i = 1:numClusters
                currCluster = clusters{i};
            end


    end

