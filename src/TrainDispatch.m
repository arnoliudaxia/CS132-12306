classdef TrainDispatch < handle
    %TRAINDISPATCH 此处显示有关此类的摘要
    %   此处显示详细说明
    % 该类包含了所有的实例变量，所有的数据流动逻辑都在于此
    % 实体类的设计按照函数式编程或者容器式设计

    properties
        SysTime %该变量用于模拟火车世界时间，格式为datetime
        SysTimeDisplay %该变量用于显示火车世界时间，格式为HH:MM
        SysTimeCron
        Trains = []
        Stations = []
        debugApp
        usrsinfo % 储存用户相关的信息，包括用户名、车票
    end

    % ========时间模拟系统==========
    methods (Access = private)

        function output = isEleInList(~, list, ele)
            tf = ismember(list, ele);

            if sum(tf) == 1
                output = true;
            else
                output = false;
            end

        end

        function output = GetEariestTrain(app, trainList)
            % 返回一个最早的动车或者高铁
            % 因为是顺序查找，所以第一个D和G就是最早的，选他们就对
            FoundType = [];
            output = [];

            for i = 1:length(trainList)
                train = trainList(i);

                if ~app.isEleInList(FoundType, train.PassType)
                    FoundType = [FoundType, train.PassType];
                    output = [output, train];
                end

            end

        end

    end

    methods (Access = public)

        function obj = TrainDispatch()
            "建立火车调度中心"
            "模拟时间系统启动"
            obj.SysTime = datetime('10:00:00');
            obj.SysTimeDisplay = datestr(obj.SysTime, 'HH:MM'); % 转换为字符串格式

            SysTimeCron = timer('ExecutionMode', 'fixedRate', 'Period', 2, 'TimerFcn', @obj.update_sys_time, 'TasksToExecute', 4);
            % start(SysTimeCron);
            % init stations
            nanjingS = Station("南京南");
            changzhouN = Station("常州北");
            suzhouN = Station("苏州北");
            shanghaiHQ = Station("上海虹桥");
            jiaxingS = Station("嘉兴南");
            liyang = Station("溧阳");
            huzhou = Station("湖州");
            hangzhouE = Station("杭州东");
            Stations = [nanjingS, changzhouN, suzhouN, shanghaiHQ, jiaxingS, liyang, huzhou, hangzhouE];
            % init trains
            % region 短线列车

            % region D21
            d21_hangzhou = hangzhouE;
            d21_hangzhou.departureTime = datetime('10:03:00');
            d21_huzhou = huzhou;
            d21_huzhou.arrivalTime = datetime('10:30:00');
            d21_huzhou.departureTime = datetime('10:33:00');
            d21_liyang = liyang;
            d21_liyang.arrivalTime = datetime('11:00:00');
            d21_liyang.departureTime = datetime('11:03:00');
            d21_nanjingS = nanjingS;
            d21_nanjingS.arrivalTime = datetime('12:30:00');
            % endregion
            D21 = Train("D21", [d21_hangzhou, d21_huzhou, d21_liyang, d21_nanjingS], 1);
            D21.lineDirection = 1;

            % region D23
            d23_hangzhou = hangzhouE;
            d23_hangzhou.departureTime = datetime('11:33:00');
            d23_huzhou = huzhou;
            d23_huzhou.arrivalTime = datetime('12:00:00');
            d23_huzhou.departureTime = datetime('12:03:00');
            d23_liyang = liyang;
            d23_liyang.arrivalTime = datetime('12:30:00');
            d23_liyang.departureTime = datetime('12:33:00');
            d23_nanjingS = nanjingS;
            d23_nanjingS.arrivalTime = datetime('13:00:00');
            % endregion
            D23 = Train("D23", [d23_hangzhou, d23_huzhou, d23_liyang, d23_nanjingS], 1);
            D23.lineDirection = 1;

            % region D24
            d24_nanjingS = nanjingS;
            d24_nanjingS.departureTime = datetime('11:33:00');
            d24_liyang = liyang;
            d24_liyang.arrivalTime = datetime('12:00:00');
            d24_liyang.departureTime = datetime('12:03:00');
            d24_huzhou = huzhou;
            d24_huzhou.arrivalTime = datetime('12:30:00');
            d24_huzhou.departureTime = datetime('12:33:00');
            d24_hangzhou = hangzhouE;
            d24_hangzhou.arrivalTime = datetime('13:00:00');
            % endregion
            D24 = Train("D24", [d24_nanjingS, d24_liyang, d24_huzhou, d24_hangzhou], 1);
            D24.lineDirection = 0;

            % region D22
            d22_nanjingS = nanjingS;
            d22_nanjingS.departureTime = datetime('10:03:00');
            d22_liyang = liyang;
            d22_liyang.arrivalTime = datetime('10:30:00');
            d22_liyang.departureTime = datetime('10:33:00');
            d22_huzhou = huzhou;
            d22_huzhou.arrivalTime = datetime('11:00:00');
            d22_huzhou.departureTime = datetime('11:03:00');
            d22_hangzhou = hangzhouE;
            d22_hangzhou.arrivalTime = datetime('12:30:00');
            % endregion
            D22 = Train("D22", [d22_nanjingS, d22_liyang, d22_huzhou, d22_hangzhou], 1);
            D22.lineDirection = 0;

            % region D25
            d25_hangzhou = hangzhouE;
            d25_hangzhou.departureTime = datetime('13:03:00');
            d25_huzhou = huzhou;
            d25_huzhou.arrivalTime = datetime('13:30:00');
            d25_huzhou.departureTime = datetime('13:33:00');
            d25_liyang = liyang;
            d25_liyang.arrivalTime = datetime('14:00:00');
            d25_liyang.departureTime = datetime('14:03:00');
            d25_nanjingS = nanjingS;
            d25_nanjingS.arrivalTime = datetime('14:30:00');
            % endregion
            D25 = Train("D25", [d25_hangzhou, d25_huzhou, d25_liyang, d25_nanjingS], 1);
            D25.lineDirection = 1;

            % region D26
            d26_nanjingS = nanjingS;
            d26_nanjingS.departureTime = datetime('13:03:00');
            d26_liyang = liyang;
            d26_liyang.arrivalTime = datetime('13:30:00');
            d26_liyang.departureTime = datetime('13:33:00');
            d26_huzhou = huzhou;
            d26_huzhou.arrivalTime = datetime('14:00:00');
            d26_huzhou.departureTime = datetime('14:03:00');
            d26_hangzhou = hangzhouE;
            d26_hangzhou.arrivalTime = datetime('14:30:00');
            % endregion
            D26 = Train("D26", [d26_nanjingS, d26_liyang, d26_huzhou, d26_hangzhou], 1);
            D26.lineDirection = 0;

            % region G21
            G21_hangzhou = hangzhouE;
            G21_hangzhou.departureTime = datetime('11:03:00');
            G21_nanjingS = nanjingS;
            G21_nanjingS.arrivalTime = datetime('12:00:00');
            % endregion
            G21 = Train("G21", [G21_hangzhou, G21_nanjingS], 1);
            G21.lineDirection = 1;

            % region G23
            G23_hangzhou = hangzhouE;
            G23_hangzhou.departureTime = datetime('12:33:00');
            G23_nanjingS = nanjingS;
            G23_nanjingS.arrivalTime = datetime('13:30:00');
            % endregion
            G23 = Train("G23", [G23_hangzhou, G23_nanjingS], 1);
            G23.lineDirection = 1;

            % region G25
            G25_hangzhou = hangzhouE;
            G25_hangzhou.departureTime = datetime('14:03:00');
            G25_nanjingS = nanjingS;
            G25_nanjingS.arrivalTime = datetime('15:00:00');
            % endregion
            G25 = Train("G25", [G25_hangzhou, G25_nanjingS], 1);
            G25.lineDirection = 1;

            % region G22
            G22_nanjingS = nanjingS;
            G22_nanjingS.departureTime = datetime('11:03:00');
            G22_hangzhou = hangzhouE;
            G22_hangzhou.arrivalTime = datetime('12:00:00');
            % endregion
            G22 = Train("G22", [G22_nanjingS, G22_hangzhou], 1);
            G22.lineDirection = 0;

            % region G24
            G24_nanjingS = nanjingS;
            G24_nanjingS.departureTime = datetime('12:33:00');
            G24_hangzhou = hangzhouE;
            G24_hangzhou.arrivalTime = datetime('13:30:00');
            % endregion
            G24 = Train("G24", [G24_nanjingS, G24_hangzhou], 1);
            G24.lineDirection = 0;

            % region G26
            G26_nanjingS = nanjingS;
            G26_nanjingS.departureTime = datetime('14:03:00');
            G26_hangzhou = hangzhouE;
            G26_hangzhou.arrivalTime = datetime('15:00:00');
            % endregion
            G26 = Train("G26", [G26_nanjingS, G26_hangzhou], 1);
            G26.lineDirection = 0;
            % endregion 短线列车

            % region 长线动车
            % region D11
            D11_suzhouN = suzhouN;
            D11_suzhouN.departureTime = datetime('10:03:00');
            D11_changzhouN = changzhouN;
            D11_changzhouN.arrivalTime = datetime('10:30:00');
            D11_changzhouN.departureTime = datetime('10:33:00');
            D11_nanjingS = nanjingS;
            D11_nanjingS.arrivalTime = datetime('11:00:00');
            D11 = Train("D11", [D11_suzhouN, D11_changzhouN, D11_nanjingS], 2);
            D11.lineDirection = 0;
            % endregion

            % region D13
            D13_hangzhouE = hangzhouE;
            D13_hangzhouE.departureTime = datetime('10:03:00');
            D13_jiaxingS = jiaxingS;
            D13_jiaxingS.arrivalTime = datetime('10:30:00');
            D13_jiaxingS.departureTime = datetime('10:33:00');
            D13_shanghaiHQ = shanghaiHQ;
            D13_shanghaiHQ.arrivalTime = datetime('11:00:00');
            D13_shanghaiHQ.departureTime = datetime('11:03:00');
            D13_suzhouN = suzhouN;
            D13_suzhouN.arrivalTime = datetime('11:30:00');
            D13_suzhouN.departureTime = datetime('11:33:00');
            D13_changzhouN = changzhouN;
            D13_changzhouN.arrivalTime = datetime('12:00:00');
            D13_changzhouN.departureTime = datetime('12:03:00');
            D13_nanjingS = nanjingS;
            D13_nanjingS.arrivalTime = datetime('13:30:00');
            D13 = Train("D13", [D13_hangzhouE, D13_jiaxingS, D13_shanghaiHQ, D13_suzhouN, D13_changzhouN, D13_nanjingS], 2);
            D13.lineDirection = 0;
            % endregion

            % region D15
            D15_hangzhouE = hangzhouE;
            D15_hangzhouE.departureTime = datetime('11:33:00');
            D15_jiaxingS = jiaxingS;
            D15_jiaxingS.arrivalTime = datetime('12:00:00');
            D15_jiaxingS.departureTime = datetime('12:03:00');
            D15_shanghaiHQ = shanghaiHQ;
            D15_shanghaiHQ.arrivalTime = datetime('12:30:00');
            D15_shanghaiHQ.departureTime = datetime('12:33:00');
            D15_suzhouN = suzhouN;
            D15_suzhouN.arrivalTime = datetime('13:00:00');
            D15_suzhouN.departureTime = datetime('13:03:00');
            D15_changzhouN = changzhouN;
            D15_changzhouN.arrivalTime = datetime('13:30:00');
            D15_changzhouN.departureTime = datetime('13:33:00');
            D15_nanjingS = nanjingS;
            D15_nanjingS.arrivalTime = datetime('14:00:00');
            D15 = Train("D15", [D15_hangzhouE, D15_jiaxingS, D15_shanghaiHQ, D15_suzhouN, D15_changzhouN, D15_nanjingS], 2);
            D15.lineDirection = 0;
            % endregion

            % region D17
            D17_hangzhouE = hangzhouE;
            D17_hangzhouE.departureTime = datetime('13:03:00');
            D17_jiaxingS = jiaxingS;
            D17_jiaxingS.arrivalTime = datetime('13:30:00');
            D17_jiaxingS.departureTime = datetime('13:33:00');
            D17_shanghaiHQ = shanghaiHQ;
            D17_shanghaiHQ.arrivalTime = datetime('14:00:00');
            D17_shanghaiHQ.departureTime = datetime('14:03:00');
            D17_suzhouN = suzhouN;
            D17_suzhouN.arrivalTime = datetime('14:30:00');
            D17_suzhouN.departureTime = datetime('14:33:00');
            D17_changzhouN = changzhouN;
            D17_changzhouN.arrivalTime = datetime('15:00:00');
            D17_changzhouN.departureTime = datetime('15:03:00');
            D17_nanjingS = nanjingS;
            D17_nanjingS.arrivalTime = datetime('15:30:00');
            D17 = Train("D17", [D17_hangzhouE, D17_jiaxingS, D17_shanghaiHQ, D17_suzhouN, D17_changzhouN, D17_nanjingS], 2);
            D17.lineDirection = 0;
            % endregion

            % region D12
            D12_shanghaiHQ = shanghaiHQ;
            D12_shanghaiHQ.departureTime = datetime('10:03:00');
            D12_jiaxingS = jiaxingS;
            D12_jiaxingS.arrivalTime = datetime('10:30:00');
            D12_jiaxingS.departureTime = datetime('10:33:00');
            D12_hangzhouE = hangzhouE;
            D12_hangzhouE.arrivalTime = datetime('11:00:00');
            D12 = Train("D12", [D12_shanghaiHQ, D12_jiaxingS, D12_hangzhouE], 2);
            D12.lineDirection = 1;
            % endregion

            % region D14
            D14_nanjingS = nanjingS;
            D14_nanjingS.departureTime = datetime('10:03:00');
            D14_changzhouN = changzhouN;
            D14_changzhouN.arrivalTime = datetime('10:30:00');
            D14_changzhouN.departureTime = datetime('10:33:00');
            D14_suzhouN = suzhouN;
            D14_suzhouN.arrivalTime = datetime('11:00:00');
            D14_suzhouN.departureTime = datetime('11:03:00');
            D14_shanghaiHQ = shanghaiHQ;
            D14_shanghaiHQ.arrivalTime = datetime('11:30:00');
            D14_shanghaiHQ.departureTime = datetime('11:33:00');
            D14_jiaxingS = jiaxingS;
            D14_jiaxingS.arrivalTime = datetime('12:00:00');
            D14_jiaxingS.departureTime = datetime('12:03:00');
            D14_hangzhouE = hangzhouE;
            D14_hangzhouE.arrivalTime = datetime('13:30:00');
            D14 = Train("D14", [D14_nanjingS, D14_changzhouN, D14_suzhouN, D14_shanghaiHQ, D14_jiaxingS, D14_hangzhouE], 2);
            D14.lineDirection = 1;
            % endregion

            % region D16
            D16_nanjingS = nanjingS;
            D16_nanjingS.departureTime = datetime('11:33:00');
            D16_changzhouN = changzhouN;
            D16_changzhouN.arrivalTime = datetime('12:00:00');
            D16_changzhouN.departureTime = datetime('12:03:00');
            D16_suzhouN = suzhouN;
            D16_suzhouN.arrivalTime = datetime('12:30:00');
            D16_suzhouN.departureTime = datetime('12:33:00');
            D16_shanghaiHQ = shanghaiHQ;
            D16_shanghaiHQ.arrivalTime = datetime('13:00:00');
            D16_shanghaiHQ.departureTime = datetime('13:03:00');
            D16_jiaxingS = jiaxingS;
            D16_jiaxingS.arrivalTime = datetime('13:30:00');
            D16_jiaxingS.departureTime = datetime('13:33:00');
            D16_hangzhouE = hangzhouE;
            D16_hangzhouE.arrivalTime = datetime('14:00:00');
            D16 = Train("D16", [D16_nanjingS, D16_changzhouN, D16_suzhouN, D16_shanghaiHQ, D16_jiaxingS, D16_hangzhouE], 2);
            D16.lineDirection = 1;
            % endregion

            % region D18
            D18_nanjingS = nanjingS;
            D18_nanjingS.departureTime = datetime('13:03:00');
            D18_changzhouN = changzhouN;
            D18_changzhouN.arrivalTime = datetime('13:30:00');
            D18_changzhouN.departureTime = datetime('13:33:00');
            D18_suzhouN = suzhouN;
            D18_suzhouN.arrivalTime = datetime('14:00:00');
            D18_suzhouN.departureTime = datetime('14:03:00');
            D18_shanghaiHQ = shanghaiHQ;
            D18_shanghaiHQ.arrivalTime = datetime('14:30:00');
            D18_shanghaiHQ.departureTime = datetime('14:33:00');
            D18_jiaxingS = jiaxingS;
            D18_jiaxingS.arrivalTime = datetime('15:00:00');
            D18_jiaxingS.departureTime = datetime('15:03:00');
            D18_hangzhouE = hangzhouE;
            D18_hangzhouE.arrivalTime = datetime('15:30:00');
            D18 = Train("D18", [D18_nanjingS, D18_changzhouN, D18_suzhouN, D18_shanghaiHQ, D18_jiaxingS, D18_hangzhouE], 2);
            D18.lineDirection = 1;
            % endregion

            % endregion 长线动车

            % region 长线高铁
            % region G11
            G11_shanghaiHQ = shanghaiHQ;
            G11_shanghaiHQ.departureTime = datetime('10:33:00');
            G11_nanjingS = nanjingS;
            G11_nanjingS.arrivalTime = datetime('11:30:00');
            % endregion
            G11 = Train("G11", [G11_shanghaiHQ, G11_nanjingS], 2);
            G11.lineDirection = 0;

            % region G13
            G13_shanghaiHQ = shanghaiHQ;
            G13_shanghaiHQ.departureTime = datetime('12:03:00');
            G13_nanjingS = nanjingS;
            G13_nanjingS.arrivalTime = datetime('13:00:00');
            % endregion
            G13 = Train("G13", [G13_shanghaiHQ, G13_nanjingS], 2);
            G13.lineDirection = 0;

            % region G15
            G15_shanghaiHQ = shanghaiHQ;
            G15_shanghaiHQ.departureTime = datetime('13:33:00');
            G15_nanjingS = nanjingS;
            G15_nanjingS.arrivalTime = datetime('14:30:00');
            % endregion
            G15 = Train("G15", [G15_shanghaiHQ, G15_nanjingS], 2);
            G15.lineDirection = 0;

            % region G12
            G12_nanjingS = nanjingS;
            G12_nanjingS.departureTime = datetime('10:33:00');
            G12_shanghaiHQ = shanghaiHQ;
            G12_shanghaiHQ.arrivalTime = datetime('11:30:00');
            % endregion
            G12 = Train("G12", [G12_nanjingS, G12_shanghaiHQ], 2);
            G12.lineDirection = 1;

            % region G14
            G14_nanjingS = nanjingS;
            G14_nanjingS.departureTime = datetime('12:03:00');
            G14_shanghaiHQ = shanghaiHQ;
            G14_shanghaiHQ.arrivalTime = datetime('13:00:00');
            % endregion
            G14 = Train("G14", [G14_nanjingS, G14_shanghaiHQ], 2);
            G14.lineDirection = 1;

            % region G16
            G16_nanjingS = nanjingS;
            G16_nanjingS.departureTime = datetime('13:33:00');
            G16_shanghaiHQ = shanghaiHQ;
            G16_shanghaiHQ.arrivalTime = datetime('14:30:00');
            % endregion
            G16 = Train("G16", [G16_nanjingS, G16_shanghaiHQ], 2);
            G16.lineDirection = 1;
            % endregion 长线高铁

            obj.Trains = [D21, D23, D25, D22, D24, D26, G21, G23, G25, G22, G24, G26, ...
                              D11, D13, D15, D17 ...
                              D12, D14, D16, D18, ...
                              G11, G13, G15, ...
                              G12, G14, G16];

        end

        function update_sys_time(Obj, ~, ~)
            % "更新时间"
            Obj.changeSysTime(minutes(5));

        end

        function changeSysTime(app, deltaTime)
            "改变时间"
            app.SysTime = app.SysTime + deltaTime;
            app.SysTimeDisplay = datestr(app.SysTime, 'HH:MM'); % 转换为字符串格式
            "显示时间";
            app.debugApp.display_update_systime();
            "更新所有列车状态"
            app.ForEachTrain(@(train) train.updateTrainStatus(app.SysTime));

            app.debugApp.updateTrainUI();

        end

        % region "列车遍历回调"
        function ForEachTrain(app, funcOut)

            for i = 1:length(app.Trains)
                train = app.Trains(i);
                funcOut(train);
            end

        end

        function ForEachActiveTrain(app, funcOut)

            for i = 1:length(app.Trains)
                train = app.Trains(i);

                if strcmp(train.status, "RUNNING")
                    funcOut(train);
                end

            end

        end

        function output = filterActiveTrains(app, funcOut)
            output = [];

            for i = 1:length(app.Trains)
                train = app.Trains(i);

                if funcOut(train)
                    output = [output, train];
                end

            end

        end

        % endregion

        function output = findTrain(app, trainCode)
            % 查询列车
            output = app.filterActiveTrains(@(train) strcmp(train.trainCode, trainCode));
        end

        % region 订票相关API

        function output = findAvailableTickets(app, fromStation, toStation, level)
            "查询从 "+fromStation.stationName + " 到 "+toStation.stationName
            "当前两个站点的距离为"+fromStation.getDistance(toStation)
            output = "";
            % 注意这里的fromStation必须包含arrivalTime，toStation必须包含arrivalTime，代表了客户到站的时间
            % 问每一辆车车会不会经过呢
            passedTrains = app.filterActiveTrains(@(train) train.findPasswayStation(fromStation));
            % 不用故意错过列车
            shouldTake = app.GetEariestTrain(passedTrains);

            for i = 1:length(shouldTake)
                train = shouldTake(i);
                % 判断当前列车是否可以直达终点站

                if ~train.findPasswayStationAfterStation(toStation, fromStation)
                    "很可惜"+train.trainCode + "不能乘到"
                    % 假设乘坐该列车到终点站
                    % 看一看是否离终点更远了
                    if train.remainingStations(end).getDistance(toStation) > fromStation.getDistance(toStation)
                        % "乘坐"+train.trainCode + "到终点站会更远"
                        continue;
                    end

                    nextSeq = app.findAvailableTickets(train.remainingStations(end), toStation, level + 1);

                    if ~strcmp(nextSeq, "")
                        %找到合适的线路了
                        if level == 0
                            "你可以先乘坐"+train.trainCode + "到"+train.remainingStations(end).stationName
                            "然后乘坐"+nextSeq + "到达"
                        end

                        output = output + train.trainCode + ","+nextSeq
                    end

                else

                    if level == 0
                        "可以乘坐"+train.trainCode + "直达"
                    end

                    output = output + ""+train.trainCode + "-"
                end

            end

            if level == 0
                output = output()
            end

        end

        function output = splitTrainCode(app, trainCode)
            "将诸如'D22,D21'的字符串split成数组";

            if ischar(trainCode)
                trainCode = string(trainCode);
            end

            output = trainCode;

            if contains(trainCode, ",")
                output = strsplit(trainCode, ",");
            end

        end

        function output = bookTicket(app, trainCode, fromStation, toStation, level, number, startTime, EndTime, usrName)
            % 需要Station格式
            trainCode = app.splitTrainCode(trainCode);

            if length(trainCode) > 1
                app.findTrain(trainCode(1)).bookTicketFrom(fromStation, level, number);

                for i = 2:length(trainCode) - 1
                    train = app.findTrain(trainCode(i));
                    train.bookTicketAll(level, number);
                end

                app.findTrain(trainCode(end)).bookTicketTo(toStation, level, number);

            else
                train = app.findTrain(trainCode);
                train.bookTicket(fromStation, toStation, level, number);
            end

            app.debugApp.displaySeats();

            if ~isempty(startTime)
                ticket = struct();
                ticket.trainCode = trainCode;
                ticket.startStation = fromStation;
                ticket.toStation = toStation;
                ticket.startTime = startTime;
                ticket.toTime = EndTime;
                ticket.seatLevel = level;

                app.recordTicket(usrName, ticket);
            end

        end

        function output = requestAvailableSeats(app, trainCode, fromStation, toStation)
            trainCode = app.splitTrainCode(trainCode);

            if length(trainCode) > 1
                trains = trainCode;
                firstTrain = trains(1);
                remain = app.requestAvailableSeats(firstTrain, fromStation, "");

                for i = 2:length(trains) - 1
                    thetrain = trains(i);
                    thisRemaining = app.requestAvailableSeats(thetrain, "", "");
                    remain(1) = min(remain(1), thisRemaining(1));
                    remain(2) = min(remain(2), thisRemaining(2));
                end

                lastTrain = trains(end);
                endreamin = app.requestAvailableSeats(lastTrain, "", toStation);
                remain(1) = min(remain(1), endreamin(1));
                remain(2) = min(remain(2), endreamin(2));

                output = remain;

            else
                train = app.findTrain(trainCode);

                if strcmp(fromStation, "") && ~strcmp(toStation, "")
                    output = train.requestAvailableSeats(train.remainingStations(1), toStation);

                elseif ~strcmp(fromStation, "") && strcmp(toStation, "")
                    output = train.requestAvailableSeats(fromStation, train.remainingStations(end));

                elseif strcmp(fromStation, "") && strcmp(toStation, "")
                    output = train.requestAvailableSeats(train.remainingStations(1), train.remainingStations(end));

                else
                    output = train.requestAvailableSeats(fromStation, toStation);
                end

            end

        end

        function output = getPriceForTransferTrains(app, trains, fromStation, toStation)
            "计算含有转乘的票价"
            output = 0;
            "先计算除了最后一个车从from到最后的价格"

            for i = 1:length(trains) - 1
                output = output + app.findTrain(trains(i)).getPriceForNonDirect();
            end

            "然后获取最后一个转乘车的价格"
            output = output + app.findTrain(trains(end)).getPriceToStaion(toStation);

        end

        % endregion 订票相关API

        % region 用户相关API

        function output = findUsr(app, usrname)
            % "返回结构体数组中的对应用户结构体的缩影"
            for i=1:length(app.usrsinfo)
                if strcmp(app.usrsinfo(i).usrName, usrname)
                    idx=i;
                end
            end

            if isempty(idx)
                output = -1;
            else
                output = idx;
            end

        end

        function output = getMyTickets(app, usrname)
            usrIndex = app.findUsr(usrname);
            output = app.usrsinfo(usrIndex).ticket;
        end

        function cancelATicketByTrainCode(app, usrname, trainCode)
            usrIndex = app.findUsr(usrName);
            tickets = app.usrsinfo(usrIndex).ticket;

            for i = 1:length(tickets)
                ticket = tickets(i);

                if ticket.trainCode == trainCode
                    app.usrsinfo(usrIndex).ticket(i) = [];
                    return
                end

            end

        end

        function cancelATicketByIndex(app, usrname, index)
            usrIndex = app.findUsr(usrname);
            ticket=app.usrsinfo(usrIndex).ticket(index);
            app.bookTicket(ticket.trainCode, ticket.startStation, ticket.toStation, ticket.seatLevel, -1, ticket.startTime, ticket.toTime, usrname)
            app.usrsinfo(usrIndex).ticket(index) = [];

        end

        function output = getRecentTicket(app, usrName)
            usrIndex = app.findUsr(usrName);
            tickets = app.usrsinfo(usrIndex).ticket;

            if isempty(tickets)
                output = [];
                return
            end

            earTIme = datetime("23:59:59");
            earIndex = 0;

            for i = 1:length(tickets)
                ticket = tickets(i);
                time = ticket.startTime;

                if time < earTIme
                    earTIme = time;
                    earIndex = i;
                end

            end

            output = tickets(earIndex);

        end

        function output = recordTicket(app, usrname, ticket)
            usrIndex = app.findUsr(usrname);
            app.usrsinfo(usrIndex).ticket = [app.usrsinfo(usrIndex).ticket, ticket];

        end

        % endregion
    end

end
