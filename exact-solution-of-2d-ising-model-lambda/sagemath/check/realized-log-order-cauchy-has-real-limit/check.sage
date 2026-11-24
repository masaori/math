from sage.all import QQ, RIF, ZZ, factor

# 0 <= e = iota(ell_2): the chain 0 = iota(0) = iota(log 1) <= iota(log 2) = iota(ell_2).
def log_vector(q):
    q = QQ(q)
    assert q > 0
    vec = {}
    for p, k in factor(q.numerator()):
        vec[p] = vec.get(p, 0) + k
    for p, k in factor(q.denominator()):
        vec[p] = vec.get(p, 0) - k
    return {p: QQ(k) / 1 for p, k in vec.items() if k != 0}

assert log_vector(1) == {}                 # log 1 = 0 (claim_log_power, k = 0)
assert QQ(1) <= QQ(2)                       # the hypothesis moved by claim_rational_embedded_log_order_iff
assert log_vector(2) == {ZZ(2): QQ(1)}      # log 2 = ell_2 (2 is prime)

# A one-generator exact sample of the realization and its Cauchy bounds.
c = RIF(2).log()
assert c.lower() > 0
for r in [QQ(1) / 2, QQ(1) / 5, QQ(3) / 10]:
    eta = r
    assert eta > 0
    realized_eta = RIF(r) * c
    assert realized_eta.lower() > 0
    for l in range(10, 16):
        for m in range(10, 16):
            diff = QQ(1) / l - QQ(1) / m
            if -eta <= diff <= eta:
                realized_diff = RIF(diff) * c
                assert realized_diff.lower() >= -realized_eta.upper()
                assert realized_diff.upper() <= realized_eta.upper()
print("PASS: exact one-generator order bounds and interval realization")
