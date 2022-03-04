
% Construction and testing of decision trees You can only add or modify a
% code where the place is dotted (.....)

clear;
% loading data set - examples in rows
%p = load('letters1.txt');
%p = load('letters2.txt');
%p = load('letters3.txt');
%p = load('letters5.txt');
p = load('car/car.txt');
%p = load('tic/tic.txt');


% Artificial difficulties:
[number_of_examples number_of_columns] = size(p);
%p = [ceil(rand(number_of_examples,4)*8) p];    % 1. Adding worthless information
%p = [ceil(rand(number_of_examples,1)*64) p];   % 2. Adding seemingly valuable information:
%p = [randperm(number_of_examples)' p];         % 3. Adding seemingly valuable information: (unique example number):


number_of_experiments = 10;    % number of experiments with each draw of the collection for learning
training_error = 0;
test_error = 0;
training_error_after_pruning = 0;
test_error_after_pruning = 0;

% I assume that half of the examples are for teaching and half for testing.
% A subset of learning examples can be broken down into tree parts
% (TrainingVectors_constr) and part for validation (checking that the tree good
% generalizes)

% part of the examples for building a tree in percentage (0-100%) :
part_for_constr = 100 % (..... you can choose the proportions)   

number_for_constr = ceil(number_of_examples*part_for_constr/100/2)   % number of examples for tree construction 

for eksp=1:number_of_experiments
   % division into subsets for tree construction, validation and decision
   % tree test
   
   p = p(randperm(number_of_examples),:);   % shuffling the examples
   
   % selection of examples for training and testing decision trees:
   TrainingVectors = p(1:end/2,1:end-1);
   TrainingVectors_constr = TrainingVectors(1:number_for_constr,:);
   ValidationVectors = TrainingVectors(number_for_constr+1:end,:);
   TestVectors = p(end/2+1:end,1:end-1);           % only for testing the final version of the tree
   TrainingClasses = p(1:end/2,end)';
   TrainingClasses_constr = TrainingClasses(1:number_for_constr);
   ValidationClasses = TrainingClasses(number_for_constr+1:end);
   TestClasses = p(end/2+1:end,end)';
   
   % BUILDING ORDINAL TREE FOR A COMPARISION WITH PRUNED VERSION:
   
   % building a tree on a complete learning data set:
   D = build_tree(TrainingVectors,TrainingClasses); 
      
   % error calculation:
   training_error(eksp) = mean(what_class(D,TrainingVectors) ~= TrainingClasses);
   training_error_constr(eksp) = mean(what_class(D,TrainingVectors_constr) ~= TrainingClasses_constr);
   if length(ValidationClasses) > 0
      training_error_valid(eksp) = mean(what_class(D,ValidationVectors) ~= ValidationClasses);
   end
   test_error(eksp) = mean(what_class(D,TestVectors) ~= TestClasses);
   
   
   % BUILDING TREE FOR PRUNING:
   
   % building a tree based on a subset to build
   Dp = build_tree(TrainingVectors_constr,TrainingClasses_constr); 
   dist_constr = distribution(Dp,TrainingVectors_constr,TrainingClasses_constr);  % distribution of examples from individual classes for tree D and the set for its construction
   dist_valid = distribution(Dp,ValidationVectors,ValidationClasses);     % -||- set for its validation
  
   
   [number_of_rows, number_of_nodes] = size(Dp);
   number_of_classes = length(dist_constr(:,1));

   % ........ Space for the pruning algorithm
   % ........ Do not use a test set for training and pruning!!!!!!!!!!!!!!!
   max_depth = 6;
   distvalues=zeros(4,number_of_nodes);
   numbdist=zeros(1,number_of_nodes);
   distbest=zeros(1,number_of_nodes);
   for i=1:number_of_nodes
       fathers = parents(Dp);
       deep = depth(Dp,fathers);
       if(deep(i)>=max_depth)
           for j=i:number_of_nodes
               if(fathers(i) == fathers(j))
                   distvalues(:,j) = dist_constr(:,j);%%%%%%%%%%%%%%%na temat parentsów a nie ta sama depth
                   numbdist(1,j) = Dp(end,j);
                   distbest(1,j) = sum(distvalues(:,j));
               end
           end
           indicie = find(distbest==max(distbest));
           Dp = delete_node(Dp,fathers(i));
           Dp(end,fathers(i)) = D(end,indicie(1));%%%do parentsa
       end
   end
         
           
   
   
   
   
   
   Dp;
   % calculation of errors after pruning:
   training_error_Dp(eksp) = mean(what_class(Dp,TrainingVectors_constr) ~= TrainingClasses_constr);
   if length(ValidationClasses) > 0
      validation_error_Dp(eksp) = mean(what_class(Dp,ValidationVectors) ~= ValidationClasses);
   end
   test_error_Dp(eksp) = mean(what_class(Dp,TestVectors) ~= TestClasses);
   
   disp(sprintf('error: training = %f, test = %f, error after pruning: training = %f, test = %f', ...
     training_error(eksp),test_error(eksp),training_error_Dp(eksp),test_error_Dp(eksp)));
   
end
disp(sprintf('average errors of decision tree classification for %d experiments:\n',number_of_experiments));
disp(sprintf('without pruning - training (examples for tree building): %f, test = %f',mean(training_error),mean(test_error)));
disp(sprintf('with pruning - training (examples for tree building): %f, test = %f',mean(training_error_Dp),mean(test_error_Dp)));
disp(sprintf('reduction of average test error = %f perc.',100*(mean(test_error)-mean(test_error_Dp))/mean(test_error)));

