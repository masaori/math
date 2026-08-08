# 対象ラベル: def_column_translation / claim_column_translation_bijective /
#             def_row_config_shift / claim_row_config_shift_bijective /
#             claim_intra_row_shift_invariant / claim_inter_row_shift_invariant /
#             claim_transfer_matrix_shift_invariant
#
# 本文（structured-latex/content/main-text.ts）の章「固有値の代数性」の
#   定義   列番号の平行移動
#   主張   列番号の平行移動は全単射である
#   定義   行配位の巡回シフト
#   主張   行配位の巡回シフトは全単射である
#   主張   行内破れ数は巡回シフトで変わらない
#   主張   行間破れ数は 2 つの行配位を同時に巡回シフトしても変わらない
#   主張   転送行列の成分は行と列を同時に巡回シフトしても変わらない
# を、小さい L で総当たりに確かめる。
#
# 確かめること。
#   1. def_column_translation。gamma が Z/LZ の写像として定まること。
#   2. claim_column_translation_bijective。人手証明の作り方そのもの
#      （gamma' を逆向きの平行移動として作り、gamma'(gamma(y)) = y と gamma(gamma'(y)) = y）を
#      全ての y について確かめる。あわせて gamma が Z/LZ 全体への全射であることも見る。
#   3. def_row_config_shift。S(tau) が行配位であること（定義域と値域）。
#   4. claim_row_config_shift_bijective。S'(S(tau)) = tau と S(S'(tau)) = tau を
#      全ての行配位について確かめる。あわせて S が R_L 全体への全射であることも見る。
#   5. claim_intra_row_shift_invariant。b_h(S(tau)) = b_h(tau) を全ての行配位について。
#      あわせて人手証明の準備（b_h(S(tau)) を定める集合が X の gamma による逆像であること）を
#      集合そのものの一致として確かめる。最終の等式だけを見ると、集合の取り違えが
#      個数の一致に隠れる場合を見逃すためである。
#   6. claim_inter_row_shift_invariant。b_v(S(tau), S(tau')) = b_v(tau, tau') を全ての対について。
#      あわせて 5 と同じく、集合が Y の逆像であることも確かめる。
#   7. claim_transfer_matrix_shift_invariant。T_{S(tau),S(tau')} = T_{tau,tau'} を全ての対について。
#      左辺は転送行列を組み上げてから添字を引き、右辺も同じ行列から引く。
#   8. 反例の側も見る。b_h は「シフトしない側だけを動かす」操作では一般に変わること
#      （b_h(S(tau)) と b_h(tau) の一致が、b_h が定数であることの帰結ではないこと）、および
#      b_v(S(tau), tau') が一般に b_v(tau, tau') と異なること（同時にシフトすることが効いていること）を
#      L = 3 で具体例により確かめる。
#
# 走らせる範囲（打ち切りを隠さない）。
#   L = 1, 2, 3, 4: 行配位はそれぞれ 2, 4, 8, 16 個。1〜7 をすべて総当たりで走る
#                   （6・7 は行配位の全対、すなわち 4, 16, 64, 256 通り）。
#   8 は L = 3 の具体例のみ（反例の提示なので 1 例で足りる）。
#
# 厳密計算のみ（ZZ、ZZ[x]）。浮動小数点は使わない。
# 本文がこの範囲で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def column_translation(L, y):
    """def_column_translation: gamma(y) = y +_{Z/LZ} 1bar。

    本文と同じく Z/LZ の加法で 1 つ進める（列番号は 0, ..., L-1 で表す）。
    """
    return (y + 1) % L


def column_translation_inverse(L, y):
    """claim_column_translation_bijective の証明が置く gamma'（逆向きの平行移動）。"""
    return (y - 1) % L


def row_shift(L, tau):
    """def_row_config_shift: (S(tau))(y) = tau(gamma(y))。"""
    return {y: tau[column_translation(L, y)] for y in range(L)}


def row_shift_inverse(L, tau):
    """claim_row_config_shift_bijective の証明が置く S'（gamma' で引き戻す）。"""
    return {y: tau[column_translation_inverse(L, y)] for y in range(L)}


def check_column_translation(L):
    """1・2: gamma が写像として定まり、gamma' との合成が恒等写像である。"""
    image = set()
    for y in range(L):
        z = column_translation(L, y)
        assert z in range(L), (L, y, z)
        image.add(z)
        assert column_translation_inverse(L, z) == y, (L, y)
        assert column_translation(L, column_translation_inverse(L, y)) == y, (L, y)
    assert image == set(range(L)), (L, image)
    print(f'OK: L={L} で gamma は全単射である（gamma\' との合成が両向きとも恒等写像、像が Z/LZ 全体）')


def check_row_shift_bijective(L):
    """3・4: S(tau) が行配位であり、S' との合成が恒等写像である。"""
    taus = list(row_configurations(L))
    image = set()
    for tau in taus:
        shifted = row_shift(L, tau)
        assert set(shifted.keys()) == set(range(L)), (L, shifted)
        assert set(shifted.values()) <= {1, -1}, (L, shifted)
        image.add(row_config_key(L, shifted))
        assert row_shift_inverse(L, shifted) == tau, (L, tau)
        assert row_shift(L, row_shift_inverse(L, tau)) == tau, (L, tau)
    assert image == set(row_config_key(L, t) for t in taus), (L,)
    print(f'OK: L={L} で S は全単射である（S\' との合成が両向きとも恒等写像、像が R_L 全体）')


def check_intra_row_invariant(L):
    """5: b_h(S(tau)) = b_h(tau)。あわせて集合が X の gamma による逆像であること。"""
    for tau in row_configurations(L):
        broken_set = set(
            z for z in range(L) if tau[z] != tau[column_translation(L, z)]
        )
        shifted = row_shift(L, tau)
        shifted_broken_set = set(
            y for y in range(L) if shifted[y] != shifted[column_translation(L, y)]
        )
        preimage = set(y for y in range(L) if column_translation(L, y) in broken_set)
        assert shifted_broken_set == preimage, (L, tau)
        assert intra_row_broken_count(L, shifted) == intra_row_broken_count(L, tau), (L, tau)
    print(f'OK: L={L} で b_h(S(tau)) = b_h(tau)（全ての行配位。破れの集合も逆像として一致）')


def check_inter_row_invariant(L):
    """6: b_v(S(tau), S(tau')) = b_v(tau, tau')。あわせて集合が Y の逆像であること。"""
    taus = list(row_configurations(L))
    for tau in taus:
        for tau_other in taus:
            differing = set(z for z in range(L) if tau[z] != tau_other[z])
            shifted = row_shift(L, tau)
            shifted_other = row_shift(L, tau_other)
            shifted_differing = set(
                y for y in range(L) if shifted[y] != shifted_other[y]
            )
            preimage = set(y for y in range(L) if column_translation(L, y) in differing)
            assert shifted_differing == preimage, (L, tau, tau_other)
            assert inter_row_broken_count(L, shifted, shifted_other) == \
                inter_row_broken_count(L, tau, tau_other), (L, tau, tau_other)
    print(f'OK: L={L} で b_v(S(tau), S(tau\')) = b_v(tau, tau\')（行配位の全対。異なる位置の集合も逆像として一致）')


def check_transfer_matrix_invariant(L):
    """7: T_{S(tau),S(tau')} = T_{tau,tau'}。"""
    T = transfer_matrix(L)
    taus = list(row_configurations(L))
    for tau in taus:
        for tau_other in taus:
            key = (row_config_key(L, tau), row_config_key(L, tau_other))
            shifted_key = (
                row_config_key(L, row_shift(L, tau)),
                row_config_key(L, row_shift(L, tau_other)),
            )
            assert T[shifted_key] == T[key], (L, key)
            assert T[key].parent() is PolynomialRingZx or T[key] in PolynomialRingZx, (L, key)
    print(f'OK: L={L} で T_{{S(tau),S(tau\')}} = T_{{tau,tau\'}}（行配位の全対、ZZ[x] の中の厳密な一致）')


def check_not_vacuous():
    """8: 同時にシフトすることが効いていること（片側だけ動かすと一般に値が変わる）。"""
    L = 3
    taus = list(row_configurations(L))
    # b_h が行配位によって実際に異なること（不変性が「定数だから」ではないこと）。
    values = set(intra_row_broken_count(L, tau) for tau in taus)
    assert len(values) >= 2, values
    # b_v(S(tau), tau') が b_v(tau, tau') と異なる対が存在すること。
    found = False
    for tau in taus:
        for tau_other in taus:
            if inter_row_broken_count(L, row_shift(L, tau), tau_other) != \
                    inter_row_broken_count(L, tau, tau_other):
                found = True
    assert found, 'b_v は片側だけのシフトでも不変になってしまっている'
    # T の成分が行配位によって実際に異なること。
    T = transfer_matrix(L)
    assert len(set(T.values())) >= 2, 'T の成分がすべて等しい'
    print('OK: L=3 で、b_h は行配位により異なり、b_v は片側だけのシフトでは変わりうる（主張は空でない）')


def main():
    for L in [1, 2, 3, 4]:
        check_column_translation(L)
        check_row_shift_bijective(L)
        check_intra_row_invariant(L)
        check_inter_row_invariant(L)
        check_transfer_matrix_invariant(L)
    check_not_vacuous()
    print('すべての検証が通った（行配位の巡回シフト）')


main()
