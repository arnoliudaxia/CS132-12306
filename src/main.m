% Entrypoint for your project.

trainDispath=TrainDispatch();
% Initialize the UI
usr1 = mainApp();
usr1.trainDispatch = trainDispath;
usr1.usrID = "XiaoShang";
testCase.usr1 = usr1;
trainDispath.usrsinfo(1).usrName = "XiaoShang";
trainDispath.usrsinfo(1).ticket = [];
trainDispath.usrsinfo(1).usrStatus = "IDLE";

% usr2= mainApp();
% usr2.trainDispatch=trainDispath;
% usr2.usrID="小张";
% usr2.DropDown_SelectPassanger.Items=["就我自己","小明"];
% trainDispath.usrsinfo(2).usrName="小张";
% trainDispath.usrsinfo(2).ticket=[];
% trainDispath.usrsinfo(2).usrStatus="IDLE";

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

testAPI=TestAPI();
testAPI.usr1=usr1;
testAPI.trainDispath=trainDispath;
testAPI.findAvaTransferTicket(3,5)
testAPI.buyTicket(1,"223",4,3)
