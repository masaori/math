for m_num in range(1, 6):
    for m_den in range(1, 6):
        for z_num in range(1, 6):
            for z_den in range(1, 6):
                m = QQ(m_num)/m_den
                z = QQ(z_num)/z_den
                if z > 2*m:
                    continue
                assert rational_of_log(log_vector(z)) <= rational_of_log(log_vector(2*m))
                assert log_vector(2*m) == vector_add(log_vector(m), ell_two)
print('PASS: upper rational inequality transfers through the logarithmic order')
