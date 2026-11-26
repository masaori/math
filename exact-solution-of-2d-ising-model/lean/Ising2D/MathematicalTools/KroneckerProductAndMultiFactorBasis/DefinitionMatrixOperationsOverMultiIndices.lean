/-
# 行列 `Mat(2^M, ℂ)` の単位行列・スカラー倍・和・零行列と、Lean の `TensorPow M` の演算（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`（`linear_space_general_definition_identity_matrix`、ラベル **`def_identity_matrix`**・
`linear_space_general_definition_matrix_scalar_multiple`、ラベル **`def_matrix_scalar_multiple`**・
`linear_space_general_definition_matrix_sum`、ラベル **`def_matrix_sum`**）、
`structured-latex/content/000_calculation_formulae_45_46.ts`（`finite_matrix_definition_zero_matrix`、ラベル **`def_zero_matrix`**）

人手は `Mat(2^M, ℂ)` の成分を番号で書き、四つの演算を成分の式で定める:
`(I)_{ij} := δ_{ij}`、`(aA)_{ij} := a A_{ij}`、`(A + B)_{ij} := A_{ij} + B_{ij}`、`O_{ik} := 0`（添字の文字は本文どおり）。
`def_kronecker` は多重添字 `I ∈ 𝓘_M` を番号 `ν(I)` と同一視して成分を並べる。

Lean の `TensorPow M = Matrix (Conf M) (Conf M) ℂ` は添字型が `𝓘_M`（Lean の `Conf M`）で、演算は mathlib の行列の `1`・`•`・`+`・`0` である。
人手の番号 `k ∈ {1,…,n}` は Lean の `k : Fin n` を名前を付けた写像 `finIndexToZZ n` で送った値であり、`ν^{-1}` は Lean の
`σ : Fin n → Conf M` で、`ν(σ(k)) = finIndexToZZ n k` によって定まる（`exists_inverse_of_kronecker_numbering`）。
したがって人手の成分 `A_{ij}` は Lean の `A (σ i) (σ j)` である。

- 単位行列は、成分の式が番号の上の `δ` を使うので、Lean の成分 `1 (σ i) (σ k)` が人手の右辺 `δ_{ik}`（本文の `δ_{ij}` の `j → k`）に等しいことを
  `ν^{-1}` の単射で示す（`tensorPow_one_apply_eq_identity_matrix`）。
- スカラー倍・和・零行列は成分の式が各成分だけで閉じ、番号 `ν(I)`・`ν(K)` の成分の式は Lean の `I`・`K` の成分の式と同じ形なので、
  `Conf M` の添字で一本ずつ書く（`tensorPow_smul_apply`・`tensorPow_add_apply`・`tensorPow_zero_apply`）。
  この 3 本は `def_kronecker` の「`I` を番号 `ν(I)` と同一視する」に頼る（状態台帳の行「有限和と有限集合の記号」の (iii) が直す同一視）。

積（`mat_mult`）はここに置かない。積の値の型は mathlib の `Matrix (Conf M) (Conf M) ℂ` と書かれるので、積を主張に書く補題は
型 `Matrix` の記号を使い、型 `Matrix` を許可の一覧に載せる前には置けない（状態台帳の行「行列とその演算」の残り）。
符号反転と差もここに置かない。一致の補題を通しの定理に繋げる使い道が、分離の行「TensorPow 上の行列の基本恒等式」の具体版の証明の中にしか無いからである。

人手の本文は演算を定めるだけで、Lean の演算との一致の主張を持たない。補題は Lean だけの段であり、
定義の一致を述べる補題なので、必要十分版は置かない。人手の `M ∈ ℤ_{≥1}` に対し、Lean は `M = 0` も許す。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionKroneckerNumbering
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

/-- **`def_identity_matrix`**: Lean の `TensorPow M` の単位行列の成分 `1 (ν^{-1}(i)) (ν^{-1}(k))` は、本文の
`(I_{Mat(n,ℂ)})_{ij} := δ_{ij}`（`n = 2^M`、`def_kronecker_delta`）の `j → k` の右辺に等しい（Lean だけの段の補題。冒頭の説明を見よ）。
mathlib の単位行列の成分は `ν^{-1}(i) = ν^{-1}(k)` かどうかで決まり、`ν^{-1}` の単射によりそれは `i = k` かどうかと同じである。 -/
theorem tensorPow_one_apply_eq_identity_matrix (M : ℕ) :
    ∀ (n : ℕ) (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
      ∀ (i k : Fin n), (1 : TensorPow M) (σ i) (σ k) = kroneckerDelta i k := by
  intro n σ hσ i k
  by_cases hik : i = k
  · subst hik
    calc (1 : TensorPow M) (σ i) (σ i)
        = 1 := Matrix.one_apply_eq _                       -- mathlib の単位行列の対角成分
      _ = kroneckerDelta i i := (kroneckerDelta_self i).symm  -- `def_kronecker_delta` の `i = k` の場合
  · -- `ν^{-1}` の単射: `ν(ν^{-1}(i)) = finIndexToZZ n i` と `finIndexToZZ n` の単射から
    have hσik : σ i ≠ σ k := fun h =>
      hik ((finIndexToZZ_bijective_onto_index_set n).1 i k (by rw [← hσ, ← hσ, h]))
    calc (1 : TensorPow M) (σ i) (σ k)
        = 0 := Matrix.one_apply_ne hσik                    -- mathlib の単位行列の対角でない成分
      _ = kroneckerDelta i k := (kroneckerDelta_of_ne hik).symm  -- `def_kronecker_delta` の `i ≠ k` の場合

/-- **`def_matrix_scalar_multiple`**: Lean の `TensorPow M` のスカラー倍の成分は、本文の `(aA)_{ij} := a A_{ij}` を
番号 `i = ν(I)`・`j = ν(K)` で読んだもの `(aA)_{IK} = a A_{IK}` である（Lean だけの段の補題。冒頭の説明を見よ）。 -/
theorem tensorPow_smul_apply {M : ℕ} (a : ℂ) (A : TensorPow M) (I K : Conf M) :
    (a • A) I K = a * A I K :=
  rfl                                                       -- mathlib の行列のスカラー倍は成分ごと

/-- **`def_matrix_sum`**: Lean の `TensorPow M` の和の成分は、本文の `(A + B)_{ij} := A_{ij} + B_{ij}` を
番号 `i = ν(I)`・`j = ν(K)` で読んだもの `(A + B)_{IK} = A_{IK} + B_{IK}` である（Lean だけの段の補題。冒頭の説明を見よ）。 -/
theorem tensorPow_add_apply {M : ℕ} (A B : TensorPow M) (I K : Conf M) :
    (A + B) I K = A I K + B I K :=
  rfl                                                       -- mathlib の行列の和は成分ごと

/-- **`def_zero_matrix`**: Lean の `TensorPow M` の零行列の成分は、本文の `O_{ik} := 0` を
番号 `i = ν(I)`・`k = ν(K)` で読んだもの `O_{IK} = 0` である（Lean だけの段の補題。冒頭の説明を見よ）。 -/
theorem tensorPow_zero_apply {M : ℕ} (I K : Conf M) :
    (0 : TensorPow M) I K = 0 :=
  rfl                                                       -- mathlib の零行列の成分

end Ising2D
