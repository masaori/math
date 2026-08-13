# 対象ラベル: claim_quadratic_zero_mem, claim_quadratic_zero_representation,
# claim_quadratic_negation_mem, claim_quadratic_negation_representation
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。

# claim_quadratic_zero_representation: s·s=2 を満たす s ∈ QQbar について、
#   0 ∈ Q_s（証人 (0,0)）であり、ξ ∈ Q_s について ξ = 0 と rep_s(ξ) = (0,0) は同値。
# claim_quadratic_negation_representation: ξ ∈ Q_s、(a,b) := rep_s(ξ) について、
#   -ξ ∈ Q_s（証人 (-a,-b)）であり、rep_s(-ξ) = (-a,-b)。
# 検査すること:
#   zero-chain: 0 = 0+0 = 0+0·s（零元の特徴づけの準備の鎖。QQbar の厳密等号）。
#   zero-iff:   標本の全 (a,b) で「a+b·s = 0 ⟺ (a,b) = (0,0)」
#               （第一の方向は表示の一意性の適用の裏取り、第二の方向は鎖の裏取り）。
#   neg-compat: QQ の加法逆元と QQbar の加法逆元の一致（準備の段の裏取り）。
#   neg-chain:  標本の全 (a,b) で -(a+b·s) = (-a)+(-(b·s)) = (-a)+(-b)·s
#               （加法逆元の表示の鎖を一段ずつ。QQbar の厳密等号）。
#   neg-rep:    (-a,-b) が -ξ の表示であること（表示の一意性のもとで、
#               -(a+b·s) = (-a)+(-b)·s がそのまま rep_s(-ξ) = (-a,-b) を与える）。

# s·s = 2 を満たす QQbar の元をすべて列挙する（t^2 - 2 の根。ちょうど 2 個）。
R.<t> = PolynomialRing(QQ)
roots = (t ** 2 - 2).roots(QQbar, multiplicities=False)
assert len(roots) == 2, "t^2 - 2 の QQbar の根がちょうど 2 個でない"

BOUND = 4
DEN = 3
samples = sorted(set(QQ(p) / QQ(q) for p in range(-BOUND, BOUND + 1)
                     for q in range(1, DEN + 1)))

checked_zero_iff = 0
checked_neg_compat = 0
checked_neg_chain = 0

# neg-compat: QQ の加法逆元と QQbar の加法逆元は同じ元（a + (-a) = 0 が両体で同じ等式）。
for a in samples:
    assert QQbar(-a) == -QQbar(a), f"加法逆元の両立が壊れている: a={a}"
    assert QQbar(a) + QQbar(-a) == QQbar(0), f"a+(-a)=0 が壊れている: a={a}"
    checked_neg_compat += 1

for s in roots:
    assert s * s == 2, "s·s = 2 が壊れている"

    # zero-chain: 0 = 0+0 = 0+0·s（準備の鎖の各段）。
    assert QQbar(0) == QQbar(0) + QQbar(0), "0 = 0+0 が壊れている"
    assert QQbar(0) + QQbar(0) == QQbar(0) + QQbar(0) * s, "0+0 = 0+0·s が壊れている"

    for a in samples:
        for b in samples:
            xi = QQbar(a) + QQbar(b) * s

            # zero-iff: a+b·s = 0 ⟺ (a,b) = (0,0)。
            assert (xi == 0) == (a == 0 and b == 0), \
                f"零元の特徴づけが壊れている: a={a}, b={b}, s={s}"
            checked_zero_iff += 1

            # neg-chain: -(a+b·s) = (-a)+(-(b·s)) = (-a)+(-b)·s を一段ずつ。
            step0 = -xi
            step1 = QQbar(-a) + (-(QQbar(b) * s))
            step2 = QQbar(-a) + QQbar(-b) * s
            assert step0 == step1, f"和の加法逆元の段が壊れている: a={a}, b={b}, s={s}"
            assert step1 == step2, f"積の加法逆元の段が壊れている: a={a}, b={b}, s={s}"

            # neg-rep: 表示の一意性のもとで rep_s(-ξ) = (-a,-b)（-ξ が (-a,-b) で表せる）。
            assert step0 == step2, f"加法逆元の表示が壊れている: a={a}, b={b}, s={s}"
            checked_neg_chain += 1

print(f"OK: neg-compat {checked_neg_compat} 組, zero-iff {checked_zero_iff} 組, "
      f"neg-chain {checked_neg_chain} 組")
