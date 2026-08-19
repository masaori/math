# 対象ラベル: claim_iterate_monoid_conjugacy_invariant_family_finite_decidability
# 共役の両側で、反復写像列の最初の再出現までの有限走査から μ, λ, e, E, Q, ファイバーを
# 定義どおり再計算し、rooted_tree_data の導出値と一致することを確かめる。
# 最初の再出現 F^{μ+λ} = F^μ が μ の最小性と λ の最小性を同時に与えることは、
# それより早い再出現があれば μ または λ の最小性に反することによる（既証明の有限走査の再実行）。
# 帰属: 有限写像の合成と等号、有限集合の像・所属、非負整数の除法・大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))


def scan_invariants(table):
    """反復表を一段ずつ作り、最初に同じ写像が再出現した位置から μ, λ を読む。"""
    seen = {}
    powers = []
    current = identity_table(len(table))
    n = 0
    while current not in seen:
        seen[current] = n
        powers.append(current)
        current = compose(table, current)
        n += 1
    mu = seen[current]
    lam = n - mu
    e = min(k for k in range(mu + lam + 1) if mu <= k and k % lam == 0)
    while len(powers) <= e:
        powers.append(compose(table, powers[-1]))
    E = powers[e]
    Q = frozenset(E)
    fibers = {q: frozenset(y for y in range(len(E)) if E[y] == q) for q in Q}
    return mu, lam, e, E, Q, fibers


checked = 0
for stage_size, rule, table, h, g_table in conjugate_instances():
    for t in (table, g_table):
        mu_s, lam_s, e_s, E_s, Q_s, fibers_s = scan_invariants(t)
        _, mu_d, lam_d, e_d, _, E_d, _, Q_d, fibers_d, _ = rooted_tree_data(t)
        assert mu_s == mu_d
        assert lam_s == lam_d
        assert e_s == e_d
        assert E_s == E_d
        assert Q_s == Q_d
        assert fibers_s == fibers_d
        checked += 1

print("scanned tables checked: {}".format(checked))
print("RESULT: PASS")
