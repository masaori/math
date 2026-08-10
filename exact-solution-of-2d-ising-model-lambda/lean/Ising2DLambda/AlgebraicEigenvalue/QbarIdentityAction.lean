/-
章「固有値の代数性」の「代数的数を成分とする単位行列と、その作用が列ベクトルを
動かさないこと」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_qbar_identity_matrix`）と主張 1 件（`claim_qbar_identity_action`）に対応する。

  人手証明                                      このファイル
  単位行列 I^Qbar_L                             qbarIdentityMatrix
  鎖の第 1 段（作用の定義）                     qbarAction の展開（rfl）
  鎖の第 2 段（τ'=τ の 1 項を分ける）           Finset.add_sum_erase
  鎖の第 3 段（単位行列の定義）                 if_pos / if_neg
  鎖の第 4 段（単位元との積）                   one_mul
  鎖の第 5 段（零元との積）                     zero_mul
  鎖の第 6 段（零元だけの有限和は零元）         Finset.sum_const_zero
  鎖の第 7 段（零元を足しても変わらない）       add_zero

mathlib の `Matrix.one_mulVec` とその一般論へは委ねず、人手証明の鎖をそのまま書く。

住処: 人手証明のこれらのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarEigenspace

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 代数的数を成分とする単位行列 `I^Qbar_L`（`def_qbar_identity_matrix`）。
対角で `1`、対角の外で `0`。 -/
noncomputable def qbarIdentityMatrix : QbarRowMatrix L :=
  fun τ τ' => if τ' = τ then 1 else 0

/-- 人手証明の本体。`I^Qbar_L · v = v`（`claim_qbar_identity_action`）。
両辺は `R_L` 上の写像なので、`τ` を任意に取ってその値が等しいことを示す。 -/
theorem qbarIdentity_action (v : QbarRowVector L) :
    qbarAction L (qbarIdentityMatrix L) v = v := by
  funext τ
  calc qbarAction L (qbarIdentityMatrix L) v τ
      = ∑ τ' : RowConfig L, (if τ' = τ then (1 : Qbar) else 0) * v τ' := rfl
        -- 第 1 段。作用の定義（と単位行列の定義の展開）。
    _ = (if τ = τ then (1 : Qbar) else 0) * v τ
          + ∑ τ' ∈ (univ : Finset (RowConfig L)).erase τ,
              (if τ' = τ then (1 : Qbar) else 0) * v τ' :=
        (Finset.add_sum_erase _ _ (mem_univ τ)).symm
        -- 第 2 段。有限和から τ'=τ の 1 項を分ける。
    _ = (1 : Qbar) * v τ
          + ∑ τ' ∈ (univ : Finset (RowConfig L)).erase τ, (0 : Qbar) * v τ' := by
        refine congrArg₂ (· + ·) ?_ (sum_congr rfl fun τ' hτ' => ?_)
        · rw [if_pos rfl]
        · rw [if_neg (Finset.mem_erase.mp hτ').1]
        -- 第 3 段。単位行列の定義（対角では 1、対角の外では 0）。
    _ = v τ + ∑ τ' ∈ (univ : Finset (RowConfig L)).erase τ, (0 : Qbar) * v τ' := by
        exact congrArg₂ (· + ·) (one_mul _) rfl
        -- 第 4 段。単位元との積。
    _ = v τ + ∑ _τ' ∈ (univ : Finset (RowConfig L)).erase τ, (0 : Qbar) := by
        exact congrArg₂ (· + ·) rfl (sum_congr rfl fun τ' _ => zero_mul _)
        -- 第 5 段。零元との積。
    _ = v τ + 0 := by rw [Finset.sum_const_zero]
        -- 第 6 段。零元だけの有限和は零元である。
    _ = v τ := add_zero _
        -- 第 7 段。零元を足しても変わらない。

end Ising2DLambda.AlgebraicEigenvalue
