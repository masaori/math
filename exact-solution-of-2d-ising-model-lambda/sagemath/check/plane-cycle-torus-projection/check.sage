# 平面の頂点単純な閉単位格子路のトーラス射影が閉じた非後退辺列であることの全数検査
# 対象: claim_plane_simple_cycle_projection_closed_nonbacktracking
# すべて ZZ の中の有限列挙・場合分け・剰余演算だけで行う。浮動小数点は使わない。

STEPS = [(0, 1), (1, 0), (0, -1), (-1, 0)]


def enumerate_simple_closed_paths(max_len):
    """始点 (0,0) の頂点単純な閉単位格子路（長さ n、3 <= n <= max_len）を全列挙する。"""
    results = []

    def dfs(path):
        cur = path[-1]
        for (dr, dc) in STEPS:
            nxt = (cur[0] + dr, cur[1] + dc)
            n = len(path)  # これまでの歩数
            if nxt == path[0] and n >= 3:
                results.append(path + [nxt])
            if nxt not in path and n < max_len - 1:
                dfs(path + [nxt])

    dfs([(0, 0)])
    return results


def check_for_L(L, paths):
    L2 = L * L

    def n_h(i, j):
        return L * i + j + 1

    def n_v(i, j):
        return L2 + L * i + j + 1

    def boundary(e):
        # 端点写像。横向き: 列だけ +1。縦向き: 行だけ +1（mod L）
        if 1 <= e <= L2:
            k = e - 1
            i, j = k // L, k % L
            return (i, j), (i, (j + 1) % L)
        else:
            k = e - L2 - 1
            i, j = k // L, k % L
            return (i, j), ((i + 1) % L, j)

    def src_tgt(e, d):
        b0, b1 = boundary(e)
        return (b0, b1) if d == 0 else (b1, b0)

    def vt(p):
        return (p[0] % L, p[1] % L)

    def project_step(a, b):
        diff = (b[0] - a[0], b[1] - a[1])
        if diff == (0, 1):
            i, j = vt(a)
            return (n_h(i, j), 0)
        if diff == (1, 0):
            i, j = vt(a)
            return (n_v(i, j), 0)
        if diff == (0, -1):
            i, j = vt(b)
            return (n_h(i, j), 1)
        if diff == (-1, 0):
            i, j = vt(b)
            return (n_v(i, j), 1)
        raise AssertionError("単位格子の一歩でない: %s -> %s" % (a, b))

    step_checks = 0
    for W in paths:
        n = len(W) - 1
        edges = [project_step(W[j], W[j + 1]) for j in range(n)]
        for j in range(n):
            e, d = edges[j]
            assert 1 <= e <= 2 * L2, "辺番号が E_L の外: %s" % ((e, d),)
            s, t = src_tgt(e, d)
            assert s == vt(W[j]), "src が頂点射影と不一致 (L=%d, j=%d)" % (L, j)
            assert t == vt(W[j + 1]), "tgt が頂点射影と不一致 (L=%d, j=%d)" % (L, j)
            # 接続と非後退（巡回）
            e2, d2 = edges[(j + 1) % n]
            s2, _ = src_tgt(e2, d2)
            assert t == s2, "接続が切れている (L=%d, j=%d)" % (L, j)
            assert (e2, d2) != (e, 1 - d), "反転が現れた (L=%d, j=%d)" % (L, j)
            step_checks += 1
    return step_checks


paths = enumerate_simple_closed_paths(10)
assert len(paths) > 0
total = 0
for L in [1, 2, 3]:
    total += check_for_L(L, paths)

print("PASS: 頂点単純な閉単位格子路 %d 本（長さ 10 以下・始点固定）、L=1,2,3 の射影の歩の検査 %d 件"
      % (len(paths), total))
