/-
# 複素行列の全体 `Mat(m, n, ℂ)` と、行列 `Mat(2^M, ℂ)` の単位行列・スカラー倍・和・零行列・積と、Lean の `TensorPow M` の演算（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`（`calc_formulae_definition_complex_matrices`、ラベル **`def_complex_matrices`**・
`calc_formulae_003_matrix_decomposition`、ラベル **`mat_mult`**）、
`structured-latex/content/002_linear_space_general.ts`（`linear_space_general_definition_identity_matrix`、ラベル **`def_identity_matrix`**・
`linear_space_general_definition_matrix_scalar_multiple`、ラベル **`def_matrix_scalar_multiple`**・
`linear_space_general_definition_matrix_sum`、ラベル **`def_matrix_sum`**）、
`structured-latex/content/000_calculation_formulae_45_46.ts`（`finite_matrix_definition_zero_matrix`、ラベル **`def_zero_matrix`**）

人手は `Mat(2^M, ℂ)` の成分を番号で書き、五つの演算を成分の式で定める:
`(I)_{ij} := δ_{ij}`、`(aA)_{ij} := a A_{ij}`、`(A + B)_{ij} := A_{ij} + B_{ij}`、`O_{ik} := 0`、`(AB)_{ik} := Σ_{j=1}^{n} A_{ij} B_{jk}`（添字の文字は本文どおり）。
`def_kronecker` は多重添字 `I ∈ 𝓘_M` を番号 `ν(I)` と同一視して成分を並べる。

Lean の `TensorPow M = Matrix (Conf M) (Conf M) ℂ` は添字型が `𝓘_M`（Lean の `Conf M`）で、演算は mathlib の行列の `1`・`•`・`+`・`0`・`*` である。
人手の番号 `k ∈ {1,…,n}` は Lean の `k : Fin n` を名前を付けた写像 `finIndexToZZ n` で送った値であり、`ν^{-1}` は Lean の
`σ : Fin n → Conf M` で、`ν(σ(k)) = finIndexToZZ n k` によって定まる（`exists_inverse_of_kronecker_numbering`）。
したがって人手の成分 `A_{ij}` は Lean の `A (σ i) (σ j)` である。

- 単位行列は、成分の式が番号の上の `δ` を使うので、Lean の成分 `1 (σ i) (σ k)` が人手の右辺 `δ_{ik}`（本文の `δ_{ij}` の `j → k`）に等しいことを
  `ν^{-1}` の単射で示す（`tensorPow_one_apply_eq_identity_matrix`）。
- スカラー倍・和・零行列は成分の式が各成分だけで閉じ、番号 `ν(I)`・`ν(K)` の成分の式は Lean の `I`・`K` の成分の式と同じ形なので、
  `Conf M` の添字で一本ずつ書く（`tensorPow_smul_apply`・`tensorPow_add_apply`・`tensorPow_zero_apply`）。
  この 3 本は `def_kronecker` の「`I` を番号 `ν(I)` と同一視する」に頼る（状態台帳の行「有限和と有限集合の記号」の (iii) が直す同一視）。

人手の `Mat(m, n, ℂ)` は添字の集合の直積 `{1,…,m} × {1,…,n}` から `ℂ` への写像の全体（`def_complex_matrices`）で、Lean の
`Matrix (Fin m) (Fin n) ℂ` は `Fin m → Fin n → ℂ` である。行と列の添字を `finIndexToZZ` で送ると、成分が行列を定め、どの成分の割り当ても
行列になる（`matrix_fin_complex_entries_determine_and_realize`）。添字が `Conf M` の行列（本文の `Mat(2^M, ℂ)`）は、`ν^{-1}` で番号へ移した
成分について同じことが言える（`tensorPow_entries_by_kronecker_numbering`）。
積（`mat_mult`）は成分の式が番号の上の和なので、単位行列と同じく `ν^{-1}` で番号へ移した成分で書き、mathlib の積の成分（`𝓘_M` の上の和）を
`def_finite_sum_of_complex_numbers_over_multi_indices` で番号の上の和へ移す（`tensorPow_mul_apply_eq_mat_mult`）。証明の段が `𝓘_M` の元を
添字に書くときのために、`𝓘_M` の上の和の形 `tensorPow_mul_apply` もそこから導く。
符号反転と差はここに置かない。一致の補題を通しの定理に繋げる使い道が、分離の行「TensorPow 上の行列の基本恒等式」の具体版の証明の中にしか無いからである。

人手の本文は演算を定めるだけで、Lean の演算との一致の主張を持たない。補題は Lean だけの段であり、
定義の一致を述べる補題なので、必要十分版は置かない。人手の `M ∈ ℤ_{≥1}` に対し、Lean は `M = 0` も許す。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionKroneckerNumbering
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionFiniteSumOverMultiIndices
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

/-- **`def_complex_matrices`**: Lean の `Matrix (Fin m) (Fin n) ℂ` は、本文の `Mat(m, n, ℂ)`（`{1,…,m} × {1,…,n}` から `ℂ` への写像の全体）と、
行と列の添字を名前を付けた写像 `finIndexToZZ` で送って対応する（Lean だけの段の補題。冒頭の説明を見よ）。
一つ目は、二つの行列が等しいことと全ての成分が等しいことが同じであること（写像の等号は点ごと）、
二つ目は、`{1,…,m} × {1,…,n}` の上の成分の割り当て `c`（`ℤ × ℤ` の上の写像の制限として与える）がどれも行列の成分になることである。 -/
theorem matrix_fin_complex_entries_determine_and_realize (m n : ℕ) :
    (∀ A B : Matrix (Fin m) (Fin n) ℂ, A = B ↔ ∀ (i : Fin m) (k : Fin n), A i k = B i k) ∧
      ∀ c : ℤ → ℤ → ℂ, ∃ A : Matrix (Fin m) (Fin n) ℂ,
        ∀ (i : Fin m) (k : Fin n), A i k = c (finIndexToZZ m i) (finIndexToZZ n k) := by
  refine ⟨fun A B => ⟨fun h i k => by rw [h], fun h => ?_⟩, fun c => ?_⟩
  · funext i k                                              -- 写像の等号は点ごと（`set_and_algebra_notation`）
    exact h i k
  · exact ⟨fun i k => c (finIndexToZZ m i) (finIndexToZZ n k), fun _ _ => rfl⟩

/-- **`def_complex_matrices`**（`Mat(2^M, ℂ)`）: Lean の `Matrix (Conf M) (Conf M) ℂ`（添字が多重添字の集合 `𝓘_M`）は、成分を `ν^{-1}` で
番号へ移すと本文の `Mat(n, ℂ)`（`n = 2^M`）と対応する（Lean だけの段の補題。冒頭の説明を見よ）。一つ目は、二つの行列が等しいことと
番号で読んだ全ての成分 `A (ν^{-1}(i)) (ν^{-1}(k))` が等しいことが同じであること、二つ目は、番号の上の成分の割り当て `C` がどれも行列の成分になることである。
`ν^{-1}` は `σ` で、`ν(σ(k)) = finIndexToZZ n k`（`exists_inverse_of_kronecker_numbering`）によって定まる。 -/
theorem tensorPow_entries_by_kronecker_numbering (M : ℕ) :
    ∀ (n : ℕ), (∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k) →
      ∀ (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
        (∀ A B : Matrix (Conf M) (Conf M) ℂ, A = B ↔ ∀ i k : Fin n, A (σ i) (σ k) = B (σ i) (σ k)) ∧
          ∀ C : Matrix (Fin n) (Fin n) ℂ, ∃ A : Matrix (Conf M) (Conf M) ℂ, ∀ i k : Fin n, A (σ i) (σ k) = C i k := by
  intro n hord σ hσ
  -- `σ` の単射は `finIndexToZZ n` の単射から（`finIndexToZZ_bijective_onto_index_set`）
  have hinj : ∀ k k' : Fin n, σ k = σ k' → k = k' := fun k k' h =>
    (finIndexToZZ_bijective_onto_index_set n).1 k k' (by rw [← hσ, ← hσ, h])
  -- `σ` の全射は `ν` の単射から（`kronecker_numbering_injective`）
  have hsurj : ∀ I : Conf M, ∃ k : Fin n, σ k = I := fun I => by
    obtain ⟨k, hk⟩ := hord I
    exact ⟨k, kronecker_numbering_injective _ _ (by rw [hσ, hk])⟩
  refine ⟨fun A B => ⟨fun h i k => by rw [h], fun h => ?_⟩, fun C => ?_⟩
  · funext I K                                              -- 写像の等号は点ごと（`set_and_algebra_notation`）
    obtain ⟨i, rfl⟩ := hsurj I
    obtain ⟨k, rfl⟩ := hsurj K
    exact h i k
  · classical
    refine ⟨fun I K => C (Classical.choose (hsurj I)) (Classical.choose (hsurj K)), fun i k => ?_⟩
    show C (Classical.choose (hsurj (σ i))) (Classical.choose (hsurj (σ k))) = C i k
    rw [hinj _ _ (Classical.choose_spec (hsurj (σ i))), hinj _ _ (Classical.choose_spec (hsurj (σ k)))]

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

/-- **`mat_mult`**: Lean の `TensorPow M` の積の成分を `ν^{-1}` で番号へ移すと、本文の `(AB)_{ik} := Σ_{j=1}^{n} A_{ij} B_{jk}`（`n = 2^M`）の
右辺に等しい（Lean だけの段の補題。冒頭の説明を見よ）。mathlib の積の成分は `𝓘_M`（Lean の `Conf M`）の上の和で、それを番号の上の和へ移すのは
`def_finite_sum_of_complex_numbers_over_multi_indices`（`finset_sum_conf_complex_eq_finite_sum_over_multi_indices`）である。 -/
theorem tensorPow_mul_apply_eq_mat_mult (M : ℕ) :
    ∀ (n : ℕ), (∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k) →
      ∀ (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
        ∀ (A B : TensorPow M) (i k : Fin n),
          (A * B) (σ i) (σ k) = ∑ j : Fin n, A (σ i) (σ j) * B (σ j) (σ k) := by
  intro n hord σ hσ A B i k
  calc (A * B) (σ i) (σ k)
      = ∑ J : Conf M, A (σ i) J * B J (σ k) := Matrix.mul_apply  -- mathlib の行列の積の成分
    _ = ∑ j : Fin n, A (σ i) (σ j) * B (σ j) (σ k) :=
        finset_sum_conf_complex_eq_finite_sum_over_multi_indices M n hord σ hσ _
                                                            -- `def_finite_sum_of_complex_numbers_over_multi_indices`

/-- **`mat_mult`**（`𝓘_M` の添字の形）: `TensorPow M` の積の成分は `(AB)_{IK} = Σ_{J∈𝓘_M} A_{IJ} B_{JK}` である。
`I = ν^{-1}(i)`・`K = ν^{-1}(k)` と書いて `tensorPow_mul_apply_eq_mat_mult` で番号の上の和にし、
`def_finite_sum_of_complex_numbers_over_multi_indices` で `𝓘_M` の上の和へ戻す（Lean だけの段。本文の和の添字を `𝓘_M` の元で書く証明の段が使う）。 -/
theorem tensorPow_mul_apply {M : ℕ} (A B : TensorPow M) (I K : Conf M) :
    (A * B) I K = ∑ J : Conf M, A I J * B J K := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- `ν^{-1}` の全射（`kronecker_numbering_injective`）: `I = σ(i)`・`K = σ(k)`
  obtain ⟨i, hi⟩ := hord I
  obtain ⟨k, hk⟩ := hord K
  have hI : σ i = I := kronecker_numbering_injective _ _ (by rw [hσ, hi])
  have hK : σ k = K := kronecker_numbering_injective _ _ (by rw [hσ, hk])
  subst hI hK
  calc (A * B) (σ i) (σ k)
      = ∑ j : Fin n, A (σ i) (σ j) * B (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ A B i k  -- `mat_mult`
    _ = ∑ J : Conf M, A (σ i) J * B J (σ k) :=
        (finset_sum_conf_complex_eq_finite_sum_over_multi_indices M n hord σ hσ
          (fun J => A (σ i) J * B J (σ k))).symm
                                                            -- `def_finite_sum_of_complex_numbers_over_multi_indices`

end Ising2D
