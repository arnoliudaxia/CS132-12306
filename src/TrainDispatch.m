classdef TrainDispatch < handle
    %TRAINDISPATCH 此处显示有关此类的摘要
    %   此处显示详细说明
    % 该类包含了所有的实例变量，所有的数据流动逻辑都在于此
    % 实体类的设计按照函数式编程或者容器式设计

    properties
        SysTime %该变量用于模拟火车世界时间，格式为从0900开始的以秒为单位的int型数值
        SysTimeDisplay %该变量用于显示火车世界时间，格式为HH:MM
        SysTimeCron
        activeTrains = []
    end

    % ========时间模拟系统==========
    methods

        function obj = TrainDispatch()
            "建立火车调度中心"
            obj.SysTime = datetime('09:00:00');
            SysTimeCron = timer('ExecutionMode', 'fixedRate', 'Period', 1, 'TimerFcn', @obj.update_sys_time,'TasksToExecute', 5);
            start(SysTimeCron);
        end

        function update_sys_time(Obj,~, ~)
            % "更新时间"
            Obj.SysTime=Obj.SysTime+minutes(1);
            Obj.SysTimeDisplay=datestr(Obj.SysTime, 'HH:MM'); % 转换为字符串格式

        end

    end

end
