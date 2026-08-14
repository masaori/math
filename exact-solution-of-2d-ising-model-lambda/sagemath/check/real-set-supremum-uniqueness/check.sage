# 対象ラベル: claim_real_set_supremum_unique
#
# 主張: S ⊆ ℝ と u₁, u₂ ∈ ℝ について、u₁ と u₂ がともに S の上限（最小上界）ならば
# u₁ = u₂。したがって記法 sup S は well-defined である。
# 実数の普遍量化された主張そのものは有限標本では検査できない。ここで検査するのは
# 証明の各段のモデルである: 準備（両向きの ≤。最小性の適用）、略記の展開（≤ は < か =）、
# 三分律による場合の除外、本体（有限モデルでの上限の一意性）。
# すべて QQ の厳密比較で行い、浮動小数点・ball 算術を使わない。
# 有限標本での検査であり、主張そのものの保証は本文の人手証明が担う。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# 有限モデル: (周囲集合 A, 部分集合 S)。上限の述語の量化「任意の M ∈ ℝ」は
# 有限モデルでは「任意の M ∈ A」に置き換える（A ⊇ S）。
FINITE_MODELS = [
    ([QQ(0)], [QQ(0)]),
    ([QQ(-1), QQ(0), QQ(1)], [QQ(-1), QQ(1)]),
    ([QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1)], [QQ(1)/3, QQ(1)/2, QQ(2)/3]),
    ([QQ(-5), QQ(0), QQ(7)/2 - QQ(1)/1000, QQ(7)/2, QQ(4)], [QQ(-5), QQ(0), QQ(7)/2]),
    ([QQ(-2), QQ(-1), QQ(-1)/2, QQ(0)], [QQ(-2), QQ(-1)]),
]

SAMPLES = [QQ(-3), QQ(-1)/2, QQ(0), QQ(1)/3, QQ(2)/3, QQ(1), QQ(22)/7, QQ(5)]


def is_upper_bound(S, M):
    # def_real_set_upper_bound のモデル（QQ で厳密）
    return all(s <= M for s in S)


def is_supremum(A, S, u):
    # def_real_set_supremum のモデル（上界の量化を周囲集合 A に制限。QQ で厳密）
    if not is_upper_bound(S, u):
        return False
    return all(u <= M for M in A if is_upper_bound(S, M))


def check_preparation():
    # 準備のモデル検査（厳密）: u₁, u₂ がともに上限なら、最小性の適用で
    # u₁ ≤ u₂ かつ u₂ ≤ u₁。
    total = 0
    for A, S in FINITE_MODELS:
        sups = [u for u in A if is_supremum(A, S, u)]
        for u1 in sups:
            for u2 in sups:
                assert u1 <= u2, (S, u1, u2)
                assert u2 <= u1, (S, u1, u2)
                total += 1
    print(f"準備 両向きの ≤（QQ で厳密）: {total} 件 OK")
    return total


def check_le_unfolding():
    # 略記の展開の標本検査（厳密）: a ≤ b ならば「a < b または a = b」であり、
    # 両方が同時には成り立たない。
    total = 0
    for a in SAMPLES:
        for b in SAMPLES:
            if a <= b:
                truths = [a < b, a == b]
                assert truths.count(True) == 1, (a, b)
                total += 1
    print(f"略記の展開（< か = のちょうど一方。QQ で厳密）: {total} 件 OK")
    return total


def check_trichotomy_exclusion():
    # 本体の場合の除外の標本検査（厳密）: a < b のとき、b < a も a = b も成り立たない
    # （三分律「ちょうど一つ」）。
    total = 0
    for a in SAMPLES:
        for b in SAMPLES:
            if a < b:
                assert not (b < a), (a, b)
                assert not (a == b), (a, b)
                total += 1
    print(f"三分律による除外（QQ で厳密）: {total} 件 OK")
    return total


def check_uniqueness_on_models():
    # 本体の有限モデル検査（厳密）: 各有限モデルで上限の述語を満たす元はちょうど一つで、
    # それは max(S) に等しい。
    total = 0
    for A, S in FINITE_MODELS:
        sups = [u for u in A if is_supremum(A, S, u)]
        assert len(sups) == 1, (A, S, sups)
        assert sups[0] == max(S), (A, S, sups)
        total += 1
    print(f"有限モデルでの上限の一意性（QQ で厳密）: {total} 件 OK")
    return total


total = 0
total += check_preparation()
total += check_le_unfolding()
total += check_trichotomy_exclusion()
total += check_uniqueness_on_models()
print(f"合計 {total} 件 OK")
