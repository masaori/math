# 対象ラベル: claim_positive_cone_element_qbar_square_root
# 有限標本で代数的平方根の等式と非零性を厳密計算する。
for a in [QQ(1), QQ(2), QQ(3), QQ(1)/2, QQ(7)/3]:
    b = AA(a).sqrt()
    assert b != 0
    assert b * b == AA(a)
    assert QQbar(b) * QQbar(b) == QQbar(a)
print('PASS: 正錐の元の代数的平方根の有限標本')
