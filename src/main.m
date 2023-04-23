% Entrypoint for your project.

trainDispath=TrainDispatch();
% Initialize the UI
mainapp= mainApp();
mainapp.trainDispatch=trainDispath;
mainapp.usrID="小明";
mainapp.DropDown_SelectPassanger.Items=["就我自己","小张"];
usr2= mainApp();
usr2.trainDispatch=trainDispath;
usr2.usrID="小张";
usr2.DropDown_SelectPassanger.Items=["就我自己","小明"];
trainDispath.usrsinfo(1).usrName="小明";
trainDispath.usrsinfo(1).ticket=[];
trainDispath.usrsinfo(1).usrStatus="IDLE";
trainDispath.usrsinfo(2).usrName="小张";
trainDispath.usrsinfo(2).ticket=[];
trainDispath.usrsinfo(2).usrStatus="IDLE";
trainDispath.client=[mainapp,usr2];
% Initialize the debug UI
debugUI= DebugApp();
trainDispath.debugApp=debugUI;
mainapp.debugApp=debugUI;
debugUI.trainDispatch=trainDispath;
debugUI.display_update_systime();
debugUI.displaySeatTrain=trainDispath.Trains(2);