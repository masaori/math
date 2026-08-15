# 対象ラベル: claim_rational_log_order_group_embedding
#
# 対数順序群 Λ（素数→ℤ、有限台）を有限台の辞書で、
# 有理係数の対数順序群 Λ_ℚ（素数→ℚ、有限台）を同じく有限台の辞書で表す。
# 写像 ι_{Λ→Λ_ℚ} は各素数の整数値を分母 1 の有理数として読むだけである。
# 証明の各行（ι の定義、Λ の加法の定義、ℚ の分母 1 の加法、Λ_ℚ の加法の定義）と、
# 単射性（分母 1 の有理数の等号から整数の等号）を、有限個の素数で厳密に検査する。
# 帰属: すべて ZZ / QQ の厳密計算。

import os
from itertools import product

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))

PRIMES = [2, 3, 5, 7, 11]


def lam(values):
    """Λ の元: 素数→ℤ の有限台辞書（値 0 は落とす）"""
    return {p: ZZ(v) for p, v in values.items() if ZZ(v) != 0}


def lam_add(l, m):
    """def_log_order_group の加法（素数ごと、ℤ の中で）"""
    out = {}
    for p in set(l) | set(m):
        s = l.get(p, ZZ(0)) + m.get(p, ZZ(0))
        if s != 0:
            out[p] = s
    return out


def lamq_add(l, m):
    """def_rational_log_order_group の加法（素数ごと、ℚ の中で）"""
    out = {}
    for p in set(l) | set(m):
        s = l.get(p, QQ(0)) + m.get(p, QQ(0))
        if s != 0:
            out[p] = s
    return out


def lamq_smul(r, l):
    """def_rational_log_order_group の有理数倍"""
    return {p: QQ(r) * v for p, v in l.items() if QQ(r) * v != 0}


def iota(l):
    """ι_{Λ→Λ_ℚ}: 整数値を分母 1 の有理数として読む"""
    return {p: QQ(v) / QQ(1) for p, v in l.items()}


count = 0
samples = [lam({2: 1}), lam({3: -2}), lam({2: 3, 5: -1}), lam({}), lam({7: 4, 11: -3, 2: -1})]

for l, m in product(samples, repeat=2):
    # 加法を保つ: 各素数で 4 行の等式を確かめる
    for p in PRIMES:
        lhs = iota(lam_add(l, m)).get(p, QQ(0))
        row1 = QQ(lam_add(l, m).get(p, ZZ(0))) / QQ(1)                # ι の定義
        row2 = QQ(l.get(p, ZZ(0)) + m.get(p, ZZ(0))) / QQ(1)         # Λ の加法の定義
        row3 = QQ(l.get(p, ZZ(0))) / QQ(1) + QQ(m.get(p, ZZ(0))) / QQ(1)  # 分母 1 の加法
        row4 = iota(l).get(p, QQ(0)) + iota(m).get(p, QQ(0))         # ι の定義
        row5 = lamq_add(iota(l), iota(m)).get(p, QQ(0))              # Λ_ℚ の加法の定義
        assert lhs == row1 == row2 == row3 == row4 == row5, (l, m, p)
        assert lhs.parent() is QQ
    assert iota(lam_add(l, m)) == lamq_add(iota(l), iota(m))
    count += 1
    # 単射性: 像が等しければ元が等しい（対偶: 元が異なれば像が異なる）
    if iota(l) == iota(m):
        assert l == m, (l, m)
    else:
        assert l != m
    count += 1

# 有理数倍と台: 台は増えない。分配則・結合則・1 倍
for l in samples:
    lq = iota(l)
    for r, s in product([QQ(1) / 4, QQ(-2) / 3, QQ(0), QQ(5)], repeat=2):
        assert set(lamq_smul(r, lq)) <= set(lq)
        assert lamq_smul(r + s, lq) == lamq_add(lamq_smul(r, lq), lamq_smul(s, lq))
        assert lamq_smul(r * s, lq) == lamq_smul(r, lamq_smul(s, lq))
        for m in samples:
            mq = iota(m)
            assert lamq_smul(r, lamq_add(lq, mq)) == lamq_add(lamq_smul(r, lq), lamq_smul(r, mq))
        count += 1
    assert lamq_smul(QQ(1), lq) == lq

# 密度の住処: Φ_L(q) を L^2 で割ったものが Λ_ℚ に入る例（L=2, q=3/2 の分配多項式の値の素因数分解）
Z2 = partition_polynomial(2)  # 周期境界 L=2 の分配多項式（_shared/defs.sage の定義どおりの実装）
q = QQ(3) / 2
val = Z2(q)
num, den = val.numerator(), val.denominator()
Phi = lam({p: e for p, e in factor(num)})
Phi = lam_add(Phi, {p: -e for p, e in factor(den)})
dens = lamq_smul(QQ(1) / 4, iota(Phi))
assert all(v.parent() is QQ for v in dens.values())
count += 1

print("PASS: rational-log-order-group-embedding (%d checks)" % count)
