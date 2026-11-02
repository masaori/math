# 使う検算: sigma_z_diagonal_action・sigma_z_product_action・site_sigma_z_is_diagonal・site_sigma_z_product_is_diagonal・config_basis_vector_own_component・site_sigma_z_product_diagonal_entry
# サイトごとの σ^z とクロネッカー積の共通の準備。行列・ベクトルはすべて成分が整数なので ZZ 上で組み、等号は厳密に判定する。
# 浮動小数点と RR / CC への脱出はない。添字は本文の 1 始まりで持ち、Sage の行列を引くときだけ 1 を引く。
#
# 各行の両辺を同じ式から作ると何も確かめないので、二つの独立な経路を置く。
#   - Sage 組み込みの経路: matrix の積、tensor_product（クロネッカー積）、vector の演算。
#   - 本文の定め方の経路: def_kronecker の成分の式 ∏_k (A_k)_{i_k j_k}・∏_k (v_k)_{i_k} と ν で成分から組む。
import itertools

M_RANGE = [1, 2, 3, 4, 5]

# pauli_matrix_products の σ^z と、def_identity_matrix の I_{Mat(2,C)}
SIGMA_Z = matrix(ZZ, [[1, 0], [0, -1]])
ID2 = identity_matrix(ZZ, 2)
# def_end_iso の e_1 = (1,0), e_2 = (0,1)（2 行 1 列の行列として持つ）
E = {1: matrix(ZZ, 2, 1, [1, 0]), 2: matrix(ZZ, 2, 1, [0, 1])}

def spin_configurations(M):
    """def_row_configurations の 𝔐 = Map({1,…,M},{-1,1})。μ を (μ(1),…,μ(M)) の組で持つ。"""
    return list(itertools.product((1, -1), repeat=M))

def iota(mu):
    """def_config_basis_iso の ι(μ) = (i_1,…,i_M)、i_m = 1 (μ(m)=+1)、2 (μ(m)=-1)。"""
    return tuple(1 if s == 1 else 2 for s in mu)

def index_set(M):
    """def_kronecker の 𝓘_M = {1,2}^M。"""
    return list(itertools.product((1, 2), repeat=M))

def nu(I):
    """def_kronecker の ν(I) = 1 + Σ_k (i_k - 1) 2^{M-k}。"""
    M = len(I)
    return 1 + sum((I[k - 1] - 1) * 2**(M - k) for k in range(1, M + 1))

def kron_sage(factors):
    """Sage 組み込みの tensor_product で A_1⊠⋯⊠A_M を組む（行列でも 2 行 1 列のベクトルでもよい）。"""
    K = factors[0]
    for B in factors[1:]:
        K = K.tensor_product(B)
    return K

def kron_matrix_by_definition(factors):
    """def_kronecker (2): (A_1⊠⋯⊠A_M)_{ν(I),ν(J)} := ∏_k (A_k)_{i_k j_k}。"""
    M = len(factors)
    K = matrix(ZZ, 2**M, 2**M)
    for I in index_set(M):
        for J in index_set(M):
            K[nu(I) - 1, nu(J) - 1] = prod(factors[k][I[k] - 1, J[k] - 1] for k in range(M))
    return K

def kron_vector_by_definition(vectors):
    """def_kronecker (1): (v_1⊠⋯⊠v_M)_{ν(I)} := ∏_k (v_k)_{i_k}。2^M 行 1 列の行列で返す。"""
    M = len(vectors)
    K = matrix(ZZ, 2**M, 1)
    for I in index_set(M):
        K[nu(I) - 1, 0] = prod(vectors[k][I[k] - 1, 0] for k in range(M))
    return K

def site_factors(M, m, A):
    """第 m 因子だけが A で他が I_{Mat(2,C)} の因子の列（def_site_pauli_matrices）。"""
    return [A if p == m else ID2 for p in range(1, M + 1)]

def sigma_z_site(M, m):
    """def_site_pauli_matrices の σ_m^z を Sage の tensor_product で組み、本文の定め方の経路と一致することも確かめて返す。"""
    S = kron_sage(site_factors(M, m, SIGMA_Z))
    assert S == kron_matrix_by_definition(site_factors(M, m, SIGMA_Z))
    return S

def f_basis(I):
    """def_end_iso の f_I = e_{i_1}⊠⋯⊠e_{i_M} を Sage の tensor_product で組み、本文の定め方と一致することも確かめて返す。"""
    vs = [E[i] for i in I]
    f = kron_sage(vs)
    assert f == kron_vector_by_definition(vs)
    return f
