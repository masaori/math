/-
交互の二色付けから二つの完全マッチングを作る必要十分版。
本文と同じ二場合の計算で、色に応じて選ぶ隣接写像が不動点のない対合になる。
必要なのは互いに逆な二写像と色反転だけで、有限性・順序・群構造は使わない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*}

/-- 第一色では順方向、第二色では逆方向の隣接点を選ぶ。 -/
noncomputable def alternatingNeighbor (f g : J → J) (C : Set J) (i : J) : J := by
  classical
  exact if i ∈ C then f i else g i

/-- 各点と色に応じて選んだ隣接点の対を集める。 -/
def alternatingNeighborPairs (f g : J → J) (C : Set J) : Set (Set J) :=
  {p | ∃ i : J, p = {i, alternatingNeighbor f g C i}}

/-- 順方向の色反転と右逆の法則から、逆方向の色反転を得る。 -/
theorem alternatingNeighbor_inverse_color (f g : J → J)
    (hfg : ∀ i : J, f (g i) = i) (C : Set J)
    (h : ∀ i : J, f i ∈ C ↔ i ∉ C) (i : J) :
    g i ∈ C ↔ i ∉ C := by
  classical
  calc
    g i ∈ C ↔ ¬¬(g i ∈ C) := not_not.symm
    _ ↔ ¬(f (g i) ∈ C) := (not_congr (h (g i))).symm
    _ ↔ i ∉ C := by rw [hfg i]

/-- どちらの色でも、選んだ隣接点の色は元の点と異なる。 -/
theorem alternatingNeighbor_color (f g : J → J)
    (hfg : ∀ i : J, f (g i) = i) (C : Set J)
    (h : ∀ i : J, f i ∈ C ↔ i ∉ C) (i : J) :
    alternatingNeighbor f g C i ∈ C ↔ i ∉ C := by
  classical
  by_cases hi : i ∈ C
  · calc
      alternatingNeighbor f g C i ∈ C ↔ f i ∈ C := by
        rw [alternatingNeighbor, if_pos hi]
      _ ↔ i ∉ C := h i
  · calc
      alternatingNeighbor f g C i ∈ C ↔ g i ∈ C := by
        rw [alternatingNeighbor, if_neg hi]
      _ ↔ i ∉ C := alternatingNeighbor_inverse_color f g hfg C h i

/-- 色反転で不動点を排除し、両側逆の法則で二回の適用を計算する。 -/
theorem alternatingNeighbor_involution (f g : J → J)
    (hgf : ∀ i : J, g (f i) = i) (hfg : ∀ i : J, f (g i) = i)
    (C : Set J) (h : ∀ i : J, f i ∈ C ↔ i ∉ C) :
    (∀ i : J, alternatingNeighbor f g C i ≠ i) ∧
      Function.Involutive (alternatingNeighbor f g C) := by
  classical
  constructor
  · intro i hfixed
    have hcolor := alternatingNeighbor_color f g hfg C h i
    by_cases hi : i ∈ C
    · have hnext : alternatingNeighbor f g C i ∈ C := by
        rw [hfixed]
        exact hi
      exact (hcolor.mp hnext) hi
    · have hnext : alternatingNeighbor f g C i ∈ C := hcolor.mpr hi
      have hmem : i ∈ C := by
        rw [← hfixed]
        exact hnext
      exact hi hmem
  · intro i
    by_cases hi : i ∈ C
    · have hnext : f i ∉ C := fun hf => (h i).mp hf hi
      calc
        alternatingNeighbor f g C (alternatingNeighbor f g C i) =
            alternatingNeighbor f g C (f i) :=
          congrArg (alternatingNeighbor f g C) (if_pos hi)
        _ = g (f i) := by rw [alternatingNeighbor, if_neg hnext]
        _ = i := hgf i
    · have hnext : g i ∈ C :=
        (alternatingNeighbor_inverse_color f g hfg C h i).mpr hi
      calc
        alternatingNeighbor f g C (alternatingNeighbor f g C i) =
            alternatingNeighbor f g C (g i) :=
          congrArg (alternatingNeighbor f g C) (if_neg hi)
        _ = f (g i) := by rw [alternatingNeighbor, if_pos hnext]
        _ = i := hfg i

/-- 二つの向きで作った対合の二元軌道は、それぞれ完全マッチングになる。 -/
theorem alternatingNeighbor_matchings (f g : J → J)
    (hgf : ∀ i : J, g (f i) = i) (hfg : ∀ i : J, f (g i) = i)
    (C : Set J) (h : ∀ i : J, f i ∈ C ↔ i ∉ C) :
    IsPerfectMatching (alternatingNeighborPairs f g C) ∧
      IsPerfectMatching (alternatingNeighborPairs g f C) := by
  let τ : FixedPointFreeInvolution J :=
    ⟨alternatingNeighbor f g C, alternatingNeighbor_involution f g hgf hfg C h⟩
  have hinverse : ∀ i : J, g i ∈ C ↔ i ∉ C :=
    alternatingNeighbor_inverse_color f g hfg C h
  let υ : FixedPointFreeInvolution J :=
    ⟨alternatingNeighbor g f C,
      alternatingNeighbor_involution g f hfg hgf C hinverse⟩
  have hforward_eq : alternatingNeighborPairs f g C = involutionPairs τ := rfl
  have hforward_pairs : IsPerfectMatching (involutionPairs τ) :=
    involutionPairs_isPerfectMatching τ
  have hforward : IsPerfectMatching (alternatingNeighborPairs f g C) := by
    rw [hforward_eq]
    exact hforward_pairs
  have hbackward_eq : alternatingNeighborPairs g f C = involutionPairs υ := rfl
  have hbackward_pairs : IsPerfectMatching (involutionPairs υ) :=
    involutionPairs_isPerfectMatching υ
  have hbackward : IsPerfectMatching (alternatingNeighborPairs g f C) := by
    rw [hbackward_eq]
    exact hbackward_pairs
  exact ⟨hforward, hbackward⟩

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
