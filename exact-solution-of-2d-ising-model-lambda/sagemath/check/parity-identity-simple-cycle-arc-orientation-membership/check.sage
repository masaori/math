"""弧署名の内部頂点で、向きと所属の組から何を落とすと分解が壊れるかを切り分ける。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-arc-interior-membership で、曲がり/直進の型を
起点に D 所属・C 所属・その両方・スロット名つき向きのどれを戻しても
非可解であることが確定した。従って必要なのは向きと所属を同時に保つ
完全署名との残差である。ここでは逆に完全署名（解あり）の側から落とし、
内部頂点を次の四変種で圧縮して直接衝突と合同 F_2 線型系の可解性を見る。

orient_d: スロット名順の E 所属（向き）・切断旗に、四スロットの D 所属を組で添える。
orient_c: 向き・切断旗に、C 所属を組で添える。
orient_dc: 向き・切断旗に、D 所属と C 所属の両方を添える
    （スロット名は固定順なので完全署名と同じ情報。解の存在の健全性検査）。
full_nowrap: 向き・D 所属・C 所属を全て保ち、切断旗だけを落とす。

読み方: orient_d か orient_c が可解なら、向きに片方の所属を組で添えれば
足りる。両方非可解で orient_dc が可解なら、向きと両所属の同時保持が本体で
あり、切断旗の要否は full_nowrap が分ける。

環境変数 ISING_ORIENT_VARIANT に変種名を与えると、その一変種だけを
実行する（与えなければ全変種を順に実行する）。観測値は EXPECTED_RESULTS に
固定してあり、登録済みの変種について一致を assert する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

import os

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-membership/construction.sage")


VARIANTS = (
    ("orient_d", make_orientation_membership_compressor(True, False, True)),
    ("orient_c", make_orientation_membership_compressor(False, True, True)),
    ("orient_dc", make_orientation_membership_compressor(True, True, True)),
    ("full_nowrap", make_orientation_membership_compressor(True, True, False)),
)


# 各変種の (型の種数, 階数, 直接衝突数, 可解性)。観測直後に固定する。
# 再実行の確認は日次監査に委ねる（overview.md 参照）。
EXPECTED_RESULTS = {
    "orient_d": (10098, 6799, 0, True),
    "orient_c": (10061, 6771, 16, False),
    "orient_dc": (10098, 6799, 0, True),
    "full_nowrap": (9787, 6491, 0, True),
}

selected_variant = os.environ.get("ISING_ORIENT_VARIANT")
if selected_variant is not None:
    names = tuple(name for name, _ in VARIANTS)
    assert selected_variant in names, selected_variant

variant_results = {}
for variant_name, compressor in VARIANTS:
    if selected_variant is not None and variant_name != selected_variant:
        continue
    type_lists = []
    for side, doubled, single, _ in joint_keys:
        type_lists.append(
            compressed_arc_types(side, doubled, single, compressor))
    all_types = sorted({arc_type for types in type_lists
                        for arc_type in types})
    # 行は「弧型ごとの個数の偶奇」である。台（奇数回現れる弧型の集合）だけを
    # 作る（列を全て並べた組を鍵ごとに作ると四変種で 30 分を超えた。
    # 実測 2026-09-05、parity-identity-simple-cycle-arc-interior-membership）。
    column_index = {arc_type: index for index, arc_type in enumerate(all_types)}
    entries = {}
    row_records = {}
    conflicts = 0
    for row_index, ((side, doubled, single, term), types) in enumerate(
            zip(joint_keys, type_lists)):
        multiplicities = {}
        for arc_type in types:
            multiplicities[arc_type] = multiplicities.get(arc_type, 0) + 1
        support = frozenset(arc_type for arc_type, count in multiplicities.items()
                            if count % 2 == 1)
        for arc_type in support:
            entries[(row_index, column_index[arc_type])] = GF(2)(1)
        if support in row_records and row_records[support] != term:
            conflicts += 1
        elif support not in row_records:
            row_records[support] = term
    variant_matrix = matrix(GF(2), len(joint_keys), len(all_types), entries)
    variant_vector = vector(GF(2), [term for _, _, _, term in joint_keys])
    try:
        variant_matrix.solve_right(variant_vector)
        solvable = True
    except ValueError:
        solvable = False
    rank = variant_matrix.rank()
    variant_results[variant_name] = (len(all_types), rank, conflicts, solvable)
    # 変種ごとに書き出して流す（打ち切られてもそこまでの観測が残る）。
    print("VARIANT %s: types=%d rank=%d direct-conflicts=%d solvable=%s"
          % (variant_name, len(all_types), rank, conflicts, solvable), flush=True)
    if variant_name in EXPECTED_RESULTS:
        assert variant_results[variant_name] == EXPECTED_RESULTS[variant_name], \
            (variant_name, variant_results[variant_name])

assert len(joint_keys) == 7085
print("OBSERVED: %s" % {name: values
                        for name, values in sorted(variant_results.items())})

print("PASS: 向き・切断旗に D 所属を組で添えた orient_d は直接衝突なしで解を持ち"
      "（C 所属は不要）、C 所属だけを添えた orient_c は非可解、両所属を保てば"
      "切断旗を落とした full_nowrap も解を持つ。")
