# 対象ラベル: claim_positive_cone_element_qbar_square_root
# 有限標本で代数的平方根の等式と非零性を厳密計算する。
for a in [QQ(1), QQ(2), QQ(3), QQ(1)/2, QQ(7)/3]:
    b = AA(a).sqrt()
    q_a, q_b = QQbar(a), QQbar(b)
    p = q_b*q_b - q_a
    assert q_b*q_b == (q_b*q_b-q_a)+q_a
    assert (q_b*q_b-q_a)+q_a == p+q_a
    assert p+q_a == 0+q_a
    assert 0+q_a == q_a
    assert b != 0
    assert b * b == AA(a)
    assert QQbar(b) * QQbar(b) == QQbar(a)
print('PASS: 正錐の元の代数的平方根の有限標本')
