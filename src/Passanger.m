classdef Passanger<handle
    
    properties
        passangerName
        myStatus
            % IDLE=0
            % ONBOARD=1
        myTickets=[]
    end
    
    methods (Access = public)
        function obj = Passanger(name)
            obj.myStatus=0;
            obj.passangerName=name;            
        end
    end
    methods (Access = private)
        % % 
        % function obj = getTicket(obj,args)
            
        % end
    end
    methods (Access = public)
        
        % 检查是否已经买了票了（不能重复购买）
        % 返回值：boolean，true代表已经买过了
        function output = isHasBoughtTicket(app,ticket)
            output=false;
            % 遍历myTickets，检查每一个元素的trainCode是否和ticket.trainCode一样
            for i = 1:length(app.myTickets)
                theTicket=app.myTickets(i);
                if strcmp(theTicket.trainCode,ticket.trainCode)
                    output=true;
                    return;
                end
                
            end
        end

        % 获取文本形式的用户状态
        function output = getMyStatus(app)
            if app.myStatus==1
                output="ONBOARD";
            else
                output="IDLE";
            end
            
        end

        % 删除用户的ticket
        % 参数：ticket，要删除的ticket，必须在用户的myTickets中
        function output = removeTicket(app,ticket)
            for i = 1:length(app.myTickets)
                theTicket=app.myTickets(i);
                if strcmp(theTicket.trainCode,ticket.trainCode)
                    app.myTickets(i)=[];
                    return;
                end
                
            end
        end

    end
end

