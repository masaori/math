"""標準接触対が平滑化で不変で、標準対での平滑化が不動点の無い対合であることを厳密検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/contact-smoothing-same-pair-involution/construction.sage")


def text_edge_key(edge):
    """本文 def_standard_contact_pair の順序: (辺の番号, 向き) の辞書式。

    def_lattice の番号は n_h(i,j) = L*i + j + 1、n_v(i,j) = L^2 + L*i + j + 1。
    """
    kind, i, j, direction = edge
    number = L * i + j + 1
    if kind == "v":
        number += L * L
    return (ZZ(number), ZZ(direction))


def pair_key(pair):
    """二元部分集合の順序: (最小元, 最大元) の辞書式（ソート済みタプルの比較と一致する）。"""
    return tuple(sorted(text_edge_key(edge) for edge in pair))


def contact_pairs(phi):
    """Ct(phi): 動く辺の二元部分集合で終点が一致するもの（切り替え可能性は要求しない）。"""
    moved = [edge for edge in oriented if phi[edge] != edge]
    pairs = set()
    for i in range(len(moved)):
        for j in range(i + 1, len(moved)):
            if endpoints(L, moved[i])[1] == endpoints(L, moved[j])[1]:
                pairs.add(frozenset((moved[i], moved[j])))
    return pairs


def ct_min(phi):
    pairs = contact_pairs(phi)
    assert pairs
    return min(pairs, key=pair_key)


def doubled_and_single_sets(phi):
    moved = moved_edges(phi)
    support = {(kind, i, j) for kind, i, j, unused_direction in moved}
    doubled = {base for base in support
               if (base[0], base[1], base[2], 0) in moved
               and (base[0], base[1], base[2], 1) in moved}
    return doubled, support.difference(doubled)
