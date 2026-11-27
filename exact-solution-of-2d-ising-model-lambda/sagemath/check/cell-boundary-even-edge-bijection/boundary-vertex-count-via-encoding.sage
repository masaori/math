# 本文「穴のないセル集合の部分集合と偶辺集合は境界で一対一に対応する」の証明の、
# 境界の各頂点に接する辺の本数が偶数であることを示す二行の検算。
# 境界は格子点の二元集合で持ち、符号化辺 (d,r,c) の端点集合 end を本文の定義どおりに作る。
from itertools import combinations


def end(e):
    d, r, c = e
    return frozenset({(r, c), (r, c + 1)}) if d == 0 else frozenset({(r, c), (r + 1, c)})


def cell_edges(p):
    r, c = p
    return {frozenset({(r, c), (r, c + 1)}), frozenset({(r + 1, c), (r + 1, c + 1)}),
            frozenset({(r, c), (r + 1, c)}), frozenset({(r, c + 1), (r + 1, c + 1)})}


def boundary(T):
    edges = set().union(*(cell_edges(p) for p in T)) if T else set()
    out = set()
    for g in edges:
        (a, b) = sorted(g)
        if a[0] == b[0]:  # 横辺 {(r,c),(r,c+1)}: 上下のセル (r,c),(r-1,c)
            r, c = a
            if ((r, c) in T) != ((r - 1, c) in T):
                out.add(g)
        else:  # 縦辺 {(r,c),(r+1,c)}: 左右のセル (r,c),(r,c-1)
            r, c = a
            if ((r, c) in T) != ((r, c - 1) in T):
                out.add(g)
    return out


box = [(r, c) for r in range(3) for c in range(3)]
codes = [(d, r, c) for d in (0, 1) for r in range(-1, 5) for c in range(-1, 5)]
checked = 0
for size in range(len(box) + 1):
    for choice in combinations(box, size):
        T = set(choice)
        B = boundary(T)
        A = {e for e in codes if end(e) in B}
        # end は A から B への全単射
        assert len({end(e) for e in A}) == len(A) and {end(e) for e in A} == B
        for r in range(-1, 5):
            for c in range(-1, 5):
                v = (r, c)
                two_point = sum(1 for g in B if v in g)
                encoded = sum(1 for e in A if v in end(e))
                four = sum(e in A for e in ((0, r, c), (0, r, c - 1), (1, r, c), (1, r - 1, c)))
                assert two_point == encoded == four
                assert two_point % 2 == 0
        checked += 1
print(f"PASS: {checked} cell sets; vertex counts agree via encoding and are even")
