figure(1);
trans = load('..\\Data\\weather_data\\majority_matrix.csv');
spy(trans);
save('SPY_trans_matrix.png');

figure(2);
trans_prob = load('..\\Data\\weather_data\\majority_matrix_prob.csv');
spy(trans_prob);
save('SPY_trans_matrix_prob.png');