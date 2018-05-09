clear all;
close all;

%points = load('./tetCenter.txt');

vertices = load('./curve_cushion.vert');
vertices = vertices(:,2:4);
tet = load('./curve_cushion.tet');
tet = tet(:,2:5);
tet = tet+1;

tet_center = zeros(size(tet,1),3);
for i = 1:size(tet,1)
    vertex1 = vertices(tet(i,1),:);
    vertex2 = vertices(tet(i,2),:);
    vertex3 = vertices(tet(i,3),:);
    vertex4 = vertices(tet(i,4),:);
    tet_center(i,1) = mean([vertex1(1,1) vertex2(1,1) vertex3(1,1) vertex4(1,1)]);
    tet_center(i,2) = mean([vertex1(1,2) vertex2(1,2) vertex3(1,2) vertex4(1,2)]);
    tet_center(i,3) = mean([vertex1(1,3) vertex2(1,3) vertex3(1,3) vertex4(1,3)]);
end
points = tet_center;

figure(3)
hold on;
sh = SpatialHashing(points,[10 10 1],3);

count = 1;
for i = 1:size(sh.hashtable,1)
    p_index = sh.hashtable(i,1);
    if p_index>0
        new_points(count,1:3) = points(p_index,1:3);
        count = count+1;
    end
    

end 


scatter3(new_points(:,1),new_points(:,2),new_points(:,3),'r*');
hold on;
scatter3(points(:,1),points(:,2),points(:,3),'y.');


out_index = sh.hashtable;
out_index(out_index==0) = [];
out_index = out_index - 1;