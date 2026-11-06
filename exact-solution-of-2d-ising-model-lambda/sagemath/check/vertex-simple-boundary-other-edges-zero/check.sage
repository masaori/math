# 対象ラベル: claim_vertex_simple_boundary_other_edges_zero
# 二つの標識付き端点寄与が全体の二を占める場合を整数で検算する。
from itertools import product

for length in range(1, 7):
    for contributions in product((0, 1, 2), repeat=length):
        for incoming in range(length):
            for outgoing in range(length):
                used = [0] * length
                used[incoming] += 1
                used[outgoing] += 1
                if any(used[j] > contributions[j] for j in range(length)):
                    continue
                if sum(contributions) != 2:
                    continue
                assert all(contributions[j] == 0 for j in range(length)
                           if j != incoming and j != outgoing)

print("pass: two labelled endpoint contributions exhaust a total of two")
