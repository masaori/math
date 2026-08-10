/-
章「固有値の代数性」の主張「零でない列ベクトルのスカラー倍が零ベクトルならば、
スカラーは 0 である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_smul_eq_zero`）に対応する。

  人手証明                                          このファイル
  v ≠ o_L から v(τ₁) ≠ o_L(τ₁) なる τ₁ を取る       hex（写像の相等は各点の相等）
  o_L(τ₁) = 0（零ベクトルの定義）                   qbarZeroVector の展開
  第 1 の鎖の第 1 段（スカラー倍の定義）            qbarVectorSmul の展開
  第 1 の鎖の第 2 段（仮定 z ⊙ v = o_L）            congrFun h τ₁
  第 1 の鎖の第 3 段（零ベクトルの定義）            qbarZeroVector の展開
  第 2 の鎖の第 1 段（1 は積の単位元）              mul_one
  第 2 の鎖の第 2 段（逆元）                        mul_inv_cancel₀ hτ
  第 2 の鎖の第 3 段（積の結合則）                  mul_assoc
  第 2 の鎖の第 4 段（z·v(τ₁) = 0）                 hzv
  第 2 の鎖の第 5 段（零元との積は零元）            zero_mul

mathlib の `smul_eq_zero`（体上の加群についての一般論）へは委ねず、人手証明の鎖をそのまま書く。
使うのは `Qbar` が体であることのうち「零でない元が積についての逆元を持つこと」だけである。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarEigenspace

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の本体（`claim_qbar_smul_eq_zero`）。
`z ⊙ v = o_L` かつ `v ≠ o_L` ならば `z = 0`。 -/
theorem qbarSmul_eq_zero (z : Qbar) (v : QbarRowVector L)
    (h : qbarVectorSmul L z v = qbarZeroVector L) (hv : v ≠ qbarZeroVector L) :
    z = 0 := by
  -- v ≠ o_L から、値の異なる点 τ₁ を取る（写像の相等は各点の相等である）。
  have hex : ∃ τ : RowConfig L, v τ ≠ qbarZeroVector L τ := by
    by_contra hcon
    apply hv
    funext τ
    by_contra hne
    exact hcon ⟨τ, hne⟩
  obtain ⟨τ₁, hτ₁⟩ := hex
  -- o_L(τ₁) = 0 なので v(τ₁) ≠ 0。
  have hτ : v τ₁ ≠ 0 := hτ₁
  -- 第 1 の鎖。z·v(τ₁) = (z ⊙ v)(τ₁) = o_L(τ₁) = 0。
  have hzv : z * v τ₁ = 0 := by
    calc z * v τ₁ = qbarVectorSmul L z v τ₁ := rfl
      _ = qbarZeroVector L τ₁ := by rw [h]
      _ = 0 := rfl
  -- 第 2 の鎖。逆元を掛けて z を取り出す。
  calc z = z * 1 := (mul_one z).symm
    _ = z * (v τ₁ * (v τ₁)⁻¹) := by rw [mul_inv_cancel₀ hτ]
    _ = (z * v τ₁) * (v τ₁)⁻¹ := (mul_assoc z (v τ₁) (v τ₁)⁻¹).symm
    _ = 0 * (v τ₁)⁻¹ := by rw [hzv]
    _ = 0 := zero_mul _

end Ising2DLambda.AlgebraicEigenvalue
