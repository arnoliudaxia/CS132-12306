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
            obj.stationName = name;
        end

        function output = getDistance(app, other)
            stationMap = ["南京南", "常州北", "苏州北", "上海虹桥", "嘉兴南", "杭州东", "湖州", "溧阳"];
            index1 = find(stationMap == app.stationName);
            index2 = find(stationMap == other.stationName);
            d1 = abs(index1 - index2);
            d2 = min(index1, index2) + (stationMap.length - max(index1, index2));
            output = min(d1, d2);
        end

        function output = isSameSide(app, other)

            if strcmp(other.stationName == "南京南") || strcmp(other.stationName == "杭州东") || strcmp(app.stationName == "南京南") || strcmp(app.stationName == "杭州东")
                output = true;
            else
                stationMap_shortSide = ["湖州", "溧阳"];
                stationMap_longSide = ["常州北", "苏州北", "上海虹桥", "嘉兴南"];
                str1=app.stationName;
                str2=other.stationName;
                if ismember(str1, stationMap_shortSide) && ismember(str2, stationMap_shortSide)
                    output = true;
                elseif ismember(str1, stationMap_longSide) && ismember(str2, stationMap_longSide)
                    output = true;
                else
                    output = false;
                end
            end

        end

    end

end

