classdef Ticket < handle
    
    properties
        isDorT = false % true:直达 false:转乘
        trainSeq=[]
        trainCode=""
        fromStation
        toStation
        allTime %待在火车上的时间
        price
        seatLevel %1是商务，2是经济

    end
    
    methods
        function obj = Ticket(ticketTrain,fromStation,toStation,seatL)
            %TICKET 构造此类的实例
            %   此处显示详细说明
            obj.trainSeq = [obj.trainSeq,ticketTrain];
            for j=1:length(obj.trainSeq)-1
                obj.trainCode=obj.trainCode+obj.trainSeq(j).trainCode+",";
            end
            obj.trainCode=obj.trainCode+obj.trainSeq(end).trainCode;
            if length(ticketTrain) == 1
                obj.isDorT = true;
            end
            obj.fromStation = fromStation;
            obj.fromStation.departureTime=ticketTrain(1).getStationDepartureTime(fromStation);
            obj.toStation = toStation;
            obj.toStation.arrivalTime=ticketTrain(end).getStationArrrivalTime(toStation);
            obj.allTime = obj.toStation.arrivalTime-obj.fromStation.departureTime;

            if obj.isDorT
                obj.price = obj.trainSeq(1).getPrice(fromStation,toStation);
            else
                obj.price = 0;
                % "先计算除了最后一个车从from到最后的价格"
                for i = 1:length(obj.trainSeq) - 1
                    obj.price = obj.price + obj.trainSeq(i).getPriceForNonDirect();
                end
    
                % "然后获取最后一个转乘车的价格"
                obj.price = obj.price + obj.trainSeq(end).getPriceToStaion(toStation);
            end
            if nargin < 4 || isempty(seatL)
                seatL=2;
            end
            obj.seatLevel=seatL;
            

        end
        
        function obj = printTicket(obj)
            fprintf('车次：%s\n',obj.trainCode);
            fprintf('出发站：%s\n',obj.fromStation.stationName);
            fprintf('到达站：%s\n',obj.toStation.stationName);
            fprintf('出发时间：%s\n',obj.fromStation.departureTime);
            fprintf('到达时间：%s\n',obj.toStation.arrivalTime);
            fprintf('总时间：%s\n',obj.allTime);
            fprintf('总价格：%s\n',obj.price);
        end

    end
end

