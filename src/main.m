% Entrypoint for your project.

trainDispath=TrainDispatch();
% Initialize the UI
mainapp= mainApp();
mainapp.trainDispatch=trainDispath;
mainapp.usrID="小明";
trainDispath.usrsinfo(1).usrName="小明";
trainDispath.usrsinfo(1).ticket=[];
mainapp.DropDown_SelectPassanger.Items=["就我自己"];
% usr2= mainApp();
% usr2.trainDispatch=trainDispath;
% usr2.usrID="小张";
% Initialize the debug UI
debugUI= DebugApp();
trainDispath.debugApp=debugUI;
mainapp.debugApp=debugUI;
debugUI.trainDispatch=trainDispath;
debugUI.display_update_systime();
debugUI.displaySeatTrain=trainDispath.Trains(2);