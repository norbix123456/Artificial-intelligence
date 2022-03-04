% Construction and testing of decision trees - toy example problem
clear     % clearing workspace

% loading data set - examples in rows
%p = load('lenses/lenses.txt');
p = load('car/car.txt'); 

% division into training set and test set:
TrainingVectors = p(1:2:end,1:end-1);
TestVectors = p(2:2:end,1:end-1);
TrainingClasses = p(1:2:end,end)';
TestClasses = p(2:2:end,end)';

 
% tree construction:
D = build_tree(TrainingVectors,TrainingClasses); 

% printing tree to file:
f = fopen('tree.txt','w');
printnode(f,D,1,0);
fclose(f);

% error calculation:
training_error = mean(what_class(D,TrainingVectors) ~= TrainingClasses)
test_error = mean(what_class(D,TestVectors) ~= TestClasses)
 
chart
pause

% pruning part:
roz = distribution(D,TrainingVectors,TrainingClasses)  % distribution of examples reaching particular nodes of a tree
D

node = 6;                     % node to remove
Dp = delete_node(D,node);     % removing the child nodes associated with the node
Dp(end,node) = 3;             % exchange node for a leaf, e.g. class 3

Dp
training_error_after_pruning = mean(what_class(Dp,TrainingVectors) ~= TrainingClasses)
test_error_after_pruning = mean(what_class(Dp,TestVectors) ~= TestClasses)

