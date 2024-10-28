clear all;
clear vars variables;
prompt = "Enter time steps:";
time = input(prompt);

PoyntingX = readtable("PoyntingX.csv", 'NumHeaderLines', 8);
PoyntingX = PoyntingX{:,:}.'; 
PoyntingY = readtable("PoyntingY.csv", 'NumHeaderLines', 8);
PoyntingY = PoyntingY{:,:}.'; 

ElecX = readtable("ElecX.csv", 'NumHeaderLines', 8);
ElecX = ElecX{:,:}.'; 
ElecY = readtable("ElecY.csv", 'NumHeaderLines', 8);
ElecY = ElecY{:,:}.'; 

MagZ = readtable("MagZ.csv", 'NumHeaderLines', 8);
MagZ = MagZ{:,:}.'; 

masterLength = length(PoyntingY);

row_size = 2;
col_size = masterLength/time;
col_blocks = repmat(col_size,1,time);

PoynYTime = mat2cell(PoyntingY,row_size,col_blocks);
PoynXTime = mat2cell(PoyntingX,row_size,col_blocks);

ElecYTime = mat2cell(ElecY,row_size,col_blocks);
ElecXTime = mat2cell(ElecX,row_size,col_blocks);

MagZTime = mat2cell(MagZ,row_size,col_blocks);

x_valsEx = 1:length(ElecXTime);
y_valsEx = linspace(-0.5,0.5,masterLength/time);

ZEx = zeros(length(ElecXTime),length(y_valsEx));
YEx = zeros(length(ElecXTime),length(y_valsEx));

for i = 1:length(ElecXTime)
    current_matrix = ElecXTime{i};
    YEx(i,:) = current_matrix(1,:);
    ZEx(i,:) = current_matrix(2,:);
end

[x_fineEx,y_fineEx] = meshgrid(linspace(1,length(ElecXTime),100),linspace(-0.5,0.5,100));
Z_fineEx = interp2(x_valsEx,y_valsEx,ZEx',x_fineEx,y_fineEx,'linear');

figure('Position', [100, 100, 1200, 800]); 
subplot(3,2,1);
surf(x_fineEx,y_fineEx,Z_fineEx,'EdgeColor','none');
 xlabel('Time (fs)');
 ylabel('X-coordinate ($\mu$m)');
 zlabel('$E_{x}$');
 title('Electric Field in X');
h = colorbar;
ylabel(h,'$$V/m$$','Interpreter','latex');
rotate3d on;

x_valsEy = 1:length(ElecYTime);
y_valsEy = linspace(-0.5,0.5,masterLength/time);

ZEy = zeros(length(ElecYTime),length(y_valsEy));
YEy = zeros(length(ElecYTime),length(y_valsEy));

for i = 1:length(ElecYTime)
    current_matrix = ElecYTime{i};
    YEy(i,:) = current_matrix(1,:);
    ZEy(i,:) = current_matrix(2,:);
end

[x_fineEy,y_fineEy] = meshgrid(linspace(1,length(ElecYTime),100),linspace(-0.5,0.5,100));
Z_fineEy = interp2(x_valsEy,y_valsEy,ZEy',x_fineEy,y_fineEy,'linear');

subplot(3,2,2);
surf(x_fineEy,y_fineEy,Z_fineEy,'EdgeColor','none');
 xlabel('Time (fs)');
 ylabel('X-coordinate ($\mu$m)');
 zlabel('$E_{y}$');
 title('Electric Field in Y');
h = colorbar;
ylabel(h,'$$V/m$$','Interpreter','latex');
rotate3d on;



x_valsPx = 1:length(PoynXTime);
y_valsPx = linspace(-0.5,0.5,masterLength/time);

ZPx = zeros(length(PoynXTime),length(y_valsPx));
YPx = zeros(length(PoynXTime),length(y_valsPx));

for i = 1:length(PoynXTime)
    current_matrix = PoynXTime{i};
    YPx(i,:) = current_matrix(1,:);
    ZPx(i,:) = current_matrix(2,:);
end

[x_finePx,y_finePx] = meshgrid(linspace(1,length(PoynXTime),100),linspace(-0.5,0.5,100));
Z_finePx = interp2(x_valsPx,y_valsPx,ZPx',x_finePx,y_finePx,'linear');

subplot(3,2,3);
surf(x_finePx,y_finePx,Z_finePx,'EdgeColor','none');
 xlabel('Time (fs)');
 ylabel('X-coordinate ($\mu$m)');
 zlabel('$E_{y}\times H_{z}$');
 title('Poynting Vector in X');
h = colorbar;
ylabel(h,'$$W/m^{2}$$','Interpreter','latex');
rotate3d on;

x_valsPy = 1:length(PoynYTime);
y_valsPy = linspace(-0.5,0.5,masterLength/time);

ZPy = zeros(length(PoynYTime),length(y_valsPy));
YPy = zeros(length(PoynYTime),length(y_valsPy));

for i = 1:length(PoynYTime)
    current_matrix = PoynYTime{i};
    YPy(i,:) = current_matrix(1,:);
    ZPy(i,:) = current_matrix(2,:);
end

[x_finePy,y_finePy] = meshgrid(linspace(1,length(PoynYTime),100),linspace(-0.5,0.5,100));
Z_finePy = interp2(x_valsPy,y_valsPy,ZPy',x_finePy,y_finePy,'linear');

subplot(3,2,4);
surf(x_finePy,y_finePy,Z_finePy,'EdgeColor','none');
 xlabel('Time (fs)');
 ylabel('X-coordinate ($\mu$m)');
 zlabel('$-E_{x}\times H_{z}$');
 title('Poynting Vector in Y');
h = colorbar;
ylabel(h,'$$W/m^{2}$$','Interpreter','latex');
rotate3d on;

x_valsHz = 1:length(MagZTime);
y_valsHz = linspace(-0.5,0.5,masterLength/time);

ZHz = zeros(length(MagZTime),length(y_valsHz));
YHz = zeros(length(ElecXTime),length(y_valsHz));

for i = 1:length(MagZTime)
    current_matrix = MagZTime{i};
    YHz(i,:) = current_matrix(1,:);
    ZHz(i,:) = current_matrix(2,:);
end

[x_fineHz,y_fineHz] = meshgrid(linspace(1,length(MagZTime),100),linspace(-0.5,0.5,100));
Z_fineHz = interp2(x_valsHz,y_valsHz,ZHz',x_fineHz,y_fineHz,'linear');

subplot(3,2,5.5);
surf(x_fineHz,y_fineHz,Z_fineHz,'EdgeColor','none');
 xlabel('Time (fs)');
 ylabel('X-coordinate ($\mu$m)');
 zlabel('$H_{z}$');
 title('Magnetic Field in Z');
h = colorbar;
ylabel(h,'$$A/m$$','Interpreter','latex');
rotate3d on;
