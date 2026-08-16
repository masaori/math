# 章「依存台による局所規則の表現」の検算の共通定義。
# 有限集合 V = {0,...,n-1}、A = {0,1}、写像 g: A^V → A を真理値表（タプル → 値の辞書）で表す。
# A^S と A^V の行き来は、構造化記述どおり制限写像 ρ^V_S と基準値延長写像 ι^V_S の 2 本だけを通す。
# 帰属: 有限集合の等号と非負整数の大小比較だけ。R/C 脱出なし。

from itertools import product

A = (0, 1)


def configurations(cells):
    """A^cells の全配位。cells はソート済みタプル。配位は cells の並びに沿った値のタプル。"""
    return [tuple(bits) for bits in product(A, repeat=len(cells))]


def restrict(cells, subset, y):
    """ρ^V_S y: V 上の配位 y を S ⊆ V へ制限する（S はソート済みタプル）。"""
    index = {c: i for i, c in enumerate(cells)}
    return tuple(y[index[c]] for c in subset)


def base_extend(cells, subset, x):
    """ι^V_S x: S 上の配位 x を、S の外を基準値 0 で埋めて V 上の配位にする。"""
    index = {c: i for i, c in enumerate(subset)}
    return tuple(x[index[c]] if c in index else 0 for c in cells)


def flip(cells, u, y):
    """一点反転写像 φ_u: 位置 u の値だけを入れ替える（A は 2 元集合）。"""
    return tuple((1 - y[i]) if c == u else y[i] for i, c in enumerate(cells))


def all_rules(cells):
    """A^V → A の全写像を真理値表として列挙する（2^(2^|V|) 個）。"""
    confs = configurations(cells)
    for values in product(A, repeat=len(confs)):
        yield dict(zip(confs, values))


def support(cells, g):
    """本質的依存台 supp(g) を定義（一点反転による同値）どおりに求める。"""
    return frozenset(u for u in cells if any(g[y] != g[flip(cells, u, y)] for y in configurations(cells)))


def subsets(cells):
    for mask in range(2 ** len(cells)):
        yield tuple(c for i, c in enumerate(cells) if (mask >> i) & 1)


def representable(cells, subset, g):
    """定義どおり: ∃ h: A^S → A, ∀ y, g(y) = h(ρ^V_S y) を、A^S → A の全 h について有限検査で決める。"""
    sub_confs = configurations(subset)
    for values in product(A, repeat=len(sub_confs)):
        h = dict(zip(sub_confs, values))
        if all(g[y] == h[restrict(cells, subset, y)] for y in configurations(cells)):
            return True
    return False
