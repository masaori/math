/-
有限集合 J の不変部分集合 C 上だけ置換を逆向きにする。
本文の所属同値、両側逆、所属保存、二度反転を、同じ場合分けと計算行で示す。
-/
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Logic.Equiv.Defs

namespace Ising2DLambda.AlgebraicEigenvalue

/-- C 内で逆写像、C 外で元の写像を使う。 -/
def invariantSubsetForward {J : Type*} [Fintype J] [DecidableEq J]
    (C : Finset J) (σ : Equiv.Perm J) (i : J) : J :=
  if i ∈ C then σ.symm i else σ i

/-- 反転した写像の逆候補。 -/
def invariantSubsetBackward {J : Type*} [Fintype J] [DecidableEq J]
    (C : Finset J) (σ : Equiv.Perm J) (i : J) : J :=
  if i ∈ C then σ i else σ.symm i

variable {J : Type*} [Fintype J] [DecidableEq J]

omit [Fintype J] [DecidableEq J] in
/-- 逆写像も C への所属を保つ。本文の二つの同値。 -/
theorem inverse_mem_invariantSubset_iff (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    σ.symm i ∈ C ↔ i ∈ C := by
  calc
    (σ.symm i ∈ C) ↔ (σ (σ.symm i) ∈ C) := (h (σ.symm i)).symm
    _ ↔ i ∈ C := by rw [σ.apply_symm_apply i]

/-- g(f(i)) = i。本文の C 内・外それぞれ三等号。 -/
theorem invariantSubsetBackward_forward (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    invariantSubsetBackward C σ (invariantSubsetForward C σ i) = i := by
  by_cases hi : i ∈ C
  · have hsi : σ.symm i ∈ C := (inverse_mem_invariantSubset_iff C σ h i).mpr hi
    calc
      invariantSubsetBackward C σ (invariantSubsetForward C σ i) =
          invariantSubsetBackward C σ (σ.symm i) :=
        congrArg (invariantSubsetBackward C σ) (if_pos hi)
      _ = σ (σ.symm i) := if_pos hsi
      _ = i := σ.apply_symm_apply i
  · have hsi : σ i ∉ C := fun hmem => hi ((h i).mp hmem)
    calc
      invariantSubsetBackward C σ (invariantSubsetForward C σ i) =
          invariantSubsetBackward C σ (σ i) :=
        congrArg (invariantSubsetBackward C σ) (if_neg hi)
      _ = σ.symm (σ i) := if_neg hsi
      _ = i := σ.symm_apply_apply i

/-- f(g(i)) = i。本文の C 内・外それぞれ三等号。 -/
theorem invariantSubsetForward_backward (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    invariantSubsetForward C σ (invariantSubsetBackward C σ i) = i := by
  by_cases hi : i ∈ C
  · have hsi : σ i ∈ C := (h i).mpr hi
    calc
      invariantSubsetForward C σ (invariantSubsetBackward C σ i) =
          invariantSubsetForward C σ (σ i) :=
        congrArg (invariantSubsetForward C σ) (if_pos hi)
      _ = σ.symm (σ i) := if_pos hsi
      _ = i := σ.symm_apply_apply i
  · have hsi : σ.symm i ∉ C :=
      fun hmem => hi ((inverse_mem_invariantSubset_iff C σ h i).mp hmem)
    calc
      invariantSubsetForward C σ (invariantSubsetBackward C σ i) =
          invariantSubsetForward C σ (σ.symm i) :=
        congrArg (invariantSubsetForward C σ) (if_neg hi)
      _ = σ (σ.symm i) := if_neg hsi
      _ = i := σ.apply_symm_apply i

/-- 両側逆を備えた、不変部分集合上の反転置換。 -/
def invariantSubsetReversal (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) : Equiv.Perm J where
  toFun := invariantSubsetForward C σ
  invFun := invariantSubsetBackward C σ
  left_inv := invariantSubsetBackward_forward C σ h
  right_inv := invariantSubsetForward_backward C σ h

/-- 反転後も C は不変。本文の各場合二つの同値。 -/
theorem invariantSubsetReversal_mem_iff (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    invariantSubsetReversal C σ h i ∈ C ↔ i ∈ C := by
  by_cases hi : i ∈ C
  · calc
      (invariantSubsetReversal C σ h i ∈ C) ↔ (σ.symm i ∈ C) := by
        change (invariantSubsetForward C σ i ∈ C) ↔ _
        rw [show invariantSubsetForward C σ i = σ.symm i from if_pos hi]
      _ ↔ i ∈ C := inverse_mem_invariantSubset_iff C σ h i
  · calc
      (invariantSubsetReversal C σ h i ∈ C) ↔ (σ i ∈ C) := by
        change (invariantSubsetForward C σ i ∈ C) ↔ _
        rw [show invariantSubsetForward C σ i = σ i from if_neg hi]
      _ ↔ i ∈ C := h i

/-- 同じ C で二度反転すると元へ戻る。本文の各場合三等号。 -/
theorem invariantSubsetReversal_twice (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) :
    invariantSubsetReversal C (invariantSubsetReversal C σ h)
      (invariantSubsetReversal_mem_iff C σ h) = σ := by
  apply Equiv.ext
  intro i
  by_cases hi : i ∈ C
  · calc
      invariantSubsetReversal C (invariantSubsetReversal C σ h)
          (invariantSubsetReversal_mem_iff C σ h) i =
          (invariantSubsetReversal C σ h).symm i := if_pos hi
      _ = invariantSubsetBackward C σ i := rfl
      _ = σ i := if_pos hi
  · calc
      invariantSubsetReversal C (invariantSubsetReversal C σ h)
          (invariantSubsetReversal_mem_iff C σ h) i =
          invariantSubsetReversal C σ h i := if_neg hi
      _ = invariantSubsetForward C σ i := rfl
      _ = σ i := if_neg hi

end Ising2DLambda.AlgebraicEigenvalue
