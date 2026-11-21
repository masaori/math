# 対象ラベル: claim_real_closed_subfield_exists
# 合成の各段を、R := AA（QQbar の中の実代数的数）、omega := I の具体的な組で厳密に検算する。
# 全称の存在は本文と Lean が示す。ここでは本文の五条件が具体的な組で成り立つことと、
# 第五条件が s と -s のどちらを平方にするかを固定することを確かめる。浮動小数点は使わない。

s = QQbar(2).sqrt()
assert s * s == 2

# 準備: 虚数単位（claim_imaginary_unit_exists）
omega = QQbar.gen()
assert omega * omega == -1

samples_R = [AA(0), AA(1), -AA(3)/2, AA(2).sqrt(), -AA(2).sqrt(), AA(3)^(1/3), -AA(5)^(1/5)]

# 第二条件: 平方の三分法（claim_maximal_ordered_subfield_square_trichotomy）
for z in samples_R:
    pos = (z > 0) and (z.sqrt() != 0) and (z.sqrt()^2 == z)
    neg = (-z > 0) and ((-z).sqrt() != 0) and ((-z).sqrt()^2 == -z)
    assert sum([z == 0, pos, neg]) == 1

# 第四条件の存在: 代数的数は a + b*omega（a, b は実代数的数）
cubic_roots = [r for (r, _) in QQ['t']([1, 1, 0, 1]).roots(QQbar)]
xs = [QQbar(1) + 2*omega, (QQbar(2).sqrt() + omega) / 3] + cubic_roots
for xi in xs:
    a = AA(xi.real()); b = AA(xi.imag())
    assert QQbar(a) + QQbar(b) * omega == xi
    # 第四条件の一意性: (b - b') * omega = a' - a で b != b' なら omega が実になり矛盾
    for (a2, b2) in [(a + 1, b), (a, b + 1), (a - AA(2).sqrt(), b + AA(2).sqrt())]:
        assert QQbar(a2) + QQbar(b2) * omega != xi
    assert omega not in [QQbar(z) for z in samples_R]

# 第五条件: s は R の正の元で、零でない w in R が w*w = s を満たす
assert s in AA and AA(s) > 0
w = AA(s).sqrt()
assert w != 0 and w * w == AA(s)

# 負の検査: s の代わりに -s を選ぶと、同じ R では第五条件が成り立たない
assert not (AA(-s) > 0)
assert not (AA(-s) == 0)

print("PASS: 7 trichotomy samples, 5 decompositions, sqrt-two square and -s negative check")
