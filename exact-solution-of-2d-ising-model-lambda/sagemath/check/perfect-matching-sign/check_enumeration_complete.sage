# 対象ラベル: claim_perfect_matching_enumeration_complete
# 本文の行: 実際のマッチングからの列挙と端点の完全列挙
# 式ペア: W(L) lists J exactly once
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, D, canonical, L, w in _enumeration_cases:
    assert len(set(L)) == len(L) and set(L) == set(canonical)
    assert complete_word(J, w)
    checked += 1

print("PASS enumeration_complete: %s 条件確認" % checked)
