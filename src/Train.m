classdef Train<handle
    %TRAIN 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        trainCode
        passangers
        remainingStations = []
        status %'NOTSTARTED','RUNNING','STOP'
    end
    
    methods
        function obj  = Train(code,stations)
        %myFun - Description
        %
        % Syntax: obj = myFun(input)
        %
        % Long description
            obj.trainCode = code;
            obj.passangers = [];
            obj.remainingStations = stations;
            obj.status = 'NOTSTARTED';
        end

    end
end

