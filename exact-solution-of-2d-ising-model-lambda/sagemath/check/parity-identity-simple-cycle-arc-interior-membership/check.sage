"""弧署名の内部頂点の所属情報のどの位置が必要かを切り分ける。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-arc-signature-compression では、内部頂点の
D/C 所属だけを落とす turnwrapword でも頂点項の分解が保たれなかった。
ここでは turnwrapword（内部頂点は曲がり/直進の型と切断旗だけ）と
完全署名（parity-identity-simple-cycle-boundary-arc-decomposition。解あり）
の間に次の四変種を置き、内部頂点のどの所属情報が必要かを切り分ける。

interior_d: 型・切断旗に、四スロット（名前順）の D 所属を加える。
interior_c: 型・切断旗に、四スロットの C 所属を加える。
interior_dc: 型・切断旗に、四スロットの D 所属と C 所属の両方を加える。
interior_orient: 型を四スロットの E 所属（名前順）へ置き換える
    （曲がり/直進では落ちる向きの情報だけを戻し、D/C 所属は落としたまま）。

各変種で、直接衝突（圧縮弧型の多重集合の偶奇が等しく頂点項が異なる
鍵対）の有無と、合同の F_2 線型系の可解性を判定する。

四変種の一括実行は 446 秒で終わる（実測 2026-09-05）。以前は上流の検算の
assertion を読み込みのたびに再実行し、さらに合同系の行を列を全て並べた組で
作っていたため、1 tick の締切に収まらなかった。
環境変数 ISING_INTERIOR_VARIANT に変種名を与えると、その一変種だけを
実行する（与えなければ全変種を順に実行する）。観測値は EXPECTED_RESULTS に
固定してあり、実行した変種について一致を assert する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

import os

load("sagemath/check/parity-identity-simple-cycle-arc-signature-compression/construction.sage")


def interior_step(signature, keep_d, keep_c, keep_orient):
    memberships, wrap_flags = signature
    if keep_orient:
        turn = tuple(in_single for _, _, in_single, _ in memberships)
    else:
        turn = signature_turn_type(signature)
    extras = []
    if keep_d:
        extras.append(tuple(in_doubled for _, in_doubled, _, _ in memberships))
    if keep_c:
        extras.append(tuple(in_chosen for _, _, _, in_chosen in memberships))
    return (turn, wrap_flags, tuple(extras))


def make_interior_compressor(keep_d, keep_c, keep_orient):
    def compressor(kind, word, endpoints=None):
        steps = tuple(interior_step(signature, keep_d, keep_c, keep_orient)
                      for signature in word)
        if kind == "cycle":
            assert endpoints is None
            return ("cycle", cyclic_reversal_invariant_word(steps))
        assert endpoints is not None
        return ("arc", reversal_invariant_word(steps), endpoints)
    return compressor


VARIANTS = (
    ("interior_d", make_interior_compressor(True, False, False)),
    ("interior_c", make_interior_compressor(False, True, False)),
    ("interior_dc", make_interior_compressor(True, True, False)),
    ("interior_orient", make_interior_compressor(False, False, True)),
)


# 各変種の (型の種数, 階数, 直接衝突数, 可解性)。観測直後に固定する。
# interior_d の三つ組は、疎な行の作り方へ変える前の実行が記録した値と一致した。
EXPECTED_RESULTS = {
    "interior_d": (10059, 6760, 25, False),
    "interior_c": (10030, 6740, 48, False),
    "interior_dc": (10075, 6776, 16, False),
    "interior_orient": (10061, 6771, 16, False),
}

selected_variant = os.environ.get("ISING_INTERIOR_VARIANT")
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
    # 行は「弧型ごとの個数の偶奇」である。零でない成分は高々その鍵の弧の本数しかないので、
    # 台（奇数回現れる弧型の集合）だけを作る。列を全て並べた組を鍵ごとに作ると
    # 7,085 行 × 約 1 万列の Python の演算になり、四変種で 30 分を超えた（実測 2026-09-05）。
    # F_2 上の行は台で一意に決まるので、直接衝突の判定にも台をそのまま使える。
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
    # 変種ごとに書き出して流す。ログへ落として走らせたとき、途中で打ち切られても
    # そこまでの観測が残る（実測 2026-09-05: 打ち切られた実行の interior_d の観測は
    # 流していなかったため取り出せなかった）。
    print("VARIANT %s: types=%d rank=%d direct-conflicts=%d solvable=%s"
          % (variant_name, len(all_types), rank, conflicts, solvable), flush=True)
    assert variant_results[variant_name] == EXPECTED_RESULTS[variant_name], \
        (variant_name, variant_results[variant_name])

assert len(joint_keys) == 7085
print("OBSERVED: %s" % {name: values
                        for name, values in sorted(variant_results.items())})

# 実行した変種は、どれも直接衝突を持ち、合同の線型系に解が無い。
for variant_name, (_, _, conflicts, solvable) in sorted(variant_results.items()):
    assert conflicts > 0
    assert not solvable

print("PASS: 内部頂点へ D 所属・C 所属・その両方・スロット名つき向きのどれを戻しても、"
      "圧縮弧型の多重集合の偶奇では頂点項を書けない（四変種とも直接衝突があり合同系は非可解）。"
      "従って必要なのは向きと所属を同時に保つ完全署名との残差である")
