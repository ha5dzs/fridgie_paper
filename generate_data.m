% Supplementary material for the fridgie paper.
% Part 1: The synthetic data.

% This script generates the required data for the neural network to be
% trained. IMPORTANT: Change the main parameters to suit your device.

clear;
clc;

%% Main parameters

% These are the conditions the neural network should detect.
% Feel free to add your own.
labels = ["normal"; "low_refrigerant"; "check_airflow"; "check_condenser"; "check_compressor"; "high_heatload"];

no_of_conditions = length(labels); % Using this for sanity checks

% These specify how many images should be generated for each condition.
% We will generate different distributions with the same parameters.
% The idea is that we train with the training data, and we validate the
% neural network model with the testing data, because it is 'new' data it
% has not seen before.

training_data_per_condition = 10000; 
testing_data_per_condition = 2500;


% To maximise the dynamic range of the 8-bit sensor values, we will define
% absolute minimum and maximum temperatures: these are temperature
% boundaries outside which we should never ever go.

% These are in Celsius, but it could be anything else, as long as you are
% consistent with the units throughout.
absolute_mimimum_temp = -20; % This will be 0
absolute_maximum_temp = 80; % This will be 1

% These are the five parameters we are looking at. They are based upon
% my old hunk-of-junk 7 kW R22 system that failed so many times.
% Naturally I didn't leak refrigerant into the atmosphere, and
% I haven't stayed outside in the 45 degrees heat over hours to collect this data.
% The standard deviations are estimated.
% A useful visualisation tool:
% https://www.desmos.com/calculator/0x3rpqtgrx

% The standard deviations are intentionally wide, so it will be difficult to
% train the neural network. In return, it will be more sensitive.

% IMPORTANT: CHANGE THESE TO YOUR SYSTEM! YOU NEED TO MEASURE THIS ON YOUR OWN!
% The order of the data ia as per the labels specified above.

t1_means = [60; 45; 55; 65; 40; 65];
t1_standard_deviations = [2; 2; 2; 2; 0.1; 2];

t3_means = [48; 40; 45; 60; 40; 45];
t3_standard_deviations = [2; 2; 2; 2; 0.1; 2];

t2_means = [4; 0; 4; 15; 35; 4];
t2_standard_deviations = [2; 2; 2; 2; 0.1; 2];

t4_means = [8; 15; 5; 30; 30; 20];
t4_standard_deviations = [2; 2; 2; 2; 0.1; 2];

d_means = [0.5; 1; 0.8; 0.3; 1; 1];
d_standard_deviations = [0.1; 0.01; 0.05; 0.06; 0.01; 0.04];


% Sanity checks!

    % t1
if(length(t1_means) ~= no_of_conditions)
    fprintf('lentgh of labels: %d, length of t1_means: %d\n', no_of_conditions, length(t1_means))
    error('t1_means does not align with the labels.')
end

if(length(t1_standard_deviations) ~= no_of_conditions)
    fprintf('lentgh of labels: %d, length of t1_standard_deviations: %d\n', no_of_conditions, length(t1_standard_deveiations))
    error('t1_standard_deviations does not align with the labels.')
end

    % t3
if(length(t3_means) ~= no_of_conditions)
    fprintf('lentgh of labels: %d, length of t3_means: %d\n', no_of_conditions, length(t3_means))
    error('t3_means does not align with the labels.')
end

if(length(t3_standard_deviations) ~= no_of_conditions)
    fprintf('lentgh of labels: %d, length of t3_standard_deviations: %d\n', no_of_conditions, length(t3_standard_deveiations))
    error('t3_standard_deviations does not align with the labels.')
end

    % t2
if(length(t2_means) ~= no_of_conditions)
    fprintf('lentgh of labels: %d, length of t2_means: %d\n', no_of_conditions, length(t2_means))
    error('t2_means does not align with the labels.')
end

if(length(t2_standard_deviations) ~= no_of_conditions)
    fprintf('lentgh of labels: %d, length of t2_standard_deviations: %d\n', no_of_conditions, length(t2_standard_deveiations))
    error('t2_standard_deviations does not align with the labels.')
end

    % t4
if(length(t4_means) ~= no_of_conditions)
    fprintf('lentgh of labels: %d, length of t4_means: %d\n', no_of_conditions, length(t4_means))
    error('t4_means does not align with the labels.')
end

if(length(t4_standard_deviations) ~= no_of_conditions)
    fprintf('lentgh of labels: %d, length of t4_standard_deviations: %d\n', no_of_conditions, length(t4_standard_deveiations))
    error('t4_standard_deviations does not align with the labels.')
end

    % d
if(length(d_means) ~= no_of_conditions)
    fprintf('lentgh of labels: %d, length of d_means: %d\n', no_of_conditions, length(d_means))
    error('d_means does not align with the labels.')
end

if(length(d_standard_deviations) ~= no_of_conditions)
    fprintf('lentgh of labels: %d, length of d_standard_deviations: %d\n', no_of_conditions, length(d_standard_deveiations))
    error('d_standard_deviations does not align with the labels.')
end


% We put these together into a table, and check 

table_1_in_paper = table(labels, t1_means, t3_means, t2_means, t4_means, d_means)


%% Create normal distributions for each variable


% Preallocate the distribution arrays.
t1_training = zeros(training_data_per_condition, no_of_conditions);
t3_training = zeros(training_data_per_condition, no_of_conditions);
t2_training = zeros(training_data_per_condition, no_of_conditions);
t4_training = zeros(training_data_per_condition, no_of_conditions);
d_training = zeros(training_data_per_condition, no_of_conditions);

t1_testing = zeros(testing_data_per_condition, no_of_conditions);
t3_testing = zeros(testing_data_per_condition, no_of_conditions);
t2_testing = zeros(testing_data_per_condition, no_of_conditions);
t4_testing = zeros(testing_data_per_condition, no_of_conditions);
d_testing = zeros(testing_data_per_condition, no_of_conditions);


% This can be done faster, but this is clearer. There are two loops here, so that the
% random number generator would work with a different seed for the training and testing data.

% Shuffle the random number generator
rng(posixtime(datetime('now', 'TimeZone', 'UTC'))); % UTC unix time. Just for the hell of it.

for i = 1:no_of_conditions
    % For each condition, we generate the distributions as specified above.
    t1_training(:, i) = normrnd(t1_means(i), t1_standard_deviations(i), [1, training_data_per_condition]);
    t3_training(:, i) = normrnd(t3_means(i), t3_standard_deviations(i), [1, training_data_per_condition]);
    t2_training(:, i) = normrnd(t2_means(i), t2_standard_deviations(i), [1, training_data_per_condition]);
    t4_training(:, i) = normrnd(t4_means(i), t4_standard_deviations(i), [1, training_data_per_condition]);
    d_training(:, i) = normrnd(d_means(i), d_standard_deviations(i), [1, training_data_per_condition]);

end

% Shuffle the random number generator, again, this time a little later.
rng(posixtime(datetime('now', 'TimeZone', 'UTC'))); % This will give a different seed from above

for i = 1:no_of_conditions
    % For each condition, we generate the distributions as specified above.    
    t1_testing(:, i) = normrnd(t1_means(i), t1_standard_deviations(i), [1, testing_data_per_condition]);
    t3_testing(:, i) = normrnd(t3_means(i), t3_standard_deviations(i), [1, testing_data_per_condition]);
    t2_testing(:, i) = normrnd(t2_means(i), t2_standard_deviations(i), [1, testing_data_per_condition]);
    t4_testing(:, i) = normrnd(t4_means(i), t4_standard_deviations(i), [1, testing_data_per_condition]);
    d_testing(:, i) = normrnd(d_means(i), d_standard_deviations(i), [1, testing_data_per_condition]);
end


%% Create and save the training data

tic; % Measure time here.

% Example figure for the paper.
example_figure_to_show = zeros(no_of_conditions, 5);

fprintf('Gerenaring training data.\nLabels: ')

output_root_dir = 'fridgie_data';

if(exist(sprintf("%s_training", output_root_dir), 'dir'))
    % If we have this directory, delete it and its contents.
    rmdir(sprintf("%s_training", output_root_dir), 's')
end

% First of all, we make the root directory, and enter it.
mkdir(sprintf("%s_training", output_root_dir));
cd(sprintf("%s_training", output_root_dir));

for i = 1:no_of_conditions
    

    % Create the condition's directory
    mkdir(sprintf("%s", labels(i)));
    cd(sprintf("%s", labels(i)));

    fprintf("%s, ", labels(i));

    % And this is the bit where we generate the image
    for j = 1:training_data_per_condition
        temperatures = [t1_training(j, i), t3_training(j, i), t2_training(j, i), t4_training(j, i)];
        % We rescale the temperature data
        temperatures_rescaled = rescale(temperatures, 'InputMin', absolute_mimimum_temp, 'InputMax', absolute_maximum_temp);
        % We whack the duty cycle information to it as well
        normalised_image_data = cat(2, temperatures_rescaled, d_training(j, i));

        % Save the image, with custom formatting options
        imwrite(normalised_image_data, sprintf("%d.png", j), 'BitDepth', 8);

    end

    % We generate this for the paper. Just an example image of all the conditions.
    example_figure_to_show(i, :) = normalised_image_data;

    % Once all done, go up one level
    cd ..

end
fprintf("...done!\n")
cd ..

imwrite(example_figure_to_show, 'condition_figure.png')

%% Create and save the testing data

fprintf('Generating testing data.\nLabels: ')

if(exist(sprintf("%s_testing", output_root_dir), 'dir'))
    % If we have this directory, delete it and its contents.
    rmdir(sprintf("%s_testing", output_root_dir), 's')
end

% First of all, we make the root directory, and enter it.
mkdir(sprintf("%s_testing", output_root_dir));
cd(sprintf("%s_testing", output_root_dir));

for i = 1:no_of_conditions
    

    % Create the condition's directory
    mkdir(sprintf("%s", labels(i)));
    cd(sprintf("%s", labels(i)));

    fprintf('%s, ', labels(i))

    % And this is the bit where we generate the image
    for j = 1:testing_data_per_condition
        temperatures = [t1_training(j, i), t3_training(j, i), t2_training(j, i), t4_training(j, i)];
        % We rescale the temperature data
        temperatures_rescaled = rescale(temperatures, 'InputMin', absolute_mimimum_temp, 'InputMax', absolute_maximum_temp);
        
        % We whack the duty cycle information to it as well
        normalised_image_data = cat(2, temperatures_rescaled, d_training(j, i));

        % Save the image, with custom formatting options
        imwrite(normalised_image_data, sprintf("%d.png", j), 'BitDepth', 8);

    end
    % Once all done, go up one level
    cd ..

end
fprintf("...done!\n")
cd ..

fprintf("Zipping the data together so you won't have to copy thousands of files ")

zip('use_this_in_the_tensorflow_code', ["fridgie_data_testing", "fridgie_data_training"])

fprintf('...done!\n')

fprintf('All done! Took %.1f minutes.\n', toc/60)