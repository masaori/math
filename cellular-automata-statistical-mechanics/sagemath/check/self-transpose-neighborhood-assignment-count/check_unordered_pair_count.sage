# 対象ラベル: claim_unordered_carrier_pair_count
# |U(V)| = n + C(n,2) = n(n+1)/2 を全数検査する。本文の証明の各段を分けて検査する。
#   U(V) は一元部分集合全体と二元部分集合全体の非交和である
#   一元部分集合は v ↦ {v} により V と全単射で n 個
#   二元部分集合は C(n,2) 個
#   n + C(n,2) = n + n(n-1)/2 = (2n + n(n-1))/2 = n(n+1)/2
#   n(n+1) は連続する二自然数の積なので偶数
# 帰属: 有限集合と自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

for size in range(0, 8):
    cells = tuple(range(size))
    n = ZZ(size)
    U = unordered_pairs(cells)

    singletons = frozenset(pair for pair in U if len(pair) == 1)
    doubletons = frozenset(pair for pair in U if len(pair) == 2)

    # 第一段: 非交和である
    assert singletons | doubletons == U
    assert len(singletons & doubletons) == 0

    # 第二段: 一元部分集合は v ↦ {v} により V と全単射
    image = frozenset(frozenset((v,)) for v in cells)
    assert image == singletons
    assert len(image) == n
    assert ZZ(len(singletons)) == n

    # 第三段: 二元部分集合は C(n,2) 個
    assert ZZ(len(doubletons)) == binomial(n, 2)

    # 第四段: 非交和の個数
    assert ZZ(len(U)) == n + binomial(n, 2)
    # 第五段: 二項係数の定義
    assert n + binomial(n, 2) == n + (n * (n - 1)) / 2
    # 第六段: 通分
    assert n + (n * (n - 1)) / 2 == (2 * n + n * (n - 1)) / 2
    # 第七段: 分配律
    assert (2 * n + n * (n - 1)) / 2 == (n * (n + 1)) / 2
    # 第八段: n(n+1) は偶数であり、商は自然数
    assert (n * (n + 1)) % 2 == 0
    assert (n * (n + 1)) / 2 in ZZ
    assert ZZ(len(U)) == (n * (n + 1)) / 2

print("PASS unordered_pair_count sizes=0..7")
