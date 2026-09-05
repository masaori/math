"""語長 1 の弧型の支持台の規則の調査。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-support/construction.sage")


def length_one_feature_bits(arc_type):
    """語長 1 の弧型（kind = arc）の特徴ビット列。

    単一ステップの向き（スロット名順の E 所属）・切断旗・D 所属に、
    両端点（切断頂点）の完全署名（スロット名順の D/E/C 所属と切断旗）を
    平坦に並べる。順序は決定的である。
    """
    kind, steps = arc_type[0], arc_type[1]
    assert kind == "arc"
    assert len(steps) == 1
    orientation, kept_wrap, extras = steps[0]
    bits = list(orientation) + list(kept_wrap) + list(extras[0])
    for endpoint in arc_type[2]:
        memberships, wrap_flags = endpoint
        for _, in_doubled, in_single, in_chosen in memberships:
            bits.extend([in_doubled, in_single, in_chosen])
        bits.extend(list(wrap_flags))
    return tuple(ZZ(bit) for bit in bits)


def affine_f2_fit(feature_rows, values):
    """定数項つきの F_2 一次式で values を書けるかを判定する。

    戻り値は (直接衝突の件数, 係数行列の階数, 可解か)。直接衝突とは、
    同じ特徴ビット列に異なる値が割り当たっている特徴列の種数である。
    """
    seen = {}
    for features, value in zip(feature_rows, values):
        seen.setdefault(features, set()).add(value)
    collisions = sum(1 for values_seen in seen.values() if len(values_seen) > 1)
    system_matrix = matrix(GF(2), [(1,) + features for features in feature_rows])
    rank = system_matrix.rank()
    try:
        system_matrix.solve_right(vector(GF(2), values))
        solvable = True
    except ValueError:
        solvable = False
    return collisions, rank, solvable


def degree_two_features(features):
    """特徴ビット列に、相異なる二成分の積を全て加えた列。"""
    extended = list(features)
    count = len(features)
    for first in range(count):
        for second in range(first + 1, count):
            extended.append(features[first] * features[second])
    return tuple(extended)
