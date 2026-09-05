"""語長 2 の二次式解の係数構造の調査。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-one-quadratic-solution/construction.sage")


def length_two_feature_bits(arc_type):
    """語長 2 の弧型（kind = arc）の特徴ビット列。

    二つのステップ（反転正準化した語順）の向き（スロット名順の E 所属）・
    切断旗・D 所属に、両端点（切断頂点。正準順の対）の完全署名
    （スロット名順の D/E/C 所属と切断旗）を平坦に並べる。順序は決定的である。
    ビット数は 12 × 2 + 16 × 2 = 56。
    """
    kind, steps = arc_type[0], arc_type[1]
    assert kind == "arc"
    assert len(steps) == 2
    bits = []
    for orientation, kept_wrap, extras in steps:
        bits.extend(list(orientation) + list(kept_wrap) + list(extras[0]))
    for endpoint in arc_type[2]:
        memberships, wrap_flags = endpoint
        for _, in_doubled, in_single, in_chosen in memberships:
            bits.extend([in_doubled, in_single, in_chosen])
        bits.extend(list(wrap_flags))
    return tuple(ZZ(bit) for bit in bits)


def length_two_feature_names():
    """length_two_feature_bits と同じ順序の特徴名の列。"""
    slots = ("up", "down", "left", "right")
    wraps = ("row0", "rowlast", "col0", "collast")
    names = []
    for step in ("step0", "step1"):
        names += ["%s_e_%s" % (step, slot) for slot in slots]
        names += ["%s_wrap_%s" % (step, wrap) for wrap in wraps]
        names += ["%s_d_%s" % (step, slot) for slot in slots]
    for endpoint in ("end0", "end1"):
        for slot in slots:
            for kind in ("d", "e", "c"):
                names.append("%s_%s_%s" % (endpoint, kind, slot))
        names += ["%s_wrap_%s" % (endpoint, wrap) for wrap in wraps]
    return tuple(names)
