% 示例文件
% 以相同数据集、随机参数计算岭回归为例

%% 函数主体
function example() 
writeInfo = spawnInfo();
RandomSearch(@TRAIN,@predict,@spawnPara,writeInfo,spawnData());  % data不改变可以用静态值，会改变使用句柄
end


%% 生成Excel写入数据
function writeInfo = spawnInfo()
writeInfo.startRow = 2;             % 从第二行开始写入（第一行留作标题）
writeInfo.endRow = 10;              % 写入到10行后结束持续
writeInfo.name = "C:\...\xxx.xlsx";  % Excel文件路径
writeInfo.sheet = 1;                % 写入文件的第一个表单
writeInfo.startColumn = 'B';        % 从B列开始写入
writeInfo.endColumn = 'D';          % 一参数、一随机种子、一结果，到D列结束
end

%% 随机生成参数的函数主体
function para = spawnPara()
seed=randi(500000000);
rng(seed)                   % 重置随机数生成器
CN=3+rand()*10;
C=2^-CN;                    % 在 2^(-3) 至 2^(-13) 范围内随机生成正则化参数
para=[seed,C];
end

%% 数据集
function data = spawnData()
data.train_x=[1,2,3,4,5;0,-1,-2,-1,-5];     %随机生成的
data.train_y=[2,4,6,8,10];
data.test_x=[1.5,2.5,3.5;0,-3,-1];
data.test_y=[3,5,7];
end

%% 进行训练的函数主体(具有参数、数据两个输入)
function model = TRAIN(para,data)
model = ridge(data.train_y',data.train_x',para(2),0);  %以MATLAB岭回归函数的格式要求得到模型参数
end

%% 使用模型和数据集进行测试
function result = predict(model,data)
pre_y=zeros(1,length(data.test_x));
for i=1:length(data.test_x)
    test = data.test_x(:,i);
    pre_y(i) = test(1)*model(1)+test(2)*model(2)+model(3);
end
result = mean((pre_y-data.test_y).^2);
end