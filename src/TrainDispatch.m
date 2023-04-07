classdef TrainDispatch < handle
    %TRAINDISPATCH 此处显示有关此类的摘要
    %   此处显示详细说明
    % 该类包含了所有的实例变量，所有的数据流动逻辑都在于此
    % 实体类的设计按照函数式编程或者容器式设计

    properties
        SysTime %该变量用于模拟火车世界时间，格式为datetime
        SysTimeDisplay %该变量用于显示火车世界时间，格式为HH:MM
        SysTimeCron
        activeTrains = []
        mainApp
        debugApp
        Stations = []
    end

    % ========时间模拟系统==========
    methods (Access = public)

        function obj = TrainDispatch(mainApphandle, debugAppHandle)
            "建立火车调度中心"
            obj.mainApp = mainApphandle;
            obj.debugApp = debugAppHandle;
            obj.SysTime = datetime('09:00:00');
            SysTimeCron = timer('ExecutionMode', 'fixedRate', 'Period', 1, 'TimerFcn', @obj.update_sys_time, 'TasksToExecute', 10);
            start(SysTimeCron);
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
        end

        function update_sys_time(Obj, ~, ~)
            % "更新时间"
            Obj.SysTime = Obj.SysTime + minutes(1);
            Obj.SysTimeDisplay = datestr(Obj.SysTime, 'HH:MM'); % 转换为字符串格式
            Obj.debugApp.display_update_systime(Obj.SysTimeDisplay);

        end

    end

end
