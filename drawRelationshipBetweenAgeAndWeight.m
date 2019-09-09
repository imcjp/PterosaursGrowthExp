function drawRelationshipBetweenAgeAndWeight( masteredDataX,masteredDataY,estimatedDataX,estimatedDataY,range )
plot(masteredDataX,masteredDataY,'*');
hold on
plot(estimatedDataX,estimatedDataY,'-');
axis(range);
xlabel('Age(year)');
ylabel('Weight(kg)');
legend('Mastered Weight','Estimated Weight');
end

