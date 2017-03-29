figure(2)
plot((0:t)*dt,zt,'r','LineWidth',2)
hold on
plot((0:t)*dt,ht,'b','LineWidth',2)
legend('Zombie','Human');
title('Population over time');
xlabel('time');
ylabel('Population');
hold off