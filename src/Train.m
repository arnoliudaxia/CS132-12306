classdef Train < handle
    %TRAIN 此处显示有关此类的摘要
    %   此处显示详细说明

    properties
        trainCode %火车代号，例如"D21"，一个字符串
        passangers
        remainingStations = []
        status %'NOTSTARTED','RUNNING', 'STOP'
        lineType %两条线路，短的是1，长的是2
        lineDirection %从上到下是0，反过来是1
        DorG %动车还是高铁（直达还是经停）
        PassType %线路完全一样的分为一类
    end

    methods (Access = private)

        function output = passType(~, trainName)
            output = 0;

            switch trainName
                case 'D11'
                    output = 1;
                case 'D13'
                    output = 2;
                case 'D15'
                    output = 2;
                case 'D17'
                    output = 2;
                case 'G11'
                    output = 3;
                case 'G13'
                    output = 3;
                case 'G15'
                    output = 3;
                case 'D12'
                    output = 4;
                case 'D14'
                    output = 5;
                case 'D16'
                    output = 5;
                case 'D18'
                    output = 5;
                case 'G12'
                    output = 6;
                case 'G14'
                    output = 6;
                case 'G16'
                    output = 6;
                case 'D21'
                    output = 7;
                case 'D23'
                    output = 7;
                case 'D25'
                    output = 7;
                case 'G21'
                    output = 8;
                case 'G23'
                    output = 8;
                case 'G25'
                    output = 8;
                case 'D22'
                    output = 9;
                case 'D24'
                    output = 9;
                case 'D26'
                    output = 9;
                case 'G22'
                    output = 10;
                case 'G24'
                    output = 10;
                case 'G26'
                    output = 10;

                otherwise
                    disp('Error! 无法对火车的站点进行归类!');
            end

            if output == 0
                disp('Error! 无法对火车的站点进行归类!');
            end

        end

    end

    methods (Access = public)

        function obj = Train(code, stations, lineT)
            obj.trainCode = code;
            obj.passangers = [];
            obj.remainingStations = stations;
            obj.status = 'NOTSTARTED';
            obj.lineType = lineT;
            %如果code以“D”开头，那么是动车，否则是高铁
            if ~isempty(extract(obj.trainCode, "D"))
                % "动车"
                obj.DorG = 1;
            else
                % "高铁"
                obj.DorG = 2;
            end

            obj.PassType = obj.passType(code);

        end

        function updateTrainStatus(app, timeNow)

            if strcmp(app.status, 'NOTSTARTED')

                if timeNow >= app.remainingStations(1).departureTime
                    app.trainCode + "发车!!!!"
                    app.status = 'RUNNING';
                end

            elseif strcmp(app.status, 'RUNNING')
                isCrossStation = 0;
                %如果当前时间大于等于下一个站的到达时间，那么就踢掉一个站点
                if timeNow >= app.remainingStations(2).arrivalTime
                    app.remainingStations = app.remainingStations(2:end);
                    isCrossStation = 1;
                end

                % 到达终点站的条件是：上面踢掉一个站点之后只剩下一个了
                if length(app.remainingStations) == 1
                    app.status = 'STOP';
                    app.remainingStations = [];
                    app.trainCode + "到达终点站，停车"
                else

                    if isCrossStation == 1
                        app.trainCode + "到达站点"+app.remainingStations(2).stationName
                    end

                end

            elseif strcmp(app.status, 'STOP')
            end

        end

        % 判断这俩车车是否会经过queryStation站点（包括时间点信息，所以queryStation需要包含arrivalTime）
        % 返回值 为1或者0，1代表会经过，0代表不会经过
        function output = findPasswayStation(app, queryStation)
            output = 0;

            for i = 1:length(app.remainingStations)
                station = app.remainingStations(i);

                if strcmp(station.stationName, queryStation.stationName) && ~isempty(station.departureTime)
                    %同一个站点而且车车必须要开不能使终点站
                    if (station.departureTime) > queryStation.arrivalTime
                        output = 1;
                    end

                end

            end

        end

        % (弃用)
        function output = findPasswayStationWithoutTime(app, queryStation)
            "WARNING 你正在调用一个弃用的API Train.findPasswayStationWithoutTime()"
            % 只看会不会经过，其他一概不考虑
            output = 0;

            for i = 1:length(app.remainingStations)
                station = app.remainingStations(i);

                if strcmp(station.stationName, queryStation.stationName)
                    output = 1;
                end

            end

        end

        function output = getStationDepartureTime(app, queryStation)
            % 获取车车在该站点的出发时间

            for i = 1:length(app.remainingStations)
                station = app.remainingStations(i);

                if strcmp(station.stationName, queryStation.stationName)
                    output = station.departureTime;
                end

            end

        end

        function output = getStationArrrivalTime(app, queryStation)
            % 获取车车在该站点的到达时间

            for i = 1:length(app.remainingStations)
                station = app.remainingStations(i);

                if strcmp(station.stationName, queryStation.stationName)
                    output = station.arrivalTime;
                end

            end

        end

        % 判断这俩车车是否会经过filterStation后到达queryStation（queryStation需要包含arrivalTime）
        % 注意如果沿途发现没有作为会立刻打断
        % 返回值 output为0代表不经过，为1代表经过
        function output = findPasswayStationAfterStation(app, queryStation, filterStation)
            output = 0;
            flag = true;

            for i = 1:length(app.remainingStations)
                station = app.remainingStations(i);

                if station.remainingSeats(2)==0
                    break;
                end

                if flag && strcmp(station.stationName, filterStation.stationName)
                    flag = false;
                end

                if ~flag && strcmp(station.stationName, queryStation.stationName)
                    output = 1;
                    break;
                end

            end

        end

        function bookTicket(app, fromStation, toStation, seatLevel, numberOfTickets)

            if isempty(numberOfTickets)
                numberOfTickets = 1;
            end

            "订购从"+fromStation.stationName + "到"+toStation.stationName + "的"+seatLevel + "票"
            startBookFlag = false;

            for i = 1:length(app.remainingStations)
                station = app.remainingStations(i);

                if strcmp(app.remainingStations(i).stationName, fromStation.stationName)
                    startBookFlag = true;
                end

                if strcmp(app.remainingStations(i).stationName, toStation.stationName)
                    break;
                end

                if startBookFlag
                    app.remainingStations(i).remainingSeats(seatLevel) = station.remainingSeats(seatLevel) - numberOfTickets;
                end

                "当前车次"+app.trainCode + "在"+station.stationName + "的剩余座位数为"
                "商务舱"+app.remainingStations(i).remainingSeats(1) + "普通座"+app.remainingStations(i).remainingSeats(2)

            end

        end

        function bookTicketFrom(app, fromStation, seatLevel, numberOfTickets)
            "从该站一直book到终点站"
            app.bookTicket(fromStation,app.remainingStations(end),seatLevel,numberOfTickets)
        end
        function bookTicketTo(app, toStation, seatLevel, numberOfTickets)
            "从起始站一直book到该站"
            app.bookTicket(app.remainingStations(1),toStation,seatLevel,numberOfTickets)
        end
        function bookTicketAll(app, toStation, seatLevel, numberOfTickets)
            "一路book"
            app.bookTicket(app.remainingStations(1),app.remainingStations(end),seatLevel,numberOfTickets)
        end

        % 查询从fromStation到toStation的剩余座位数
        % 返回：[vip, npc]，vip表示商务座，npc表示普通座
        function output = requestAvailableSeats(app, fromStation, toStation)
            minVip = 100;
            minNPC = 100;
            startBookFlag = false;

            for i = 1:length(app.remainingStations)
                station = app.remainingStations(i);

                if strcmp(app.remainingStations(i).stationName, fromStation.stationName)
                    startBookFlag = true;
                end

                if startBookFlag
                    minVip = min(minVip, station.remainingSeats(1));
                    minNPC = min(minNPC, station.remainingSeats(2));
                end

                if strcmp(app.remainingStations(i).stationName, toStation.stationName)
                    break;
                end

            end

            output = [minVip, minNPC];

        end

    % region 价格API

        % "只考虑直达情况下从s1到s2的价格"
        function output = getPrice(app, station1, station2)

            if app.DorG == 2
                % "高铁,一律4元"
                output = 4;
            else
                % "动车，一站一元"
                output = 0;
                flag = true;

                for i = 1:length(app.remainingStations)
                    station = app.remainingStations(i);
                    if flag && strcmp(station.stationName, station1.stationName)
                        flag = false;
                        continue;
                    end
                    if ~flag
                        output = output + 1;
                        if strcmp(station.stationName, station2.stationName)
                            break;
                        end

                    end

                end
            end

        end

        % "只考虑非直达情况下从s1乘到终点站的价格"
        function output = getPriceForNonDirect(app)

            if app.DorG == 2
                % "高铁,一律4元"
                output = 4;
            else
                % "动车，一站一元,直接考虑剩下多少站点"
                output = length(app.remainingStations);
            end

        end

        % 从现在开到station的价格
        function output = getPriceToStaion(app, station)

            if app.DorG == 2
                "高铁,一律4元"
                output = 4;
            else
                "动车，一站一元"
                output = app.getPrice(app.remainingStations(1), station);
            end

        end


    % endregion


    end




end
