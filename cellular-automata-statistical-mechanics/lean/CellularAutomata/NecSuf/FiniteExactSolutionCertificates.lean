/-
正本: structured-latex/content/finite-exact-solution-certificates.ts の必要十分版。

片側写像の全単射性と braid 条件の非含意に必要なのは、型、二体写像、
片側写像の全単射性、および二つの braid 合成を分ける一入力だけである。
有限性と等号判定は有限表から条件を決定する段にだけ要る。
二元状態、セル、局所規則、実数、複素数、除算、対数、極限は一般定理には要らない。
-/
import CellularAutomata.FiniteExactSolutionCertificates

namespace CellularAutomata.NecSuf.FiniteExactSolutionCertificates

open CellularAutomata.FiniteYangBaxterBoundary

variable {X : Type*}

/-- 二体写像の全ての左片側写像と右片側写像が全単射であること。 -/
def HasBijectiveSlices (R : PairMap X) : Prop :=
  (∀ x, Function.Bijective (fun y => (R (x, y)).1)) ∧
    ∀ y, Function.Bijective (fun x => (R (x, y)).2)

/-- 片側写像による一般定義は具体版の古典的非退化性と必要十分である。 -/
theorem hasBijectiveSlices_iff_classicallyNondegenerate (R : PairMap X) :
    HasBijectiveSlices R ↔
      CellularAutomata.FiniteExactSolutionCertificates.ClassicallyNondegenerate R := by
  rfl

/-- 一つの入力が二つの braid 合成を分ければ、その二体写像は braid 条件を満たさない。 -/
theorem not_satisfiesBraid_of_witness (R : PairMap X) (witness : X × X × X)
    (hne :
      (adjacent12 R ∘ adjacent23 R ∘ adjacent12 R) witness ≠
        (adjacent23 R ∘ adjacent12 R ∘ adjacent23 R) witness) :
    ¬ SatisfiesBraid R := by
  intro h
  exact hne (congrFun h witness)

/--
全単射な片側写像と braid 合成を分ける一入力があれば、古典的非退化性から
braid 条件への含意に対する反例が得られる。型の有限性は使わない。
-/
theorem nondegeneracy_does_not_imply_braid_of_witness
    (R : PairMap X) (witness : X × X × X)
    (hSlices : HasBijectiveSlices R)
    (hne :
      (adjacent12 R ∘ adjacent23 R ∘ adjacent12 R) witness ≠
        (adjacent23 R ∘ adjacent12 R ∘ adjacent23 R) witness) :
    ∃ U : PairMap X, HasBijectiveSlices U ∧ ¬ SatisfiesBraid U := by
  exact ⟨R, hSlices, not_satisfiesBraid_of_witness R witness hne⟩

/-! ## 具体版の導出 -/

section Derivation

open CellularAutomata.FiniteExactSolutionCertificates

/-- 具体版の古典的非退化性は一般の片側全単射条件と同値である。 -/
theorem classicallyNondegenerate_iff_hasBijectiveSlices_of_necSuf (R : PairMap X) :
    ClassicallyNondegenerate R ↔ HasBijectiveSlices R := by
  exact (hasBijectiveSlices_iff_classicallyNondegenerate R).symm

/-- 明示写像は一般の片側全単射条件を満たす。 -/
theorem binaryCounterexample_hasBijectiveSlices_of_necSuf :
    HasBijectiveSlices binaryNondegenerateCounterexample := by
  exact (hasBijectiveSlices_iff_classicallyNondegenerate _).2
    binaryCounterexample_classicallyNondegenerate

/-- 明示反例の一入力は二つの braid 合成を分ける。 -/
theorem binaryCounterexample_braid_witness_of_necSuf :
    (adjacent12 binaryNondegenerateCounterexample ∘
        adjacent23 binaryNondegenerateCounterexample ∘
        adjacent12 binaryNondegenerateCounterexample) (true, false, false) ≠
      (adjacent23 binaryNondegenerateCounterexample ∘
        adjacent12 binaryNondegenerateCounterexample ∘
        adjacent23 binaryNondegenerateCounterexample) (true, false, false) := by
  decide

/-- 具体版の非含意は一般の反例定理の特殊化である。 -/
theorem classicalNondegeneracy_does_not_imply_braid_of_necSuf :
    ∃ R : PairMap Bool, ClassicallyNondegenerate R ∧ ¬ SatisfiesBraid R := by
  obtain ⟨R, hSlices, hNotBraid⟩ :=
    nondegeneracy_does_not_imply_braid_of_witness
      binaryNondegenerateCounterexample (true, false, false)
      binaryCounterexample_hasBijectiveSlices_of_necSuf
      binaryCounterexample_braid_witness_of_necSuf
  exact ⟨R, (hasBijectiveSlices_iff_classicallyNondegenerate R).1 hSlices, hNotBraid⟩

end Derivation

end CellularAutomata.NecSuf.FiniteExactSolutionCertificates
