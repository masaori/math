"""位相寄与が {-1,1} に属し、残余の位相和が符号付き数え上げになることを厳密検査する。

対象: claim_phase_contribution_sign_value と claim_residual_fiber_phase_signed_count。

一辺 L=2 の全非後退置換について、
(1) 位相寄与 W^{a,b}(phi) が四つのスピン構造の全てで {-1, 1} に属すること、
(2) 標準対が切り替え不能な残余 R_L をファイバー (D,E) に分け、その位相和が
    位相寄与 1 の置換の個数から位相寄与 -1 の置換の個数を引いた整数に等しいこと
を Q(zeta8) と ZZ の厳密演算で検査する。浮動小数点は使わない。
"""

load("sagemath/check/non-phase-reversing-standard-smoothing-involution/check.sage")

# (1) 全非後退置換×四スピン構造で位相寄与が {-1, 1} に属する
sign_checked = 0
for phi in nonbacktracking_permutations:
    key = permutation_key(phi)
    for a in (0, 1):
        for b in (0, 1):
            value = contributions[key][(a, b)]
            assert value in (K8(1), K8(-1))
            sign_checked += 1

# (2) 残余 R_L（接触対を持ち、標準対が切り替え不能）の符号付き数え上げ
signed_counts = {}
residual_count = 0
for phi in nonbacktracking_permutations:
    pairs = contact_pairs(phi)
    if not pairs:
        continue
    pair = tuple(ct_min(phi))
    if is_switchable_contact_pair(phi, pair[0], pair[1]):
        continue
    residual_count += 1
    doubled, single = doubled_and_single_sets(phi)
    fiber = (frozenset(doubled), frozenset(single))
    key = permutation_key(phi)
    for a in (0, 1):
        for b in (0, 1):
            value = contributions[key][(a, b)]
            count_key = (fiber, a, b)
            positive, negative, total = signed_counts.get(
                count_key, (ZZ(0), ZZ(0), K8(0)))
            if value == K8(1):
                positive += 1
            else:
                assert value == K8(-1)
                negative += 1
            signed_counts[count_key] = (positive, negative, total + value)

checked = 0
for positive, negative, total in signed_counts.values():
    assert total == K8(positive - negative)
    assert positive - negative in ZZ
    checked += 1

assert sign_checked == 4 * len(nonbacktracking_permutations)
assert residual_count > 0
assert checked > 0
print("PASS: L=%d の位相寄与の符号性 %d 件と、残余 %d 個を含む"
      "ファイバー×四スピン構造 %d 組の符号付き数え上げを検査"
      % (L, sign_checked, residual_count, checked))
