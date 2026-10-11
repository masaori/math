# 対象ラベル: claim_perfect_matching_enumeration_complete
# 本文の行: 二元集合の等号と昇順性
# 式ペア: (a,b) = (c,d)
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, D, canonical in _matching_cases:
    for a, b in canonical:
        for c, d in canonical:
            for i in set((a, b)) & set((c, d)):
                assert a < b and c < d
                expr1 = (a, b)
                expr2 = (c, d)
                assert expr1 == expr2
                checked += 1

print("PASS shared_pair_ordered: %s 等式" % checked)
