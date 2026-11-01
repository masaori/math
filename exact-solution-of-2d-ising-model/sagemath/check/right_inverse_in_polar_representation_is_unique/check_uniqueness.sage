# 対象ラベル: right_inverse_in_polar_representation_is_unique
# 主張: a = [(r,θ)]（r ≠ 0）について、a·b = e を満たす b ∈ (極座標表現) は c = [(1/r,-θ)] に限る
# 鎖: b = e·b = (c·a)·b = c·(a·b) = c·e = c
#   行 1 (b = e·b)、行 2 (e·b = (c·a)·b)、行 3 ((c·a)·b = c·(a·b))、行 5 (c·e = c) は仮定 a·b = e を使わない。
#   行 4 (c·(a·b) = c·e) だけが仮定 a·b = e を使う。
# r ≠ 0 の各元 a と、(極座標表現) の候補 q の有限集合（標本の全ての元（半径零を含む）、c とその別の代表元、
# c を少しずらしたもの）の全てについて次を確かめる。
#   (1) 主張: 「a·q ~ e」⟺「q ~ c」
#   (2) 仮定を使わない四つの行を、条件を満たさない候補を含む全ての候補で（行 3 は代表元の段でも一致）。
#   (3) 行 4 は、条件を満たす候補で成り立ち、満たさない候補で成り立たないこと（仮定が効いていることの対照）。
load("../../_shared/polar_representation.sage")

total = 0
sat = 0
for a in NONZERO:
    ra, ta = a
    c = (1 / ra, -ta)
    assert polar_equiv(mul_rep(c, a), E)                                  # c·a = e（inverse_in_polar_representation）
    cands = list(SAMPLE) + [c] + other_reps(c) + [(1 / ra, -ta + pi_), (2 / ra, -ta), (1 / ra, ta + pi_)]
    for q in cands:
        ok = polar_equiv(mul_rep(a, q), E)
        assert ok == polar_equiv(q, c)                                    # (1)
        assert polar_equiv(q, mul_rep(E, q))                              # 行 1
        assert polar_equiv(mul_rep(E, q), mul_rep(mul_rep(c, a), q))      # 行 2（c·a = e）
        assert mul_rep(mul_rep(c, a), q) == mul_rep(c, mul_rep(a, q))     # 行 3（代表元の段で一致）
        assert polar_equiv(mul_rep(c, E), c)                              # 行 5
        assert polar_equiv(mul_rep(c, mul_rep(a, q)), mul_rep(c, E)) == ok    # (3) 行 4
        sat += ok
        total += 1
print(f"{total} candidates for {len(NONZERO)} elements with r != 0 ({sat} satisfy a·q ~ e): claim, rows 1,2,3,5 on all, row 4 iff a·q ~ e")
print("RESULT: PASS")
