classdef SpatialHashing
    properties
        points
        hash_func
        cell_size = 0.001;
        hashtable
        conversion_factor
        eps = 0.000001;
        
    end
    
    methods
        function sh = SpatialHashing(points,cell_num,sub_split_num)
            sh.points = points;
            cell_num = cell_num*sub_split_num;
            
            %get 3d grid
            Xmin = min(points(:,1))-eps;
            Xmax = max(points(:,1))+eps;
            Ymin = min(points(:,2))-eps;
            Ymax = max(points(:,2))+eps;
            Zmin = min(points(:,3))-eps;
            Zmax = max(points(:,3))+eps;
            
           
            x_cell_num = cell_num(1,1);
            y_cell_num = cell_num(1,2);
            z_cell_num =  cell_num(1,3)/3;
            sh.hashtable = zeros(floor(x_cell_num*y_cell_num*z_cell_num),1);
            x_cell_size = (Xmax-Xmin)/x_cell_num;
            y_cell_size = (Ymax-Ymin)/y_cell_num;
            z_cell_size = (Zmax-Zmin)/z_cell_num;
            Xs = Xmin:x_cell_size*sub_split_num:Xmax;
            Ys =Ymin:y_cell_size*sub_split_num:Ymax;
            Zs = Zmin:z_cell_size:Zmax;
            
            hold on;
            [X1 Y1 Z1] = meshgrid(Xs([1 end]),Ys,Zs);
            X1 = permute(X1,[2 1 3]); Y1 = permute(Y1,[2 1 3]); Z1 = permute(Z1,[2 1 3]);
            X1(end+1,:,:) = NaN; Y1(end+1,:,:) = NaN; Z1(end+1,:,:) = NaN;
            [X2 Y2 Z2] = meshgrid(Xs,Ys([1 end]),Zs);
            X2(end+1,:,:) = NaN; Y2(end+1,:,:) = NaN; Z2(end+1,:,:) = NaN;
            [X3 Y3 Z3] = meshgrid(Xs,Ys,Zs([1 end]));
            X3 = permute(X3,[3 1 2]); Y3 = permute(Y3,[3 1 2]); Z3 = permute(Z3,[3 1 2]);
            X3(end+1,:,:) = NaN; Y3(end+1,:,:) = NaN; Z3(end+1,:,:) = NaN;

            %#figure('Renderer','opengl')
            h = line([X1(:);X2(:);X3(:)], [Y1(:);Y2(:);Y3(:)], [Z1(:);Z2(:);Z3(:)]);
            set(h, 'Color',[0.5 0.5 1], 'LineWidth',1, 'LineStyle','-')

            %#set(gca, 'Box','on', 'LineWidth',2, 'XTick',x, 'YTick',y, 'ZTick',z, ...
            %#  'XLim',[x(1) x(end)], 'YLim',[y(1) y(end)], 'ZLim',[z(1) z(end)])
            %#xlabel x, ylabel y, zlabel z
%             axis off
%             view(3), axis vis3d
%             camproj perspective, rotate3d on
            
            
            % put each point into its bucket
            for i=1:size(points,1)
                Xposition = floor((points(i,1)-Xmin)/x_cell_size);
                Yposition = floor((points(i,2)-Ymin)/y_cell_size);
                Zposition = floor((points(i,3)-Zmin)/z_cell_size);
                %if mod(Xposition,sub_split_num)==floor(sub_split_num/2) && mod(Yposition,sub_split_num)==floor(sub_split_num/2) && mod(Zposition,sub_split_num)==floor(sub_split_num/2)
       
                if mod(Xposition,sub_split_num)==floor(sub_split_num/2) && mod(Yposition,sub_split_num)==floor(sub_split_num/2)
                    index = Zposition*x_cell_num*y_cell_num+Yposition*x_cell_num+Xposition+1;
                    sh.hashtable(index,1) =i;
                
                end
            end
                
            
        end
    end
   
    
end

 
            
                
        