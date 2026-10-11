# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 空集合と奇数個の集合
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for n in (0,1,3,5,7):
    pm = [D for J,D in _pm_cases if len(J) == n]
    inv = [tau for J,tau in _inv_cases if len(J) == n]
    assert (pm == [frozenset()] and inv == [{}]) if n == 0 else (pm == [] and inv == [])
    checked += 1
print("PASS empty_odd: %s 条件確認" % checked)
