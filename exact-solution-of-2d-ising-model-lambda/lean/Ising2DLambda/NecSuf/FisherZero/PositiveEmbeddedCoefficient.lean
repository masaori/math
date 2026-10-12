import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 本文の十二行。零を保つ包含と右作用、加法の右単位元、表示の一意性、
正係数の非負性・非零性、正錐の第一条件だけを用いる。
表示の結論は仮定せず、三等号から所属の証人と表示を作る。
体・全順序・乗法全体・根の平方条件は不要である。 -/
theorem embedded_coefficient_positive_necSuf
    {A V : Type*} [Zero A] [Zero V] [Add V]
    (hAddZero : ∀ z : V, z + 0 = z)
    (embed : A → V) (hEmbedZero : embed 0 = 0)
    (rightMul : V → V) (hRightZero : rightMul 0 = 0)
    (nonnegative positive : A → Prop)
    (hNonnegativeZero : nonnegative 0)
    (hPositiveNonnegative : ∀ q : A, positive q → nonnegative q)
    (hPositiveNeZero : ∀ q : A, positive q → q ≠ 0)
    (rep : {z : V // ∃ a b : A, z = embed a + rightMul (embed b)} → A × A)
    (hUnique : ∀ x : {z : V // ∃ a b : A, z = embed a + rightMul (embed b)},
      ∀ a b : A, x.val = embed a + rightMul (embed b) → rep x = (a, b))
    (P : A × A → Prop)
    (hFirst : ∀ a b : A, nonnegative a → nonnegative b →
      (a, b) ≠ (0, 0) → P (a, b))
    (q : A) (hq : positive q) :
    ∃ hmem : (∃ a b : A, embed q = embed a + rightMul (embed b)),
      P (rep ⟨embed q, hmem⟩) := by
  have hvalue : embed q = embed q + rightMul (embed 0) := by
    calc
      embed q = embed q + 0 := (hAddZero _).symm
      _ = embed q + rightMul 0 := congrArg (embed q + ·) hRightZero.symm
      _ = embed q + rightMul (embed 0) :=
        congrArg (fun z : V => embed q + rightMul z) hEmbedZero.symm
  have hmem : ∃ a b : A, embed q = embed a + rightMul (embed b) := ⟨q, 0, hvalue⟩
  let x : {z : V // ∃ a b : A, z = embed a + rightMul (embed b)} := ⟨embed q, hmem⟩
  have hrep : rep x = (q, 0) := hUnique x q 0 hvalue
  let a : A := q
  let b : A := 0
  have ha : a = q := rfl
  have hb : b = 0 := rfl
  have ha_nonneg : nonnegative a := ha.symm ▸ hPositiveNonnegative q hq
  have hb_nonneg : nonnegative b := hb.symm ▸ hNonnegativeZero
  have hq_ne : q ≠ 0 := hPositiveNeZero q hq
  have hab_ne : (a, b) ≠ (0, 0) := by
    intro hab
    exact hq_ne (ha.symm.trans (congrArg Prod.fst hab))
  refine ⟨hmem, ?_⟩
  change P (rep x)
  rw [hrep]
  exact hFirst a b ha_nonneg hb_nonneg hab_ne

end Ising2DLambda.NecSuf.FisherZero
