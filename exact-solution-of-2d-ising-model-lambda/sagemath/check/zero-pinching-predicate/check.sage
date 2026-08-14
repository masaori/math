# 対象ラベル: def_zero_pinching_predicate, claim_distance_positive_on_fisher_zeros,
#             def_phase_transition_countable_statement
# QQ・AA・QQbar の厳密計算だけを使う。浮動小数点を使わない。
# モデル: R = AA（実代数的数体）、ω = QQbar(I)。有限標本での検査であり、
# 普遍量化された主張そのものの証明ではない（主張の証明は本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

OMEGA = QQbar(I)

# L = 3 の Fisher 零点は最小多項式の次数が 12 で、real()/imag() と AA の厳密比較の
# exactify が資源上限で終わらない（real-closed-subfield の検査と同じ理由）。
# L ∈ {1, 2} に限る（L = 1 は零点なし、L = 2 は次数 8 の零点 8 個）。検査内容は緩めていない。
L_RANGE = [1, 2]

# q のサンプル（正の有理数。1 未満・1・1 超え）
Q_SAMPLES = [QQ(1)/3, QQ(2)/5, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7]

# ε のサンプル（正の有理数。小さいものから大きいものまで）
EPS_SAMPLES = [QQ(1)/10, QQ(1)/4, QQ(1)/2, QQ(1), QQ(2)]


def fisher_zeros(L):
    # def_finite_lattice_fisher_zeros のモデル: Z_L の QQbar における根の全体。
    ZL = partition_polynomial(L)
    return [root for root, _ in ZL.roots(QQbar)]


def dsq(xi, q):
    # def_distance_squared_to_rational のモデル。
    # 一意表示の成分は real()/imag()（AA の元を厳密に返す）。
    a = xi.real()
    b = xi.imag()
    assert a in AA and b in AA
    assert xi == QQbar(a) + QQbar(b) * OMEGA
    value = (a - AA(q)) * (a - AA(q)) + b * b
    assert value in AA
    return value


def lt_R(u, v):
    # def_real_algebraic_strict_order のモデル: v - u が零元でない平方であること。
    # AA では「零元でない平方」は狭義の正と同値なので、厳密比較 u < v で判定する。
    return u < v


def check_predicate_well_defined():
    # def_zero_pinching_predicate: 述語の中身（dsq(ξ,q) <_R ε·ε）の両辺が
    # AA の元であり、厳密比較で真偽が決定できること。
    count = 0
    for L in L_RANGE:
        for xi in fisher_zeros(L):
            for q in Q_SAMPLES:
                value = dsq(xi, q)
                for eps in EPS_SAMPLES:
                    rhs = AA(eps * eps)
                    verdict = lt_R(value, rhs)
                    assert verdict in (True, False)
                    count += 1
    print("述語の決定可能性: 比較 %d 件で通過" % count, flush=True)


def check_distance_positive():
    # claim_distance_positive_on_fisher_zeros: L=1,2 の全 Fisher 零点と
    # 正の有理点サンプルの全対で dsq(ξ,q) ≠ 0 であること。
    count = 0
    for L in L_RANGE:
        for xi in fisher_zeros(L):
            for q in Q_SAMPLES:
                assert dsq(xi, q) != 0
                count += 1
    print("距離の二乗の非零性: 対 %d 組で通過" % count, flush=True)


def check_pinch_instances():
    # def_phase_transition_countable_statement の言明の各 ε 段のモデル検査:
    # サンプルの ε それぞれについて、L ∈ {1,2} と ξ ∈ F_L と q の標本の中に
    # dsq(ξ,q) <_R ε·ε の証人が実際にあるか（真偽の記録。無くても失敗にしない。
    # 言明そのものの証明は本文の今後のセクションが担う）。
    for eps in EPS_SAMPLES:
        found = None
        for L in L_RANGE:
            for xi in fisher_zeros(L):
                for q in Q_SAMPLES:
                    if lt_R(dsq(xi, q), AA(eps * eps)):
                        found = (L, xi, q)
                        break
                if found:
                    break
            if found:
                break
        if found:
            print("Pinch(%s): 証人あり（L=%d）" % (eps, found[0]), flush=True)
        else:
            print("Pinch(%s): この標本の範囲では証人なし" % eps, flush=True)


check_predicate_well_defined()
check_distance_positive()
check_pinch_instances()
print("zero-pinching-predicate: すべて通過", flush=True)
