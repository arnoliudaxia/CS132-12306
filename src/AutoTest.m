classdef AutoTest < handle

    properties (Access=public)
        testcases=[]
        trainDispatch
    end

    methods (Access=public)
        function result=test1(app)
            "直达车检票测试样例-1"
            "寻找票的接口是trainDispatch.findAvailableTickets"
            "参数列表说明：第一个参数是Station类型的一个对象，指代起始站，需要包含arrivalTime，指代用户到达站点时间，即火车要在这个时间点后到达"
            "第二个参数也是Station类型的一个对象，指代终点站"
            startStation=Station("南京南");
            startStation.arrivalTime=datetime("09:00:00"); % 时间为12点00分00秒，所有时间全都不考虑到秒
            toStation=Station("溧阳");
            SearchedTickets=app.trainDispatch.findAvailableTickets(startStation,toStation,0);
            % 返回的SearchedTickets是字符串拼接的形式
            tickets=strsplit(SearchedTickets,"-");
            tickets=tickets(1:end-1);
            % 现在tickets是一个一维向量，每一个的形式只可能会有两种，一种是诸如"D22"这样的直达车，另一种类似于"D22,G21"这样的转乘车
            "这里来校验答案"
            result=true;
            if ~ismember("D22",tickets)
                result=false;
            end

            
        end
        function result=test2(app)
            "占位"
            result=false;
        end

        function obj = AutoTest()
            obj.testcases={@obj.test1,@obj.test2};
            
        end

        function output = Test(app)
            output=true;
            for i=1:length(app.testcases)
                result=app.testcases{i};
                result=result();
                "现在检验第" + string(i) + "个测试样例"
                if result==true
                    disp("测试通过");
                else
                    disp("测试失败")
                    output=false;
                end
            end
            
        end
    end


end