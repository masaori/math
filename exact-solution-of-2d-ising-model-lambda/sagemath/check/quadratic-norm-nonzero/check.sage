from sage.all import QQ, QuadraticField

for d in (2, 3, 5, 7):
    K = QuadraticField(d, 'b')
    b = K.gen()
    a = K(d)
    assert b * b == a
    for u_num in range(-3, 4):
        for v_num in range(-3, 4):
            u, v = QQ(u_num), QQ(v_num)
            z = K(u) + K(v) * b
            norm = u * u - a * (v * v)
            assert (z == 0) == (norm == 0)
            assert (K(u) + K(v) * b) * (K(u) - K(v) * b) == norm
print('PASS: 二次係数表示の非零ノルムを厳密な有限標本で確認')
