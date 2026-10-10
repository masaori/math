/-
非単射の行選択で、二行を交換した置換の項を二つずつ相殺する必要十分版。
有限和の相殺は加法可換モノイドと有限集合上の不動点を持たない対合だけを使う。
置換和は加法可換群・乗法可換モノイドと積への負号の移送則を使う。
行添字の有限性、添字の順序、環の分配則、標数零、二による除算は仮定しない。
-/
import Ising2DLambda.NecSuf.KacWard.PermutationSignOrbitProduct
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Perm

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 一組を取り出して残りへ強帰納法を適用する、本文の有限和の相殺。 -/
theorem paired_finset_sum_zero_necSuf {X M : Type*} [AddCommMonoid M]
    (S : Finset X) (F : X → X) (w : X → M)
    (hstable : ∀ p ∈ S, F p ∈ S)
    (hinvolution : ∀ p ∈ S, F (F p) = p)
    (hnoFixed : ∀ p ∈ S, F p ≠ p)
    (hpair : ∀ p ∈ S, w p + w (F p) = 0) :
    ∑ p ∈ S, w p = 0 := by
  classical
  induction S using Finset.strongInduction with
  | H S ih =>
    obtain rfl | ⟨p, hp⟩ := S.eq_empty_or_nonempty
    · exact Finset.sum_empty
    have hFp : F p ∈ S.erase p :=
      Finset.mem_erase.mpr ⟨hnoFixed p hp, hstable p hp⟩
    let T := (S.erase p).erase (F p)
    have hsubset : T ⊆ S :=
      (Finset.erase_subset _ _).trans (Finset.erase_subset _ _)
    have hsmaller : T ⊂ S :=
      lt_of_le_of_lt (Finset.erase_subset _ _) (Finset.erase_ssubset hp)
    have hstableT : ∀ q ∈ T, F q ∈ T := by
      intro q hq
      obtain ⟨hqFp, hqErase⟩ := Finset.mem_erase.mp hq
      obtain ⟨hqp, hqS⟩ := Finset.mem_erase.mp hqErase
      have hFqp : F q ≠ p := by
        intro heq
        apply hqFp
        calc
          q = F (F q) := (hinvolution q hqS).symm
          _ = F p := congrArg F heq
      have hFqFp : F q ≠ F p := by
        intro heq
        apply hqp
        calc
          q = F (F q) := (hinvolution q hqS).symm
          _ = F (F p) := congrArg F heq
          _ = p := hinvolution p hp
      exact Finset.mem_erase.mpr
        ⟨hFqFp, Finset.mem_erase.mpr ⟨hFqp, hstable q hqS⟩⟩
    have hsumT : ∑ q ∈ T, w q = 0 :=
      ih T hsmaller hstableT
        (fun q hq => hinvolution q (hsubset hq))
        (fun q hq => hnoFixed q (hsubset hq))
        (fun q hq => hpair q (hsubset hq))
    calc
      ∑ q ∈ S, w q = w p + ∑ q ∈ S.erase p, w q :=
        (Finset.add_sum_erase S w hp).symm
      _ = w p + (w (F p) + ∑ q ∈ T, w q) :=
        congrArg (w p + ·) (Finset.add_sum_erase (S.erase p) w hFp).symm
      _ = (w p + w (F p)) + ∑ q ∈ T, w q := (add_assoc _ _ _).symm
      _ = 0 + ∑ q ∈ T, w q := congrArg (· + ∑ q ∈ T, w q) (hpair p hp)
      _ = 0 + 0 := congrArg (0 + ·) hsumT
      _ = 0 := zero_add _

/-- 同じ行を選ぶ二点の交換で積が保たれ、係数が反転する置換和は零である。 -/
theorem permutation_row_sum_collision_zero_necSuf
    {J K R : Type*} [Fintype J] [DecidableEq J] [AddCommGroup R] [CommMonoid R]
    (hnegMul : ∀ r s : R, (-r) * s = -(r * s))
    (B : K → J → R) (f : J → K) (a b : J) (hab : a ≠ b) (hf : f a = f b)
    (c : Equiv.Perm J → R)
    (hc : ∀ σ : Equiv.Perm J,
      c (σ * Ising2DLambda.NecSuf.KacWard.transpositionPerm a b) = -c σ) :
    ∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (f i) (σ i) = 0 := by
  classical
  let t : Equiv.Perm J := Ising2DLambda.NecSuf.KacWard.transpositionPerm a b
  let F : Equiv.Perm J → Equiv.Perm J := fun σ => σ * t
  let P : Equiv.Perm J → R := fun σ => ∏ i : J, B (f i) (σ i)
  let w : Equiv.Perm J → R := fun σ => c σ * P σ
  have htleft : t a = b := Ising2DLambda.NecSuf.KacWard.transpositionPerm_apply_left a b
  have htright : t b = a := Ising2DLambda.NecSuf.KacWard.transpositionPerm_apply_right a b
  have htinvolution (i : J) : t (t i) = i := transpositionOn_involutive a b i
  have hfstable (i : J) : f (t i) = f i := by
    by_cases hia : i = a
    · subst i
      calc
        f (t a) = f b := congrArg f htleft
        _ = f a := hf.symm
    · by_cases hib : i = b
      · subst i
        calc
          f (t b) = f a := congrArg f htright
          _ = f b := hf
      · exact congrArg f
          (Ising2DLambda.NecSuf.KacWard.transpositionPerm_apply_of_ne a b hia hib)
  have hFinvolution (σ : Equiv.Perm J) : F (F σ) = σ := by
    ext i
    calc
      F (F σ) i = F σ (t i) := rfl
      _ = σ (t (t i)) := rfl
      _ = σ i := congrArg σ (htinvolution i)
  have hFnoFixed (σ : Equiv.Perm J) : F σ ≠ σ := by
    have hpoint : F σ a ≠ σ a := by
      calc
        F σ a = σ (t a) := rfl
        _ = σ b := congrArg σ htleft
        _ ≠ σ a := fun heq => hab (σ.injective heq).symm
    intro heq
    exact hpoint (congrArg (fun ρ : Equiv.Perm J => ρ a) heq)
  have hPstable (σ : Equiv.Perm J) : P (F σ) = P σ := by
    calc
      P (F σ) = ∏ i : J, B (f i) ((F σ) i) := rfl
      _ = ∏ i : J, B (f i) (σ (t i)) := rfl
      _ = ∏ i : J, B (f (t i)) (σ (t i)) :=
        Finset.prod_congr rfl (fun i _ => congrArg (fun k => B k (σ (t i))) (hfstable i).symm)
      _ = ∏ i : J, B (f i) (σ i) :=
        Fintype.prod_equiv t _ _ (fun _ => rfl)
      _ = P σ := rfl
  have hwneg (σ : Equiv.Perm J) : w (F σ) = -w σ := by
    calc
      w (F σ) = c (F σ) * P (F σ) := rfl
      _ = (-c σ) * P (F σ) := congrArg (· * P (F σ)) (hc σ)
      _ = (-c σ) * P σ := congrArg ((-c σ) * ·) (hPstable σ)
      _ = -(c σ * P σ) := hnegMul _ _
      _ = -w σ := rfl
  have hpair (σ : Equiv.Perm J) : w σ + w (F σ) = 0 := by
    calc
      w σ + w (F σ) = w σ + (-w σ) := congrArg (w σ + ·) (hwneg σ)
      _ = 0 := add_neg_cancel _
  calc
    ∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (f i) (σ i) = ∑ σ : Equiv.Perm J, w σ := rfl
    _ = 0 := paired_finset_sum_zero_necSuf Finset.univ F w
      (fun σ _ => Finset.mem_univ (F σ))
      (fun σ _ => hFinvolution σ) (fun σ _ => hFnoFixed σ) (fun σ _ => hpair σ)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
