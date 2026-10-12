/-
有限集合上の交互の二色付けから二つの完全マッチングを作る独立具体版。
色に応じて置換か逆置換を選ぶ写像について、本文の各分岐と計算をそのまま示す。
空の添字集合も許し、二色付けの存在やマッチング対からの逆構成は仮定・主張しない。
-/
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatching

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*}

/-- 第一色では置換、第二色では逆置換による隣接点を選ぶ。 -/
noncomputable def alternatingNeighbor (σ : Equiv.Perm J) (C : Set J) (i : J) : J := by
  classical
  exact if i ∈ C then σ i else σ.symm i

/-- 各点と色に応じて選んだ隣接点の対を集める。 -/
def alternatingNeighborPairs (σ : Equiv.Perm J) (C : Set J) : Set (Set J) :=
  {p | ∃ i : J, p = {i, alternatingNeighbor σ C i}}

/-- 置換による色反転から、逆置換による色反転を得る。 -/
theorem alternatingNeighbor_inverse_color (σ : Equiv.Perm J) (C : Set J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∉ C) (i : J) :
    σ.symm i ∈ C ↔ i ∉ C := by
  classical
  calc
    σ.symm i ∈ C ↔ ¬¬(σ.symm i ∈ C) := not_not.symm
    _ ↔ ¬(σ (σ.symm i) ∈ C) := (not_congr (h (σ.symm i))).symm
    _ ↔ i ∉ C := by rw [σ.apply_symm_apply i]

/-- どちらの色でも、選んだ隣接点の色は元の点と異なる。 -/
theorem alternatingNeighbor_color (σ : Equiv.Perm J) (C : Set J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∉ C) (i : J) :
    alternatingNeighbor σ C i ∈ C ↔ i ∉ C := by
  classical
  by_cases hi : i ∈ C
  · calc
      alternatingNeighbor σ C i ∈ C ↔ σ i ∈ C := by
        rw [alternatingNeighbor, if_pos hi]
      _ ↔ i ∉ C := h i
  · calc
      alternatingNeighbor σ C i ∈ C ↔ σ.symm i ∈ C := by
        rw [alternatingNeighbor, if_neg hi]
      _ ↔ i ∉ C := alternatingNeighbor_inverse_color σ C h i

/-- 色反転で不動点を排除し、逆置換の法則で二回の適用を計算する。 -/
theorem alternatingNeighbor_involution (σ : Equiv.Perm J) (C : Set J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∉ C) :
    (∀ i : J, alternatingNeighbor σ C i ≠ i) ∧
      Function.Involutive (alternatingNeighbor σ C) := by
  classical
  constructor
  · intro i hfixed
    have hcolor := alternatingNeighbor_color σ C h i
    by_cases hi : i ∈ C
    · have hnext : alternatingNeighbor σ C i ∈ C := by
        rw [hfixed]
        exact hi
      exact (hcolor.mp hnext) hi
    · have hnext : alternatingNeighbor σ C i ∈ C := hcolor.mpr hi
      have hmem : i ∈ C := by
        rw [← hfixed]
        exact hnext
      exact hi hmem
  · intro i
    by_cases hi : i ∈ C
    · have hnext : σ i ∉ C := fun hf => (h i).mp hf hi
      calc
        alternatingNeighbor σ C (alternatingNeighbor σ C i) =
            alternatingNeighbor σ C (σ i) :=
          congrArg (alternatingNeighbor σ C) (if_pos hi)
        _ = σ.symm (σ i) := by rw [alternatingNeighbor, if_neg hnext]
        _ = i := σ.symm_apply_apply i
    · have hnext : σ.symm i ∈ C :=
        (alternatingNeighbor_inverse_color σ C h i).mpr hi
      calc
        alternatingNeighbor σ C (alternatingNeighbor σ C i) =
            alternatingNeighbor σ C (σ.symm i) :=
          congrArg (alternatingNeighbor σ C) (if_neg hi)
        _ = σ (σ.symm i) := by rw [alternatingNeighbor, if_pos hnext]
        _ = i := σ.apply_symm_apply i

variable [Fintype J]

/-- 順方向と逆方向から作った二元軌道の族は、二つの完全マッチングになる。 -/
theorem alternatingNeighbor_matchings (σ : Equiv.Perm J) (C : Set J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∉ C) :
    IsPerfectMatching (alternatingNeighborPairs σ C) ∧
      IsPerfectMatching (alternatingNeighborPairs σ.symm C) := by
  let τ : FixedPointFreeInvolution J :=
    ⟨alternatingNeighbor σ C, alternatingNeighbor_involution σ C h⟩
  have hinverse : ∀ i : J, σ.symm i ∈ C ↔ i ∉ C :=
    alternatingNeighbor_inverse_color σ C h
  let υ : FixedPointFreeInvolution J :=
    ⟨alternatingNeighbor σ.symm C, alternatingNeighbor_involution σ.symm C hinverse⟩
  have hforward_eq : alternatingNeighborPairs σ C = involutionPairs τ := rfl
  have hforward_pairs : IsPerfectMatching (involutionPairs τ) :=
    involutionPairs_isPerfectMatching τ
  have hforward : IsPerfectMatching (alternatingNeighborPairs σ C) := by
    rw [hforward_eq]
    exact hforward_pairs
  have hbackward_eq : alternatingNeighborPairs σ.symm C = involutionPairs υ := rfl
  have hbackward_pairs : IsPerfectMatching (involutionPairs υ) :=
    involutionPairs_isPerfectMatching υ
  have hbackward : IsPerfectMatching (alternatingNeighborPairs σ.symm C) := by
    rw [hbackward_eq]
    exact hbackward_pairs
  exact ⟨hforward, hbackward⟩

end Ising2DLambda.AlgebraicEigenvalue
