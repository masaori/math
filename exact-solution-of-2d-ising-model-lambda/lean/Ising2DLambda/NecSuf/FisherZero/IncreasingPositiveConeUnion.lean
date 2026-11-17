import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.NecSuf.FisherZero

/-- 正錐の和集合に必要なのは、上に有向な添字と、各段の正錐の延長である。 -/
theorem increasingPositiveConeUnion_isPositiveCone {K : Type} [Zero K] [Add K] [Mul K] [Neg K]
    (F C : ℕ → Set K)
    (hstep : ∀ n, ExtendsPositiveConeOn (F n) (F (n + 1)) (C n) (C (n + 1))) :
    IsPositiveConeOn {z | ∃ n, z ∈ F n} {z | ∃ n, z ∈ C n} := by
  have hC : Monotone C := monotone_nat_of_le_succ (by
    intro n z hz
    exact ((hstep n).inter_eq z).2 hz |>.1)
  have hF : Monotone F := monotone_nat_of_le_succ (fun n => (hstep n).subset_le)
  refine ⟨?_, ?_, ?_, ?_⟩
  · rintro z ⟨n, hz⟩
    exact ⟨n, (hstep n).cone_F.subset z hz⟩
  · rintro x y ⟨i, hx⟩ ⟨j, hy⟩
    let k := max i j
    exact ⟨k, (hstep k).cone_F.add_mem x y
      (hC (Nat.le_max_left i j) hx) (hC (Nat.le_max_right i j) hy)⟩
  · rintro x y ⟨i, hx⟩ ⟨j, hy⟩
    let k := max i j
    exact ⟨k, (hstep k).cone_F.mul_mem x y
      (hC (Nat.le_max_left i j) hx) (hC (Nat.le_max_right i j) hy)⟩
  · rintro z ⟨i, hz⟩
    have htri := (hstep i).cone_F.trichotomy z hz
    refine ⟨?_, ?_, ?_, ?_⟩
    · rcases htri.1 with hzero | hpos | hneg
      · exact Or.inl hzero
      · exact Or.inr (Or.inl ⟨i, hpos⟩)
      · exact Or.inr (Or.inr ⟨i, hneg⟩)
    · rintro ⟨hzero, j, hpos⟩
      have htri' := (hstep j).cone_F.trichotomy z ((hstep j).cone_F.subset z hpos)
      exact htri'.2.1 ⟨hzero, hpos⟩
    · rintro ⟨hzero, j, hneg⟩
      let k := max i j
      have hzF : z ∈ F k := hF (Nat.le_max_left i j) hz
      exact ((hstep k).cone_F.trichotomy z hzF).2.2.1
        ⟨hzero, hC (Nat.le_max_right i j) hneg⟩
    · rintro ⟨⟨j, hpos⟩, ⟨k, hneg⟩⟩
      let m := max j k
      have hzm : z ∈ F m := (hstep m).cone_F.subset z (hC (Nat.le_max_left j k) hpos)
      exact ((hstep m).cone_F.trichotomy z hzm).2.2.2
        ⟨hC (Nat.le_max_left j k) hpos, hC (Nat.le_max_right j k) hneg⟩

end Ising2DLambda.NecSuf.FisherZero
