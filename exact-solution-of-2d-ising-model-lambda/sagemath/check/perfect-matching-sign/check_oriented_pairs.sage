# 対象ラベル: def_perfect_matching_enumeration
# 本文の行: 昇順対の集合の定義
# 式ペア: E_D = {(a,b) | a<b, {a,b} in D}
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, D, canonical in _matching_cases:
    actual = set(canonical)
    expected = {(a, b) for a in J for b in J if a < b and frozenset((a, b)) in D}
    assert actual == expected
    assert len(actual) == len(D)
    checked += 1

print("PASS oriented_pairs: %s 集合等式" % checked)
