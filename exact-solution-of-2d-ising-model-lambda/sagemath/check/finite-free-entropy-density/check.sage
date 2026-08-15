# 対象ラベル: def_finite_free_entropy_density
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない。
#
# 検査すること（def_finite_free_entropy_density の定義の中身）:
#   1. L ≥ 1 で L² ≠ 0、1/L² ∈ QQ が定まる。
#   2. Z_L(q) ∈ QQ_{>0}（claim_value_at_rational_is_positive）で Φ_L(q) = log Z_L(q) ∈ Λ が定まる。
#   3. Ψ_L(q) := (1/L²)·ι(Φ_L(q)) の各素数での値が Φ_L(q)(p)/L² に等しい（三段の鎖）。
#   4. Ψ_L(q) の台は Φ_L(q) の台に等しい（有限台）。
#   5. 具体例 L = 2、q = 1/2: Ψ_2(1/2)(353) = 1/4、Ψ_2(1/2)(2) = -7/4、他は 0。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def log_lambda(q):
    # 正の有理数の対数（def_rational_log）: 素因数分解の指数ベクトル（Λ の元。値は ZZ）
    assert q > 0
    return {ZZ(p): ZZ(e) for p, e in QQ(q).factor() if e != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}: 各素数の整数値を分母 1 の有理数として読む
    return {p: QQ(z) / QQ(1) for p, z in lam.items()}


def smul(c, v):
    # Λ_Q の有理数倍（素数ごとに QQ の積）
    return {p: QQ(c) * a for p, a in v.items() if QQ(c) * a != 0}


L_RANGE = [1, 2, 3]
Q_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]

count = 0
for L in L_RANGE:
    # 1. 1/L² ∈ QQ が定まる
    assert L * L != 0
    inv = QQ(1) / QQ(L * L)
    assert inv in QQ and inv > 0
    count += 1
    Z = partition_polynomial(L)
    for q in Q_SAMPLES:
        # 2. Z_L(q) ∈ QQ_{>0}、Φ_L(q) ∈ Λ
        value = QQ(Z(q))
        assert value > 0
        phi = log_lambda(value)
        assert all(p in ZZ and z in ZZ for p, z in phi.items())
        # Ψ_L(q) := (1/L²)·ι(Φ_L(q))
        psi = smul(inv, iota(phi))
        # 3. 各素数での値: 三段の鎖の各段
        for p in set(phi) | set(psi):
            step1 = inv * iota(phi).get(p, QQ(0))          # 有理数倍の定義
            step2 = inv * (QQ(phi.get(p, 0)) / QQ(1))     # ι の定義
            step3 = QQ(phi.get(p, 0)) / QQ(L * L)          # QQ の積
            assert psi.get(p, QQ(0)) == step1 == step2 == step3
            count += 1
        # 4. 台の一致
        assert set(psi) == set(phi)
        count += 1

# 5. 具体例 L = 2、q = 1/2
Z2 = partition_polynomial(2)
assert QQ(Z2(QQ(1)/2)) == QQ(353) / QQ(2**7)
phi2 = log_lambda(QQ(Z2(QQ(1)/2)))
assert phi2 == {ZZ(353): ZZ(1), ZZ(2): ZZ(-7)}
psi2 = smul(QQ(1)/4, iota(phi2))
assert psi2 == {ZZ(353): QQ(1)/4, ZZ(2): QQ(-7)/4}
count += 1

print("PASS: finite-free-entropy-density (%d checks)" % count)
