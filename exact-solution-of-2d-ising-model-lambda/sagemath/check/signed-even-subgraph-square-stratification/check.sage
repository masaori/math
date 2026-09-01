"""符号付き偶部分グラフ多項式の平方の選択集合による層別を厳密検査する。

対象: claim_signed_even_subgraph_square_stratified。
一辺 L=2 のトーラスと四つのスピン構造について、偶部分グラフ順序対の
符号付き母関数を、共通辺 D・対称差 E・選択集合 C_L(D,E) で層別した和へ
書き換え、ZZ[x] で一致を検査する。浮動小数点は使わない。
"""

load("sagemath/check/even-subgraph-pair-stratified-count/check.sage")


def winding_parities(L, subset):
    return (sum(seam_parities(L, edge)[0] for edge in subset) % 2,
            sum(seam_parities(L, edge)[1] for edge in subset) % 2)


def signed_weight(L, a, b, subset):
    h, v = winding_parities(L, subset)
    return ZZ(-1) ** ((1 + a) * h + (1 + b) * v + h * v)


checked = 0
for a in (0, 1):
    for b in (0, 1):
        q = R(0)
        for A in even_sets:
            q += signed_weight(L, a, b, A) * x ** len(A)

        stratified = R(0)
        selector_total = 0
        for D in subsets:
            for E in even_sets:
                if D & E:
                    continue
                signed_selection_sum = ZZ(0)
                selectors = [C for C in subsets if C <= E and is_even(L, D | C)]
                for C in selectors:
                    A = D | C
                    B = D | (E - C)
                    assert is_even(L, A)
                    assert is_even(L, B)
                    assert A & B == D
                    assert A.symmetric_difference(B) == E
                    signed_selection_sum += (signed_weight(L, a, b, A)
                                             * signed_weight(L, a, b, B))
                    selector_total += 1
                stratified += signed_selection_sum * x ** (2 * len(D) + len(E))

        assert q ** 2 == stratified
        assert selector_total == pair_total
        checked += 1

assert checked == 4
print("PASS: (Q_L^{a,b})^2 = Σ U_L^{a,b}(D,E) x^(2|D|+|E|) "
      f"(L={L}, 偶部分グラフ順序対 {pair_total} 件, スピン構造 {checked} 件)")
