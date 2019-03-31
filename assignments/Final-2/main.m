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
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-40.mat')); 
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
pre_x = cat(1, svm.pre_trained.trainset.features, svm.pre_trained.testset.features);
pre_y = cat(1, svm.pre_trained.trainset.labels, svm.pre_trained.testset.labels);
tsne(full(pre_x), pre_y);
savefig('results/tsne_pre_trained.fig')

% Fine-tuned
figure;
fine_x = cat(1, svm.fine_tuned.trainset.features, svm.fine_tuned.testset.features);
fine_y = cat(1, svm.fine_tuned.trainset.labels, svm.fine_tuned.testset.labels);
tsne(full(fine_x), fine_y);
savefig('results/tsne_fine_tuned.fig');
