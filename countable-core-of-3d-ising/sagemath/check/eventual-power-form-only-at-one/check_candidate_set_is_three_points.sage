# 式ペア: 絞り込みで残る正の有理点は q ∈ {1/2, 1, 2} の三つに限られる。
# 帰属: QQ。候補集合が三点であることと、束ね主張が扱う場合分けがこの三点で尽きることを確かめる。
load("_prelude.sage")
assert len(CANDIDATE_POINTS) == 3
assert QQ(1) / QQ(2) in CANDIDATE_POINTS
assert QQ(1) in CANDIDATE_POINTS
assert QQ(2) in CANDIDATE_POINTS
for q in CANDIDATE_POINTS:
    assert q > 0
    # 分母 2 の有理点は 1/2 だけ、正の整数の有理点は 1 と 2 だけである。
    assert q.denominator() in [ZZ(1), ZZ(2)]
    if q.denominator() == ZZ(2):
        assert q.numerator() == ZZ(1)
    else:
        assert q.numerator() in [ZZ(1), ZZ(2)]
print("RESULT: PASS")
