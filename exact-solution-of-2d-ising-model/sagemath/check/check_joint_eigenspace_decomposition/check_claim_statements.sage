# 対象ラベル: check_joint_eigenspace_decomposition
# 主張 (1)〜(5) そのものを、全ての ε, ε' ∈ {0,1}^{M_col} と全ての ν で厳密に確かめる（証明の行を経ずに、主張の式を直接比べる）。
#   Q̌_ε := ∏_{μ∈M̌} R_μ^{(ε(μ))}（def_check_Q_epsilon。R は def_check_R_factor、積は def_product_over_check_index_set の
#   μ = 1, …, M_col の順に左から掛ける積）。以前の定義 ∏_μ(ε_μň_μ + (1−ε_μ)(I−ň_μ)) と同じ行列であることも確かめる。
#   (1) ε ≠ ε' で Q̌_εQ̌_{ε'} = O、Q̌_ε^2 = Q̌_ε
#   (2) Σ_ε Q̌_ε = I
#   (3) ε(ν) = 1 なら ň_νQ̌_ε = Q̌_εň_ν = Q̌_ε、ε(ν) = 0 なら ň_νQ̌_ε = Q̌_εň_ν = O（三つの式を対で比べる）
#   (4) tr(Q̌_ε) = 1、dim im Q̌_ε = 1（rank を体 F の上の行基本変形で厳密に求める）、Step 4 の dim im Q̌_ε = tr(Q̌_ε)
#   (5) 2^{M_col} 個の像の基底を並べた行列の rank が 2^{M_col}（像の和が全体）で、各像の次元の和も 2^{M_col}（和が直和）。
# ň_μ は _number_operators.sage の number_operator_settings() から取る（既定は Jordan–Wigner の模型 M = 2, 3, 4、
# check_with_check_psi.sage からは本文の ψ̌）。
# 否定コントロール: I − ň_μ の代わりに I を使った族（ε(μ) = 0 の因子を I にしたもの）では (1) の直交性と (4) の次元が外れる。
# 帰属: 成分は QQ か本文の ψ̌ の数体 F（厳密計算。浮動小数点は使わない）。
load("_number_operators.sage")
import itertools

claim_count = 0
claim_neg = 0


def claim_check(ok, label):
    global claim_count
    assert ok, label
    claim_count += 1


def left_product(Xs):
    out = Xs[0]
    for X in Xs[1:]:
        out = out * X
    return out


for (tag, M, F, ns) in number_operator_settings():
    N = 2 ^ M
    Id = identity_matrix(F, N)
    O = matrix(F, N, N, 0)
    W = [tuple(w) for w in itertools.product([1, 0], repeat=M)]
    Rfac = lambda e, n: n if e == 1 else Id - n                         # def_check_R_factor
    Q = {w: left_product([Rfac(w[mu], ns[mu]) for mu in range(M)]) for w in W}   # def_check_Q_epsilon
    old_factor = lambda e, n: e * n + (1 - e) * (Id - n)                # 以前の定義の因子 ε_μň_μ + (1−ε_μ)(I−ň_μ)
    for w in W:
        claim_check(Q[w] == left_product([old_factor(w[mu], ns[mu]) for mu in range(M)]),
                    f"{tag} ε={w}: def_check_Q_epsilon の Q̌_ε は以前の定義の行列に等しい")
    for w in W:
        for wp in W:
            if w != wp:
                claim_check(Q[w] * Q[wp] == O, f"{tag} ε={w} ε'={wp}: (1) 直交")
        claim_check(Q[w] * Q[w] == Q[w], f"{tag} ε={w}: (1) 冪等")
        for nu in range(M):
            claim_check(ns[nu] * Q[w] == Q[w] * ns[nu], f"{tag} ε={w} ν={nu + 1}: (3) 可換")
            target = Q[w] if w[nu] == 1 else O                          # ε(ν) = 1 なら Q̌_ε、ε(ν) = 0 なら O
            claim_check(ns[nu] * Q[w] == target, f"{tag} ε={w} ν={nu + 1}: (3) ň_νQ̌_ε")
            claim_check(Q[w] * ns[nu] == target, f"{tag} ε={w} ν={nu + 1}: (3) Q̌_εň_ν")
        claim_check(Q[w].trace() == 1, f"{tag} ε={w}: (4) tr = 1")
        claim_check(Q[w].rank() == Q[w].trace(), f"{tag} ε={w}: Step 4 の dim im Q̌_ε = tr(Q̌_ε)")
        claim_check(Q[w].rank() == 1, f"{tag} ε={w}: (4) dim im = 1")
    claim_check(sum(Q[w] for w in W) == Id, f"{tag}: (2) Σ Q̌_ε = I")
    bases = [Q[w].column_space().basis() for w in W]
    claim_check(sum(len(b) for b in bases) == N, f"{tag}: (5) 次元の和 = 2^M")
    claim_check(matrix(F, [v for b in bases for v in b]).rank() == N, f"{tag}: (5) 像の和が全体")
    # 否定コントロール
    bad = {w: left_product([ns[mu] if w[mu] == 1 else Id for mu in range(M)]) for w in W}
    ones, zeros = tuple([1] * M), tuple([0] * M)
    assert bad[zeros] * bad[ones] != O and bad[zeros].rank() != 1, tag
    claim_neg += 1
    print(f"  {tag}: 済（累計 {claim_count} 件）", flush=True)

print(f"PASS check_joint_eigenspace_decomposition 主張 (1)〜(5) そのもの: {claim_count} 件、否定コントロール {claim_neg} 件")
print("RESULT: PASS")
