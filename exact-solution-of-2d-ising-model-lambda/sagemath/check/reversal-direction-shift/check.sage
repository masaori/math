"""反転が方向番号を二だけ進めること（claim_reversal_direction_shift）を厳密検査する。

L = 1,...,5 の全向き付き辺について dir(ι(e)) ≡ dir(e) + 2 (mod 4) を整数で確かめる。
浮動小数点は使わない。
"""


def edges(L):
    return [(kind, i, j, d) for kind in ("h", "v")
            for i in range(L) for j in range(L) for d in (0, 1)]


def reversal(edge):
    kind, i, j, d = edge
    return (kind, i, j, 1 - d)


def direction(edge):
    kind, _, _, d = edge
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[(kind, d)]


total = 0
for L in range(1, 6):
    for edge in edges(L):
        assert (direction(reversal(edge)) - (direction(edge) + 2)) % 4 == 0
        total += 1

print(f"PASS: L=1,...,5 の全 {total} 向き付き辺で dir(ι(e)) = dir(e) + 2 (mod 4)")
