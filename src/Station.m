classdef Station
    %STATION 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        stationName
        % arrivalTime
    end
    
    methods
        function obj = Station(name)
            obj.stationName=name
            % obj.arrivalTime=datetime("now")
            
        end
    end
end

