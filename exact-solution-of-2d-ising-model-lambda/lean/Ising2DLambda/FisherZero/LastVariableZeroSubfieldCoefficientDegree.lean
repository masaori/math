/-
節「対称式の基本定理」のうち、末尾の変数への零代入が部分体係数を保ち全次数を増やさないことの具体版。

  人手証明                                                    このファイル
  主張 `claim_last_variable_zero_subfield_coefficient`        `lastVariableZero_mem_subfieldCoefficientMvPolys`
  主張 `claim_last_variable_zero_total_degree_bound`          `qbarTotalDegree_lastVariableZero_le`
    準備（ez_n(b) は P の台にある）                           `hsupp`
    式鎖の第一〜第六の等号（sz_n(b) = sz_{n+1}(ez_n(b))）      `exponentTotal_exponentZeroExtension`
    式鎖の最後の不等号（最大元の性質）                        `exponentTotal_le_qbarTotalDegree`

全次数は mathlib の `MvPolynomial.totalDegree` を使わず、本文の定義 `qbarTotalDegree` で述べる。

住処: Qbar（全次数と指数の総和は ℕ）。R / C は現れない。
-/
import Ising2DLambda.FisherZero.MonomialAndLastVariableZeroCoefficient
import Ising2DLambda.FisherZero.SymmetricVanishingDivisibleByProduct

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `claim_last_variable_zero_subfield_coefficient` の具体版。`P ∈ F[X_{<n+1}]` なら `lz_n(P) ∈ F[X_{<n}]`。 -/
theorem lastVariableZero_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {n : ℕ}
    (P : QbarMvPoly (n + 1)) (hP : P ∈ subfieldCoefficientMvPolys F (n + 1)) :
    lastVariableZero n P ∈ subfieldCoefficientMvPolys F n := by
  intro b
  -- mco_b(lz_n(P)) = mco_{ez_n(b)}(P) ∈ F。
  rw [lastVariableZero_coeff]
  exact hP (exponentZeroExtension b)

/-- `claim_last_variable_zero_total_degree_bound` の式鎖の等号の部分。`sz_n(b) = sz_{n+1}(ez_n(b))`。 -/
theorem exponentTotal_exponentZeroExtension {n : ℕ} (b : Fin n →₀ ℕ) :
    exponentTotal b = exponentTotal (exponentZeroExtension b) := by
  calc exponentTotal b
      -- 第一の等号: sz_n の定義。
      = ∑ k : Fin n, b k := rfl
      -- 第二の等号: ez_n(b)(k) = b(k)（k < n）。
    _ = ∑ k : Fin n, exponentZeroExtension b k.castSucc :=
        Finset.sum_congr rfl fun k _ => (exponentZeroExtension_castSucc b k).symm
      -- 第三の等号: ℕ の加法の単位元。
    _ = ∑ k : Fin n, exponentZeroExtension b k.castSucc + 0 := (add_zero _).symm
      -- 第四の等号: ez_n(b)(n) = 0。
    _ = ∑ k : Fin n, exponentZeroExtension b k.castSucc + exponentZeroExtension b (Fin.last n) := by
        rw [exponentZeroExtension_last]
      -- 第五の等号: 有限和の末項の分離。
    _ = ∑ k : Fin (n + 1), exponentZeroExtension b k := (Fin.sum_univ_castSucc _).symm
      -- 第六の等号: sz_{n+1} の定義。
    _ = exponentTotal (exponentZeroExtension b) := rfl

/-- `claim_last_variable_zero_total_degree_bound` の具体版。`tdeg_n(lz_n(P)) ≤ tdeg_{n+1}(P)`。 -/
theorem qbarTotalDegree_lastVariableZero_le {n : ℕ} (P : QbarMvPoly (n + 1)) :
    qbarTotalDegree (lastVariableZero n P) ≤ qbarTotalDegree P := by
  apply qbarTotalDegree_le_of_forall
  intro b hb
  -- 準備: mco_{ez_n(b)}(P) = mco_b(lz_n(P)) ≠ 0。
  have hsupp : coeff (exponentZeroExtension b) P ≠ 0 := by
    rw [← lastVariableZero_coeff]
    exact hb
  calc exponentTotal b
      = exponentTotal (exponentZeroExtension b) := exponentTotal_exponentZeroExtension b
    _ ≤ qbarTotalDegree P := exponentTotal_le_qbarTotalDegree P _ hsupp

end Ising2DLambda.FisherZero
