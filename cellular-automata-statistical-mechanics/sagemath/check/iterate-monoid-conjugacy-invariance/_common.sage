# 章「有限大域写像の共役による安定ファイバー根付き木族の不変性」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属・個数、非負整数の乗算・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-stable-fiber-rooted-tree', '_common.sage'))


def conjugating_bijections(size):
    """配位番号集合 {0,...,size-1} 上の決定的な全単射の族（真理値表）。
    恒等、反転（辞書式順序での全セル値の反転に一致）、先頭 2 元の互換、巡回、互換と巡回の合成。
    重複は取り除く。乱数は使わない。"""
    perms = [tuple(range(size))]
    perms.append(tuple(size - 1 - k for k in range(size)))
    if size >= 2:
        swapped = list(range(size))
        swapped[0], swapped[1] = swapped[1], swapped[0]
        perms.append(tuple(swapped))
        cycle = tuple((k + 1) % size for k in range(size))
        perms.append(cycle)
        perms.append(tuple(perms[2][cycle[k]] for k in range(size)))
    unique = []
    for p in perms:
        if p not in unique:
            unique.append(p)
    return tuple(unique)


def inverse_bijection(h):
    """全単射 h の逆写像の真理値表。"""
    inv = [None] * len(h)
    for k in range(len(h)):
        inv[h[k]] = k
    return tuple(inv)


def conjugate_table(h, table):
    """G := h ∘ F ∘ h^{-1}。定義から h ∘ F = G ∘ h（def_iterate_monoid_conjugacy_bijection）。"""
    h_inv = inverse_bijection(h)
    return tuple(h[table[h_inv[k]]] for k in range(len(table)))


def conjugate_instances():
    """全数対象の各大域写像 F と、各全単射 h、共役 G = h∘F∘h^{-1} を列挙する。"""
    for stage_size, rule, table in exhaustive_instances():
        for h in conjugating_bijections(len(table)):
            yield stage_size, rule, table, h, conjugate_table(h, table)
