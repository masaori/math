# 対象ラベル: claim_rational_power_base_den_two_exponent_balance
# 本文の仮定を満たす有限な整数標本。
CASES = [
    (ZZ(1), ZZ(2), ZZ(1), ZZ(2), ZZ(1), ZZ(1), ZZ(1)),
    (ZZ(1), ZZ(4), ZZ(1), ZZ(2), ZZ(1), ZZ(2), ZZ(1)),
    (ZZ(1), ZZ(4), ZZ(1), ZZ(2), ZZ(2), ZZ(3), ZZ(2)),
    (ZZ(5), ZZ(12), ZZ(3), ZZ(4), ZZ(11664), ZZ(2), ZZ(4)),
]

def check_assumptions(a, b, u, v, P, point_count, edge_count):
    assert min(a, b, u, v, P, point_count, edge_count) > 0
    assert gcd(a, b) == 1
    assert gcd(u, v) == 1
    assert v % 2 == 0
    assert P * v ** point_count == u ** point_count * b ** edge_count

for case in CASES:
    check_assumptions(*case)
