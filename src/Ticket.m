classdef Ticket
    %TICKET 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        trainSeq=[]
        % bookPassanger
        fromStation
        toStation
    end
    
    methods
        function obj = Ticket(ticketTrain,fromStation,toStation)
            %TICKET 构造此类的实例
            %   此处显示详细说明
            obj.ticketTrain = ticketTrain;
            obj.isOcupied = false;
            obj.bookPassanger = [];
            obj.fromStation = fromStation;
            obj.toStation = toStation;
        end
        
        % function obj = bookTicket(obj,passanger)
        %     obj.isOcupied = true;
        %     obj.bookPassanger = passanger;
        % end
        
        % function obj = cancelTicket(obj)
        %     obj.isOcupied = false;
        %     obj.bookPassanger = [];
        % end
        
        function obj = printTicket(obj)
            fprintf('车次：%s\n',obj.ticketTrain.trainNumber);
            fprintf('出发站：%s\n',obj.fromStation.stationName);
            fprintf('到达站：%s\n',obj.toStation.stationName);
            fprintf('出发时间：%s\n',obj.fromStation.arriveTime);
            fprintf('到达时间：%s\n',obj.toStation.arriveTime);
            fprintf('票价：%d\n',obj.ticketTrain.ticketPrice);
            fprintf('乘客姓名：%s\n',obj.bookPassanger.passangerName);
            fprintf('乘客身份证号：%s\n',obj.bookPassanger.passangerID);
        end

    end
end

