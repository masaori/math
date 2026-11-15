# 対象ラベル: claim_signed_even_subgraph_orbit_product
# 定数項の式鎖（有限積の定数項は各因子の定数項の積 → F_O の定数項は一 → Δ_O の定数項は一）と、
# 一意性による P_L^{a,b} = S_L^{a,b} = Q_L^{a,b} の同定。
# 明示積はこのファイルの先頭で計算し終えてから、Q_L^{a,b} の構成（別の多項式環 x を定義する）を読み込む。
explicit = {}
for length in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
            # 二行目: 有限積の定数項は各因子の定数項の積
            assert prod(factors)[0] == prod(factor[0] for factor in factors)
            # 三行目: 一元軌道の因子 F_O の定数項は一
            assert all(fixed_factor(point)[0] == 1 for point in fixed)
            # 四行目: Δ_O の定数項は一（四元軌道では平方の定数項も一）
            assert all(delta(*point)[0] == 1 for point in paired + quadrupled)
            assert prod(factors)[0] == 1
            explicit[(length, a, b)] = [QQbar(c) for c in prod(factors).list()]

load(os.path.join(directory, '..', 'torus-kac-ward-even-subgraph-square', 'construction.sage'))
for length in (1, 2):
    oriented = edges(length)
    evens = even_subgraphs(length)
    for a in (0, 1):
        for b in (0, 1):
            q = P(0)
            for subset in evens:
                h = sum(seam_parities(length, edge)[0] for edge in subset) % 2
                v = sum(seam_parities(length, edge)[1] for edge in subset) % 2
                q += ZZ(-1) ** ((1+a)*h + (1+b)*v + h*v) * x ** len(subset)
            transition = matrix(P, len(oriented), len(oriented),
                                lambda r, s: P(transition_entry(length, a, b, oriented[r], oriented[s])))
            d = (identity_matrix(P, len(oriented)) - x * transition).det()
            # S_L^{a,b} := Q_L^{a,b} は定数項一で S·S = D（claim_determinant_polynomial_square_root_exists）
            assert q[0] == 1 and q * q == d
            # P_L^{a,b} = S_L^{a,b}（一意性の結論を係数で突き合わせる）
            assert explicit[(length, a, b)] == [QQbar(c) for c in q.list()]
print('constant term chain and identification P = Q: PASS')
