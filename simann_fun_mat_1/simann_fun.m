% Simulated Annealing  - the minimum of 2D function searching

number_of_params = 2;               % number of solution parameters 
number_of_steps = 2000;             % number of steps: do not change
N = number_of_params;
Solution = rand(1,N)*20-10;         % initial solution - random point       
T = 3000  %%%%%                           % temperature (randomness coefficient)        
Tmin = 0.001;%%%%%%%                          % minimal temperature   
wT = 0.97;%%%%%                            % change of temperature   
c = 0.3;%%%%%%                             % constant due to the influence of T for acceptance probability    
Emin = 10e40;                       % minimal function value
Eprev = 0;                          % previous value of the function 
format long;                           
Route = [Solution];                 % array of record solutions

for cyk=1:number_of_steps
             % new solution (should be near previous one !)                   
    SolutionNew = Solution;
        wsp1 = ceil(rand*2);
        wsp2 = ceil(rand*2);
        if(wsp2==1)
            if (rand>0.5)
                diff1=rand*(10-SolutionBest(1,wsp1));
            else  
                diff1=rand*(-10-SolutionBest(1,wsp1));
            end 
        else
            if (rand>0.5)
                diff1=rand*(10-Solution(1,wsp1));
            else  
                diff1=rand*(-10-Solution(1,wsp1));
            end
        end
     SolutionNew(1,wsp1)=diff1+Solution(1,wsp1);
%    SolutionNew = Solution + (rand(1,N)*20-10)*0.1;
%    SolutionNew = Solution + normrnd(0,10)*0.1;
% random = normrnd(0,T/2000,1,2);
% SolutionNew = Solution + Solution.*random;
   E = fun3(SolutionNew(1),SolutionNew(2));  % function value for point coordinates      
   
   dE = E - Eprev;                  % change of function value (dE < 0 means than new solution is better)
   
    p_accept = 1/(1+exp(dE/(c*T)));
        %%%                   % acceptance probability
     %   p_accept=exp(-dE/T);
   if (rand < p_accept)       
      Solution = SolutionNew;     
      Eprev = E;
   end
   
   if E < Emin                         
      disp('Solution was improved:')
      Emin = E
      disp('For solution:')
      SolutionBest = SolutionNew  
      Route = [Route ; SolutionBest];
   end
   
   T = T*wT;%%%%%%%                         % temperature changing (can be only after accaptance or in another place)                             
   if T<Tmin 
      T=Tmin;
   end
end

show_fun
hold on
plot(Route(:,1)',Route(:,2)');
plot(Route(:,1)',Route(:,2)','ro');
plot(Route(end,1)',Route(end,2)','gs');

for i=1:length(Route(:,1)')
	text(Route(i,1)'+0.01, Route(i,2)'+0.01, int2str(i), ...
   	'fontsize', 8);
end
hold off