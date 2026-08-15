# 章「逆写像の局所性」の反例（5 元舞台、局所真理値表 g = 初等 CA 規則 45）を、
# 構造化記述の定義どおりに有限集合の写像として作る共通定義。
# 剰余類の演算は使わず、ℓ, r は本文の表どおりに与える。
# 帰属: 有限集合の等号だけを使う。R/C 脱出なし。

from itertools import product

V = (0, 1, 2, 3, 4)
A = (0, 1)
LEFT = {0: 4, 1: 0, 2: 1, 3: 2, 4: 3}       # ℓ(v)
RIGHT = {0: 1, 1: 2, 2: 3, 3: 4, 4: 0}      # r(v)
NEIGHBORHOOD = {v: frozenset((LEFT[v], v, RIGHT[v])) for v in V}

# g(a,b,c) の表（本文の表と同じ並び 000,001,...,111）
G_TABLE = {
    (0, 0, 0): 1, (0, 0, 1): 0, (0, 1, 0): 1, (0, 1, 1): 1,
    (1, 0, 0): 0, (1, 0, 1): 1, (1, 1, 0): 0, (1, 1, 1): 0,
}


def g(a, b, c):
    return G_TABLE[(a, b, c)]


def all_configurations():
    """A^V の全 32 配位を、5 文字の列と同じ順（辞書式）で列挙する。"""
    return [tuple(bits) for bits in product(A, repeat=len(V))]


def global_map(y):
    """(F y)(v) = g(y(ℓ(v)), y(v), y(r(v)))。"""
    return tuple(g(y[LEFT[v]], y[v], y[RIGHT[v]]) for v in V)


def flip(u, z):
    """一点反転写像 φ_u: u の位置の値だけを入れ替える（A は 2 元集合）。"""
    return tuple((1 - z[w]) if w == u else z[w] for w in V)


def as_string(y):
    return "".join(str(b) for b in y)


def from_string(s):
    return tuple(int(ch) for ch in s)


def inverse_table():
    """F の像の表を右から左へ読んで F^{-1} の表を作る（単射性は別ファイルで検査する）。"""
    table = {}
    for y in all_configurations():
        z = global_map(y)
        assert z not in table, "F is not injective: collision at {}".format(as_string(z))
        table[z] = y
    return table
