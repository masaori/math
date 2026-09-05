# 対象ラベル: def_positive_fixed_point_count_rational_input
# 式ペア・判定: q_F(n)=Z_n(F)/1 ∈ QQ_{>0}、零個・非正回数は定義域外
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

accepted = 0
rejected = 0
for name, mapping, n in rows():
    count = count_fixed(mapping, n)
    if count > 0:
        q = positive_rational_input(mapping, n)
        assert q.parent() is QQ, (name, n)
        assert q > 0 and q.numerator() == count and q.denominator() == 1, (name, n)
        accepted += 1
    else:
        try:
            positive_rational_input(mapping, n)
        except ValueError:
            rejected += 1
        else:
            raise AssertionError(('zero-count input was accepted', name, n))
for n in (0, -1, -2):
    try:
        positive_rational_input((1, 0), n)
    except ValueError:
        rejected += 1
    else:
        raise AssertionError(('nonpositive exponent was accepted', n))
assert accepted > 0 and rejected > 0
print("positive rational inputs:", accepted, "; excluded inputs:", rejected)
print("RESULT: PASS")
