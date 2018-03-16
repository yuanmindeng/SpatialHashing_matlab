classdef SpatialHashing
    properties
        points
        hash_func
        cell_size = 0.001;
        hashtable
        conversion_factor
        
    end
    
    methods
        function sh = SpatialHashing(points,cell_size)
            sh.points = points;
            if nargin >1    
                sh.cell_size = cell_size;
                sh.conversion_factor = 1/cell_size;
            end
            %get 3d grid
            Xmin = min(points(:,1));
            Xmax = max(points(:,1));
            Ymin = min(points(:,2));
            Ymax = max(points(:,2));
            Zmin = min(points(:,3));
            Zmax = max(points(:,3));
            length = ceil((Xmax-Xmin)/cell_size);
            width = ceil((Ymax-Ymin)/cell_size);
            height = ceil((Zmax-Zmin)/cell_size);
            
            sh.hashtable = zeros(floor(length*width*height),1);
            % put each point into its bucket
            for i=1:size(points,1)
                Xposition = floor((points(i,1)-Xmin)*sh.conversion_factor);
                Yposition = floor((points(i,2)-Xmin)*sh.conversion_factor);
                Zposition = floor((points(i,3)-Xmin)*sh.conversion_factor);
                index = Zposition*length*width+Yposition*length+Xposition;
                sh.hashtable(index,1) =i;
            end
                
            
        end
    end
    
    methods
        function cellQuery(cell_index)
            
        end
    end
    
    methods
        function objQuery(obj_index)
            
        end
    end
    
end

 
            
                
        