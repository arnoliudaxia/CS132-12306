classdef Station
    %STATION 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        stationName
        arrivalTime
        departureTime
    end
    
    methods
        function obj = Station(name)
            obj.stationName=name;
        end

        function output = getDistance(app,other)
            stationMap=["南京南","常州北","苏州北","上海虹桥","嘉兴南","杭州东","湖州","溧阳"];
            index1=find(stationMap==app.stationName);
            index2=find(stationMap==other.stationName);
            d1=abs(index1-index2);
            d2=min(index1,index2)+(stationMap.length-max(index1,index2));
            output=min(d1,d2);            
        end
    end
end

