"""内部辺対と局所位相の合成偶奇が配向に依存することを反例で固定する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

偶奇恒等式の左辺を動辺数・内部辺対・切断線辺対・局所位相へ分けたとき、
内部側の合成偶奇 p_int := 動辺数 + 内部辺対の反転和 + 局所位相 (mod 2) が
鍵 (D, E) だけで決まるなら、一般証明は内部と切断線を独立に扱えた。
本検算はそれが成立しないことを固定する。

- 一辺二では 8 鍵、一辺三（D=empty の自明文字）では 21 鍵で、同じ鍵の
  曲がり型なし均衡配向の間で p_int の値が異なる（配向依存）。
- p_int が配向によらず一定の鍵に限っても、切断線統計
  （E の巻き付き偶奇、切断線に触れる辺数の偶奇、その二項係数の偶奇）が
  同じで p_int が異なる鍵の組が存在する（統計では予測できない）。

従って残る一般証明は、内部寄与を配向と独立な不変量として合成するのでは
なく、成分反転で内部側の変化と切断線側の変化が相殺することを示す形で
組む必要がある。有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使う。
"""

load("sagemath/check/parity-identity-interior-orientation-dependence/construction.sage")

def interior_composite_parity(side, doubled, single, orientation):
    pieces, decomposed = pair_and_seam_decomposition(
        side, doubled, single, orientation)
    moved_parity, interior, seam, local_phase = pieces
    return (moved_parity + interior + local_phase) % 2


def seam_statistics(side, doubled, single):
    eps_h, eps_v = subset_parities(side, single)
    seam_singles = [base for base in sorted(single)
                    if base_seam_parities(side, base) != (0, 0)]
    seam_total = len(seam_singles) + len(
        [base for base in sorted(doubled)
         if base_seam_parities(side, base) != (0, 0)])
    n = len(seam_singles)
    return (eps_h, eps_v, seam_total % 2, n % 2, (n * (n - 1) // 2) % 2)


constant_two = {}
nonconstant_two = ZZ(0)
for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    if not selectors or not character_is_trivial_general(2, single):
        continue
    values = set(
        interior_composite_parity(2, doubled, single, orientation)
        for orientation in curved_free_orientations(2, single))
    if len(values) > 1:
        nonconstant_two += 1
    else:
        constant_two[(doubled, single)] = values.pop()

assert nonconstant_two == 8

stats_values_two = {}
for (doubled, single), value in constant_two.items():
    stats_values_two.setdefault(
        seam_statistics(2, doubled, single), set()).add(value)
collisions_two = [stats for stats, values in stats_values_two.items()
                  if len(values) > 1]
assert (0, 0, 0, 0, 0) in collisions_two

nonconstant_three = ZZ(0)
constant_three = {}
for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single or not character_is_trivial_general(3, single):
        continue
    orientations = curved_free_orientations(3, single)
    if not orientations:
        continue
    values = set(
        interior_composite_parity(3, frozenset(), single, orientation)
        for orientation in orientations)
    if len(values) > 1:
        nonconstant_three += 1
    else:
        constant_three[single] = values.pop()

assert nonconstant_three == 21

stats_values_three = {}
for single, value in constant_three.items():
    stats_values_three.setdefault(
        seam_statistics(3, frozenset(), single), set()).add(value)
collisions_three = [stats for stats, values in stats_values_three.items()
                    if len(values) > 1]
assert (0, 0, 0, 0, 0) in collisions_three

print("PASS: 内部辺対と局所位相の合成偶奇の配向依存を固定"
      "（一辺二の配向依存 %d 鍵・統計衝突 %d 組、"
      "一辺三の配向依存 %d 鍵・統計衝突 %d 組）"
      % (nonconstant_two, len(collisions_two),
         nonconstant_three, len(collisions_three)))
