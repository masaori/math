/-
「頂点ごとの横断数は水平直進数と垂直直進数の積である」
（`claim_vertex_crossing_number_factorization`）の具体版。
閉歩道の添字を `Fin m`、通過頂点と局所通過を写像として持つ。
-/
import Ising2DLambda.KacWard.CrossingNumberVertexDecomposition
import Ising2DLambda.NecSuf.KacWard.VertexCrossingFactorization

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 頂点 `v` での横断数は、そこでの水平直進通過数と垂直直進通過数の積である。 -/
theorem vertex_crossing_number_factorization {m : ℕ} {V : Type} [DecidableEq V]
    (vertex : Fin m → V) (visit : Fin m → LocalVisit) (v : V) :
    (((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).filter
          fun p => vertex p.1 = v).card
      = (Finset.univ.filter fun k : Fin m => vertex k = v ∧
          (visit k).turn = .straight ∧ (visit k).vertical = false).card
        * (Finset.univ.filter fun k : Fin m => vertex k = v ∧
          (visit k).turn = .straight ∧ (visit k).vertical = true).card := by
  let C := (((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
      p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).filter fun p => vertex p.1 = v)
  let D := (Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
      p.1 < p.2 ∧ (vertex p.1 = v ∧ (visit p.1).turn = .straight) ∧
        (vertex p.2 = v ∧ (visit p.2).turn = .straight) ∧
        (visit p.1).vertical ≠ (visit p.2).vertical
  have hCD : C = D := by
    ext p
    simp only [C, D, Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and,
      IndexCrossing, TransverseCrossing]
    constructor
    · rintro ⟨⟨hlt, hvtx, hs₁, hs₂, haxis⟩, hv⟩
      exact ⟨hlt, ⟨hv, hs₁⟩, ⟨hvtx ▸ hv, hs₂⟩, haxis⟩
    · rintro ⟨hlt, ⟨hv₁, hs₁⟩, ⟨hv₂, hs₂⟩, haxis⟩
      exact ⟨⟨hlt, hv₁.trans hv₂.symm, hs₁, hs₂, haxis⟩, hv₁⟩
  change C.card = _
  rw [hCD]
  simpa only [D, and_assoc, and_left_comm, and_comm] using
    (opposite_bool_unordered_pairs_card_necSuf Finset.univ
      (fun k : Fin m => vertex k = v ∧ (visit k).turn = .straight)
      (fun k => (visit k).vertical))

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem vertex_crossing_number_factorization_from_necSuf {m : ℕ} {V : Type}
    [DecidableEq V] (vertex : Fin m → V) (visit : Fin m → LocalVisit) (v : V) :
    (((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).filter
          fun p => vertex p.1 = v).card
      = (Finset.univ.filter fun k : Fin m => vertex k = v ∧
          (visit k).turn = .straight ∧ (visit k).vertical = false).card
        * (Finset.univ.filter fun k : Fin m => vertex k = v ∧
          (visit k).turn = .straight ∧ (visit k).vertical = true).card :=
  vertex_crossing_number_factorization vertex visit v

end Ising2DLambda.KacWard
