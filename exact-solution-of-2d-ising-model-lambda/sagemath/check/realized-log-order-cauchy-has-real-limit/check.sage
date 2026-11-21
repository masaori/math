from sage.all import QQ, RIF

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
