"""partial D で切った弧の署名圧縮で頂点項の分解が保たれるかを検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-boundary-arc-decomposition では、弧ごとの
頂点署名の完全な列を弧型とすれば、一辺二・三の全 7,085 鍵の頂点項が
弧型ごとの値の和として書けることを確定した。ここではその弧型を粗い
統計へ圧縮しても分解が保たれるかを、三段の圧縮水準で判定する。

counts: 弧の長さ・曲がり型頂点の個数・切断旗の総数・両端頂点の
    完全署名の対。
turnword: 曲がり/直進の型を閉路順に並べた列（反転同一視）・
    切断旗の総数・両端頂点の完全署名の対。
turnwrapword: 型と切断旗を頂点ごとに並べた列（反転同一視）・
    両端頂点の完全署名の対。

各水準で、直接衝突（圧縮弧型の多重集合の偶奇が等しく頂点項が異なる
鍵対）の有無と、合同の F_2 線型系の可解性を判定する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-boundary-arc-decomposition/check.sage")


def signature_turn_type(signature):
    memberships, _ = signature
    names = tuple(name for name, _, in_single, _ in memberships
                  if in_single == 1)
    assert len(names) == 2
    if set(names) in ({"up", "down"}, {"left", "right"}):
        return "straight"
    return "curved"


def signature_wrap_total(signature):
    _, wrap_flags = signature
    return sum(ZZ(flag) for flag in wrap_flags)


def compress_counts(kind, word, endpoints=None):
    curved = sum(1 for signature in word
                 if signature_turn_type(signature) == "curved")
    wraps = sum(signature_wrap_total(signature) for signature in word)
    if kind == "cycle":
        assert endpoints is None
        return ("cycle", len(word), ZZ(curved), ZZ(wraps))
    assert endpoints is not None
    return ("arc", len(word), ZZ(curved), ZZ(wraps), endpoints)


def compress_turnword(kind, word, endpoints=None):
    turns = tuple(signature_turn_type(signature) for signature in word)
    wraps = sum(signature_wrap_total(signature) for signature in word)
    if kind == "cycle":
        assert endpoints is None
        return ("cycle", cyclic_reversal_invariant_word(turns), ZZ(wraps))
    assert endpoints is not None
    return ("arc", reversal_invariant_word(turns), ZZ(wraps),
            endpoints)


def compress_turnwrapword(kind, word, endpoints=None):
    steps = tuple((signature_turn_type(signature), signature[1])
                  for signature in word)
    if kind == "cycle":
        assert endpoints is None
        return ("cycle", cyclic_reversal_invariant_word(steps))
    assert endpoints is not None
    return ("arc", reversal_invariant_word(steps), endpoints)


COMPRESSIONS = (
    ("counts", compress_counts),
    ("turnword", compress_turnword),
    ("turnwrapword", compress_turnwrapword),
)


def compressed_arc_types(side, doubled, single, compressor):
    chosen = key_selector(side, doubled, single)
    vertices = cycle_vertex_order(side, single)
    words = tuple(
        selector_vertex_signature(side, vertex, doubled, single, chosen)
        for vertex in vertices)
    boundary = boundary_vertices(side, doubled)
    assert boundary.issubset(set(vertices))
    if not boundary:
        return (compressor("cycle", words),)
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
        arcs.append(compressor("arc", word, endpoints))
    return tuple(arcs)


results = {}
for level_name, compressor in COMPRESSIONS:
    type_lists = []
    for side, doubled, single, _ in joint_keys:
        type_lists.append(
            compressed_arc_types(side, doubled, single, compressor))
    all_types = sorted({arc_type for types in type_lists
                        for arc_type in types})
    rows = []
    row_records = {}
    conflicts = 0
    for (side, doubled, single, term), types in zip(joint_keys, type_lists):
        row = tuple(GF(2)(types.count(arc_type)) for arc_type in all_types)
        rows.append(row)
        if row in row_records and row_records[row] != term:
            conflicts += 1
        elif row not in row_records:
            row_records[row] = term
    level_matrix = matrix(GF(2), rows)
    level_vector = vector(GF(2), [term for _, _, _, term in joint_keys])
    try:
        level_matrix.solve_right(level_vector)
        solvable = True
    except ValueError:
        solvable = False
    rank = level_matrix.rank()
    results[level_name] = (len(all_types), rank, conflicts, solvable)
    print("LEVEL %s: types=%d rank=%d direct-conflicts=%d solvable=%s"
          % (level_name, len(all_types), rank, conflicts, solvable))

assert len(joint_keys) == 7085
assert results == {
    "counts": (8890, 5898, 243, False),
    "turnword": (9225, 6198, 160, False),
    "turnwrapword": (9998, 6708, 65, False),
}
print("OBSERVED: %s" % {name: tuple(int(v) if v in (True, False) else int(v)
                                    for v in values)
                        for name, values in sorted(results.items())})
print("PASS: 三水準の圧縮はいずれも直接衝突を持ち、頂点項を弧型ごとの"
      "値の和として書く合同線型系も解を持たない")
