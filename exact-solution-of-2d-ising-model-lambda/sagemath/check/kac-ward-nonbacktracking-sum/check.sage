"""四つの Kac--Ward 行列式が非後退置換の位相表示の和に一致することを厳密検査する。

対象: claim_kac_ward_determinant_nonbacktracking_phase_sum。
一辺 L=2 のトーラスで、非後退置換（動く辺がすべて直ちに引き返さない後続へ移る置換）を
全列挙し、各置換の軌道ごとの位相表示 Π_C ( -x^|C| · (-1)^{a h(γ_C)+b v(γ_C)} ζ8^{t∘(γ_C)} )
の総和を、det(I - x M^{a,b}) の直接計算と Q(ζ8)[x] で比較する。行列式は全置換にわたる
和なので、この一致は「非後退でない置換の項が零である」ことも同時に確かめる。
"""

load("sagemath/check/kac-ward-nonbacktracking-sum/construction.sage")

def orbit_phase_twist_product(a, b, walks):
    product = P(1)
    for walk in walks:
        r = len(walk)
        h_parity = sum(seam_parities(L, edge)[0] for edge in walk) % 2
        v_parity = sum(seam_parities(L, edge)[1] for edge in walk) % 2
        cyclic_turning = sum(step_turning(walk[k], walk[(k + 1) % r])
                             for k in range(r))
        value = K8(ZZ(-1) ** (a * h_parity + b * v_parity)) \
            * zeta8 ** cyclic_turning
        product *= -(x ** r) * P(value)
    return product


orbits_of = [moved_orbits(phi) for phi in nonbacktracking_permutations]
checked = 0
for a in (0, 1):
    for b in (0, 1):
        m = matrix(P, edge_count, edge_count, lambda r, s: P(
            transition_entry(L, a, b, oriented[r], oriented[s])))
        det_poly = (identity_matrix(P, edge_count) - x * m).det()
        total = P(0)
        for walks in orbits_of:
            total += orbit_phase_twist_product(a, b, walks)
        assert total == det_poly
        checked += 1

assert len(nonbacktracking_permutations) > 0
assert checked == 4
print("PASS: det(I - x M^{a,b}) = Σ_{非後退置換} Π_C ( -x^|C| × 切断線偶奇の符号 × "
      f"ζ8^循環総回転数 ) (非後退置換 {len(nonbacktracking_permutations)} 件, "
      f"スピン構造 {checked} 件)")
