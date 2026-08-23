# SageMath: 双曲正則型の面次数が三以上であることを厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_degree_lower_bounds
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-degree-lower-bounds/_prelude.sage")

for data in examples:
    p = data["p"]
    q = data["q"]
    assert is_hyperbolic(p, q)
    assert 3 <= p

for p in (NN(1), NN(2)):
    for q in srange(NN(1), NN(21)):
        assert p * q <= 2 * q
        assert 2 * q < 2 * p + 2 * q
        assert not is_hyperbolic(p, q)

print("RESULT: PASS — every checked hyperbolic regular type has face degree at least three")
