%% Determine Sample Boundary

all_black = imread('/Users/rileymoeykens/Desktop/RAC/CS_Analysis/Processed_cross_sections/1005/1005-CO/for_processing/1005_CO_binary_editted.tif')
height1 = height(all_black);
width1 = width(all_black);
black_boundary_CO_1005 = zeros(height1,1);

for i = 1:height1
    for j = 1:width1
        if all_black(i,j) == 0
            black_boundary_CO_1005(i) = j;
            break
        end
    end
end

%% Methodology 2

sample = imread('/Users/rileymoeykens/Desktop/RAC/CS_Analysis/Processed_cross_sections/1005/1005-CO/1005_CO_binary.tif')
sample_height = height(sample);
sample_width = width(sample);
CO_1005_counts_method_2 = sum(sample, 1)
CO_1005_counts_method_2 = 1-CO_1005_counts_method_2/(sample_height*255)
for i = min(black_boundary_CO_1005):max(black_boundary_CO_1005)
    CO_1005_counts_method_2(:, i) = 0;
end
CO_1005_counts_method_2 = CO_1005_counts_method_2(1,1:mean(black_boundary_CO_1005));
plot((1:mean(black_boundary_CO_1005))/(mean(black_boundary_CO_1005)), CO_1005_counts_method_2)

%% Methodology 1

CO_1005_counts_method_1 = zeros(sample_height,1);

for i = 1:sample_height
    for j = (black_boundary_CO_1005(i)-1):-1:1  % Scan from right to left
        if sample(i,j) == 0       % Look for white pixel
            CO_1005_counts_method_1(i) = j;
            break;
        end
    end
end

CO_1005_counts_method_1 = CO_1005_counts_method_1/mean(black_boundary_CO_1005);

%% Plotting

% Method 2
% Set the bin size
binSize = 5;

% Trim data to be a multiple of binSize
trimmedLength = floor(length(CO_0501_counts_method_2)/binSize) * binSize;
CO_0501_method_2 = CO_0501_counts_method_2(1:trimmedLength);

trimmedLength = floor(length(RAC_0501_counts_method_2)/binSize) * binSize;
RAC_0501_method_2 = RAC_0501_counts_method_2(1:trimmedLength);

trimmedLength = floor(length(CO_0506_counts_method_2)/binSize) * binSize;
CO_0506_method_2 = CO_0506_counts_method_2(1:trimmedLength);

trimmedLength = floor(length(RAC_0506_counts_method_2)/binSize) * binSize;
RAC_0506_method_2 = RAC_0506_counts_method_2(1:trimmedLength);

trimmedLength = floor(length(CO_1219_counts_method_2)/binSize) * binSize;
CO_1219_method_2 = CO_1219_counts_method_2(1:trimmedLength);

trimmedLength = floor(length(RAC_1219_counts_method_2)/binSize) * binSize;
RAC_1219_method_2 = RAC_1219_counts_method_2(1:trimmedLength);

trimmedLength = floor(length(CO_0427_counts_method_2)/binSize) * binSize;
CO_0427_method_2 = CO_0427_counts_method_2(1:trimmedLength);

trimmedLength = floor(length(RAC_0427_counts_method_2)/binSize) * binSize;
RAC_0427_method_2 = RAC_0427_counts_method_2(1:trimmedLength);

trimmedLength = floor(length(CO_1005_counts_method_2)/binSize) * binSize;
CO_1005_method_2 = CO_1005_counts_method_2(1:trimmedLength);

trimmedLength = floor(length(RAC_1005_counts_method_2)/binSize) * binSize;
RAC_1005_method_2 = RAC_1005_counts_method_2(1:trimmedLength);


% Reshape and sum
CO_0501_method_2 = reshape(CO_0501_method_2, binSize, []);
CO_0501_method_2 = sum(CO_0501_method_2, 1)/binSize;  % 1×(N/binSize) output
CO_0501_method_2_cum_sum = cumsum(CO_0501_method_2)/sum(CO_0501_method_2);

RAC_0501_method_2 = reshape(RAC_0501_method_2, binSize, []);
RAC_0501_method_2 = sum(RAC_0501_method_2, 1)/binSize;  % 1×(N/binSize) output
RAC_0501_method_2_cum_sum = cumsum(RAC_0501_method_2)/sum(RAC_0501_method_2);

CO_0506_method_2 = reshape(CO_0506_method_2, binSize, []);
CO_0506_method_2 = sum(CO_0506_method_2, 1)/binSize;  % 1×(N/binSize) output
CO_0506_method_2_cum_sum = cumsum(CO_0506_method_2)/sum(CO_0506_method_2);

RAC_0506_method_2 = reshape(RAC_0506_method_2, binSize, []);
RAC_0506_method_2 = sum(RAC_0506_method_2, 1)/binSize;  % 1×(N/binSize) output
RAC_0506_method_2_cum_sum = cumsum(RAC_0506_method_2)/sum(RAC_0506_method_2);

CO_1219_method_2 = reshape(CO_1219_method_2, binSize, []);
CO_1219_method_2 = sum(CO_1219_method_2, 1)/binSize;  % 1×(N/binSize) output
CO_1219_method_2_cum_sum = cumsum(CO_1219_method_2)/sum(CO_1219_method_2);

RAC_1219_method_2 = reshape(RAC_1219_method_2, binSize, []);
RAC_1219_method_2 = sum(RAC_1219_method_2, 1)/binSize;  % 1×(N/binSize) output
RAC_1219_method_2_cum_sum = cumsum(RAC_1219_method_2)/sum(RAC_1219_method_2);

CO_0427_method_2 = reshape(CO_0427_method_2, binSize, []);
CO_0427_method_2 = sum(CO_0427_method_2, 1)/binSize;  % 1×(N/binSize) output
CO_0427_method_2_cum_sum = cumsum(CO_0427_method_2)/sum(CO_0427_method_2);

RAC_0427_method_2 = reshape(RAC_0427_method_2, binSize, []);
RAC_0427_method_2 = sum(RAC_0427_method_2, 1)/binSize;  % 1×(N/binSize) output
RAC_0427_method_2_cum_sum = cumsum(RAC_0427_method_2)/sum(RAC_0427_method_2);

CO_1005_method_2 = reshape(CO_1005_method_2, binSize, []);
CO_1005_method_2 = sum(CO_1005_method_2, 1)/binSize;  % 1×(N/binSize) output
CO_1005_method_2_cum_sum = cumsum(CO_1005_method_2)/sum(CO_1005_method_2);

RAC_1005_method_2 = reshape(RAC_1005_method_2, binSize, []);
RAC_1005_method_2 = sum(RAC_1005_method_2, 1)/binSize;  % 1×(N/binSize) output
RAC_1005_method_2_cum_sum = cumsum(RAC_1005_method_2)/sum(RAC_1005_method_2);

figure;

% --- 1st subplot ---
subplot(5,1,1);
plot((1:length(CO_0427_method_2))/length(CO_0427_method_2), CO_0427_method_2, 'k', 'LineWidth', 2); hold on;
plot((1:length(RAC_0427_method_2))/length(RAC_0427_method_2), RAC_0427_method_2, '--', 'Color', 'k', 'LineWidth', 2);
title('650C_4h_Salt#1', 'Interpreter', 'latex');
%ylabel('Sum');
ylim([0,0.03])
xlim([0,0.8])
set(gca, 'FontSize',16)
legend('CO', 'RAC', 'FontSize',18, 'Interpreter', 'latex')
grid on;

% --- 2nd subplot ---
subplot(5,1,2);
plot((1:length(CO_0501_method_2))/length(CO_0501_method_2), CO_0501_method_2, 'k', 'LineWidth', 2); hold on;
plot((1:length(RAC_0501_method_2))/length(RAC_0501_method_2), RAC_0501_method_2, '--', 'Color', 'k', 'LineWidth', 2);
title('675C_4h_Salt#1', 'Interpreter', 'latex');
%ylabel('Sum');
ylim([0,0.03])
xlim([0,0.8])
set(gca, 'FontSize',16)
legend('CO', 'RAC', 'FontSize',18, 'Interpreter', 'latex')
grid on;

% --- 3rd subplot ---
subplot(5,1,3);
plot((1:length(CO_0506_method_2))/length(CO_0506_method_2), CO_0506_method_2, 'k', 'LineWidth', 2); hold on;
plot((1:length(RAC_0506_method_2))/length(RAC_0506_method_2), RAC_0506_method_2, '--', 'Color', 'k', 'LineWidth', 2);
title('675C_8h_Salt#1', 'Interpreter', 'latex');
%ylabel('Sum');
ylim([0,0.08])
xlim([0,0.8])
set(gca, 'FontSize',16)
legend('CO', 'RAC', 'FontSize',18, 'Interpreter', 'latex')
grid on;

% --- 4th subplot ---
subplot(5,1,4);
plot((1:length(CO_1005_method_2))/length(CO_1005_method_2), CO_1005_method_2, 'k', 'LineWidth', 2); hold on;
plot((1:length(RAC_1005_method_2))/length(RAC_1005_method_2), RAC_1005_method_2, '--', 'Color', 'k', 'LineWidth', 2);
title('650C_4h_Salt#2', 'Interpreter', 'latex');
%ylabel('Sum');
ylim([0,0.03])
xlim([0,0.8])
set(gca, 'FontSize',16)
legend('CO', 'RAC', 'FontSize',18, 'Interpreter', 'latex')
grid on;

% --- 5th subplot ---
subplot(5,1,5);
plot((1:length(CO_1219_method_2))/length(CO_1219_method_2), CO_1219_method_2, 'k', 'LineWidth', 2); hold on;
plot((1:length(RAC_1219_method_2))/length(RAC_1219_method_2), RAC_1219_method_2, '--', 'Color', 'k', 'LineWidth', 2);
title('650C_8h_Salt#2', 'Interpreter', 'latex');
text(0.5, -0.35, 'Normalized Depth', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'center', ...
    'FontSize', 25, ...
    'Interpreter', 'latex');

ylim([0,0.03])
xlim([0,0.8])
legend('CO', 'RAC', 'FontSize',18, 'Interpreter', 'latex')
set(gca, 'FontSize',16)
grid on;
set(gcf, 'Position', [100 100 1000 1800])

axes('Position', [0 0 1 1], 'Visible', 'off');  % Full figure axes
ylabel('Fraction of Normalized Depth', 'Visible', 'on', 'Units', 'normalized', ...
       'Position', [0.07, 0.5, 0], 'HorizontalAlignment', 'center', ...
       'VerticalAlignment', 'middle', 'FontSize', 25, 'Rotation', 90, 'Interpreter', 'latex');
%% Method 2 cummulative sum
hold off
% Define muted RGB color palette (5 colors)
colors = [
    0.36, 0.54, 0.84;  % brighter blue
    0.87, 0.33, 0.33;  % soft crimson
    0.30, 0.68, 0.38;  % medium green
    0.75, 0.55, 0.25;  % amber-brown
    0.64, 0.36, 0.72;  % richer violet
];


% Plot each CO/RAC pair using a unique color
plot((1:length(CO_0427_method_2))/length(CO_0427_method_2), CO_0427_method_2_cum_sum, ...
     'Color', colors(1,:), 'LineWidth', 3); hold on;
plot((1:length(RAC_0427_method_2))/length(RAC_0427_method_2), RAC_0427_method_2_cum_sum, ...
     '--', 'Color', colors(1,:), 'LineWidth', 3);

plot((1:length(CO_0501_method_2))/length(CO_0501_method_2), CO_0501_method_2_cum_sum, ...
     'Color', colors(2,:), 'LineWidth', 3);
plot((1:length(RAC_0501_method_2))/length(RAC_0501_method_2), RAC_0501_method_2_cum_sum, ...
     '--', 'Color', colors(2,:), 'LineWidth', 3);

plot((1:length(CO_0506_method_2))/length(CO_0506_method_2), CO_0506_method_2_cum_sum, ...
     'Color', colors(3,:), 'LineWidth', 3);
plot((1:length(RAC_0506_method_2))/length(RAC_0506_method_2), RAC_0506_method_2_cum_sum, ...
     '--', 'Color', colors(3,:), 'LineWidth', 3);

plot((1:length(CO_1005_method_2))/length(CO_1005_method_2), CO_1005_method_2_cum_sum, ...
     'Color', colors(4,:), 'LineWidth', 3);
plot((1:length(RAC_1005_method_2))/length(RAC_1005_method_2), RAC_1005_method_2_cum_sum, ...
     '--', 'Color', colors(4,:), 'LineWidth', 3);

plot((1:length(CO_1219_method_2))/length(CO_1219_method_2), CO_1219_method_2_cum_sum, ...
     'Color', colors(5,:), 'LineWidth', 3);
plot((1:length(RAC_1219_method_2))/length(RAC_1219_method_2), RAC_1219_method_2_cum_sum, ...
     '--', 'Color', colors(5,:), 'LineWidth', 3);

% Final plot formatting
text(0.5, -0.07, 'Normalized Depth', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'center', ...
    'FontSize', 25, ...
    'Interpreter', 'latex');
text(-0.07, 0.5, 'Cummulative Fraction of Normalized Depth', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'center', ...
    'FontSize', 25, ...
    'Interpreter', 'latex', ...
    'Rotation', 90);

set(gca, 'FontSize',20)
set(gcf, 'Position', [100 100 1000 1000])
ylim([0,1.2])
xlim([0,0.8])
legend('650C_4h_Salt#1 CO', '650C_4h_Salt#1 RAC','675C_4h_Salt#1 CO', '675C_4h_Salt#1 RAC','675C_8h_Salt#1 CO','675C_8h_Salt#1 RAC','650C_4h_Salt#2 CO', '650C_4h_Salt#2 RAC','650C_8h_Salt#2 CO','650C_8h_Salt#2 RAC','FontSize', 24, 'Interpreter', 'latex', 'location', 'southeast')
%title('CO/RAC Normalized Profiles');
grid on;

%% Method 1
binWidth = 0.01;                 % Desired bin width
binEdges = 0:binWidth:1;        % Define bin edges from 0 to 1 in steps of 0.1


[CO_0501_method_1, edges] = histcounts(CO_0501_counts_method_1(CO_0501_counts_method_1 ~= 0), binEdges);
CO_0501_method_1 = CO_0501_method_1/(length(CO_0501_counts_method_1)*binWidth*mean(black_boundary_CO_0501));
CO_0501_method_1_cum_sum = cumsum(CO_0501_method_1)/sum(CO_0501_method_1);

[RAC_0501_method_1, edges] = histcounts(RAC_0501_counts_method_1(RAC_0501_counts_method_1 ~= 0), binEdges);
RAC_0501_method_1 = RAC_0501_method_1/(length(RAC_0501_counts_method_1)*binWidth*mean(black_boundary_RAC_0501));
RAC_0501_method_1_cum_sum = cumsum(RAC_0501_method_1)/sum(RAC_0501_method_1);

[CO_0506_method_1, edges] = histcounts(CO_0506_counts_method_1(CO_0506_counts_method_1 ~= 0), binEdges);
CO_0506_method_1 = CO_0506_method_1/(length(CO_0506_counts_method_1)*binWidth*mean(black_boundary_CO_0506));
CO_0506_method_1_cum_sum = cumsum(CO_0506_method_1)/sum(CO_0506_method_1);

[RAC_0506_method_1, edges] = histcounts(RAC_0506_counts_method_1(RAC_0506_counts_method_1 ~= 0), binEdges);
RAC_0506_method_1 = RAC_0506_method_1/(length(RAC_0506_counts_method_1)*binWidth*mean(black_boundary_RAC_0506));
RAC_0506_method_1_cum_sum = cumsum(RAC_0506_method_1)/sum(RAC_0506_method_1);


[CO_0427_method_1, edges] = histcounts(CO_0427_counts_method_1(CO_0427_counts_method_1 ~= 0), binEdges);
CO_0427_method_1 = CO_0427_method_1/(length(CO_0427_counts_method_1)*binWidth*mean(black_boundary_CO_0427));
CO_0427_method_1_cum_sum = cumsum(CO_0427_method_1)/sum(CO_0427_method_1);

[RAC_0427_method_1, edges] = histcounts(RAC_0427_counts_method_1(RAC_0427_counts_method_1 ~= 0), binEdges);
RAC_0427_method_1 = RAC_0427_method_1/(length(RAC_0427_counts_method_1)*binWidth*mean(black_boundary_RAC_0427));
RAC_0427_method_1_cum_sum = cumsum(RAC_0427_method_1)/sum(RAC_0427_method_1);

[CO_1005_method_1, edges] = histcounts(CO_1005_counts_method_1(CO_1005_counts_method_1 ~= 0), binEdges);
CO_1005_method_1 = CO_1005_method_1/(length(CO_1005_counts_method_1)*binWidth*mean(black_boundary_CO_1005));
CO_1005_method_1_cum_sum = cumsum(CO_1005_method_1)/sum(CO_1005_method_1);

[RAC_1005_method_1, edges] = histcounts(RAC_1005_counts_method_1(RAC_1005_counts_method_1 ~= 0), binEdges);
RAC_1005_method_1 = RAC_1005_method_1/(length(RAC_1005_counts_method_1)*binWidth*mean(black_boundary_RAC_1005));
RAC_1005_method_1_cum_sum = cumsum(RAC_1005_method_1)/sum(RAC_1005_method_1);

[CO_1219_method_1, edges] = histcounts(CO_1219_counts_method_1(CO_1219_counts_method_1 ~= 0), binEdges);
CO_1219_method_1 = CO_1219_method_1/(length(CO_1219_counts_method_1)*binWidth*mean(black_boundary_CO_1219));
CO_1219_method_1_cum_sum = cumsum(CO_1219_method_1)/sum(CO_1219_method_1);


[RAC_1219_method_1, edges] = histcounts(RAC_1219_counts_method_1(RAC_1219_counts_method_1 ~= 0), binEdges);
RAC_1219_method_1 = RAC_1219_method_1/(length(RAC_1219_counts_method_1)*binWidth*mean(black_boundary_RAC_1219));
RAC_1219_method_1_cum_sum = cumsum(RAC_1219_method_1)/sum(RAC_1219_method_1);

% Compute bin centers for plotting
binCenters = edges(1:end-1) + binWidth/2;

figure;

% --- 1st subplot ---
subplot(5,1,1);
plot(binCenters, CO_0427_method_1, 'k', 'LineWidth', 2); hold on;
plot(binCenters, RAC_0427_method_1, '--', 'Color', 'k', 'LineWidth', 2);
title('650C_4h_Salt#1', 'Interpreter', 'latex');
%ylabel('Sum');
%ylim([0,0.03])
xlim([0,0.8])
set(gca, 'FontSize',16)
legend('CO', 'RAC', 'FontSize',18, 'Interpreter', 'latex')
grid on;

% --- 2nd subplot ---
subplot(5,1,2);
plot(binCenters, CO_0501_method_1, 'k', 'LineWidth', 2); hold on;
plot(binCenters, RAC_0501_method_1, '--', 'Color', 'k', 'LineWidth', 2);
title('675C_4h_Salt#1', 'Interpreter', 'latex');
%ylabel('Sum');
%ylim([0,0.03])
xlim([0,0.8])
set(gca, 'FontSize',16)
legend('CO', 'RAC', 'FontSize',18, 'Interpreter', 'latex')
grid on;

% --- 3rd subplot ---
subplot(5,1,3);
plot(binCenters, CO_0506_method_1, 'k', 'LineWidth', 2); hold on;
plot(binCenters, RAC_0506_method_1, '--', 'Color', 'k', 'LineWidth', 2);
title('675C_8h_Salt#1', 'Interpreter', 'latex');
%ylabel('Sum');
%ylim([0,0.08])
xlim([0,0.8])
set(gca, 'FontSize',16)
legend('CO', 'RAC', 'FontSize',18, 'Interpreter', 'latex')
grid on;

% --- 4th subplot ---
subplot(5,1,4);
plot(binCenters, CO_1005_method_1, 'k', 'LineWidth', 2); hold on;
plot(binCenters, RAC_1005_method_1, '--', 'Color', 'k', 'LineWidth', 2);
title('650C_4h_Salt#2', 'Interpreter', 'latex');
%ylabel('Sum');
%ylim([0,0.03])
xlim([0,0.8])
set(gca, 'FontSize',16)
legend('CO', 'RAC', 'FontSize',18, 'Interpreter', 'latex')
grid on;

% --- 5th subplot ---
subplot(5,1,5);
plot(binCenters, CO_1219_method_1, 'k', 'LineWidth', 2); hold on;
plot(binCenters, RAC_1219_method_1, '--', 'Color', 'k', 'LineWidth', 2);
title('650C_8h_Salt#2', 'Interpreter', 'latex');
text(0.5, -0.35, 'Normalized Depth', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'center', ...
    'FontSize', 25, ...
    'Interpreter', 'latex');
%ylim([0,0.03])
xlim([0,0.8])
legend('CO', 'RAC', 'FontSize',18, 'Interpreter', 'latex')
set(gca, 'FontSize',16)
grid on;
set(gcf, 'Position', [100 100 1000 1800])

axes('Position', [0 0 1 1], 'Visible', 'off');  % Full figure axes
ylabel('Fraction of Normalized Depth', 'Visible', 'on', 'Units', 'normalized', ...
       'Position', [0.07, 0.5, 0], 'HorizontalAlignment', 'center', ...
       'VerticalAlignment', 'middle', 'FontSize', 25, 'Rotation', 90, 'Interpreter', 'latex');

%% Method 1 cummulative sum
hold off
% Define muted RGB color palette (5 colors)
colors = [
    0.36, 0.54, 0.84;  % brighter blue
    0.87, 0.33, 0.33;  % soft crimson
    0.30, 0.68, 0.38;  % medium green
    0.75, 0.55, 0.25;  % amber-brown
    0.64, 0.36, 0.72;  % richer violet
];


% Plot each CO/RAC pair using a unique color
plot(binCenters, CO_0427_method_1_cum_sum, ...
     'Color', colors(1,:), 'LineWidth', 3); hold on;
plot(binCenters, RAC_0427_method_1_cum_sum, ...
     '--', 'Color', colors(1,:), 'LineWidth', 3);

plot(binCenters, CO_0501_method_1_cum_sum, ...
     'Color', colors(2,:), 'LineWidth', 3);
plot(binCenters, RAC_0501_method_1_cum_sum, ...
     '--', 'Color', colors(2,:), 'LineWidth', 3);

plot(binCenters, CO_0506_method_1_cum_sum, ...
     'Color', colors(3,:), 'LineWidth', 3);
plot(binCenters, RAC_0506_method_1_cum_sum, ...
     '--', 'Color', colors(3,:), 'LineWidth', 3);

plot(binCenters, CO_1005_method_1_cum_sum, ...
     'Color', colors(4,:), 'LineWidth', 3);
plot(binCenters, RAC_1005_method_1_cum_sum, ...
     '--', 'Color', colors(4,:), 'LineWidth', 3);

plot(binCenters, CO_1219_method_1_cum_sum, ...
     'Color', colors(5,:), 'LineWidth', 3);
plot(binCenters, RAC_1219_method_1_cum_sum, ...
     '--', 'Color', colors(5,:), 'LineWidth', 3);

% Final plot formatting
text(0.5, -0.07, 'Normalized Depth', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'center', ...
    'FontSize', 25, ...
    'Interpreter', 'latex');
text(-0.07, 0.5, 'Cummulative Fraction of Normalized Depth', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'center', ...
    'FontSize', 25, ...
    'Interpreter', 'latex', ...
    'Rotation', 90);
set(gca, 'FontSize',20)
set(gcf, 'Position', [100 100 1000 1000])
ylim([0,1.2])
xlim([0,0.8])
legend('650C_4h_Salt#1 CO', '650C_4h_Salt#1 RAC','675C_4h_Salt#1 CO', '675C_4h_Salt#1 RAC','675C_8h_Salt#1 CO','675C_8h_Salt#1 RAC','650C_4h_Salt#2 CO', '650C_4h_Salt#2 RAC','650C_8h_Salt#2 CO','650C_8h_Salt#2 RAC','FontSize', 24, 'Interpreter', 'latex', 'location', 'southeast')
%title('CO/RAC Normalized Profiles');
grid on;




     