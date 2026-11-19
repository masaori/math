# 対象ラベル: claim_maximal_ordered_subfield_sum_of_squares_is_square
# 零の分岐と正錐へ入る分岐を実代数的数の厳密演算で検算する。

s = AA(2).sqrt()
samples = [(AA(0), AA(0)), (AA(0), AA(3)), (AA(2), AA(0)),
           (s, AA(3)), (AA(-2), AA(-5))]
for a, b in samples:
    u = a * a + b * b
    assert u >= 0
    c = u.sqrt()
    assert c in AA
    assert c * c == u

print("PASS: 5 exact algebraic pairs")
