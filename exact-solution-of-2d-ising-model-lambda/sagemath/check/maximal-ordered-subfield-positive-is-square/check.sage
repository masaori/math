# 対象ラベル: claim_maximal_ordered_subfield_positive_is_square
# 有限標本で、正錐の元の平方根が同じ実代数的部分体に属する結論を検算する。
# AA は厳密な実代数的数の演算にだけ使う。極大性の全称命題の証明ではない。

s = AA(2).sqrt()
samples = [AA(1), AA(2), s, AA(3) + s, AA(5) - s]
for a in samples:
    assert a > 0
    b = a.sqrt()
    assert b != 0
    assert b * b == a
    assert b in AA

print("PASS: 5 exact algebraic samples")
