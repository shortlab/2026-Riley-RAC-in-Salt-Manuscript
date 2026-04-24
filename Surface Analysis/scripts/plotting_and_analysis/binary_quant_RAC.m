% MATLAB script to process binary images and compute the fractional white pixels
% using the distribution of white-pixel ratios per column


% Repeat for each sample
directoryPath = ''; %Insert file location containing set of classified images

imageFiles = dir(fullfile(directoryPath, '*.tif'))

% Store all column-wise ratios
allColumnRatios = [];

for k = 1:length(imageFiles)
    filePath = fullfile(directoryPath, imageFiles(k).name);
    img = imread(filePath);
    
    % Ensure binary
    if ~islogical(img)
        img = imbinarize(img);
    end
    
    [rows, cols] = size(img);
    
    % Right 80%
    startCol = round(cols * 0.2) + 1;
    right80Image = img(:, startCol:end);
    
    % --- NEW PART: compute ratio per column ---
    whitePerCol = sum(right80Image, 1);   % sum down rows (per column)
    totalPerCol = size(right80Image, 1);  % number of rows
    
    colRatios = whitePerCol / totalPerCol;  % fraction per column
    
    % Append to global distribution
    allColumnRatios = [allColumnRatios, colRatios];
end

% Mean and uncertainty based on column distribution
CO_0427 = mean(allColumnRatios); %edit sample name
CO_0427_err = std(allColumnRatios); %edit sample name


%%
bar_labels = categorical({'675C\_4h\_Salt#1' '675C\_8h\_Salt#1' '650C\_8h\_Salt#2' '650C\_4h\_Salt#1'});
to_plot = [CO_0501, RAC_0501; CO_0506, RAC_0506; CO_1219, RAC_1219; CO_0427, RAC_0427];

b = bar(bar_labels, to_plot);


err_high = [CO_0501_err, RAC_0501_err; CO_0506_err, RAC_0506_err; CO_1219_err, RAC_1219_err; CO_0427_err, RAC_0427_err];
err_low = [CO_0501_err, RAC_0501_err; CO_0506_err, RAC_0506_err; CO_1219_err, RAC_1219_err; CO_0427_err, RAC_0427_err];

hold on

ylim([0,0.7])


% Number of groups and bars per group
[nGroups, nBars] = size(to_plot);

% Get x-coordinates of the bars
x_coords = nan(nGroups, nBars);
for i = 1:nBars
    x_coords(:, i) = b(i).XEndPoints; % XEndPoints gives the center positions of each bar
end

% Add error bars
for i = 1:nBars
    errorbar(x_coords(:, i), to_plot(:, i), err_low(:, i), err_high(:, i), ...
             'k', 'LineStyle', 'none', 'LineWidth', 1.5);
end

legend('CO', 'RAC', '','', 'FontSize', 20, 'Interpreter', 'latex')
set(gcf, 'Position', [100 100 1000 800])
ylabel('Corroded Area (Normalized)', 'FontSize', 20, 'Interpreter', 'latex')
%title('Surface Corrosion Density Comparison')
set(gca, 'FontSize', 20);  % Increase tick label font size

exportgraphics(gcf, ...
    '', ...
    'ContentType', 'vector') %Insert file save location and name
hold off

%% Boundary Counting

% Read the binary image
imagePath = '' % Replace with the path to your image
binaryImage = imread(imagePath);
binaryImageheight = size(binaryImage, 1)


gap = [2607,3771]
% Ensure the image is binary
if size(binaryImage, 3) == 3
    % Convert to grayscale if the image is in RGB
    binaryImage = rgb2gray(binaryImage);
end
binaryImage = imbinarize(binaryImage); % Ensure binary

% Calculate the number of white pixels in each column
whitePixelCountPerColumn = sum(binaryImage, 1);

% Group the columns into bins of 20
binSize = 10;
numBins = ceil(length(whitePixelCountPerColumn) / binSize);
binnedWhitePixelCounts = zeros(1, numBins);

for i = 1:numBins
    startIdx = (i - 1) * binSize + 1;
    endIdx = min(i * binSize, length(whitePixelCountPerColumn));
    binnedWhitePixelCounts(i) = sum(whitePixelCountPerColumn(startIdx:endIdx));
end

binnedWhitePixelCounts = binnedWhitePixelCounts/(binSize*binaryImageheight);

% Determine bin indices from column ranges
bins1 = 1 : ceil(gap(1) / binSize);         % Bins 1–44
bins2 = ceil(gap(2) / binSize) : ceil(5615 / binSize);  % Bins 73–108

distance_2_pixel = 100/765;
midpoint = ceil((gap(1)+gap(2))/(2*binSize));

% Plot only the specified bins
figure;
plot((bins1-midpoint)*distance_2_pixel*binSize, binnedWhitePixelCounts(bins1), '-o', 'LineWidth', 2, 'MarkerSize', 1);
hold on;
plot((bins2-midpoint)*distance_2_pixel*binSize, binnedWhitePixelCounts(bins2), '-o', 'LineWidth', 2, 'MarkerSize', 1);
yline(mean(binnedWhitePixelCounts(bins1)), '--','LineWidth',3)
mean(binnedWhitePixelCounts(bins1))
std(binnedWhitePixelCounts(bins1))
yline(mean(binnedWhitePixelCounts(bins2)), '--', 'LineWidth',3)
mean(binnedWhitePixelCounts(bins2))
std(binnedWhitePixelCounts(bins2))

% Define buffer zone (missing region)
gapStart = (ceil(gap(1) / binSize)-midpoint)*distance_2_pixel*binSize; % 218
gapEnd   = (ceil(gap(2) / binSize)-midpoint)*distance_2_pixel*binSize; % 361

ylim([0, 1])  % or auto if you want it dynamic
% Shade the buffer zone using fill
yl = ylim; % Get current y-axis limits
fill([gapStart gapEnd gapEnd gapStart], [yl(1) yl(1) yl(2) yl(2)], [0.8 0.8 0.8], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.4); % light gray, semi-transparent
hold on;

xlabel('Distance from Approximate Beam Boundary ($\mathrm{\mu}m$)', 'Interpreter', 'latex', 'FontSize',18);
ylabel('Corroded Area (Normalized)', 'Interpreter', 'latex', 'FontSize',18);
legend('CO', 'RAC','FontSize',18, 'Interpreter', 'latex')
set(gca, 'FontSize', 16)
%title('Binned White Pixel Count (50 Columns per Bin)');
xlim([-midpoint*distance_2_pixel*binSize, (numBins-midpoint)*distance_2_pixel*binSize])
%ylim([0, 0.8])
set(gcf, 'Position', [100, 100, 1500, 600])

% Save the figure
saveas(gcf, '') %Replace with desired save location and file name/type

