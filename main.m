points = load('GreenRubber/Model/principle_stretch_scaleGT.txt');
targets = load('GreenRubber/Model/stress_scaleGT.txt');
sh = SpatialHashing(points,0.001);

count = 1;
for i = 1:size(sh.hashtable,1)
    p_index = sh.hashtable(i,1);
    if p_index>0
        new_points(count,1:3) = points(p_index,1:3);
        new_targets(count,1:3) = targets(p_index,1:3);
        count = count+1;
    end
    

end 
 

figure(1)
plot(points(:,1), targets(:,1), 'r*');
hold on;
plot(points(:,2), targets(:,2), 'g*');
hold on;
plot(points(:,3), targets(:,3), 'b*');




figure(2)
plot(new_points(:,1), new_targets(:,1), 'r*');
hold on;
plot(new_points(:,2), new_targets(:,2), 'g*');
hold on;
plot(new_points(:,3), new_targets(:,3), 'b*');


