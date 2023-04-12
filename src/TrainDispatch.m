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
        mainApp
        debugApp
        Stations = []
    end

    % ========时间模拟系统==========
    methods (Access = private)
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
            %#region D21
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
            %#endregion
            D21 = Train("D21", [d21_hangzhou, d21_huzhou, d21_liyang, d21_nanjingS],1);
            D21.lineDirection = 1;

            %region D23
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
            %endregion
            D23 = Train("D23", [d23_hangzhou, d23_huzhou, d23_liyang, d23_nanjingS],1);
            D23.lineDirection = 1;

            %region D24
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
            %endregion
            D24 = Train("D24", [d24_nanjingS, d24_liyang, d24_huzhou, d24_hangzhou],1);
            D24.lineDirection = 0;

            %region D22
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
            %endregion
            D22 = Train("D22", [d22_nanjingS, d22_liyang, d22_huzhou, d22_hangzhou],1);
            D22.lineDirection = 0;

            %region D25
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
            %endregion
            D25 = Train("D25", [d25_hangzhou, d25_huzhou, d25_liyang, d25_nanjingS],1);
            D25.lineDirection = 1;

            %region D26
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
            %endregion
            D26 = Train("D26", [d26_nanjingS, d26_liyang, d26_huzhou, d26_hangzhou],1);
            D26.lineDirection = 0;


            %region G21
            G21_hangzhou = hangzhouE;
            G21_hangzhou.departureTime = datetime('11:03:00');
            G21_nanjingS = nanjingS;
            G21_nanjingS.arrivalTime = datetime('12:00:00');
            %endregion
            G21 = Train("G21", [G21_hangzhou, G21_nanjingS],1);
            G21.lineDirection = 1;

            %region G23
            G23_hangzhou = hangzhouE;
            G23_hangzhou.departureTime = datetime('12:33:00');
            G23_nanjingS = nanjingS;
            G23_nanjingS.arrivalTime = datetime('13:30:00');
            %endregion
            G23 = Train("G23", [G23_hangzhou, G23_nanjingS],1);
            G23.lineDirection = 1;

            obj.Trains = [D21, D23, D24, D22, D25, D26,G21,G23];

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

        % endregion

    end

end
