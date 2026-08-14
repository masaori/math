# 対象ラベル: def_real_set_upper_bound, def_real_set_supremum,
#             claim_free_energy_density_supremum_approximation
#
# 主張: u を Ψ_t の上限（最小上界）とすると、任意の ε > 0 に対し、
# ある L ≥ 1 が存在して u − ε < ψ_L(t)。
# 真の上限 u（無限集合 Ψ_t の最小上界）は有限標本では計算できない。ここで検査するのは
# 証明の各段のモデルである: 準備（u−ε < u。厳密）、三分律の標本（厳密）、
# 有限モデルでの最小性→非上界（第一段。厳密）、非上界の展開（第二段。厳密）、
# および実列 ψ_L(t) の有限段の最大元の証人（QQ の厳密比較）。
# すべて QQ の厳密比較で行い、浮動小数点・ball 算術を使わない。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

L_RANGE = [1, 2, 3]
T_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]
EPS_SAMPLES = [QQ(1)/100, QQ(1)/7, QQ(1), QQ(10)]
U_SAMPLES = [QQ(-3), QQ(0), QQ(2)/3, QQ(5)]
# 有限モデル（QQ の有限部分集合。最大元がそのモデルでの最小上界になる）
FINITE_MODELS = [
    [QQ(0)],
    [QQ(-1), QQ(1)],
    [QQ(1)/3, QQ(1)/2, QQ(2)/3],
    [QQ(-5), QQ(0), QQ(7)/2, QQ(7)/2 - QQ(1)/1000],
]


def check_preparation():
    # 準備の検査（厳密）: 0 < ε ならば u − ε < u（QQ は順序体のモデル）。
    total = 0
    for u in U_SAMPLES:
        for eps in EPS_SAMPLES:
            assert eps > 0
            assert u - eps < u, (u, eps)
            total += 1
    print(f"準備 u−ε < u（QQ で厳密）: {total} 件 OK")
    return total


def check_trichotomy():
    # realEscape で追加した三分律の標本検査（厳密）: ちょうど一つが成り立つ。
    total = 0
    samples = U_SAMPLES + EPS_SAMPLES + [QQ(2)/3]
    for a in samples:
        for b in samples:
            truths = [a < b, a == b, b < a]
            assert truths.count(True) == 1, (a, b)
            total += 1
    print(f"三分律（ちょうど一つ。QQ で厳密）: {total} 件 OK")
    return total


def check_minimality_gives_not_upper_bound():
    # 本体第一段の有限モデル検査（厳密）: 有限集合 S の最大元 u は S の最小上界であり、
    # 任意の ε > 0 について u − ε は S の上界ではない
    # （u − ε が上界なら最小性より u ≤ u − ε となり u − ε < u に反する、の帰結）。
    total = 0
    for S in FINITE_MODELS:
        u = max(S)
        # u が上界（def_real_set_upper_bound のモデル）
        assert all(s <= u for s in S)
        # u が最小（def_real_set_supremum のモデル。上界の標本は S の元 + ずらし）
        upper_candidates = [m for m in [u, u + QQ(1), u + QQ(1)/3] ]
        assert all(u <= m for m in upper_candidates if all(s <= m for s in S))
        total += 1
        for eps in EPS_SAMPLES:
            # u − ε は上界ではない（u ∈ S が反例）
            assert not all(s <= u - eps for s in S), (S, eps)
            total += 1
    print(f"有限モデルの最小性と非上界（QQ で厳密）: {total} 件 OK")
    return total


def check_not_upper_bound_unfolding():
    # 本体第二段の有限モデル検査（厳密）: M が S の上界でないなら、ある s ∈ S が
    # M < s を満たす（y ≤ M の否定は三分律により M < y）。
    total = 0
    for S in FINITE_MODELS:
        u = max(S)
        for eps in EPS_SAMPLES:
            M = u - eps
            assert not all(s <= M for s in S)
            witnesses = [s for s in S if M < s]
            assert len(witnesses) >= 1, (S, eps)
            total += 1
    print(f"非上界の展開（証人の存在。QQ で厳密）: {total} 件 OK")
    return total


def check_on_real_sequence():
    # 実列 ψ_L(t) の有限段での検査（QQ の厳密比較。浮動小数点を使わない）:
    # 有限モデル {ψ_L(t) | L ∈ {1,2,3}} に最大元 u₃ = ψ_{Lmax}(t) が存在すること
    # （Lmax が上界の証人であること）を確かめる。ψ_a(t) ≤ ψ_b(t) は、実対数の
    # 弱い単調性と正値性により Z_a(t)^{b²} ≤ Z_b(t)^{a²}（QQ の厳密比較）と同値なので、
    # 比較はすべて QQ で行う（t = 1 のように全元が等しい標本もこの形で扱える）。
    # u₃ − ε < ψ_{Lmax}(t) はこの証人と準備（u−ε < u。check_preparation で検査済み）から
    # 従う。真の上限 sup Ψ_t は有限標本では計算できない（主張そのものは本文の人手証明が担う）。
    total = 0
    for t in T_SAMPLES:
        values = [(L, QQ(partition_polynomial(L)(x=t))) for L in L_RANGE]
        for v in values:
            assert v[1] > 0, (t, v[0])
        # ψ_a ≤ ψ_b ⟺ Z_a^{b²} ≤ Z_b^{a²} で最大元を探す
        def psi_le(a, Za, b, Zb):
            return Za ** (b * b) <= Zb ** (a * a)
        Lmax, Zmax = values[0]
        for L, Z in values[1:]:
            if psi_le(Lmax, Zmax, L, Z):
                Lmax, Zmax = L, Z
        for L, Z in values:
            assert psi_le(L, Z, Lmax, Zmax), (t, L, Lmax)
            total += 1
    print(f"実列の有限段の最大元の証人（QQ で厳密）: {total} 件 OK")
    return total


total = 0
total += check_preparation()
total += check_trichotomy()
total += check_minimality_gives_not_upper_bound()
total += check_not_upper_bound_unfolding()
total += check_on_real_sequence()
print(f"合計 {total} 件 OK")
