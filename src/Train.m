classdef Train < handle
    %TRAIN 此处显示有关此类的摘要
    %   此处显示详细说明

    properties
        trainCode
        passangers
        remainingStations = []
        status %'NOTSTARTED','RUNNING', 'STOP'
        lineType %两条线路，短的是1，长的是2
        lineDirection %从上到下是0，反过来是1
    end

    methods (Access = public)

        function obj = Train(code, stations)
            obj.trainCode = code;
            obj.passangers = [];
            obj.remainingStations = stations;
            obj.status = 'NOTSTARTED';

            if length(stations) == 4
                obj.lineType = 1;
            else
                obj.lineType = 2;
            end

        end

        function updateTrainStatus(app, timeNow)

            if strcmp(app.status, 'NOTSTARTED')

                if timeNow >= app.remainingStations(1).departureTime
                    app.trainCode + "发车!!!!"
                    app.status = 'RUNNING';
                end

            elseif strcmp(app.status, 'RUNNING')
                %如果当前时间大于等于下一个站的到达时间，那么就踢掉一个站点
                if timeNow >= app.remainingStations(2).arrivalTime
                    app.remainingStations = app.remainingStations(2:end);
                    
                end

                % 到达终点站的条件是：上面踢掉一个站点之后只剩下一个了
                if length(app.remainingStations) == 1
                    app.status = 'STOP';
                    app.remainingStations = [];
                    app.trainCode + "到达终点站，停车"
                else
                    app.trainCode + "到达站点"+app.remainingStations(2).stationName

                end


            elseif strcmp(app.status, 'STOP')
                % if timeNow == app.remainingStations(1).arrivalTime
                %     app.status = 'RUNNING';
                % end
            end

        end

    end

end
