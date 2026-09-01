"""ファイバーの位相付き寄与が位相形（切断線偶奇の符号 × 回転位相の冪）で
書けることを厳密検査する。

対象: claim_fiber_phase_weight_topological_form。

一辺 L=2 のトーラスで、四つのスピン構造 (a,b) と全ての非空ファイバー N_L(D,E)
について、遷移行列の成分による定義
  K^{a,b}_L(D,E) = Σ_φ Π_C ( - Π_{e∈C} M^{a,b}_{e,φ(e)} )
と、位相形
  Σ_φ Π_C ( -(-1)^{a h(γ^φ_C)+b v(γ^φ_C)} ζ8^{t∘(γ^φ_C)} )
とを Q(ζ8) で比較する。位相形は基点の選び方に依らないことも、
各軌道列を一つ回した基点で再計算して確かめる。浮動小数点は使わない。
"""

load("sagemath/check/kac-ward-nonbacktracking-sum/check.sage")


def permutation_stratum(phi):
    moved = {edge for edge in oriented if phi[edge] != edge}
    support = {edge[:3] for edge in moved}
    doubled = frozenset(base for base in support
                        if base + (0,) in moved and base + (1,) in moved)
    single = frozenset(support - set(doubled))
    return doubled, single


def walk_phase(a, b, walk):
    """軌道列 walk の位相 (-1)^{a h + b v} ζ8^{t∘} を Q(ζ8) で返す。"""
    r = len(walk)
    h_parity = sum(seam_parities(L, e)[0] for e in walk) % 2
    v_parity = sum(seam_parities(L, e)[1] for e in walk) % 2
    cyclic_turning = sum(step_turning(walk[k], walk[(k + 1) % r])
                         for k in range(r))
    return K8(ZZ(-1) ** (a * h_parity + b * v_parity)) \
        * zeta8 ** cyclic_turning


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
        for (doubled, single), members in fibers.items():
            entry_weight = K8(0)     # def_fiber_phase_weight（遷移成分の積）
            phase_weight = K8(0)     # 位相形（基点は orbits_of の先頭）
            rotated_weight = K8(0)   # 位相形（基点を一つ回した別の選択）
            for index in members:
                phi = nonbacktracking_permutations[index]
                walks = orbits_of[index]

                entry_term = K8(1)
                phase_term = K8(1)
                rotated_term = K8(1)
                for walk in walks:
                    entry_product = K8(1)
                    for edge in walk:
                        entry_product *= K8(
                            transition_entry(L, a, b, edge, phi[edge]))
                    entry_term *= -entry_product
                    phase_term *= -walk_phase(a, b, walk)
                    rotated = walk[1:] + walk[:1]
                    rotated_term *= -walk_phase(a, b, rotated)
                entry_weight += entry_term
                phase_weight += phase_term
                rotated_weight += rotated_term

            # 主張の等式と、基点の選び方に依らないこと。
            assert entry_weight == phase_weight
            assert phase_weight == rotated_weight
            checked += 1

assert checked == 4 * len(fibers)
print("PASS: K^{a,b}_L(D,E) = Σ_φ Π_C ( -(-1)^{a h + b v} ζ8^{t∘} ) "
      f"(L={L}, 非後退置換 {len(nonbacktracking_permutations)} 件, "
      f"ファイバー {len(fibers)} 件, スピン構造 4 件, 検査 {checked} 件)")
