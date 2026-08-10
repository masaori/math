/-
章「固有値の代数性」の主張「代数的数を成分とする単位行列は積の単位元である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_identity_matrix_unit`）に対応する。人手証明は 2 本の 7 段の鎖なので、
定理も 2 本置く。

  人手証明                                          このファイル
  左から掛ける側の鎖の第 1 段（積の定義）           qbarRowMatrixProduct の展開（rfl）
  左から掛ける側の第 2 段（τ'=τ の 1 項を分ける）   Finset.add_sum_erase
  左から掛ける側の第 3 段（単位行列の定義）         if_pos / if_neg
  左から掛ける側の第 4 段（単位元との積）           one_mul
  左から掛ける側の第 5 段（零元との積）             zero_mul
  左から掛ける側の第 6 段（零元だけの有限和）       Finset.sum_const_zero
  左から掛ける側の第 7 段（零元を足す）             add_zero
  右から掛ける側の第 1 段（積の定義）               qbarRowMatrixProduct の展開（rfl）
  右から掛ける側の第 2 段（τ'=τ'' の 1 項を分ける） Finset.add_sum_erase
  右から掛ける側の第 3 段（単位行列の定義）         if_pos / if_neg
  右から掛ける側の第 4 段（単位元との積）           mul_one
  右から掛ける側の第 5 段（零元との積）             mul_zero
  右から掛ける側の第 6・7 段                        Finset.sum_const_zero / add_zero

mathlib の `Matrix.one_mul` / `Matrix.mul_one`（`Matrix` の半環構造）へは委ねず、
人手証明の鎖をそのまま書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarIdentityAction
import Ising2DLambda.AlgebraicEigenvalue.QbarMatrixProductAssoc

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の左から掛ける側（`claim_qbar_identity_matrix_unit`）。`I^Qbar_L A = A`。 -/
theorem qbarIdentityMatrix_mul (A : QbarRowMatrix L) :
    qbarRowMatrixProduct L (qbarIdentityMatrix L) A = A := by
  funext τ τ''
  calc qbarRowMatrixProduct L (qbarIdentityMatrix L) A τ τ''
      = ∑ τ' : RowConfig L, (if τ' = τ then (1 : Qbar) else 0) * A τ' τ'' := rfl
        -- 第 1 段。積の定義（と単位行列の定義の展開）。
    _ = (if τ = τ then (1 : Qbar) else 0) * A τ τ''
          + ∑ τ' ∈ (univ : Finset (RowConfig L)).erase τ,
              (if τ' = τ then (1 : Qbar) else 0) * A τ' τ'' :=
        (Finset.add_sum_erase _ _ (mem_univ τ)).symm
        -- 第 2 段。有限和から τ'=τ の 1 項を分ける。
    _ = (1 : Qbar) * A τ τ''
          + ∑ τ' ∈ (univ : Finset (RowConfig L)).erase τ, (0 : Qbar) * A τ' τ'' := by
        refine congrArg₂ (· + ·) ?_ (sum_congr rfl fun τ' hτ' => ?_)
        · rw [if_pos rfl]
        · rw [if_neg (Finset.mem_erase.mp hτ').1]
        -- 第 3 段。単位行列の定義（対角では 1、対角の外では 0）。
    _ = A τ τ'' + ∑ τ' ∈ (univ : Finset (RowConfig L)).erase τ, (0 : Qbar) * A τ' τ'' := by
        exact congrArg₂ (· + ·) (one_mul _) rfl
        -- 第 4 段。単位元との積。
    _ = A τ τ'' + ∑ _τ' ∈ (univ : Finset (RowConfig L)).erase τ, (0 : Qbar) := by
        exact congrArg₂ (· + ·) rfl (sum_congr rfl fun τ' _ => zero_mul _)
        -- 第 5 段。零元との積。
    _ = A τ τ'' + 0 := by rw [Finset.sum_const_zero]
        -- 第 6 段。零元だけの有限和は零元である。
    _ = A τ τ'' := add_zero _
        -- 第 7 段。零元を足しても変わらない。

/-- 人手証明の右から掛ける側（`claim_qbar_identity_matrix_unit`）。`A I^Qbar_L = A`。
分けるのは τ' = τ'' の項であり、単位行列の成分は第 2 添字が第 1 添字に等しいときに 1 である。 -/
theorem qbarMatrix_mul_qbarIdentityMatrix (A : QbarRowMatrix L) :
    qbarRowMatrixProduct L A (qbarIdentityMatrix L) = A := by
  funext τ τ''
  calc qbarRowMatrixProduct L A (qbarIdentityMatrix L) τ τ''
      = ∑ τ' : RowConfig L, A τ τ' * (if τ'' = τ' then (1 : Qbar) else 0) := rfl
        -- 第 1 段。積の定義（と単位行列の定義の展開）。
    _ = A τ τ'' * (if τ'' = τ'' then (1 : Qbar) else 0)
          + ∑ τ' ∈ (univ : Finset (RowConfig L)).erase τ'',
              A τ τ' * (if τ'' = τ' then (1 : Qbar) else 0) :=
        (Finset.add_sum_erase _ _ (mem_univ τ'')).symm
        -- 第 2 段。有限和から τ'=τ'' の 1 項を分ける。
    _ = A τ τ'' * (1 : Qbar)
          + ∑ τ' ∈ (univ : Finset (RowConfig L)).erase τ'', A τ τ' * (0 : Qbar) := by
        refine congrArg₂ (· + ·) ?_ (sum_congr rfl fun τ' hτ' => ?_)
        · rw [if_pos rfl]
        · rw [if_neg (Ne.symm (Finset.mem_erase.mp hτ').1)]
        -- 第 3 段。単位行列の定義（第 2 添字が第 1 添字に等しいときだけ 1）。
    _ = A τ τ'' + ∑ τ' ∈ (univ : Finset (RowConfig L)).erase τ'', A τ τ' * (0 : Qbar) := by
        exact congrArg₂ (· + ·) (mul_one _) rfl
        -- 第 4 段。単位元との積。
    _ = A τ τ'' + ∑ _τ' ∈ (univ : Finset (RowConfig L)).erase τ'', (0 : Qbar) := by
        exact congrArg₂ (· + ·) rfl (sum_congr rfl fun τ' _ => mul_zero _)
        -- 第 5 段。零元との積。
    _ = A τ τ'' + 0 := by rw [Finset.sum_const_zero]
        -- 第 6 段。零元だけの有限和は零元である。
    _ = A τ τ'' := add_zero _
        -- 第 7 段。零元を足しても変わらない。

end Ising2DLambda.AlgebraicEigenvalue
