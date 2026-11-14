# 対象ラベル: claim_edge_set_horizontal_seam_parity_equals_winding_parity
# 対象ラベル: claim_edge_set_vertical_seam_parity_equals_winding_parity
# 辺は (向き, 行の代表, 列の代表)。n_h(i,j) = ("h", s(i), s(j))、n_v(i,j) = ("v", s(i), s(j))。
from itertools import combinations
import random

random.seed(int(20261114))
checked = 0


def residue_rep(y, size):
    # 代表 s(π(y)) ∈ {0, …, size-1}
    return ZZ(y) % size


def subsets(edges, size):
    if size <= 2:
        for k in range(len(edges) + 1):
            for A in combinations(edges, k):
                yield set(A)
    else:
        for _ in range(3000):
            yield {e for e in edges if random.randint(0, 1) == 1}


for size in (1, 2, 3):
    last = residue_rep(-1, size)
    # s(y) = L-1 と y = π(-1) の同値
    for y in range(size):
        assert (y == size - 1) == (y == last)
        checked += 1
    edges = [(side, r, c) for side in ("h", "v") for r in range(size) for c in range(size)]
    seam = {
        "h": [("h", i, last) for i in range(size)],
        "v": [("v", last, j) for j in range(size)],
    }

    def c_ind(side, e):
        if side == "h":
            return ZZ(e[0] == "h" and e[2] == size - 1)
        return ZZ(e[0] == "v" and e[1] == size - 1)

    for side in ("h", "v"):
        line = seam[side]
        # 一辺ごとの等式の三行
        for e in edges:
            row_sum = sum(ZZ(e == f) for f in line)
            if side == "h":
                exists_pi = ZZ(any(e == ("h", r, j) and j == last
                                   for r in range(size) for j in range(size)))
                exists_s = ZZ(any(e == ("h", r, j) and j == size - 1
                                  for r in range(size) for j in range(size)))
            else:
                exists_pi = ZZ(any(e == ("v", i, r) and i == last
                                   for i in range(size) for r in range(size)))
                exists_s = ZZ(any(e == ("v", i, r) and i == size - 1
                                  for i in range(size) for r in range(size)))
            assert row_sum == exists_pi
            assert exists_pi == exists_s
            assert exists_s == c_ind(side, e)
            checked += 1
        # 辺部分集合の式鎖の五行
        assert len(set(line)) == len(line)  # 単射
        for A in subsets(edges, size):
            lhs = sum(c_ind(side, e) for e in A) % 2
            step1 = sum(sum(ZZ(e == f) for f in line) for e in A) % 2
            step2 = sum(sum(ZZ(e == f) for e in A) for f in line) % 2
            step3 = sum(ZZ(f in A) for f in line) % 2
            step4 = len(A & set(line)) % 2
            assert lhs == step1 == step2 == step3 == step4
            checked += 1

print(f"PASS: {checked} exact seam/winding parity identities")
