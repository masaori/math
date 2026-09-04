"""partial D で切った弧の署名圧縮で頂点項の分解が保たれるかを検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-boundary-arc-decomposition/construction.sage")

def signature_turn_type(signature):
    memberships, _ = signature
    names = tuple(name for name, _, in_single, _ in memberships
                  if in_single == 1)
    assert len(names) == 2
    if set(names) in ({"up", "down"}, {"left", "right"}):
        return "straight"
    return "curved"


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
