clear all;

set(0,'defaulttextinterpreter','latex')

PoyntingX = readtable("PoyntingX.csv", 'NumHeaderLines', 8);
PoyntingX = PoyntingX{:,:}.'; 
PoyntingY = readtable("PoyntingY.csv", 'NumHeaderLines', 8);
PoyntingY = PoyntingY{:,:}.'; 

row_size = 2;
%Test
col_size = 21;
col_blocks = repmat(col_size,1,34);

PoynYTime = mat2cell(PoyntingY,row_size,col_blocks);
PoynXTime = mat2cell(PoyntingX,row_size,col_blocks);

%%%%%%%%%

x_vals = 1:length(PoynXTime);
y_vals = linspace(-0.5,0.5,21);

Z = zeros(length(PoynXTime),length(y_vals));
Y = zeros(length(PoynXTime),length(y_vals));

for i = 1:length(PoynXTime)
    current_matrix = PoynXTime{i};
    Y(i,:) = current_matrix(1,:);
    Z(i,:) = current_matrix(2,:);
end

[x_fine,y_fine] = meshgrid(linspace(1,length(PoynXTime),100),linspace(-0.5,0.5,100));
Z_fine = interp2(x_vals,y_vals,Z',x_fine,y_fine,'linear');

figure;
surf(x_fine,y_fine,Z_fine,'EdgeColor','none');
 xlabel('Time (fs)');
 ylabel('X-coordinate ($\mu$m)');
 zlabel('$E_{y}\times H_{z}$');
 title('Poynting Vector in X');
h = colorbar;
ylabel(h,'$$W/m^{2}$$','Interpreter','latex');
rotate3d on;

x_vals = 1:length(PoynYTime);
y_vals = linspace(-0.5,0.5,21);

Z = zeros(length(PoynYTime),length(y_vals));
Y = zeros(length(PoynYTime),length(y_vals));

for i = 1:length(PoynYTime)
    current_matrix = PoynYTime{i};
    Y(i,:) = current_matrix(1,:);
    Z(i,:) = current_matrix(2,:);
end

[x_fine,y_fine] = meshgrid(linspace(1,length(PoynYTime),100),linspace(-0.5,0.5,100));
Z_fine = interp2(x_vals,y_vals,Z',x_fine,y_fine,'linear');

figure;
surf(x_fine,y_fine,Z_fine,'EdgeColor','none');
 xlabel('Time (fs)');
 ylabel('X-coordinate ($\mu$m)');
 zlabel('$-E_{x}\times H_{z}$');
 title('Poynting Vector in Y');
h = colorbar;
ylabel(h,'$$W/m^{2}$$','Interpreter','latex');
rotate3d on;
