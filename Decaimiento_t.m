
%S5
[file, path] = uigetfile('*.dcm','Seleccione los dicom de decaimiento temporal.','MultiSelect','on');
for i=1:length(file)
infodicom.(['img_',num2str(i)]) = dicominfo([path, file{i}]);
img_UM(:,:,i)=double(dicomread([path, file{i}]));
img_UM=double(img_UM);
Ycenter=round(length(img_UM(:,1,i))/2);
Xcenter=round(length(img_UM(1,:,i))/2);
imgVector=img_UM(Ycenter-100:Ycenter+100,Xcenter-100:Xcenter+100,i);
imgVector=imgVector(:);
mean_I(i)=mean(imgVector);
std_I(i)=std(imgVector');
end
t=[0.5 1 1.5 2 2.5 3 6.5 9 22];
plot(t,mean_I,'.')
erry = std_I;
errorbar(t,mean_I,erry)
errx = 0.1;
for k = 1:length(t)
 x = [t(k) - errx/2, t(k) + errx/2];
 line(x, [mean_I(k), mean_I(k)]);
 y = [mean_I(k) - 1, mean_I(k) + 1];
 line([x(1), x(1)], y);
 line([x(2), x(2)], y);
end

fitresult = cell( 3, 1 );
gof = struct( 'sse', cell( 3, 1 ), ...
    'rsquare', [], 'dfe', [], 'adjrsquare', [], 'rmse', [] );

[xData, yData] = prepareCurveData( t, mean_I );

% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [791.978057001671 -0.00265910619426656];

% Fit model to data.
[fitresult{1}, gof(1)] = fit( xData, yData, ft, opts );

hold on
plot(fitresult{1})
xlabel Tiempo
ylabel Intensidad de pixel
grid on
hold off

