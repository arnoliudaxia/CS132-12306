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
    methods (Access = public)

        function obj = TrainDispatch()
            "建立火车调度中心"
            "模拟时间系统启动"
            obj.SysTime = datetime('09:50:00');
            SysTimeCron = timer('ExecutionMode', 'fixedRate', 'Period', 1, 'TimerFcn', @obj.update_sys_time, 'TasksToExecute', 20);
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
            Stations = [nanjingS,changzhouN,suzhouN,shanghaiHQ,jiaxingS,liyang,huzhou,hangzhouE];
            % init trains
            % D21
            d21_hangzhou=hangzhouE;
            d21_hangzhou.departureTime=datetime('10:03:00');
            d21_huzhou=huzhou;
            d21_huzhou.arrivalTime=datetime('11:30:00');
            d21_huzhou.departureTime=datetime('10:05:00');
            
            D21 = Train("D21", [d21_hangzhou])
        end

        function update_sys_time(Obj, ~, ~)
            % "更新时间"
            Obj.SysTime = Obj.SysTime + minutes(1);
            Obj.SysTimeDisplay = datestr(Obj.SysTime, 'HH:MM'); % 转换为字符串格式
            Obj.debugApp.display_update_systime(Obj.SysTimeDisplay);

        end

        function changeSysTime(app,deltaTime)
            "改变时间"
            app.SysTime = app.SysTime + deltaTime;
            app.SysTimeDisplay = datestr(app.SysTime, 'HH:MM'); % 转换为字符串格式
            app.debugApp.display_update_systime(app.SysTimeDisplay);
        end

        

    end

end
