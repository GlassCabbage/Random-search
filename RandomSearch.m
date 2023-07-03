function [] =RandomSearch(trainHandle,predictHandle,parameterHandle,writeInfo,data)
% 输入 trainHandle 为训练句柄，具有两个输入变量，一为以行向量进行输入的参数，
%   二为训练数据，需要存储为struct格式。有一个输出变量，为模型 model
% 输入 predictHandle 为测试句柄，有两个输入变量，一为 model， 二为数据集data，
%   有一个行向量输出，包括所有需要的指标
% parameterHandle 为参数生成器，没有输入变量，输出为行向量的参数向量
% writeInfo 为写入参数具有：
%       startRow    初始写入行
%       endRow      写入截至行
%       name        文件名
%       sheet       写入表单数
%       startColumn 写入初始列
%       endColumn   写入截至列
% data 为本次搜索使用的数据集 data，可以使用句柄

for i = writeInfo.startRow:writeInfo.endRow
    disp(['开始进行',num2str(i),'行的计算'])
    %% spawn
    P = parameterHandle();
    disp("开始训练")
    model = trainHandle(P,data);
    disp("开始预测")
    result = predictHandle(model,data);

    %% write
    disp("开始写入")
    Range = [writeInfo.startColumn,num2str(i),':',writeInfo.endColumn,num2str(i)];
    writematrix([P,result],writeInfo.name,'Sheet',writeInfo.sheet,'Range',Range);
    disp(['完成',num2str(i),'行的写入']);
    disp(' ')
end
end

