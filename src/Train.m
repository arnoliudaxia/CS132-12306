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
        DorG %动车还是高铁（直达还是经停）
        PassType %根据通过站点对所有列车分类
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

            obj.PassType = obj.passType(code)

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

        function output = findPasswayStation(app, queryStation)
            % 判断这俩车车是否会经过该站点（包括时间点信息，所以queryStation需要包含arrivalTime）
            % output为0代表不经过，为1代表经过
            output = 0;

            for i = 1:length(app.remainingStations)
                station = app.remainingStations(i);

                if strcmp(station.stationName, queryStation.stationName) && ~isempty(station.departureTime)
                    %同一个站点而且车车必须要开不能使终点站
                    if (station.departureTime - minutes(5)) > queryStation.arrivalTime
                        % 开车前5min停止购票
                        output = 1;
                    end

                end

            end

        end

        function output = findPasswayStationWithoutTime(app, queryStation)
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

        function output = findPasswayStationAfterStation(app, queryStation, filterStation)
            % 判断这俩车车是否会经过该站点（包括时间点信息，所以queryStation需要包含arrivalTime）
            % output为0代表不经过，为1代表经过
            output = 0;
            flag = true;

            for i = 1:length(app.remainingStations)
                station = app.remainingStations(i);

                if strcmp(station.stationName, filterStation.stationName) && flag
                    flag = false;
                end

                if ~flag && strcmp(station.stationName, queryStation.stationName)
                    output = 1;

                end

            end

        end

        function output = bookTicket(app, fromStation, toStation, seatLevel)
            "订购从"+fromStation.stationName+"到"+toStation.stationName+"的"+seatLevel+"票"
            startBookFlag = false;

            for i = 1:app.remainingStations.length
                station = app.remainingStations(i);

                if strcmp(app.remainingStations(i).stationName, fromStation.stationName)
                    startBookFlag = true;
                end

                if strcmp(app.remainingStations(i).stationName, toStation.stationName)
                    break;
                end

                if startBookFlag
                    station.remainingSeats(seatLevel) = station.remainingSeats(seatLevel) - 1;
                end

                

            end

        end

        function output = requestAvailableSeats(app,fromStation, toStation)
            minVip=100;
            minNPC=100;
            startBookFlag = false;

            for i = 1:length(app.remainingStations)
                station = app.remainingStations(i);
                
                if strcmp(app.remainingStations(i).stationName, fromStation.stationName)
                    startBookFlag = true;
                end

                if startBookFlag
                    minVip=min(minVip,station.remainingSeats(1));
                    minNPC=min(minNPC,station.remainingSeats(2));
                end

                if strcmp(app.remainingStations(i).stationName, toStation.stationName)
                    break;
                end
            end
            output=[minVip,minNPC];

        end

    end

end
