%% main function 

clc; clear;

model_folder = 'data/cnn_assignment-lenet';
if exist(model_folder, 'dir')
    files = dir(model_folder);
    for k = 1:length(files)
        delete([ model_folder  '\' files(k).name])
    end
    
    rmdir data/cnn_assignment-lenet
end

%% fine-tune cnn

[net, info, expdir] = finetune_cnn();

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile(expdir, 'imdb-stl.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-stl.mat'));


%%
train_svm(nets, data);
