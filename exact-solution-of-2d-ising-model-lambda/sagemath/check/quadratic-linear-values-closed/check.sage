from sage.all import QQ, QuadraticField

for d in (2, 3, 5, 7):
    K = QuadraticField(d, 'b')
    b = K.gen()
    a = QQ(d)
    assert b * b == a
    assert K(0) == K(0) + K(0) * b
    assert K(1) == K(1) + K(0) * b
    for u_num in range(-2, 3):
        for v_num in range(-2, 3):
            for w_num in range(-2, 3):
                for t_num in range(-2, 3):
                    u, v, w, t = map(QQ, (u_num, v_num, w_num, t_num))
                    y, z = K(u) + K(v) * b, K(w) + K(t) * b
                    assert y + z == K(u + w) + K(v + t) * b
                    assert -y == K(-u) + K(-v) * b
                    assert y * z == K(u * w + a * v * t) + K(u * t + v * w) * b
print('PASS: 四つの二次体で一次式の和・符号反転・積を厳密に確認')
