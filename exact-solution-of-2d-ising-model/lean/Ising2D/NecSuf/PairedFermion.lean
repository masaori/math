/-
# 共役添字の対合で対をなすフェルミオン（**必要十分版**）

対応する人手証明のラベル（具体版は `Ising2D/Part017/`）:

- `def_check_number_operator`（`Ising2D.NecSuf.numPaired`）
- `check_number_operator_idempotent` / `check_number_operators_commute`
  （**新しい必要十分版は不要**。`Ising2D/NecSuf/NumberOperator.lean` の
  `num_mul_num` / `commute_num_num` がそのまま使える）
- `trace_of_check_number_operator_product`（`Ising2D.NecSuf.two_pow_smul_tau_noncommProd`）

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査）

章 009（整数運動量）の個数演算子は `n_μ = ψ_μ^† ψ_{-μ}`、
章 017（半整数運動量）のそれは `ň_μ = ψ̌_μ^† ψ̌_{M+1-μ}` である。
対をなす添字が `-μ` から `M+1-μ` に変わっているが、
**この違いは「添字集合の上の対合 `σ` を 1 つ選ぶこと」に完全に吸収される。**

実際、反交換関係が

  `[c_i, a_j]_+ = δ_{j, σ i} · 1`   （`σ` は単射）

の形で与えられたとき、`a'_i := a_{σ i}` と置けば

  `[c_i, a'_j]_+ = δ_{j i} · 1`

という**標準形の CAR** になる（`acomm_cre_ann_comp`）。したがって
`Ising2D/NecSuf/NumberOperator.lean` と `Ising2D/NecSuf/JointEigenspace.lean` の
定理群は、`(c, a')` に対してそのまま適用できる。

**つまり、整数運動量版と半整数運動量版は同じ必要十分版の別の特殊化であり、
違いは対合 `σ` の取り方（`μ ↦ -μ` か `μ ↦ M+1-μ` か）だけである。**

効いているのは次の 2 点だけで、`σ` が対合であることすら不要（**単射で十分**）である。

1. 台が環であること。
2. `σ` が単射であること（`σ j = σ i ⇒ j = i`）。

添字集合が `{1,…,M}` に閉じていること、`M+1-μ` という具体形、
合同式 `μ+ν ≡ 1 (mod M)`、行列であること、複素数であることはいずれも効いていない。

## トレースについて

`trace_of_check_number_operator_product`（`tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M-k}`）も
新しい内容を持たない。既存の `NecSuf.two_pow_smul_tau_projOn` を
`T = s`（＝すべての因子で `n_i` を選ぶ）と特殊化すればよい
（`projFactor n s i = n i`（`i ∈ s`）だから）。効いているのは
「加法的かつ巡回的な汎関数 `τ` が 1 つあること」だけである。
-/
import Ising2D.NecSuf.JointEigenspace

namespace Ising2D.NecSuf

open Finset

/-! ## 共役添字の対合による付け替え -/

section Pairing

variable {A : Type*} [Ring A] {ι : Type*} [DecidableEq ι]

/-- 対合（一般には単射）`σ` で付け替えた消滅演算子 `a'_i := a_{σ i}`。 -/
def annPaired (a : ι → A) (σ : ι → ι) (i : ι) : A := a (σ i)

/-- 対をなす添字が `σ` で与えられるときの個数演算子 `n_i := c_i a_{σ i}`
（人手証明 `def_check_number_operator` の `ň_μ = ψ̌_μ^† ψ̌_{M+1-μ}`）。 -/
def numPaired (c a : ι → A) (σ : ι → ι) (i : ι) : A := num c (annPaired a σ) i

theorem numPaired_def (c a : ι → A) (σ : ι → ι) (i : ι) :
    numPaired c a σ i = c i * a (σ i) := rfl

/-- **本章の要点**: `δ_{ν, σ μ}` の形の CAR は、消滅演算子を `σ` で付け替えると
Kronecker のデルタ `δ_{μν}` になる。

人手証明 `check_number_operator_idempotent` (2) の
「`ν = M+1-μ` と取ると `δ_{M+1-μ, M+1-μ} = 1`」および
`check_number_operators_commute` Step 1 の
「`δ_{M+1-ν, M+1-μ} = δ_{μν} = 0`」にあたる。 -/
theorem acomm_cre_ann_comp (c a : ι → A) {σ : ι → ι} (hσ : Function.Injective σ)
    (hca : ∀ i j, c i * a j + a j * c i = if j = σ i then (1 : A) else 0) (i j : ι) :
    c i * annPaired a σ j + annPaired a σ j * c i = if j = i then (1 : A) else 0 := by
  unfold annPaired
  rw [hca i (σ j)]
  by_cases h : j = i
  · subst h; simp
  · rw [if_neg h, if_neg (fun hc => h (hσ hc))]

end Pairing

/-! ## 個数演算子の積のトレース -/

section Trace

variable {A : Type*} [Ring A] {ι : Type*} [DecidableEq ι]
variable {R : Type*} [AddCommGroup R]

/-- **人手証明 `trace_of_check_number_operator_product` の必要十分版**:
`2^{|s|} τ(∏_{i∈s} n_i) = τ(1)`。

`NecSuf.two_pow_smul_tau_projOn` を `T = s` と特殊化したものである
（人手証明が `tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M-k}` と書いているものにあたる。
`τ(1) = 2^M`, `|s| = k`）。 -/
theorem two_pow_smul_tau_noncommProd (c a : ι → A)
    (hn : ∀ i j, Commute (num c a i) (num c a j))
    (τ : A → R) (hadd : ∀ x y : A, τ (x + y) = τ x + τ y)
    (hcyc : ∀ x y : A, τ (x * y) = τ (y * x))
    (hca : ∀ i, c i * a i + a i * c i = 1)
    (hcc : ∀ i j, i ≠ j → Commute (c i) (num c a j))
    (hac : ∀ i j, i ≠ j → Commute (a i) (num c a j))
    (s : Finset ι) :
    (2 ^ s.card) • τ (s.noncommProd (num c a) fun i _ j _ _ => hn i j) = τ 1 := by
  have hEq : projOn (num c a) hn s s = s.noncommProd (num c a) fun i _ j _ _ => hn i j :=
    Finset.noncommProd_congr rfl (fun i hi => projFactor_of_mem hi) _
  have h := two_pow_smul_tau_projOn c a hn τ hadd hcyc hca hcc hac s s
  rwa [hEq] at h

end Trace

end Ising2D.NecSuf
