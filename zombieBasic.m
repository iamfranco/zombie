%% physical parameters (input)
z0 = 1;
h0 = 10000;

zSpeed = 7;
hSpeed = 5;

hSightRadius = 20;
zSightRadius = 20;

hAttackRadius = 1;
zAttackRadius = 1;

pz = 0.7;
ph = 0.3;

lim = 1000; %arena size

%% computational parameters (input)
framePause = 0.01;
dt = 0.5;

%% Z and H properties: x, y, kill signal
Z = zeros(z0+h0,3);   % z0+h0 because preallocation
H = zeros(h0,3);
% set initial x, y 
Z(1:z0,1:2) = lim*rand(z0,2);
H(:,1:2) = lim*rand(h0,2);

%% set alive boundaries
z = z0;   % set initial alive zombie quantity
h = h0;   % set initial alive human quantity
zg = z+h; % graveyard for zombie
zt = z;
ht = h;

%% play simulation
t = 0;
while z>0 && h>0
  plot(Z(1:z,1),Z(1:z,2),'.','MarkerEdgeColor','r','MarkerSize',15);
  hold on
  plot(H(1:h,1),H(1:h,2),'.','MarkerEdgeColor','b','MarkerSize',15);
  xlim([-1 lim+1]);
  ylim([-1 lim+1]);
  hold off
  pause(framePause);
  
  %% check closest enemy (vector: index)
  [Hz, HzD] = knnsearch(H(1:h,1:2),Z(1:z,1:2));
  [Zh, ZhD] = knnsearch(Z(1:z,1:2),H(1:h,1:2));

  %% has enemy in radius? (logical vector: 1=True, 0=False)
  hasZinSight = ZhD(1:h) <= hSightRadius;
  hasHinSight = HzD(1:z) <= zSightRadius;
  hasZinFight = ZhD(1:h) <= hAttackRadius;
  hasHinFight = HzD(1:z) <= zAttackRadius;

  %% chase movement (vector: x,y)
  Hchase = hSpeed.*(H(1:h,1:2)-Z(Zh(1:h),1:2))./ZhD(1:h)*dt.*hasZinSight;
  Zchase = zSpeed.*(H(Hz(1:z),1:2)-Z(1:z,1:2))./HzD(1:z)*dt.*hasHinSight;
  
  % convert NaN to 0 (because 0/0==NaN)
  Hchase(isnan(Hchase)) = 0;
  Zchase(isnan(Zchase)) = 0;

  %% apply chase xor walk movement (depending on distance)
  H(1:h,1:2) = H(1:h,1:2) + Hchase + hSpeed.*randn(h,2)*dt.*(~hasZinSight);
  Z(1:z,1:2) = Z(1:z,1:2) + Zchase + zSpeed.*randn(z,2)*dt.*(~hasHinSight);

  %% arena wall
  H(H(1:h,1)<0,1)=0; H(H(1:h,1)>lim,1)=lim;
  H(H(1:h,2)<0,2)=0; H(H(1:h,2)>lim,2)=lim;
  Z(Z(1:z,1)<0,1)=0; Z(Z(1:z,1)>lim,1)=lim;
  Z(Z(1:z,2)<0,2)=0; Z(Z(1:z,2)>lim,2)=lim;

  %% attack (send kill signal)
  Hkills = logical((rand(h,1)<=ph).*hasZinFight);
  Zkills = logical((rand(z,1)<=pz).*hasHinFight);
  if size(Hz(Zkills))
    H(Hz(Zkills),3) = t+1;
  end
  if size(Zh(Hkills))
    Z(Zh(Hkills),3) = t+1;
  end

  %% apply kill
  for iz = z:-1:1 % backwards because z-th element might have kill signal 1
    if Z(iz,3)==t+1
      Z([iz z zg],:) = Z([z zg iz],:);  % swap position
      z = z - 1;                        % reset "alive" boundary
      zg = zg - 1;                      % reset next grave position
    end
  end
  
  for ih = h:-1:1 % backwards because h-th element might have kill signal 1
    if H(ih,3)==t+1
      % copy dead human to alive zombie array
      z = z + 1;
      Z(z,:)=H(ih,:)+[0 0 -t-1];
      % send dead human to human graveyard
      H([ih h],:) = H([h ih],:);  % swap position
      h = h - 1;                  % reset "alive" boundary
    end
  end

  %% record population size over time
  zt = [zt z];
  ht = [ht h];
  t = t+1;
end

%% end frame
plot(Z(1:z,1),Z(1:z,2),'.','MarkerEdgeColor','r','MarkerSize',15);
plot(H(1:h,1),H(1:h,2),'.','MarkerEdgeColor','b','MarkerSize',15);
xlim([-1 lim+1]);
ylim([-1 lim+1]);
hold off
H(:,3) = H(:,3) - 1;
Z(:,3) = Z(:,3) - 1;