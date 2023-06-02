% Entrypoint for your project.

trainDispath=TrainDispatch();
% Initialize the UI
usr1 = mainApp();
usr1.trainDispatch = trainDispath;
usr1.usrID = "XiaoShang";
trainDispath.addUsr(usr1.usrID);



usr1.setOtherPassengers(["XiaoShang"]);
trainDispath.client=[usr1];
% Initialize the debug UI
debugUI= DebugApp();
trainDispath.debugApp=debugUI;
debugUI.trainDispatch=trainDispath;
debugUI.display_update_systime();
debugUI.displaySeatTrain=trainDispath.Trains(2);
% 自动化测试
% autoTest=AutoTest();
% autoTest.trainDispatch=trainDispath;
% autoTest.Test();

% well,你可以先试一试从常州北到杭州东，看看路线齐不齐全
% testAPI=TestAPI();
% testAPI.usr1=usr1;
% testAPI.trainDispath=trainDispath;
% testAPI.debugApp=debugUI;

% id=testAPI.buyTicket(1,"223",4,3)
% pause(15)
% testAPI.refund(id)


% testAPI.setTime(10,50);
% testAPI.findAvaTransferTicket(3,5)
% testAPI.setTime(12,20);
% testAPI.findAvaNonstopTicket(1,6)