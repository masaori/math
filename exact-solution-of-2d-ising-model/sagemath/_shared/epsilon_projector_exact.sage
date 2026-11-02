# ε の射影子 P^{(+)} := (1/2)(I + ε) と、ε と可換な行列の検算で共有する準備。
# ε・サイトの Pauli 行列・H_1^{(+)}・exp のボールは pauli_sites_exact.sage（成分は QQ(i) = KG で厳密）。
# V_1・V_2 の成分の式は row_configurations.sage（def_transfer_matrix）。
load("../../_shared/pauli_sites_exact.sage")
load("../../_shared/row_configurations.sage")


def projector_plus(M):
    """def_epsilon_projectors: P^{(+)} := (1/2)(I + ε)。本文の定め方（def_matrix_sum・def_matrix_scalar_multiple の成分の式、
    1/2 は QQ ⊂ KG の元）で組み、Sage の `+`・`/` で組んだものと一致を確かめてから返す。"""
    E = epsilon(M)
    n = 2 ** M
    P = body_scalar(KG(1) / 2, body_sum(body_identity(KG, n), E))
    assert P == (identity_matrix(KG, n) + E) / 2
    return P


def control_projector(M):
    """対照: ε を σ_1^z に替えた (1/2)(I + σ_1^z)。ε とは別の行列なので、仮定 εX = Xε から何も従わない。"""
    n = 2 ** M
    return body_scalar(KG(1) / 2, body_sum(body_identity(KG, n), site(M, 1, 'z')))
