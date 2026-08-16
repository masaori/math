# 対象ラベル: claim_inverse_map_is_ca_iff_support_subset
# 併せて claim_minimal_inverse_neighborhood_finite_decidability を検査する。
# セル数 L = 2, 3, 4, 5 の巡回舞台（近傍 {v-1, v, v+1}、ℓ, r は表として与える）上の全 256 初等 CA 規則のうち
# 大域写像 F が単射なものについて、
#   (a) N*(v) := supp((F^{-1})_v) を一点反転走査で求め、等号検査回数 ≤ |V|·2^{|V|}
#   (b) 局所規則 f'_v := (F^{-1})_v ∘ ι^V_{N*(v)} をもつ近傍 N* の CA の大域写像 F' が F^{-1} に一致（(2)⇒(1)）
#   (c) N' として N*(v) から 1 元を除いた近傍を取ると、どの局所規則 f'_v でも F' ≠ F^{-1}（(1)⇒(2) の対偶の有限確認。
#       局所規則は全走査ではなく、(F^{-1})_v が N'(v) 上の局所規則で表せないことを定義どおり全 h の走査で確認）
# を検査する。L = 5・規則 45 が前章の反例（N* = V）に一致することも確認する。
# 帰属: 有限集合の等号と非負整数の比較だけ。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))


def rule_table(number):
    return {(a, b, c): (number >> (4 * a + 2 * b + c)) & 1 for a in A for b in A for c in A}


def make_global_map(L, table):
    left = {v: (v - 1) % L for v in range(L)}    # 表として与える（以後 % は使わない）
    right = {v: (v + 1) % L for v in range(L)}
    def F(y):
        return tuple(table[(y[left[v]], y[v], y[right[v]])] for v in range(L))
    return F


injective_count = 0
rule45_L5_full = None
for L in (2, 3, 4, 5):
    cells = tuple(range(L))
    confs = configurations(cells)
    bound = L * 2 ** L
    for number in range(256):
        F = make_global_map(L, rule_table(number))
        image = {}
        injective = True
        for y in confs:
            z = F(y)
            if z in image:
                injective = False
                break
            image[z] = y
        if not injective:
            continue
        injective_count += 1
        inv = image  # F^{-1} の表
        n_star = {}
        for v in cells:
            comparisons = 0
            supp = set()
            for u in cells:
                for x in confs:
                    comparisons += 1
                    if inv[x][v] != inv[flip(cells, u, x)][v]:
                        supp.add(u)
                        break
            assert comparisons <= bound
            n_star[v] = tuple(sorted(supp))
        # (b) N* の CA の大域写像 F' が F^{-1} に一致
        for z in confs:
            Fp = tuple(inv[base_extend(cells, n_star[v], restrict(cells, n_star[v], z))][v] for v in cells)
            assert Fp == inv[z], (L, number, z)
        # (c) N*(v) を真に縮めると (F^{-1})_v は表せない
        for v in cells:
            gv = {x: inv[x][v] for x in confs}
            for w in n_star[v]:
                smaller = tuple(c for c in n_star[v] if c != w)
                assert not representable(cells, smaller, gv), (L, number, v, w)
        if L == 5 and number == 45:
            rule45_L5_full = all(n_star[v] == cells for v in cells)
assert rule45_L5_full is True
print("injective (L, rule) pairs checked: {}".format(injective_count))
print("RESULT: PASS")
