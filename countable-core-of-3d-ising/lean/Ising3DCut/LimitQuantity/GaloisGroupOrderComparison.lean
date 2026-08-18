/-
「ずらした自由族では Galois 群が非同型である」の Lean 具体版の有限位数側。

SageMath が確かめた二つの入力（最初の群の位数は 4、二つ目の群の位数は
40 の倍数）から、二つの有限群の間に同値が存在しないことを一段で示す。
群作用から 40 が位数を割る段と、末尾ずらしによる極限一致との束ねは後続で行う。
-/
import Mathlib

namespace Ising3DCut.LimitQuantity

/-- 有限群が有限非空集合へ推移的に作用するとき、その集合の元数は群の位数を割る。 -/
theorem card_dvd_card_group_of_pretransitive
    {G X : Type*} [Group G] [Fintype G] [Fintype X]
    [MulAction G X]
    (htransitive : MulAction.IsPretransitive G X)
    (x : X) :
    Fintype.card X ∣ Fintype.card G := by
  letI := htransitive
  rw [← Nat.card_eq_fintype_card, ← MulAction.index_stabilizer_of_transitive G x]
  simpa [Nat.card_eq_fintype_card] using (MulAction.stabilizer G x).index_dvd_card

/-- 既約 40 次多項式の分解体上の Galois 群の位数は 40 の倍数である。 -/
theorem forty_dvd_card_galois_group_of_irreducible
    {F : Type*} [Field F] [CharZero F]
    (p : Polynomial F) [Fintype p.Gal]
    (hp : Irreducible p)
    (hdegree : p.natDegree = 40) :
    40 ∣ Fintype.card p.Gal := by
  letI : Fact ((p.map (algebraMap F p.SplittingField)).Splits) :=
    ⟨Polynomial.SplittingField.splits p⟩
  letI : SMul p.Gal (p.rootSet p.SplittingField) :=
    Polynomial.Gal.smul p p.SplittingField
  letI : MulAction p.Gal (p.rootSet p.SplittingField) :=
    Polynomial.Gal.galAction p p.SplittingField
  have htransitive : MulAction.IsPretransitive p.Gal (p.rootSet p.SplittingField) :=
    Polynomial.Gal.galAction_isPretransitive (p := p) (E := p.SplittingField) hp
  have hcard : Fintype.card (p.rootSet p.SplittingField) = 40 := by
    rw [Polynomial.card_rootSet_eq_natDegree hp.separable
      (Polynomial.SplittingField.splits p), hdegree]
  have hnonempty : Nonempty (p.rootSet p.SplittingField) :=
    Fintype.card_pos_iff.mp (hcard.symm ▸ by decide)
  obtain ⟨x⟩ := hnonempty
  rw [← hcard]
  exact card_dvd_card_group_of_pretransitive
    (G := p.Gal) (X := p.rootSet p.SplittingField) htransitive x

/-- 位数 4 の有限群と、位数が 40 の倍数である有限群は同値でない。 -/
theorem no_equiv_of_card_four_of_forty_dvd_card
    {G₂ G₃ : Type*} [Fintype G₂] [Fintype G₃]
    (h₂ : Fintype.card G₂ = 4)
    (h₃ : 40 ∣ Fintype.card G₃) :
    ¬ Nonempty (G₂ ≃ G₃) := by
  rintro ⟨e⟩
  have hcard : Fintype.card G₂ = Fintype.card G₃ := Fintype.card_congr e
  omega

end Ising3DCut.LimitQuantity
