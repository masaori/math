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

上流検算の読み込み（実測 13 分）を変種の実行ごとにやり直すと 1 tick の
締切に収まらない（実測 2026-09-05）。そこで鍵ごとの弧の生の署名語
（圧縮前の頂点署名列・切断頂点の署名対・頂点項）を一度だけ計算し、
ARC_WORDS_CACHE_PATH へ保存する。キャッシュがあれば上流を読み込まずに
それを使う。キャッシュは check.sage 自身が同じコードで再生成するので、
上流の検算を変更したらキャッシュを削除して作り直すこと（overview 参照）。
キャッシュ経路の正しさは、観測済み変種の EXPECTED_RESULTS への一致
assert が検査する（値は上流を読み込む経路で観測したものである）。

環境変数 ISING_INTERIOR_VARIANT に変種名を与えると、その一変種だけを
実行する（与えなければ全変種を順に実行する）。観測済みの変種は
EXPECTED_RESULTS に固定し、再実行時に一致を assert する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

import os

ARC_WORDS_CACHE_PATH = (
    "sagemath/check/parity-identity-simple-cycle-arc-interior-membership/"
    "arc-words-cache.sobj")


def plain_signature(signature):
    memberships, wrap_flags = signature
    return (tuple((str(name), int(in_doubled), int(in_single), int(in_chosen))
                  for name, in_doubled, in_single, in_chosen in memberships),
            tuple(int(flag) for flag in wrap_flags))


def raw_arc_words(side, doubled, single):
    # compressed_arc_types（arc-signature-compression）と同じ切り方で、
    # 圧縮を施す前の生の署名語を返す。語は閉路順のまま保存する
    # （反転同一視は圧縮後の列に対して行うので、ここで正規化してはならない）。
    chosen = key_selector(side, doubled, single)
    vertices = cycle_vertex_order(side, single)
    words = tuple(
        plain_signature(
            selector_vertex_signature(side, vertex, doubled, single, chosen))
        for vertex in vertices)
    boundary = boundary_vertices(side, doubled)
    assert boundary.issubset(set(vertices))
    if not boundary:
        return (("cycle", words, None),)
    cuts = [index for index, vertex in enumerate(vertices)
            if vertex in boundary]
    arcs = []
    for position, begin in enumerate(cuts):
        end = cuts[(position + 1) % len(cuts)]
        if begin < end:
            word = words[begin:end]
        else:
            word = words[begin:] + words[:end]
        assert word
        endpoints = min((words[begin], words[end]),
                        (words[end], words[begin]))
        arcs.append(("arc", word, endpoints))
    return tuple(arcs)


if os.path.exists(ARC_WORDS_CACHE_PATH):
    cached_records = load(ARC_WORDS_CACHE_PATH)
    print("CACHE: %d 鍵の弧署名語を %s から読み込んだ"
          % (len(cached_records), ARC_WORDS_CACHE_PATH))
else:
    load("sagemath/check/parity-identity-simple-cycle-arc-signature-compression/check.sage")
    cached_records = tuple(
        (int(side), tuple(sorted(doubled)), tuple(sorted(single)), int(term),
         raw_arc_words(side, doubled, single))
        for side, doubled, single, term in joint_keys)
    save(cached_records, ARC_WORDS_CACHE_PATH)
    print("CACHE: %d 鍵の弧署名語を %s へ保存した"
          % (len(cached_records), ARC_WORDS_CACHE_PATH))

assert len(cached_records) == 7085


def word_reversal_invariant(word):
    reversed_word = tuple(reversed(word))
    return min(word, reversed_word)


def word_cyclic_reversal_invariant(word):
    candidates = []
    for oriented in (word, tuple(reversed(word))):
        for offset in range(len(oriented)):
            candidates.append(oriented[offset:] + oriented[:offset])
    return min(candidates)


def plain_turn_type(signature):
    memberships, _ = signature
    names = tuple(name for name, _, in_single, _ in memberships
                  if in_single == 1)
    assert len(names) == 2
    if set(names) in ({"up", "down"}, {"left", "right"}):
        return "straight"
    return "curved"


def interior_step(signature, keep_d, keep_c, keep_orient):
    memberships, wrap_flags = signature
    if keep_orient:
        turn = tuple(in_single for _, _, in_single, _ in memberships)
    else:
        turn = plain_turn_type(signature)
    extras = []
    if keep_d:
        extras.append(tuple(in_doubled for _, in_doubled, _, _ in memberships))
    if keep_c:
        extras.append(tuple(in_chosen for _, _, _, in_chosen in memberships))
    return (turn, wrap_flags, tuple(extras))


def compress_record_arcs(arcs, keep_d, keep_c, keep_orient):
    compressed = []
    for kind, word, endpoints in arcs:
        steps = tuple(interior_step(signature, keep_d, keep_c, keep_orient)
                      for signature in word)
        if kind == "cycle":
            assert endpoints is None
            compressed.append(("cycle", word_cyclic_reversal_invariant(steps)))
        else:
            assert endpoints is not None
            compressed.append(
                ("arc", word_reversal_invariant(steps), endpoints))
    return tuple(compressed)


VARIANTS = (
    ("interior_d", (True, False, False)),
    ("interior_c", (False, True, False)),
    ("interior_dc", (True, True, False)),
    ("interior_orient", (False, False, True)),
)


# 観測済みの変種の (型の種数, 階数, 直接衝突数, 可解性)。観測直後に固定する。
EXPECTED_RESULTS = {
    "interior_d": (10059, 6760, 25, False),
}

selected_variant = os.environ.get("ISING_INTERIOR_VARIANT")
if selected_variant is not None:
    names = tuple(name for name, _ in VARIANTS)
    assert selected_variant in names, selected_variant

variant_results = {}
for variant_name, (keep_d, keep_c, keep_orient) in VARIANTS:
    if selected_variant is not None and variant_name != selected_variant:
        continue
    type_lists = tuple(
        compress_record_arcs(arcs, keep_d, keep_c, keep_orient)
        for _, _, _, _, arcs in cached_records)
    all_types = sorted({arc_type for types in type_lists
                        for arc_type in types})
    type_index = {arc_type: position
                  for position, arc_type in enumerate(all_types)}
    rows = []
    row_records = {}
    conflicts = 0
    for (_, _, _, term, _), types in zip(cached_records, type_lists):
        row_bits = [0] * len(all_types)
        for arc_type in types:
            position = type_index[arc_type]
            row_bits[position] = 1 - row_bits[position]
        row = tuple(row_bits)
        rows.append(row)
        if row in row_records and row_records[row] != term:
            conflicts += 1
        elif row not in row_records:
            row_records[row] = term
    variant_matrix = matrix(GF(2), rows)
    variant_vector = vector(
        GF(2), [term for _, _, _, term, _ in cached_records])
    try:
        variant_matrix.solve_right(variant_vector)
        solvable = True
    except ValueError:
        solvable = False
    rank = variant_matrix.rank()
    variant_results[variant_name] = (len(all_types), rank, conflicts, solvable)
    print("VARIANT %s: types=%d rank=%d direct-conflicts=%d solvable=%s"
          % (variant_name, len(all_types), rank, conflicts, solvable))
    if variant_name in EXPECTED_RESULTS:
        assert variant_results[variant_name] == EXPECTED_RESULTS[variant_name], \
            (variant_name, variant_results[variant_name])

print("OBSERVED: %s" % {name: values
                        for name, values in sorted(variant_results.items())})
