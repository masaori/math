# 対象ラベル: claim_walk_twist_sign_product
# 有限な辺列を二つの切断線偶奇の列で表し、ねじれ符号の積が
# 全体の横・縦偶奇だけで決まることを整数の厳密計算で検査する。

from itertools import product
from math import prod


def sign(parity):
    return -1 if parity % 2 else 1


checks = 0
for length in range(0, 9):
    for crossings in product(product((0, 1), repeat=2), repeat=length):
        h = sum(horizontal for horizontal, _ in crossings) % 2
        v = sum(vertical for _, vertical in crossings) % 2
        for a, b in product((0, 1), repeat=2):
            lhs = prod(sign(a * horizontal + b * vertical)
                       for horizontal, vertical in crossings)
            rhs = sign(a * h + b * v)
            assert lhs == rhs
            checks += 1

print(f"OK: claim_walk_twist_sign_product — 長さ 0 から 8 の全切断線偶奇列で {checks} 件を厳密検査した")
