# =============================================================
# 共通定義 (sagemath/_shared/defs.sage)
#
# structured-latex/content/main-text.ts の定義に 1 対 1 で対応させる。
#   def_lattice / def_configuration    -> vertices(L), edges(L), configurations(L)
#   def_broken_bond_count              -> broken_bond_count(L, sigma)
#   def_multiplicity                   -> multiplicity_vector(L)
#   def_partition_polynomial           -> partition_polynomial(L)
#   claim_coefficient_representation   -> partition_polynomial_from_multiplicity(L)
#
# すべて厳密計算（ZZ / QQ / ZZ['x']）で書く。浮動小数点を使わない。
# 使い方:
#   import os
#   _dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
#   load(os.path.join(_dir, '<相対パス>/sagemath/_shared/defs.sage'))
# =============================================================

from itertools import product

# 分配多項式の係数環と不定元。指数関数を入口に置かない（README「形式変数のまま進む」）。
PolynomialRingZx = PolynomialRing(ZZ, 'x')
x = PolynomialRingZx.gen()


def vertices(L):
    """def_lattice: 頂点集合 V_L = (Z/LZ)^2 を添字の組 (i, j) として返す。|V_L| = L^2。

    本文と同じく、第 1 成分 i を行番号、第 2 成分 j を列番号と呼ぶ。
    """
    return [(i, j) for i in range(L) for j in range(L)]


def horizontal_edge_numbers(L):
    """def_lattice: 横向きの辺の番号の集合 E_{L,h} = {1, ..., L^2}。"""
    return range(1, L * L + 1)


def vertical_edge_numbers(L):
    """def_lattice: 縦向きの辺の番号の集合 E_{L,v} = {L^2+1, ..., 2L^2}。

    E_{L,h} と番号の範囲が重ならないので、両者は互いに素である
    （札を付けて区別する必要がない。本文と同じ約束）。
    """
    return range(L * L + 1, 2 * L * L + 1)


def projection(L, n):
    """def_lattice: 自然な射影 pi: Z -> Z/LZ。

    ここでは Z/LZ の元を 0..L-1 の整数で表しているので剰余を取る操作にあたる。
    本文と同じ名前を置いて「どこで Z と Z/LZ を行き来したか」を見えるようにする。
    """
    return ZZ(n) % L


def representative(L, y):
    """def_lattice: 代表を取る写像 s: Z/LZ -> Z（0 <= s(y) <= L-1、pi(s(y)) = y）。

    ここでは Z/LZ の元を 0..L-1 の整数で表しているので s は恒等だが、
    本文と同じ名前を置いて「どこで Z と Z/LZ を行き来したか」を見えるようにする。
    """
    return ZZ(y) % L


def edge_number_horizontal(L, i, j):
    """def_lattice: n_h(i,j) = L*s(i) + s(j) + 1。"""
    return L * representative(L, i) + representative(L, j) + 1


def edge_number_vertical(L, i, j):
    """def_lattice: n_v(i,j) = L^2 + L*s(i) + s(j) + 1。"""
    return L * L + L * representative(L, i) + representative(L, j) + 1


def endpoints(L, e):
    """def_lattice: 辺の番号 e から両端 (d0(e), d1(e)) を読み出す。

    本文では d0, d1 を n_h / n_v の逆向きとして定めている。ここでは番号から
    (i, j) を復元して同じ値を返す（n_h / n_v が全単射なので一致する）。
    行番号・列番号を進める加法は Z/LZ の中で行う（% L がそれにあたる）。

    本文と同じ分解を使う。番号を L で割った商が行番号 i、余りが列番号 j。
      e in E_{L,h} なら e - 1     = iL + j で、両端は (i,j) と (i,j+1)   同じ行の中
      e in E_{L,v} なら e - L^2-1 = iL + j で、両端は (i,j) と (i+1,j)   隣り合う行の間
    加法は Z/LZ の中で行う（周期境界）。
    """
    e = ZZ(e)
    if e <= L * L:
        i, j = divmod(e - 1, L)
        return ((i, j), (i, (j + 1) % L))
    i, j = divmod(e - L * L - 1, L)
    return ((i, j), ((i + 1) % L, j))


def edges(L):
    """def_lattice: 辺の番号ごとの端点の組を、番号 1, 2, ..., 2L^2 の順に並べて返す。

    長さは常に 2L^2（横向き L^2 本のあとに縦向き L^2 本）。
    L <= 2 では異なる番号が同じ頂点対を指す
    （L=1 は d0 = d1、L=2 は横向きの 2 本が同じ 2 点を結ぶ）。
    2 元集合として重複を潰すと本数が 2L^2 からずれるので、必ず番号ごとに数える
    （本文 def_lattice の但し書きと同じ理由）。
    """
    return [endpoints(L, e) for e in range(1, 2 * L * L + 1)]


def configurations(L):
    """def_configuration: 配位 sigma: V_L -> {+1,-1} を全列挙する。個数は 2^(L^2)。"""
    sites = vertices(L)
    for values in product([1, -1], repeat=len(sites)):
        yield dict(zip(sites, values))


def broken_bond_count(L, sigma):
    """def_broken_bond_count: 破れている辺の番号の個数 b(sigma) を返す（N の元）。"""
    return sum(1 for (u, w) in edges(L) if sigma[u] != sigma[w])


def multiplicity_vector(L):
    """def_multiplicity: Omega_L(m) を m = 0, 1, ..., 2L^2 の順に並べた整数の列。"""
    counts = [ZZ(0)] * (2 * L * L + 1)
    for sigma in configurations(L):
        counts[broken_bond_count(L, sigma)] += 1
    return counts


def partition_polynomial(L):
    """def_partition_polynomial: Z_L = sum_{sigma in Sigma_L} x^{b(sigma)} in ZZ[x]。

    本文の定義そのまま、配位ごとに単項式を足し上げて作る。
    多重度から作ってはならない。多重度から作ると係数表示
    Z_L = sum_m Omega_L(m) x^m が構成から自明になり、
    claim_coefficient_representation の検証が空になるためである。
    """
    total = PolynomialRingZx(0)
    for sigma in configurations(L):
        total += x ** broken_bond_count(L, sigma)
    return total


def partition_polynomial_from_multiplicity(L):
    """claim_coefficient_representation の右辺 sum_m Omega_L(m) x^m を、多重度から作る。

    partition_polynomial(L) とは作り方が独立なので、両者の一致が主張の内容になる。
    """
    return PolynomialRingZx(multiplicity_vector(L))


# --- 章「転送行列」の定義 -------------------------------------------------
#   def_row_configuration        -> row_configurations(L)
#   def_row_restriction          -> row_restriction(L, sigma, i)
#   def_intra_row_broken_count   -> intra_row_broken_count(L, tau)
#   def_inter_row_broken_count   -> inter_row_broken_count(L, tau, tau_next)
#   claim_edge_row_partition     -> horizontal_edge_numbers_of_row(L, i)
#                                   vertical_edge_numbers_of_row(L, i)


def row_configurations(L):
    """def_row_configuration: 行配位 tau: Z/LZ -> {+1,-1} を全列挙する。個数は 2^L。

    行配位は列番号 j = 0, ..., L-1 を添字とする辞書として表す。
    """
    for values in product([1, -1], repeat=L):
        yield dict(zip(range(L), values))


def row_restriction(L, sigma, i):
    """def_row_restriction: 配位 sigma の第 i 行への制限 rho_i(sigma) を返す。

    本文と同じく rho_i(sigma) と呼び、sigma_i とは書かない
    （添字を付けた sigma に別の意味を持たせないため）。
    """
    return {j: sigma[(i % L, j)] for j in range(L)}


def intra_row_broken_count(L, tau):
    """def_intra_row_broken_count: b_h(tau) = |{ j | tau(j) != tau(j+1) }|。

    j+1 は Z/LZ の中の加法（周期境界）。
    """
    return sum(1 for j in range(L) if tau[j] != tau[(j + 1) % L])


def inter_row_broken_count(L, tau, tau_next):
    """def_inter_row_broken_count: b_v(tau, tau') = |{ j | tau(j) != tau'(j) }|。"""
    return sum(1 for j in range(L) if tau[j] != tau_next[j])


def horizontal_edge_numbers_of_row(L, i):
    """claim_edge_row_partition: E_{L,h,i} = { iL + j + 1 | j = 0, ..., L-1 }。"""
    return [i * L + j + 1 for j in range(L)]


def vertical_edge_numbers_of_row(L, i):
    """claim_edge_row_partition: E_{L,v,i} = { L^2 + iL + j + 1 | j = 0, ..., L-1 }。"""
    return [L * L + i * L + j + 1 for j in range(L)]


# --- 章「転送行列」の続き: 行配位の族と転送行列 ---------------------------
#   def_row_family               -> row_families(L), row_config_key(L, tau)
#   def_rows_map                 -> rows_map(L, sigma), config_from_rows(L, c)
#   def_matrix_over_row_configs  -> row_matrix_product(L, A, B), row_matrix_pow(L, A, k),
#                                   row_matrix_trace(L, A)
#   def_transfer_matrix          -> transfer_matrix(L)


def row_config_key(L, tau):
    """行配位 tau（列番号を添字とする辞書）を、添字に使えるタプルへ直す。

    本文では R_L の元そのものを添字に使うが、Sage の辞書の鍵にするには
    ハッシュ可能な表現が要るため、値を列番号の順に並べたタプルで表す。
    """
    return tuple(tau[j] for j in range(L))


def row_config_from_key(key):
    """row_config_key の逆。タプルから行配位（辞書）へ戻す。"""
    return dict(enumerate(key))


def row_families(L):
    """def_row_family: 行配位の族 c: Z/LZ -> R_L を全列挙する。個数は (2^L)^L = 2^(L^2)。

    族は行番号 i = 0, ..., L-1 の順に行配位の表現（タプル）を並べたタプルで表す。
    """
    keys = [row_config_key(L, tau) for tau in row_configurations(L)]
    for family in product(keys, repeat=L):
        yield family


def rows_map(L, sigma):
    """def_rows_map: rows(sigma) = (rho_0(sigma), ..., rho_{L-1}(sigma))。"""
    return tuple(row_config_key(L, row_restriction(L, sigma, i)) for i in range(L))


def config_from_rows(L, c):
    """def_rows_map: conf(c)((i,j)) = (c(i))(j)。rows の逆写像の候補。"""
    return {(i, j): c[i][j] for i in range(L) for j in range(L)}


def transfer_matrix(L):
    """def_transfer_matrix: T_{tau,tau'} = x^{b_h(tau) + b_v(tau,tau')} in ZZ[x]。

    行と列を行配位の表現（タプル）で添字づけた辞書として返す。
    指数関数を経由せず、破れの本数だけを指数に置く（README「形式変数のまま進む」）。
    """
    keys = [row_config_key(L, tau) for tau in row_configurations(L)]
    entries = {}
    for key in keys:
        tau = row_config_from_key(key)
        intra = intra_row_broken_count(L, tau)
        for key_next in keys:
            tau_next = row_config_from_key(key_next)
            inter = inter_row_broken_count(L, tau, tau_next)
            entries[(key, key_next)] = x ** ZZ(intra + inter)
    return entries


def row_matrix_keys(L):
    """行列の添字に使う行配位の表現をすべて並べる（個数は 2^L）。"""
    return [row_config_key(L, tau) for tau in row_configurations(L)]


def row_matrix_product(L, A, B):
    """def_matrix_product: (AB)_{tau,tau''} = sum_{tau'} A_{tau,tau'} B_{tau',tau''}。"""
    keys = row_matrix_keys(L)
    entries = {}
    for a in keys:
        for c in keys:
            entries[(a, c)] = sum((A[(a, b)] * B[(b, c)] for b in keys), PolynomialRingZx(0))
    return entries


def row_matrix_pow(L, A, k):
    """def_matrix_product: A^1 = A、A^{k+1} = A^k A（k >= 1）。"""
    assert k >= 1
    result = A
    for _ in range(k - 1):
        result = row_matrix_product(L, result, A)
    return result


def row_matrix_trace(L, A):
    """def_matrix_trace: Tr A = sum_{tau} A_{tau,tau}。"""
    return sum((A[(key, key)] for key in row_matrix_keys(L)), PolynomialRingZx(0))


# --- 章「転送行列」の続き: 行配位の道 -------------------------------------
#   def_row_walk / def_walk_weight -> row_walks(L, k, start, goal), walk_weight(L, A, p)
#   claim_matrix_pow_entry         -> 上の 2 つと row_matrix_pow(L, A, k) を突き合わせる


def row_walks(L, k, start, goal):
    """def_row_walk: W_{L,k}(tau, tau'') を全列挙する（k >= 1）。

    道 p: {0,1,...,k} -> R_L を、行配位の表現（タプル）を i の順に並べた
    長さ k+1 のタプルで表す。定義域は整数の集合であり剰余類ではないので、
    行配位の族（row_families）とは別の対象である。
    個数は |R_L|^{k-1} = (2^L)^{k-1}（両端が指定されているため）。
    """
    assert k >= 1
    keys = row_matrix_keys(L)
    for interior in product(keys, repeat=k - 1):
        yield (start,) + interior + (goal,)


def walk_weight(L, A, p):
    """def_walk_weight: w_A(p) = prod_{i=0}^{k-1} A_{p(i),p(i+1)}。"""
    result = PolynomialRingZx(1)
    for i in range(len(p) - 1):
        result *= A[(p[i], p[i + 1])]
    return result


# --- 章「転送行列」の続き: 閉じた道 ---------------------------------------
#   def_closed_walk / def_walk_of_family -> closed_row_walks(L), walk_of_family(L, c),
#                                           family_of_walk(L, p)
#   claim_closed_walk_bijection          -> 上の 3 つを突き合わせる
#   theorem_partition_polynomial_is_trace -> partition_polynomial(L) と
#                                            row_matrix_trace(L, row_matrix_pow(L, T, L))


def closed_row_walks(L):
    """def_closed_walk: W^cl_L = { p in W_{L,L} | p(0) = p(L) } を全列挙する。

    道の表現は row_walks と同じ長さ L+1 のタプルである。
    """
    keys = row_matrix_keys(L)
    for start in keys:
        for p in row_walks(L, L, start, start):
            yield p


def walk_of_family(L, c):
    """def_walk_of_family: (Theta(c))(i) = c(i mod L)（i = 0, ..., L）。

    族 c は行番号 0, ..., L-1 の順に並べたタプル（row_families の表現）である。
    i = L のとき i mod L = 0 なので、作られる道は必ず閉じている。
    """
    return tuple(c[i % L] for i in range(L + 1))


def family_of_walk(L, p):
    """def_walk_of_family: (Xi(p))(a mod L) = p(a)（a = 0, ..., L-1）。"""
    return tuple(p[a] for a in range(L))


# --- 章「固有値の代数性」の定義 -------------------------------------------
#   def_spin_index               -> spin_index(v)
#   def_row_config_order         -> differing_indices(L, tau, tau_next),
#                                   first_difference(L, tau, tau_next),
#                                   row_config_less(L, tau, tau_next)


def spin_index(v):
    """def_spin_index: eps(+1) = 0、eps(-1) = 1。"""
    assert v in (1, -1), v
    return ZZ(0) if v == 1 else ZZ(1)


def differing_indices(L, tau, tau_other):
    """def_row_config_order: D(tau, tau') = { k in {0,...,L-1} | tau(pi(k)) != tau'(pi(k)) }。"""
    return [k for k in range(L) if tau[projection(L, k)] != tau_other[projection(L, k)]]


def first_difference(L, tau, tau_other):
    """def_row_config_order: k_0(tau, tau') = min D(tau, tau')。tau = tau' のときは None。"""
    d = differing_indices(L, tau, tau_other)
    return min(d) if d else None


def row_config_less(L, tau, tau_other):
    """def_row_config_order: tau ≺ tau' の判定。"""
    k0 = first_difference(L, tau, tau_other)
    if k0 is None:
        return False
    return spin_index(tau[projection(L, k0)]) < spin_index(tau_other[projection(L, k0)])


def row_config_key(L, tau):
    """行配位を辞書のキーとして使えるタプルへ直す（表現の都合。本文の対象ではない）。"""
    return tuple(tau[j] for j in range(L))


def row_permutations(L):
    """def_row_permutation: 置換の全体 S_L（R_L から R_L への全単射）を全列挙する。

    置換は「行配位のキー -> 行配位」の辞書として表す。個数は (2^L)!。
    """
    configs = list(row_configurations(L))
    keys = [row_config_key(L, tau) for tau in configs]
    for perm in Permutations(len(configs)):
        yield {keys[i]: configs[perm[i] - 1] for i in range(len(configs))}


def apply_row_permutation(L, phi, tau):
    """置換 phi を行配位 tau に施す。"""
    return phi[row_config_key(L, tau)]


def ordered_pairs(L):
    """def_inversion_count: P_L = { (tau, tau') | tau ≺ tau' }。"""
    configs = list(row_configurations(L))
    return [
        (tau, tau_other)
        for tau in configs
        for tau_other in configs
        if row_config_less(L, tau, tau_other)
    ]


def inversion_count(L, phi, pairs=None):
    """def_inversion_count: inv(phi) = |{ (tau,tau') in P_L | phi(tau') ≺ phi(tau) }|。"""
    if pairs is None:
        pairs = ordered_pairs(L)
    return ZZ(sum(
        1
        for (tau, tau_other) in pairs
        if row_config_less(
            L, apply_row_permutation(L, phi, tau_other), apply_row_permutation(L, phi, tau)
        )
    ))


def permutation_sign(L, phi, pairs=None):
    """def_permutation_sign: sgn(phi) = (-1)^{inv(phi)} in ZZ。"""
    return ZZ(-1) ** inversion_count(L, phi, pairs)


def compose_row_permutations(L, phi, psi):
    """置換の合成 (phi ∘ psi)(tau) = phi(psi(tau))。"""
    # psi は「キー -> psi(その行配位)」なので、値の側へ phi を施せば合成になる。
    return {key: apply_row_permutation(L, phi, image) for key, image in psi.items()}


def identity_row_permutation(L):
    """恒等置換 id_{R_L}。"""
    return {row_config_key(L, tau): tau for tau in row_configurations(L)}
