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
  let H := Finset.univ.filter fun k : Fin m => vertex k = v ∧
    (visit k).turn = .straight ∧ (visit k).vertical = false
  let V := Finset.univ.filter fun k : Fin m => vertex k = v ∧
    (visit k).turn = .straight ∧ (visit k).vertical = true
  change D.card = H.card * V.card
  rw [← Finset.card_product]
  symm
  refine Finset.card_bij
    (fun p _ => if p.1 < p.2 then p else (p.2, p.1)) ?_ ?_ ?_
  · intro p hp
    simp only [H, V, Finset.mem_product, Finset.mem_filter, Finset.mem_univ,
      true_and] at hp
    obtain ⟨⟨hv₁, hs₁, ha₁⟩, ⟨hv₂, hs₂, ha₂⟩⟩ := hp
    by_cases hlt : p.1 < p.2
    · simp only [if_pos hlt, D, Finset.mem_filter, Finset.mem_product,
        Finset.mem_univ, true_and]
      exact ⟨hlt, ⟨hv₁, hs₁⟩, ⟨hv₂, hs₂⟩, by simp [ha₁, ha₂]⟩
    · have hne : p.1 ≠ p.2 := by
        intro heq
        have := congrArg (fun k => (visit k).vertical) heq
        simp [ha₁, ha₂] at this
      have hrev : p.2 < p.1 := lt_of_le_of_ne (not_lt.mp hlt) (Ne.symm hne)
      simp only [if_neg hlt, D, Finset.mem_filter, Finset.mem_product,
        Finset.mem_univ, true_and]
      exact ⟨hrev, ⟨hv₂, hs₂⟩, ⟨hv₁, hs₁⟩, by simp [ha₁, ha₂]⟩
  · intro p hp q hq heq
    simp only [H, V, Finset.mem_product, Finset.mem_filter, Finset.mem_univ,
      true_and] at hp hq
    have hpaxis := hp.1.2.2
    have hqaxis := hq.1.2.2
    by_cases hporder : p.1 < p.2 <;> by_cases hqorder : q.1 < q.2
    · simpa [hporder, hqorder] using heq
    · simp only [if_pos hporder, if_neg hqorder] at heq
      have hfirst := congrArg (fun x : Fin m × Fin m => (visit x.1).vertical) heq
      simp [hpaxis, hq.2.2.2] at hfirst
    · simp only [if_neg hporder, if_pos hqorder] at heq
      have hfirst := congrArg (fun x : Fin m × Fin m => (visit x.1).vertical) heq
      simp [hp.2.2.2, hqaxis] at hfirst
    · have hswap : (p.2, p.1) = (q.2, q.1) := by
        simpa [hporder, hqorder] using heq
      exact Prod.ext (congrArg Prod.snd hswap) (congrArg Prod.fst hswap)
  · intro q hq
    simp only [D, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and] at hq
    obtain ⟨horder, ⟨hv₁, hs₁⟩, ⟨hv₂, hs₂⟩, haxis⟩ := hq
    by_cases ha : (visit q.1).vertical = false
    · have hb : (visit q.2).vertical = true := by
        cases hbool : (visit q.2).vertical <;> simp_all
      refine ⟨q, ?_, ?_⟩
      · simp only [H, V, Finset.mem_product, Finset.mem_filter, Finset.mem_univ,
          true_and]
        exact ⟨⟨hv₁, hs₁, ha⟩, ⟨hv₂, hs₂, hb⟩⟩
      · simp [horder]
    · have ha' : (visit q.1).vertical = true := by
        cases hbool : (visit q.1).vertical <;> simp_all
      have hb : (visit q.2).vertical = false := by
        cases hbool : (visit q.2).vertical <;> simp_all
      refine ⟨(q.2, q.1), ?_, ?_⟩
      · simp only [H, V, Finset.mem_product, Finset.mem_filter, Finset.mem_univ,
          true_and]
        exact ⟨⟨hv₂, hs₂, hb⟩, ⟨hv₁, hs₁, ha'⟩⟩
      · simp [not_lt.mpr (le_of_lt horder)]

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
