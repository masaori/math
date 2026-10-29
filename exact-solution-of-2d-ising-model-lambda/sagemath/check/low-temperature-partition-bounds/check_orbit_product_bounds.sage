# 対象ラベル: claim_low_temperature_partition_bounds
# 軌道積の具体値で、符号と四項和の両側評価を厳密に検算する。
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

for length in range(1, 4):
    for q in (QQ(1)/10, QQ(1)/3):
        assert 0 < q < 1 and q^2 + 2*q - 1 < 0
        values = []
        for a, b in ((0, 0), (0, 1), (1, 0), (1, 1)):
            _, _, factors, _, _, _ = orbit_products(length, a, b)
            value = prod(factors, R.one())(q)
            assert value.imag() == 0 and value.real() > 0
            values.append(value.real())
        maximum = max(values)
        partition_value = sum(values) / 2
        assert maximum / 2 <= partition_value <= 2 * maximum
print('RESULT: PASS orbit product bounds')
