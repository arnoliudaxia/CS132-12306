classdef TestAPI < handle & matlab.uitest.TestCase

    properties (Access = public)
        usr1
        usr2
        usr3
        trainDispath
        debugApp
    end

    methods (TestMethodSetup)

        function launchApp(testCase)

        end

    end

    methods (Static)

        function output = stationIDtoStation(input)

            if input == 1
                output = Station("南京南");
            elseif input == 2
                output = Station("溧阳");
            elseif input == 3
                output = Station("湖州");
            elseif input == 4
                output = Station("杭州东");
            elseif input == 5
                output = Station("嘉兴南");
            elseif input == 6
                output = Station("上海虹桥");
            elseif input == 7
                output = Station("苏州北");
            elseif input == 8
                output = Station("常州北");
            else
                disp("error in stationIDtoStation")
            end

        end

        function output = trainCodeTrans(str)
            % 根据第一个字符，将2替换为D，将1替换为G
            str=char(str);
            if str(1) == '2'
                output = "D"+string(str(2:end));
            else
                output = "G"+string(str(2:end));
            end

        end


        function output = passengerName(input)
            if input==1
                output = "XiaoShang";
            elseif input==2
                output = "xiaoKe";
            elseif input==3
                output="xiaoDa"
            else
                disp("错误的乘客ID")
            end
        end

    end

    methods (Access = public)
        function setTime(tc,hour,minute)
            % your software should have a system time, which can flow itself by timer and be easy to control and modify
            % when we set the time, system should accelerate to target time rather than jumping to target time.
            % when testing, time should be paused in default, time will only flow when we call this function.
            % when testing, illegal input will be avoided, time won't trace back.
            targetTime=datetime(hour+":"+minute+":00");
            disp("WARNNING: 注意当前版本调整时间的最小分度值是5分钟")
            while tc.trainDispath.SysTime<targetTime
                tc.trainDispath.changeSysTime(minutes(1));
                tc.debugApp.updateTrainUI();
                pause(0.1);
            end


        
        end

        function trainNumberList = findAvaTransferTicket(app, depStationID, arrStationID)
            % return list of transfer train-pairs whose time and seat is available.
            % only when depStation and arrStation are on different lines do we need transfer.
            % return in order of departure time of first train (then second train)
            % For example, searching Huzhou-Jiaxing at 10:50 will return
            % trainNumberList = {222,215;223,218}   n × 2 cell array
            % if no available train-pair, return {} 0x0 empty cell array
            startStation = app.stationIDtoStation(depStationID);
            startStation.arrivalTime = app.trainDispath.SysTime;
            toStation = app.stationIDtoStation(arrStationID);

            SearchedTickets = app.trainDispath.findAvailableTickets(startStation, toStation, 0);
            "搜索到的车票为";
            disp(SearchedTickets)
            tickets = strsplit(SearchedTickets, "-");
            trainNumberList = tickets(1:end - 1)

        end

        function trainNumberList = findAvaNonstopTicket(tc,depStationID, arrStationID)
            % return list of nonstop trains whose time and seat is available.
          % return in order of departure time
          % For example, searching Nanjing-Shanghai at 12:20 will return
          % trainNumberList = {114,218,116}   1 × n cell array
          % if no available train, return {} 0x0 empty cell array

            %   为了简单起见，直接调用findAvaTransferTicket，然后过滤结果
            trainNumberList=tc.findAvaTransferTicket(depStationID, arrStationID);
            if trainNumberList.length>=1
                result=[];
                for i=1:trainNumberList.length
                    trains=trainNumberList(i);
                    if ~contains(trains, ',')
                        "直达列车";
                        result=[result trains]
                    end

                end
                trainNumberList=result;
            end
        
        end

        function orderID = buyTicket(tc, passengerID, trainID, depStationID, arrStationID)
            % passenger can only buy one ticket per train, but can buy tickets of different trains without quantitative limitation.
            % we will setTime before call this function, so there no time parameter, just take system time
            % buying transfer ticket will call this function twice
            % return 0 when no ticket available
            % return an arbitrary orderID, as long as no same ID even if refunding happens
            trainCode = tc.trainCodeTrans(trainID);
            startStation = tc.stationIDtoStation(depStationID);
            toStation = tc.stationIDtoStation(arrStationID);
            temptime = datetime("01:00:00");

            tc.trainDispath.bookTicket(trainCode, startStation, toStation, 2, 1, temptime, temptime, tc.passengerName(passengerID))

        end

    end

    methods (Test)

        function testFindTicketExample(testCase)
            % State: No order for the table and no dish selected
            % Input: Choose appetizer 1 and press select button
            % Expected Output: OrderList has appetizer 1's name, amount and
            % unit price
            testCase.verifyEqual(testCase.usr1.usrID, "XiaoShang")

        end

    end

end
