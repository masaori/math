"""語長三の純二次式から、切断旗を含まない積の一種類を除く有限系。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-joint-localization/construction.sage")


def membership_kind(name):
    """特徴の定義の順序にある D/E/C 所属と切断旗を区別する。"""
    kind = name.split("_")[1]
    assert kind in ("d", "e", "c", "wrap")
    return kind


def pair_membership_kind(names, pair):
    first, second = (membership_kind(names[index]) for index in pair)
    if "wrap" in (first, second):
        return None
    return tuple(sorted((first, second)))


def pure_quadratic_system(entries, rhs, all_types, column_index, types, pairs):
    """語長三の値だけを指定した二次項の和へ結ぶ。残る型の値は自由。"""
    combined = dict(entries)
    start = len(all_types)
    for offset, arc_type in enumerate(types):
        bits = arc_feature_bits(arc_type)
        row = len(rhs) + offset
        combined[(row, column_index[arc_type])] = GF(2)(1)
        for index, (i, j) in enumerate(pairs):
            if bits[i] * bits[j]:
                combined[(row, start + index)] = GF(2)(1)
    return (matrix(GF(2), len(rhs) + len(types), start + len(pairs), combined),
            vector(GF(2), list(rhs) + [0] * len(types)))
