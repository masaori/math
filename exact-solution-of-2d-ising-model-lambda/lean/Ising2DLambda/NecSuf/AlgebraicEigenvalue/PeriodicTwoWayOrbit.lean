import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitInvariant
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.IterateNoShortReturn
import Mathlib.Data.Set.Card

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 二つの写像をそれぞれ有限回たどって到達する点。 -/
def twoWayOrbit {J : Type*} (f g : J → J) (i : J) : Set J :=
  {j | ∃ n : ℕ, f^[n] i = j ∨ g^[n] i = j}

/-- 有限性は不要。正の帰還は巻き戻しの端点に、左逆は逆向きの一歩に必要。 -/
theorem twoWayOrbit_mem_iff_lt_period_necSuf {J : Type*}
    (f g : J → J) (hleft : Function.LeftInverse g f)
    (i : J) (p : ℕ) (hp : 0 < p) (hret : f^[p] i = i) (j : J) :
    j ∈ twoWayOrbit f g i ↔ ∃ r : ℕ, r < p ∧ f^[r] i = j := by
  let e : ℕ → J := fun r => f^[r] i
  let C : Set J := {j | ∃ r : ℕ, r < p ∧ e r = j}
  have hzero : e 0 = i := rfl
  have hperiod : e p = i := hret
  have hlast : p - 1 + 1 = p := by omega
  have hlastLt : p - 1 < p := by omega
  have hstep (r : ℕ) : f (e r) = e (r + 1) := by
    calc
      f (e r) = f^[r] (f i) := iterate_commute_necSuf f r i
      _ = e (r + 1) := rfl
  have hforward (j : J) (hj : j ∈ C) : f j ∈ C := by
    obtain ⟨r, hr, rfl⟩ := hj
    by_cases hnext : r + 1 < p
    · exact ⟨r + 1, hnext, (hstep r).symm⟩
    · have heq : r + 1 = p := by omega
      have hwrap : f (e r) = e 0 := by
        calc
          f (e r) = e (r + 1) := hstep r
          _ = e p := congrArg e heq
          _ = i := hperiod
          _ = e 0 := hzero.symm
      exact ⟨0, hp, hwrap.symm⟩
  have hbackward (j : J) (hj : j ∈ C) : g j ∈ C := by
    obtain ⟨r, hr, rfl⟩ := hj
    cases r with
    | zero =>
      have hwrap : g (e 0) = e (p - 1) := by
        calc
          g (e 0) = g i := congrArg g hzero
          _ = g (e p) := congrArg g hperiod.symm
          _ = g (e (p - 1 + 1)) := congrArg (fun k => g (e k)) hlast.symm
          _ = g (f (e (p - 1))) := congrArg g (hstep (p - 1)).symm
          _ = e (p - 1) := hleft (e (p - 1))
      exact ⟨p - 1, hlastLt, hwrap.symm⟩
    | succ k =>
      have hk : k < p := by omega
      have hback : g (e (k + 1)) = e k := by
        calc
          g (e (k + 1)) = g (f (e k)) := congrArg g (hstep k).symm
          _ = e k := hleft (e k)
      exact ⟨k, hk, hback.symm⟩
  have reach (t : J → J) (hclosed : ∀ j : J, j ∈ C → t j ∈ C)
      (n : ℕ) : t^[n] i ∈ C := by
    induction n with
    | zero =>
      have heq : t^[0] i = e 0 := by
        calc
          t^[0] i = i := rfl
          _ = e 0 := hzero.symm
      rw [heq]
      exact ⟨0, hp, rfl⟩
    | succ n ih =>
      have heq : t^[n + 1] i = t (t^[n] i) := by
        calc
          t^[n + 1] i = t^[n] (t i) := rfl
          _ = t (t^[n] i) := (iterate_commute_necSuf t n i).symm
      rw [heq]
      exact hclosed _ ih
  constructor
  · rintro ⟨n, h | h⟩
    · have hn := reach f hforward n
      rw [h] at hn
      exact hn
    · have hn := reach g hbackward n
      rw [h] at hn
      exact hn
  · rintro ⟨r, _, h⟩
    exact ⟨r, Or.inl h⟩

/-- 短い順向き反復を二方向の軌道へ入れる写像。 -/
def twoWayOrbitEnumeration {J : Type*} (f g : J → J) (i : J) (p : ℕ)
    (r : Fin p) : twoWayOrbit f g i := ⟨f^[r.val] i, ⟨r.val, Or.inl rfl⟩⟩

/-- 短い正の帰還の不在だけを加える。単射性は左逆から得られる。 -/
theorem twoWayOrbitEnumeration_bijective_necSuf {J : Type*}
    (f g : J → J) (hleft : Function.LeftInverse g f)
    (i : J) (p : ℕ) (hp : 0 < p) (hret : f^[p] i = i)
    (hmin : ∀ n : ℕ, 0 < n → f^[n] i = i → p ≤ n) :
    Function.Bijective (twoWayOrbitEnumeration f g i p) := by
  constructor
  · intro r t h
    apply Fin.ext
    exact iterate_injOn_of_no_short_return_necSuf f hleft.injective i p hmin
      r.isLt t.isLt (congrArg Subtype.val h)
  · intro j
    obtain ⟨r, hr, heq⟩ :=
      (twoWayOrbit_mem_iff_lt_period_necSuf f g hleft i p hp hret j.val).mp j.property
    exact ⟨⟨r, hr⟩, Subtype.ext heq⟩

/-- 同じ三等号。周囲の型の有限性も全射性も用いない。 -/
theorem period_eq_twoWayOrbit_ncard_necSuf {J : Type*}
    (f g : J → J) (hleft : Function.LeftInverse g f)
    (i : J) (p : ℕ) (hp : 0 < p) (hret : f^[p] i = i)
    (hmin : ∀ n : ℕ, 0 < n → f^[n] i = i → p ≤ n) :
    p = (twoWayOrbit f g i).ncard := by
  calc
    p = Nat.card (Fin p) := (Nat.card_fin _).symm
    _ = Nat.card (twoWayOrbit f g i) :=
      Nat.card_congr (Equiv.ofBijective _
        (twoWayOrbitEnumeration_bijective_necSuf f g hleft i p hp hret hmin))
    _ = (twoWayOrbit f g i).ncard := rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
