/-
# `Mat(2^M, ℂ)` の正定値行列の合同・正の実数倍・トレース（**具体版**）

対応する人手証明のラベル: `congruence_preserves_positive_definite`・`positive_real_multiple_preserves_positive_definite`
（`structured-latex/content/009_eigenvalues_of_V.ts`）と `trace_of_positive_definite_is_positive`
（同じファイル）の、行列が `Mat(2^M, ℂ)` の場合（`n → 2^M`）。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい
（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/CongruencePreservesPositiveDefinite.lean`・`Ising2D/NecSuf/PositiveMultiplePreservesPositiveDefinite.lean`・
`Ising2D/NecSuf/TraceOfPositiveDefinite.lean`。具体版をその系として導くのは
`ClaimCongruencePreservesPositiveDefiniteFromNecSuf.lean`・`ClaimPositiveRealMultiplePreservesPositiveDefiniteFromNecSuf.lean`・
`ClaimTraceOfPositiveDefiniteIsPositiveFromNecSuf.lean`（`*_tensorPow_of_necSuf`）。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列と `ℂ^{2^M}` の数ベクトルは成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` と `Conf M → ℂ` は
多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分
`A (σ i) (σ k)`・`x (σ k)` が人手の `A_{ik}`・`x_k` である（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。主張は次の順に示す。

* `A ∈ Mat(2^M, ℂ)` が正定値であること（`def_hermitian_positive_definite`。Lean の `IsPositiveDefiniteTensorPow`）を、番号で読んだ成分の行列
  `Aν`（`Fin n` の添字）が正定値であることにする（`isPositiveDefiniteTensorPow_iff_by_kronecker_numbering`）。
  エルミート性は成分ごとの等号（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）と共役転置の成分
  （`matrix_conf_conjTranspose_apply`・`matrix_fin_conjTranspose_apply`）で、`x^*Ax` は `def_conjugate_bilinear_value` の二重の和を
  `def_finite_sum_of_complex_numbers_over_multi_indices`（`finset_sum_conf_complex_eq_finite_sum_over_multi_indices`）で番号の上の和へ移して読む。
  零でない数ベクトルは、番号で読んだ成分の数ベクトルが零でないことと同じである（`confVec_eq_iff_entries_by_kronecker_numbering`）。
* 主張に出る積・共役転置・スカラー倍・トレースの成分を、番号の上の本文の式へ移す（`matrix_conf_mul_apply_eq_mat_mult`・
  `tensorPow_mul_apply_eq_mat_mult`（`mat_mult`）・`tensorPow_one_apply_eq_identity_matrix`（`def_identity_matrix`）・
  `tensorPow_smul_apply`（`def_matrix_scalar_multiple`）・`tensorPow_trace_eq_def_trace`（`def_trace`））。
* 番号で読んだ成分の行列について人手の主張（`ClaimCongruencePreservesPositiveDefinite.lean` の `congruence_preserves_positive_definite`、
  `ClaimPositiveRealMultiplePreservesPositiveDefinite.lean` の `positive_real_multiple_preserves_positive_definite`、
  `ClaimTraceOfPositiveDefiniteIsPositive.lean` の `trace_of_positive_definite_is_positive`）を引く。人手の主張は任意の `n` について述べてあり、
  ここはその `2^M` の場合である。トレースの主張の `n ∈ ℤ_{≥1}` は、`𝓘_M` が空でない（全ての成分が `1` の多重添字がある）ことから出す。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimCongruencePreservesPositiveDefinite
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveRealMultiplePreservesPositiveDefinite
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionConjugateTransposeAndHermitian
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionFiniteSumOverMultiIndices

namespace Ising2D

open Matrix

/-- **`def_hermitian_positive_definite`**（`Mat(2^M, ℂ)`）: `A ∈ TensorPow M` が正定値であることは、`ν^{-1}` で番号へ移した成分の行列
`C`（`C_{ik} = A (ν^{-1}(i)) (ν^{-1}(k))`、`Fin n` の添字）が正定値であることと同じである（Lean だけの段の補題。冒頭の説明を見よ）。 -/
theorem isPositiveDefiniteTensorPow_iff_by_kronecker_numbering (M : ℕ) :
    ∀ (n : ℕ), (∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k) →
      ∀ (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
        ∀ (A : TensorPow M) (C : Matrix (Fin n) (Fin n) ℂ), (∀ i k : Fin n, A (σ i) (σ k) = C i k) →
          (IsPositiveDefiniteTensorPow A ↔
            (Cᴴ = C ∧ ∀ y : Fin n → ℂ, y ≠ 0 → ∃ r : ℝ, 0 < r ∧ conjugateBilinearValue y C y = (r : ℂ))) := by
  intro n hord σ hσ A Aν hAν
  have hent := tensorPow_entries_by_kronecker_numbering M n hord σ hσ
  have hvec := confVec_eq_iff_entries_by_kronecker_numbering M n hord σ hσ
  have hsum := finset_sum_conf_complex_eq_finite_sum_over_multi_indices M n hord σ hσ
  -- エルミート性: `A^* = A` は、番号で読んだ全ての成分の等号 `\overline{A_{ki}} = A_{ik}`、すなわち `(Aν)^* = Aν` と同じ
  have hherm : Aᴴ = A ↔ Aνᴴ = Aν := by
    calc Aᴴ = A
        ↔ ∀ i k : Fin n, Aᴴ (σ i) (σ k) = A (σ i) (σ k) := hent.1 _ _        -- すべての成分が等しい（`def_complex_matrices`）
      _ ↔ ∀ i k : Fin n, Aνᴴ i k = Aν i k := by
          simp only [matrix_conf_conjTranspose_apply, matrix_fin_conjTranspose_apply, hAν]
                                                                               -- `def_hermitian_positive_definite`、`C` の取り方
      _ ↔ Aνᴴ = Aν := Matrix.ext_iff                                          -- すべての成分が等しい（`def_complex_matrices`）
  -- `x^*Ax`: 二重の和を番号の上の和へ移すと、番号で読んだ成分の数ベクトル `x ∘ ν^{-1}` についての `x^*Aνx` になる
  have hcbv : ∀ x : Conf M → ℂ,
      conjugateBilinearValue x A x = conjugateBilinearValue (fun k => x (σ k)) Aν (fun k => x (σ k)) := fun x =>
    calc conjugateBilinearValue x A x
        = ∑ K : Conf M, ∑ L : Conf M, (star (x K) * A K L) * x L := rfl      -- `def_conjugate_bilinear_value`
      _ = ∑ k : Fin n, ∑ L : Conf M, (star (x (σ k)) * A (σ k) L) * x L :=
          hsum _                                                               -- `def_finite_sum_of_complex_numbers_over_multi_indices`
      _ = ∑ k : Fin n, ∑ l : Fin n, (star (x (σ k)) * A (σ k) (σ l)) * x (σ l) :=
          Finset.sum_congr rfl fun k _ => hsum _                               -- `def_finite_sum_of_complex_numbers_over_multi_indices` を各項へ
      _ = ∑ k : Fin n, ∑ l : Fin n, (star (x (σ k)) * Aν k l) * x (σ l) := by
          simp only [hAν]                                                      -- `C` の取り方
      _ = conjugateBilinearValue (fun k => x (σ k)) Aν (fun k => x (σ k)) := rfl  -- `def_conjugate_bilinear_value`
  -- 数ベクトル: `x ≠ 0` は、番号で読んだ成分の数ベクトルが零でないことと同じ
  have hne : ∀ x : Conf M → ℂ, x ≠ 0 ↔ (fun k => x (σ k)) ≠ 0 := fun x => by
    refine not_congr ?_
    calc x = 0
        ↔ ∀ k : Fin n, x (σ k) = (0 : Conf M → ℂ) (σ k) := hvec _ _           -- 数ベクトルの等号は成分ごと（`def_complex_number_vectors`）
      _ ↔ (fun k => x (σ k)) = 0 := by
          simp only [confVec_zero_apply, funext_iff, vec_zero_apply]           -- `def_zero_matrix`、数ベクトルの等号は成分ごと（`def_complex_number_vectors`）
  -- 番号の上の数ベクトル `y` は、ある `x` を番号で読んだものである（`ν` は全単射。`tensorPow_entries_by_kronecker_numbering` の後半を `C_{ik} := y_i` に当てる）
  have hlift : ∀ y : Fin n → ℂ, ∃ x : Conf M → ℂ, (fun k => x (σ k)) = y := fun y => by
    obtain ⟨C, hC⟩ := hent.2 (Matrix.of fun i _ => y i)
    exact ⟨fun I => C I I, funext fun k => hC k k⟩
  constructor
  · rintro ⟨hH, hP⟩
    refine ⟨hherm.1 hH, fun y hy => ?_⟩
    obtain ⟨x, rfl⟩ := hlift y
    obtain ⟨r, hr, hrx⟩ := hP x ((hne x).2 hy)
    exact ⟨r, hr, (hcbv x).symm.trans hrx⟩
  · rintro ⟨hH, hP⟩
    refine ⟨hherm.2 hH, fun x hx => ?_⟩
    obtain ⟨r, hr, hrx⟩ := hP _ ((hne x).1 hx)
    exact ⟨r, hr, (hcbv x).trans hrx⟩

/-- **`congruence_preserves_positive_definite`**（`Mat(2^M, ℂ)`）: `A ∈ TensorPow M` が正定値で `B'B = I` なら `B^*(AB)` は正定値。 -/
theorem congruence_preserves_positive_definite_tensorPow {M : ℕ} {A B B' : TensorPow M}
    (hA : IsPositiveDefiniteTensorPow A) (hB : B' * B = 1) : IsPositiveDefiniteTensorPow (Bᴴ * (A * B)) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  have hpd := isPositiveDefiniteTensorPow_iff_by_kronecker_numbering M n hord σ hσ
  -- 番号で読んだ成分の行列 `A_{ik}`・`B_{ik}`・`B'_{ik}`
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun i k => A (σ i) (σ k) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun i k => B (σ i) (σ k) with hBν
  set B'ν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun i k => B' (σ i) (σ k) with hB'ν
  -- `B^*(AB)` を番号で読んだ成分の行列は `Bν^*(AνBν)`
  have hC : (Matrix.of fun i k => (Bᴴ * (A * B)) (σ i) (σ k)) = Bνᴴ * (Aν * Bν) := by
    ext i k
    calc (Matrix.of fun i k => (Bᴴ * (A * B)) (σ i) (σ k)) i k
        = (Bᴴ * (A * B)) (σ i) (σ k) := rfl                                     -- 番号で読んだ成分の行列の定義
      _ = ∑ j : Fin n, Bᴴ (σ i) (σ j) * (A * B) (σ j) (σ k) :=
          matrix_conf_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k              -- `mat_mult`
      _ = ∑ j : Fin n, Bᴴ (σ i) (σ j) * ∑ l : Fin n, A (σ j) (σ l) * B (σ l) (σ k) := by
          simp only [tensorPow_mul_apply_eq_mat_mult M n hord σ hσ A B]        -- `mat_mult` を各項へ
      _ = ∑ j : Fin n, Bνᴴ i j * ∑ l : Fin n, Aν j l * Bν l k := by
          simp only [matrix_conf_conjTranspose_apply, matrix_fin_conjTranspose_apply, hAν, hBν, Matrix.of_apply]
                                                                                -- `def_hermitian_positive_definite`、`Aν`・`Bν` の定義
      _ = ∑ j : Fin n, Bνᴴ i j * (Aν * Bν) j k := by
          simp only [matrix_mul_apply_sum Aν Bν]                                -- `mat_mult` を各項へ
      _ = (Bνᴴ * (Aν * Bν)) i k := (matrix_mul_apply_sum _ _ _ _).symm          -- `mat_mult`
  -- `B'B = I` を番号で読むと `B'νBν = I`
  have hBinv : B'ν * Bν = 1 := by
    ext i k
    calc (B'ν * Bν) i k
        = ∑ j : Fin n, B'ν i j * Bν j k := matrix_mul_apply_sum _ _ _ _         -- `mat_mult`
      _ = ∑ j : Fin n, B' (σ i) (σ j) * B (σ j) (σ k) := by
          simp only [hB'ν, hBν, Matrix.of_apply]                               -- `B'ν`・`Bν` の定義
      _ = (B' * B) (σ i) (σ k) := (tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k).symm  -- `mat_mult`
      _ = (1 : TensorPow M) (σ i) (σ k) := by rw [hB]                          -- `B'B = I`
      _ = kroneckerDelta i k := tensorPow_one_apply_eq_identity_matrix M n σ hσ i k  -- `def_identity_matrix`
      _ = (1 : Matrix (Fin n) (Fin n) ℂ) i k := (identity_matrix_apply i k).symm    -- `def_identity_matrix`
  refine (hpd _ (Bνᴴ * (Aν * Bν)) fun i k => by rw [← hC]; rfl).2 ?_
  exact congruence_preserves_positive_definite ((hpd A Aν fun _ _ => rfl).1 hA) hBinv            -- `congruence_preserves_positive_definite` の `n → 2^M`

/-- **`positive_real_multiple_preserves_positive_definite`**（`Mat(2^M, ℂ)`）: `A ∈ TensorPow M` が正定値、`α ∈ ℝ_{>0}` なら `α_ℂA` は正定値。 -/
theorem positive_real_multiple_preserves_positive_definite_tensorPow {M : ℕ} {A : TensorPow M}
    (hA : IsPositiveDefiniteTensorPow A) {α : ℝ} (hα : 0 < α) : IsPositiveDefiniteTensorPow ((α : ℂ) • A) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  have hpd := isPositiveDefiniteTensorPow_iff_by_kronecker_numbering M n hord σ hσ
  -- 番号で読んだ成分の行列 `A_{ik}`
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun i k => A (σ i) (σ k) with hAν
  -- `α_ℂA` を番号で読んだ成分の行列は `α_ℂAν`
  have hC : (Matrix.of fun i k => ((α : ℂ) • A) (σ i) (σ k)) = (α : ℂ) • Aν := by
    ext i k
    calc (Matrix.of fun i k => ((α : ℂ) • A) (σ i) (σ k)) i k
        = ((α : ℂ) • A) (σ i) (σ k) := rfl                                     -- 番号で読んだ成分の行列の定義
      _ = (α : ℂ) * A (σ i) (σ k) := tensorPow_smul_apply _ _ _ _               -- `def_matrix_scalar_multiple`
      _ = (α : ℂ) * Aν i k := rfl                                               -- `Aν` の定義
      _ = ((α : ℂ) • Aν) i k := (matrix_smul_apply _ _ _ _).symm                -- `def_matrix_scalar_multiple`
  refine (hpd _ ((α : ℂ) • Aν) fun i k => by rw [← hC]; rfl).2 ?_
  exact positive_real_multiple_preserves_positive_definite ((hpd A Aν fun _ _ => rfl).1 hA) hα    -- `positive_real_multiple_preserves_positive_definite` の `n → 2^M`

/-- **`trace_of_positive_definite_is_positive`**（`Mat(2^M, ℂ)`）: `A ∈ TensorPow M` が正定値なら `tr(A) ∈ ℝ_{>0}`。 -/
theorem trace_of_positive_definite_is_positive_tensorPow {M : ℕ} (A : TensorPow M) (hA : IsPositiveDefiniteTensorPow A) :
    ∃ s : ℝ, 0 < s ∧ A.trace = (s : ℂ) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  have hpd := isPositiveDefiniteTensorPow_iff_by_kronecker_numbering M n hord σ hσ
  -- 番号で読んだ成分の行列 `A_{ik}`
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun i k => A (σ i) (σ k) with hAν
  -- `n ∈ ℤ_{≥1}`: 全ての成分が `1` の多重添字の番号 `k` があるので `{1,…,n}` は空でない
  obtain ⟨k₀, _⟩ := hord (fun _ => 0)
  have hn : 1 ≤ n := Nat.one_le_iff_ne_zero.2 fun h => by subst h; exact k₀.elim0
  -- `tr(A)` を番号で読むと `tr(Aν)`
  have htr : A.trace = Aν.trace :=
    calc A.trace
        = ∑ k : Fin n, A (σ k) (σ k) := tensorPow_trace_eq_def_trace M n hord σ hσ A  -- `def_trace`
      _ = ∑ k : Fin n, Aν k k := rfl                                             -- `Aν` の定義
      _ = Aν.trace := (trace_eq_sum_diag Aν).symm                                -- `def_trace`
  obtain ⟨s, hs, hsA⟩ := trace_of_positive_definite_is_positive hn Aν ((hpd A Aν fun _ _ => rfl).1 hA)  -- `trace_of_positive_definite_is_positive` の `n → 2^M`
  exact ⟨s, hs, htr.trans hsA⟩

end Ising2D
