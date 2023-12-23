%3D brain plot

%clear all;
%close all;
%clc;

function []=brain3d(rate,web)

if web==1

    options = weboptions('ContentReader', @importdata);
    vertices = webread('https://scalablebrainatlas.incf.org//templates/MERetal14_on_F99/meshes/wholebrain_vertices.csv',options);

    faces = webread('https://scalablebrainatlas.incf.org//templates/MERetal14_on_F99/meshes/wholebrain_faces.csv',options);
    faces = round(faces) + 1; % Matlab design flaw: arrays have offset one
    faces=faces([1:end-1],:); %take out the last line, it has NANs and it's extra anyway

    labels = webread('https://scalablebrainatlas.incf.org//templates/MERetal14_on_F99/meshdata/wholebrain_labels.csv',options);
    labels = round(labels) + 1; % Matlab design flaw: arrays have offset one

    %just in case you can't access the data temporarily, here it is:
    %save 'scalablebrainatlasdata.mat' vertices faces labels
    
elseif web==0
    load 'scalablebrainatlasdata.mat'
end

%default color
colors=3*ones(length(labels),1);
%top firing rate value in a hidden area (small area inside a temporal sulcus):
facesarea=find(labels==17);colors(facesarea,1)=35;

%Converter is to go from our labeling to SBA labeling. 
%Example: V1 is 1st in our labeling, but 28th in SBA labeling.
converter=[28 25 20 90 36 74 88 71 45 21 63 50 86 72 52 75 83 51 12 16 78 84 93 69 41 27 95 89 10 77];

%example firing rate distribution:
%ratecolor=zeros(30,1);ratecolor(1)=50;
%load 'stimv1lesionLIP.mat';
ratecolor=squeeze(rate(1,end,:));
size(ratecolor);

%now we paint:
Nareas=size(ratecolor);
for i=1:Nareas
    SBAlabel=converter(i); %our i-th area is marked as 'SBAlabel' in the SBA database
    facesarea=find(labels==SBAlabel);
    colors(facesarea,1)=ratecolor(i)+3; %the +3 is to ensure the minimum color
end



%clf;
figure;
subplot(1,2,1)
braincolor=colormap('autumn');
braincolor(1:5,:)=0.5; %inactive areas are gray
colormap(braincolor);
%hy=colorbar;ylabel(hy,'Firing rate');
p = patch('Vertices',vertices,'Faces',faces,'FaceVertexCData',colors,...
          'FaceColor','flat','FaceLighting','phong','EdgeColor','none','CDataMapping','scaled');
%get(gca,'clim')
set(gcf,'renderer','zbuffer');
lighting('flat');material('dull');
daspect([1 1 1]);
axis off image
%camlight('headlight');
camlight(-180,25);
camlight(-120,0);
camlight(-50,-20);
view(-90,0);

subplot(1,2,2)
p = patch('Vertices',vertices,'Faces',faces,'FaceVertexCData',colors,...
          'FaceColor','flat','FaceLighting','phong','EdgeColor','none','CDataMapping','scaled');
%get(gca,'clim')
set(gcf,'renderer','zbuffer');
lighting('flat');material('dull');
daspect([1 1 1]);
axis off image
camlight(90,0);
camlight(140,0)
view(90,0);



%colormaps made easy:
%Gt = fliplr(linspace(0,1,64)) .';
%braincolor = horzcat(zeros(size(Gt)), Gt, zeros(size(Gt)));


