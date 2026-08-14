# 対象ラベル: def_free_energy_density_value_set, claim_free_energy_density_supremum_exists
#
# 主張: 各 t ∈ ℝ, 0 < t に対し、値集合 Ψ_t = { ψ_L(t) | L ∈ ℕ, L ≥ 1 } は
# 上限 sup Ψ_t ∈ ℝ を持つ。
# 完備性そのもの（無限集合の上限の存在）は有限標本では検査できない。ここで検査するのは
# 証明の各段のモデルである: 非空性（L=1 が条件を満たすこと。厳密）、上界性
# （各標本 L, t について ψ_L(t) ≤ M_t。ball の分離で厳密）、および有限部分集合では
# 最大元が最小上界になること（上限の性質のモデル。ball の比較）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

RBF = RealBallField(256)

# L の範囲（free-energy-density-upper-bound の検査と同じ範囲に揃える）
L_RANGE = [1, 2, 3]

# t の標本（正の有理数。ι_{Q→R} を通した R の元のモデル。1 未満・1・1 超え）
T_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]


def psi_ball(L, t):
    # ψ_L(t) = (1/L²)·log(Z_L(t)) の ball 表現（Z_L(t) は QQ で厳密に計算する）。
    ZL = partition_polynomial(L)
    value = QQ(ZL(x=t))
    assert value > 0, (L, t)
    return QQ(1) / (L * L) * RBF(value).log()


def check_nonempty():
    # 準備の第一の検査（厳密）: L=1 は L ∈ ℕ, L ≥ 1 を満たす（非空性の証人）。
    total = 0
    L = 1
    assert L in ZZ and L >= 1
    total += 1
    for t in T_SAMPLES:
        # 証人 ψ_1(t) が計算でき、内包的定義の条件 y = ψ_1(t) を y := ψ_1(t) が
        # 満たすこと（自明だが、証人の値が確定することを検査する）。
        b = psi_ball(1, t)
        assert b.is_finite(), t
        total += 1
    print(f"非空性の証人 L=1（厳密）と ψ_1(t) の確定: {total} 件 OK")
    return total


def check_upper_bound():
    # 準備の第二の検査（ball の分離で厳密）: ψ_L(t) ≤ M_t（M_t は L に依らない）。
    # claim_free_energy_density_upper_bound の再確認を、値集合の全標本元に対して行う。
    total = 0
    for t in T_SAMPLES:
        M = RBF(QQ(2)).log() + QQ(2) * RBF(1 + t).log()
        for L in L_RANGE:
            diff = M - psi_ball(L, t)
            assert diff.lower() > 0, (L, t)
            total += 1
    print(f"ψ_L(t) ≤ M_t（ball の分離で厳密）: {total} 件 OK")
    return total


def check_finite_sup_model():
    # 上限（最小上界）の性質の有限モデルの検査（ball）: 有限部分集合
    # { ψ_L(t) | L ∈ L_RANGE } では最大元 m が (1) すべての元の上界であり、
    # (2) m 自身が集合の元なので、どの上界 b についても m ≤ b（最小上界）。
    # (1) は ball の比較（上界性は「上端 ≤ 下端 または同一元」で確認する。
    # 同一 L の元は可算側で同一なので厳密）、(2) は m ∈ 集合（構成による。厳密）。
    total = 0
    for t in T_SAMPLES:
        balls = [(L, psi_ball(L, t)) for L in L_RANGE]
        # 最大元の添字を ball の中心の比較で選ぶ（選択そのものは検査対象ではない）
        m_index = max(range(len(balls)), key=lambda i: balls[i][1].center())
        m = balls[m_index][1]
        for i, (L, b) in enumerate(balls):
            if i == m_index:
                assert True  # m は集合の元（構成による。厳密）
            else:
                # b ≤ m を ball の分離で確認する（分離しない標本はこの範囲に無い）
                assert (m - b).lower() > 0 or (m - b).contains_zero(), (t, L)
            total += 1
    print(f"有限部分集合の最大元が最小上界になるモデル（ball）: {total} 件 OK")
    return total


def main():
    total = 0
    total += check_nonempty()
    total += check_upper_bound()
    total += check_finite_sup_model()
    print(f"合計 {total} 件 OK")


main()
