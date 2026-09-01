"""行列式の位相和が反転対と単純通過で層別されることを厳密検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

一辺 L=2 のトーラスで、四つのスピン構造 (a,b) それぞれについて、
det(I - x M^{a,b}) の直接計算と、非後退置換をファイバー N_L(D,E) へ分けて
各ファイバーの位相付き寄与 K^{a,b}_L(D,E) = Σ_φ Π_C ( - Π_{e∈C} M^{a,b}_{e,φ(e)} )
を x^{2|D|+|E|} に掛けた総和とを Q(ζ8)[x] で比較する。
併せて、各置換の軌道長総和が 2|D(φ)|+|E_1(φ)| に等しいこと、
位相付き寄与が軌道ごとの切断線偶奇の符号と回転位相の冪の積に一致することも
全数で確かめる。浮動小数点は使わない。
"""

load("sagemath/check/kac-ward-nonbacktracking-sum/check.sage")


def permutation_stratum(phi):
    moved = {edge for edge in oriented if phi[edge] != edge}
    support = {edge[:3] for edge in moved}
    doubled = frozenset(base for base in support
                        if base + (0,) in moved and base + (1,) in moved)
    single = frozenset(support - set(doubled))
    return doubled, single


# ファイバーへの分割。キーは (D, E)。
fibers = {}
for index, phi in enumerate(nonbacktracking_permutations):
    doubled, single = permutation_stratum(phi)
    assert doubled.isdisjoint(single)
    fibers.setdefault((doubled, single), []).append(index)

assert sum(len(members) for members in fibers.values()) \
    == len(nonbacktracking_permutations)

checked = 0
for a in (0, 1):
    for b in (0, 1):
        m = matrix(P, edge_count, edge_count, lambda r, s: P(
            transition_entry(L, a, b, oriented[r], oriented[s])))
        det_poly = (identity_matrix(P, edge_count) - x * m).det()

        stratified = P(0)
        for (doubled, single), members in fibers.items():
            weight = K8(0)
            for index in members:
                phi = nonbacktracking_permutations[index]
                walks = orbits_of[index]

                # 軌道長総和 = 2|D|+|E|（claim_moved_orbit_length_sum_stratified）。
                assert sum(len(walk) for walk in walks) \
                    == 2 * len(doubled) + len(single)

                term = K8(1)
                for walk in walks:
                    # 軌道の遷移成分積（def_fiber_phase_weight の内側の積）。
                    entry_product = K8(1)
                    for k in range(len(walk)):
                        entry = transition_entry(
                            L, a, b, walk[k], phi[walk[k]])
                        entry_product *= K8(entry)

                    # 位相分解との一致（claim_moved_orbit_weight_phase_twist）。
                    r = len(walk)
                    h_parity = sum(seam_parities(L, e)[0] for e in walk) % 2
                    v_parity = sum(seam_parities(L, e)[1] for e in walk) % 2
                    cyclic_turning = sum(
                        step_turning(walk[k], walk[(k + 1) % r])
                        for k in range(r))
                    assert entry_product == K8(
                        ZZ(-1) ** (a * h_parity + b * v_parity)) \
                        * zeta8 ** cyclic_turning

                    term *= -entry_product
                weight += term

            stratified += P(weight) \
                * x ** (2 * len(doubled) + len(single))

        assert stratified == det_poly
        checked += 1

assert checked == 4
print("PASS: det(I - x M^{a,b}) = Σ_{(D,E)} K^{a,b}_L(D,E) × x^{2|D|+|E|} "
      f"(L={L}, 非後退置換 {len(nonbacktracking_permutations)} 件, "
      f"ファイバー {len(fibers)} 件, スピン構造 {checked} 件)")
