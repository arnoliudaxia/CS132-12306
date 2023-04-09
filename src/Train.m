classdef Train<handle
    %TRAIN 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        trainCode
        passangers
        remainingStations = []
        status %'NOTSTARTED','RUNNING','STOP'
    end
    
    methods (Access=public)
        function obj  = Train(code,stations)
            obj.trainCode = code;
            obj.passangers = [];
            obj.remainingStations = stations;
            obj.status = 'NOTSTARTED';
        end

        function updateStatus(timeNow)
            if app.status == 'NOTSTARTED'
                if timeNow >= app.remainingStations(1).departureTime
                    app.trainCode+"发车!!!!"
                    app.status = 'RUNNING';
                end
            elseif app.status == 'RUNNING'
                % 
                if timeNow == app.remainingStations(1).arriveTime
                    app.status = 'STOP';
                end
            elseif app.status == 'STOP'
                if timeNow == app.remainingStations(1).arriveTime
                    app.status = 'RUNNING';
                end
            end
        end
            
        end

    end
end

