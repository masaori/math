/-
章「固有値の代数性」の「零ベクトル・固有ベクトル・固有値・固有空間と、固有空間が
和とスカラー倍で閉じること」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 4 件
（`def_qbar_zero_vector` / `def_qbar_eigenvector` / `def_qbar_eigenvalue` /
`def_qbar_eigenspace`）と主張 2 件
（`claim_qbar_eigenspace_add` / `claim_qbar_eigenspace_smul`）に対応する。

  人手証明                                    このファイル
  零ベクトル o_L                              qbarZeroVector
  z に属する固有ベクトル                      IsQbarEigenvector
  固有値                                      IsQbarEigenvalue
  固有空間 E_A(z)                             qbarEigenspace
  和の鎖の第 1 段（作用が和を保つ）           qbarAction_add
  和の鎖の第 2 段（和の定義）                 rfl
  和の鎖の第 3 段（固有空間の条件）           仮定 hv・hw の書き換え
  和の鎖の第 4 段（スカラー倍の定義）         rfl
  和の鎖の第 5 段（分配則）                   mul_add
  和の鎖の第 6・7 段（定義へ戻す）            rfl
  倍の鎖の第 1 段（作用がスカラー倍を保つ）   qbarAction_smul
  倍の鎖の第 3 段（固有空間の条件）           仮定 hv の書き換え
  倍の鎖の第 5・7 段（積の結合則）            mul_assoc
  倍の鎖の第 6 段（積の可換性）               mul_comm

mathlib の `Module.End.eigenspace` や部分加群の一般論へは委ねず、人手証明の鎖をそのまま書く。

住処: 人手証明のこれらのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarActionLinear

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 零ベクトル `o_L`（`def_qbar_zero_vector`）。 -/
noncomputable def qbarZeroVector : QbarRowVector L := fun _ => 0

/-- `v` が `A` の `z` に属する固有ベクトルであること（`def_qbar_eigenvector`）。
零ベクトルを除く条件を含む。 -/
def IsQbarEigenvector (A : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L) : Prop :=
  qbarAction L A v = qbarVectorSmul L z v ∧ v ≠ qbarZeroVector L

/-- `z` が `A` の固有値であること（`def_qbar_eigenvalue`）。 -/
def IsQbarEigenvalue (A : QbarRowMatrix L) (z : Qbar) : Prop :=
  ∃ v : QbarRowVector L, IsQbarEigenvector L A z v

/-- 固有空間 `E_A(z)`（`def_qbar_eigenspace`）。固有ベクトルの定義と違い
`v ≠ o_L` を課さない（課すとスカラー倍で閉じない）。 -/
def qbarEigenspace (A : QbarRowMatrix L) (z : Qbar) : Set (QbarRowVector L) :=
  {v | qbarAction L A v = qbarVectorSmul L z v}

/-- 人手証明の本体（その 1）。固有空間は和で閉じる（`claim_qbar_eigenspace_add`）。 -/
theorem qbarEigenspace_add
    (A : QbarRowMatrix L) (z : Qbar) (v w : QbarRowVector L)
    (hv : v ∈ qbarEigenspace L A z) (hw : w ∈ qbarEigenspace L A z) :
    qbarVectorAdd L v w ∈ qbarEigenspace L A z := by
  simp only [qbarEigenspace, Set.mem_setOf_eq] at hv hw ⊢
  have hv' : qbarAction L A v = qbarVectorSmul L z v := hv
  have hw' : qbarAction L A w = qbarVectorSmul L z w := hw
  show qbarAction L A (qbarVectorAdd L v w)
      = qbarVectorSmul L z (qbarVectorAdd L v w)
  funext τ
  calc qbarAction L A (qbarVectorAdd L v w) τ
      = qbarVectorAdd L (qbarAction L A v) (qbarAction L A w) τ := by
        -- 第 1 段。作用が和を保つこと。
        rw [qbarAction_add L A v w]
    _ = (qbarAction L A v) τ + (qbarAction L A w) τ := rfl
        -- 第 2 段。和の定義。
    _ = (qbarVectorSmul L z v) τ + (qbarVectorSmul L z w) τ := by
        -- 第 3 段。固有空間の条件（v, w ∈ E_A(z)）。
        rw [hv', hw']
    _ = z * v τ + z * w τ := rfl
        -- 第 4 段。スカラー倍の定義。
    _ = z * (v τ + w τ) := (mul_add _ _ _).symm
        -- 第 5 段。元と 2 元の和の積についての分配則。
    _ = z * (qbarVectorAdd L v w) τ := rfl
        -- 第 6 段。和の定義。
    _ = qbarVectorSmul L z (qbarVectorAdd L v w) τ := rfl
        -- 第 7 段。スカラー倍の定義。

/-- 人手証明の本体（その 2）。固有空間はスカラー倍で閉じる
（`claim_qbar_eigenspace_smul`）。 -/
theorem qbarEigenspace_smul
    (A : QbarRowMatrix L) (z c : Qbar) (v : QbarRowVector L)
    (hv : v ∈ qbarEigenspace L A z) :
    qbarVectorSmul L c v ∈ qbarEigenspace L A z := by
  simp only [qbarEigenspace, Set.mem_setOf_eq] at hv ⊢
  have hv' : qbarAction L A v = qbarVectorSmul L z v := hv
  show qbarAction L A (qbarVectorSmul L c v)
      = qbarVectorSmul L z (qbarVectorSmul L c v)
  funext τ
  calc qbarAction L A (qbarVectorSmul L c v) τ
      = qbarVectorSmul L c (qbarAction L A v) τ := by
        -- 第 1 段。作用がスカラー倍を保つこと。
        rw [qbarAction_smul L A c v]
    _ = c * (qbarAction L A v) τ := rfl
        -- 第 2 段。スカラー倍の定義。
    _ = c * (qbarVectorSmul L z v) τ := by
        -- 第 3 段。固有空間の条件（v ∈ E_A(z)）。
        rw [hv']
    _ = c * (z * v τ) := rfl
        -- 第 4 段。スカラー倍の定義。
    _ = (c * z) * v τ := (mul_assoc _ _ _).symm
        -- 第 5 段。積の結合則。
    _ = (z * c) * v τ := by
        -- 第 6 段。積の可換性。
        rw [mul_comm c z]
    _ = z * (c * v τ) := mul_assoc _ _ _
        -- 第 7 段。積の結合則。
    _ = z * (qbarVectorSmul L c v) τ := rfl
        -- 第 8 段。スカラー倍の定義。
    _ = qbarVectorSmul L z (qbarVectorSmul L c v) τ := rfl
        -- 第 9 段。スカラー倍の定義。

end Ising2DLambda.AlgebraicEigenvalue
