# 対象ラベル: claim_signed_even_subgraph_rational_sign
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

for q in (QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(3)/4, QQ(9)/10):
    assert 0 < q < 1
    r = q^2 + 2*q - 1
    assert r != 0
    assert (q + 1)^2 == q^2 + 2*q + 1
    assert q^2 + 2*q + 1 == r + 2
    assert 1 + q^2 > 0
    assert 1 + 2*q - q^2 == (1 - q^2) + 2*q
    assert 1 + 2*q - q^2 > 0
    assert 1 - 2*q - q^2 == -r
