% value iteration:

function [V, pi] = value_iteration(mdp, precision)

%IN: mdp, precision
%OUT: V, pi

% Recall: to obtain an estimate of the value function within accuracy of
% "precision" it suffices that one of the following conditions is met:
%   (i)  max(abs(V_new-V)) <= precision / (2*gamma/(1-gamma))
%   (ii) gamma^i * Rmax / (1-gamma) <= precision  -- with i the value
%   iteration count, and Rmax = max_{s,a,s'} | R(s,a,s') |



mdp;
max(mdp.R{3}(:))
max(max(mdp.R{3}(:)))


gamma = mdp.gamma; 
ns = size(mdp.T{1},1); %number of states
na = size(mdp.T,2); %number of actions

% initializing V and pi
V = zeros(ns, 1); %Expected sum of discounted rewards
pi = zeros(1, ns); %policies


nr = size(mdp.R,2); %number of rewards

%Rmax = max ([max(max(mdp.R{1}(:))), max(max(mdp.R{2}(:))), max(max(mdp.R{3}(:))), max(max(mdp.R{4}(:)))]);



Rmax = -Inf;

for i = 1: size(mdp.R,2)
    Rmax = max([Rmax, max(max(mdp.R{i}(:)))]);
end

%Rmax

i = 0;

while true
    i = i + 1;
    V_new = zeros(ns, 1);
    

    for state1 = 1:ns
        q = zeros(na,1);
        for action = 1:na
            for state2 = 1:ns
                state_val = mdp.T{action}(state1,state2);
                reward_val = mdp.R{action}(state1,state2) + gamma * V(state2);
                q(action) = q(action) + state_val * reward_val;
            end
        end
        [V_new(state1), pi(state1)] = max(q);
    end

    V_old = V;
    V = V_new;
    
    if (max(abs(V_new-V_old)) <= precision / (2*gamma/(1-gamma))) || (gamma^i * Rmax / (1-gamma) <= precision);
        break;
    end
    
end

