"""全辺鍵の位相ベクトルの符号公式を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

全辺鍵のファイバーの置換 phi について、四つのスピン構造の位相寄与は
次の三つの積へ分解される。

1. 巡回ごとの符号 (-1) の積 = (-1)^{巡回数}。
2. 巡回ごとの回転積の積。非後退な閉歩道の四半回転の和は 4 の倍数なので、
   各回転積は zeta8^{4k} = (-1)^k（k は回転数）であり、積は
   (-1)^{総回転数} になる。
3. ねじれ (a,b) の縫い目寄与。全辺鍵では動く辺集合が全基底辺を各一度ずつ
   使うので、縫い目寄与の合計は水平・垂直とも L 本になり、成分 (a,b) の
   寄与は (-1)^{aL+bL} である。

従って位相ベクトルは、奇数辺長では epsilon(phi) * (1,-1,-1,1)、偶数辺長では
epsilon(phi) * (1,1,1,1) に等しい。ここで
epsilon(phi) = (-1)^{巡回数 + 総回転数} である。二値性は一辺三の偶然ではなく
全ての奇数辺長で成り立ち、対角共変な位相反転完全マッチングの存在は、
epsilon の +1 と -1 の個数が平行移動の軌道サイズの各層で均衡することへ帰着する。

検査は、一辺二・三の全ファイバーと一辺五・七の対角固定置換について、
四半回転の和が 4 の倍数であること、縫い目合計が (L,L) であること、
位相ベクトルが符号公式と一致すること、epsilon の個数の均衡を
有限集合と Q(zeta8) の等号だけで固定する。浮動小数点は使わない。
"""

load("sagemath/check/translation-diagonal-full-key-fixed-permutation-phase/check.sage")


def quarter_turn(edge, successor):
    turn = (direction(successor) - direction(edge)) % 4
    assert turn in (0, 1, 3)
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[turn]


def cycle_data(side, phi):
    """巡回数・総回転数・縫い目合計を返す。各巡回の四半回転和は 4 の倍数。"""
    orbits = moved_orbits(phi)
    total_rotation = ZZ(0)
    seam_total_h = ZZ(0)
    seam_total_v = ZZ(0)
    for walk in orbits:
        quarter_sum = sum(
            quarter_turn(edge, phi[edge]) for edge in walk
        )
        assert quarter_sum % 4 == 0
        total_rotation += quarter_sum // 4
        for edge in walk:
            ch, cv = seam_parities(side, edge)
            seam_total_h += ch
            seam_total_v += cv
    return len(orbits), total_rotation, (seam_total_h, seam_total_v)


def sign_formula_vector(side, cycle_count, total_rotation):
    epsilon = K8((-1) ** ((cycle_count + total_rotation) % 2))
    return tuple(
        epsilon * K8((-1) ** ((a * side + b * side) % 2))
        for a in (0, 1) for b in (0, 1)
    )


def epsilon_of(cycle_count, total_rotation):
    return ZZ((-1) ** ((cycle_count + total_rotation) % 2))


def check_population(side, permutations):
    epsilon_counts = {ZZ(1): ZZ(0), ZZ(-1): ZZ(0)}
    for phi in permutations:
        cycle_count, total_rotation, seam_totals = cycle_data(side, phi)
        assert seam_totals == (ZZ(side), ZZ(side))
        assert phase_vector(side, phi) == sign_formula_vector(
            side, cycle_count, total_rotation
        )
        epsilon_counts[epsilon_of(cycle_count, total_rotation)] += 1
    return epsilon_counts


# 一辺二の全ファイバー。偶数辺長なので位相は epsilon * (1,1,1,1) になる。
side2_counts = check_population(2, side2_fiber)
print(f"L=2 full fiber: epsilon counts {sorted(side2_counts.items())}")
assert side2_counts == {ZZ(1): ZZ(160), ZZ(-1): ZZ(128)}

# 一辺三の全ファイバー。位相は epsilon * (1,-1,-1,1) で、均衡する。
side3_fiber = all_full_key_permutations(3)
assert len(side3_fiber) == 75776
side3_counts = check_population(3, side3_fiber)
print(f"L=3 full fiber: epsilon counts {sorted(side3_counts.items())}")
assert side3_counts == {ZZ(1): ZZ(37888), ZZ(-1): ZZ(37888)}

# 一辺三・五・七の対角固定置換。固定置換の層でも epsilon は均衡する。
fixed_expected = {
    3: {ZZ(1): ZZ(40), ZZ(-1): ZZ(40)},
    5: {ZZ(1): ZZ(544), ZZ(-1): ZZ(544)},
    7: {ZZ(1): ZZ(8320), ZZ(-1): ZZ(8320)},
}
for side in (3, 5, 7):
    _, fixed_permutations = invariant_fixed_permutations(side)
    fixed_counts = check_population(side, fixed_permutations)
    print(f"L={side} diagonal-fixed: epsilon counts {sorted(fixed_counts.items())}")
    assert fixed_counts == fixed_expected[side]

print("PASS: translation-diagonal-full-key-phase-sign-formula")
