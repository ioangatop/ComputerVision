%% main function 

% clc; clear;
% addpath data
% model_folder = 'data/cnn_assignment-lenet';
% if exist(model_folder, 'dir')
%     files = dir(model_folder);
%     for k = 1:length(files)
%         delete([ model_folder  '/' files(k).name])
%     end
%     
%     rmdir data/cnn_assignment-lenet
% end

%% fine-tune cnn

[net, info, expdir] = finetune_cnn();

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
% IMPORTANT:    
% change to net-epoch-X.mat where X is the number of epochs
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-120.mat')); 
nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); 
if isfield(nets.pre_trained, 'net')
   nets.pre_trained = nets.pre_trained.net; 
end
data = load(fullfile(expdir, 'imdb-stl.mat'));

%% Train SVM

svm = train_svm(nets, data);

%% Reduce dimensionality and visualize features using t-SNE

% Pre-trained
figure;
pre_x = full(cat(1, svm.pre_trained.trainset.features, svm.pre_trained.testset.features));
pre_y = cat(1, svm.pre_trained.trainset.labels, svm.pre_trained.testset.labels);
pre_mappedX = tsne(pre_x, pre_y);

pre_labels = convert_labels(pre_y);
gscatter(pre_mappedX(:,1), pre_mappedX(:,2), pre_labels);
title('Pre-trained features');
savefig('results/tsne_pre_trained.fig')

% Fine-tuned
figure;
fine_x = full(cat(1, svm.fine_tuned.trainset.features, svm.fine_tuned.testset.features));
fine_y = cat(1, svm.fine_tuned.trainset.labels, svm.fine_tuned.testset.labels);
fine_mappedX = tsne(fine_x, fine_y);

figure;
fine_labels = convert_labels(fine_y);
gscatter(fine_mappedX(:,1), fine_mappedX(:,2), fine_labels);
title('Fine-tuned features');
savefig('results/tsne_fine_tuned.fig');
