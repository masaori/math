# 対象ラベル: def_row_config_order / claim_row_config_order_linear
#
# 本文（structured-latex/content/main-text.ts）の章「固有値の代数性」の
#   定義   スピン値の番号と、行配位の辞書式順序（eps, D, k_0, ≺）
#   主張   行配位の辞書式順序は線形順序である（三分律と推移律）
# を、小さい L で総当たりに確かめる。
#
# 三分律は全ての対（2^L × 2^L 通り）について、推移律は全ての 3 つ組
# （2^L × 2^L × 2^L 通り）について確かめる。標本を取らず全て走る。
#
# あわせて、証明が使う 2 つの準備も別々に確かめる。
#   準備 1: k_0 の位置で値が異なること。
#   準備 2: k_0 未満の位置では値が一致すること。
#
# さらに、この順序が「行配位を二進法で番号付けたときの番号の大小」と一致することを
# 独立に作った番号から確かめる。順序の定義（最初に違う位置を探す）と番号の作り方
# （各位置の値に重み 2^k を掛けて足す）は作り方が独立なので、この一致は空ではない。
#
# 厳密計算のみ（ZZ）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def check_first_difference_properties(L):
    """def_row_config_order: k_0 が D の最小元であることの 2 つの帰結。"""
    for tau in row_configurations(L):
        for tau_other in row_configurations(L):
            k0 = first_difference(L, tau, tau_other)
            if tau == tau_other:
                assert k0 is None, (L, tau, tau_other)
                continue
            assert k0 is not None, (L, tau, tau_other)
            # 準備 1: k_0 の位置で値が異なる。
            assert tau[projection(L, k0)] != tau_other[projection(L, k0)], (L, tau, tau_other)
            # 準備 2: k_0 未満の位置では値が一致する。
            for k in range(k0):
                assert tau[projection(L, k)] == tau_other[projection(L, k)], (L, tau, tau_other, k)
            # D は対称なので k_0 も対称である。
            assert first_difference(L, tau_other, tau) == k0, (L, tau, tau_other)


def check_trichotomy(L):
    """claim_row_config_order_linear の三分律: 3 つのうちちょうど 1 つが成り立つ。"""
    for tau in row_configurations(L):
        for tau_other in row_configurations(L):
            holds = [
                row_config_less(L, tau, tau_other),
                tau == tau_other,
                row_config_less(L, tau_other, tau),
            ]
            assert sum(1 for h in holds if h) == 1, (L, tau, tau_other, holds)


def check_transitivity(L):
    """claim_row_config_order_linear の推移律。"""
    configs = list(row_configurations(L))
    for tau in configs:
        for tau_other in configs:
            if not row_config_less(L, tau, tau_other):
                continue
            for tau_third in configs:
                if not row_config_less(L, tau_other, tau_third):
                    continue
                assert row_config_less(L, tau, tau_third), (L, tau, tau_other, tau_third)


def binary_number(L, tau):
    """独立に作る番号: 各位置 k の値に重み 2^(L-1-k) を掛けて足す。

    重みを k が小さいほど大きく取るのは、順序の定義が「最初に違う位置」で決まるためである。
    この関数は順序の定義を一切参照していない。
    """
    return sum(spin_index(tau[projection(L, k)]) * ZZ(2) ** (L - 1 - k) for k in range(L))


def check_agrees_with_binary_number(L):
    """順序が二進法の番号の大小と一致すること（作り方が独立な 2 つの比較の一致）。"""
    for tau in row_configurations(L):
        for tau_other in row_configurations(L):
            assert row_config_less(L, tau, tau_other) == (
                binary_number(L, tau) < binary_number(L, tau_other)
            ), (L, tau, tau_other)
    # 番号は 0, ..., 2^L - 1 を一度ずつ取る（順序が全順序であることの別の見方）。
    numbers = sorted(binary_number(L, tau) for tau in row_configurations(L))
    assert numbers == list(range(2 ** L)), (L, numbers)


def main():
    for L in [1, 2, 3, 4]:
        check_first_difference_properties(L)
        check_trichotomy(L)
        check_transitivity(L)
        check_agrees_with_binary_number(L)
        print(
            "L = %d: k_0 の 2 つの性質・三分律・推移律・二進法の番号との一致を確認"
            "（行配位 %d 個、対 %d 通り、3 つ組 %d 通り）"
            % (L, 2 ** L, 4 ** L, 8 ** L)
        )
    print("すべてのアサーションが成立した（L = 1, 2, 3, 4。厳密計算のみ）")


main()
