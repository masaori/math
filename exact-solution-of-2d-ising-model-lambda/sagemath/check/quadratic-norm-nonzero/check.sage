from sage.all import QQ, QuadraticField

for d in (2, 3, 5, 7):
    K = QuadraticField(d, 'b')
    b = K.gen()
    a = K(d)
    assert b * b == a
    for c0_num in range(-3, 4):
        for c1_num in range(-3, 4):
            c0, c1 = QQ(c0_num), QQ(c1_num)
            z = K(c0) + K(c1) * b
            norm = c0 * c0 - a * (c1 * c1)
            assert (z == 0) == (norm == 0)
            assert (K(c0) + K(c1) * b) * (K(c0) - K(c1) * b) == norm
print('PASS: 二次係数表示の非零ノルムを厳密な有限標本で確認')
