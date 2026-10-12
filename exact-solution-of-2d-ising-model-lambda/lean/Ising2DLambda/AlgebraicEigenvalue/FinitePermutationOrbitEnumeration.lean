import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationPeriodInjective
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitInvariant

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- 短い反復値の集合の順逆の閉性と、反復回数の帰納法による両包含。 -/
theorem finitePermutationOrbit_mem_iff_lt_period (σ : Equiv.Perm J) (i j : J) :
    j ∈ finitePermutationOrbit σ i ↔
      ∃ r : ℕ, r < finitePermutationMinimalPeriod σ i ∧ finiteMapIterate σ r i = j := by
  let p := finitePermutationMinimalPeriod σ i
  have hp : 0 < p := (finitePermutationMinimalPeriod_spec σ i).1
  have hret : finiteMapIterate σ p i = i := (finitePermutationMinimalPeriod_spec σ i).2.1
  let e : ℕ → J := fun r => finiteMapIterate σ r i
  let C : Set J := {j | ∃ r : ℕ, r < p ∧ e r = j}
  have hzero : e 0 = i := rfl
  have hperiod : e p = i := hret
  have hlast : p - 1 + 1 = p := by omega
  have hlastLt : p - 1 < p := by omega
  have hstep (r : ℕ) : σ (e r) = e (r + 1) := by
    calc
      σ (e r) = finiteMapIterate σ r (σ i) := finiteMapIterate_commute σ r i
      _ = e (r + 1) := rfl
  have hforward (j : J) (hj : j ∈ C) : σ j ∈ C := by
    obtain ⟨r, hr, rfl⟩ := hj
    by_cases hnext : r + 1 < p
    · exact ⟨r + 1, hnext, (hstep r).symm⟩
    · have heq : r + 1 = p := by omega
      have hwrap : σ (e r) = e 0 := by
        calc
          σ (e r) = e (r + 1) := hstep r
          _ = e p := congrArg e heq
          _ = i := hperiod
          _ = e 0 := hzero.symm
      exact ⟨0, hp, hwrap.symm⟩
  have hbackward (j : J) (hj : j ∈ C) : σ.symm j ∈ C := by
    obtain ⟨r, hr, rfl⟩ := hj
    cases r with
    | zero =>
      have hwrap : σ.symm (e 0) = e (p - 1) := by
        calc
          σ.symm (e 0) = σ.symm i := congrArg σ.symm hzero
          _ = σ.symm (e p) := congrArg σ.symm hperiod.symm
          _ = σ.symm (e (p - 1 + 1)) := congrArg (fun k => σ.symm (e k)) hlast.symm
          _ = σ.symm (σ (e (p - 1))) := congrArg σ.symm (hstep (p - 1)).symm
          _ = e (p - 1) := σ.symm_apply_apply (e (p - 1))
      exact ⟨p - 1, hlastLt, hwrap.symm⟩
    | succ k =>
      have hk : k < p := by omega
      have hback : σ.symm (e (k + 1)) = e k := by
        calc
          σ.symm (e (k + 1)) = σ.symm (σ (e k)) := congrArg σ.symm (hstep k).symm
          _ = e k := σ.symm_apply_apply (e k)
      exact ⟨k, hk, hback.symm⟩
  have reach (t : J → J) (hclosed : ∀ j : J, j ∈ C → t j ∈ C)
      (n : ℕ) : finiteMapIterate t n i ∈ C := by
    induction n with
    | zero =>
      have heq : finiteMapIterate t 0 i = e 0 := by
        calc
          finiteMapIterate t 0 i = i := rfl
          _ = e 0 := hzero.symm
      rw [heq]
      exact ⟨0, hp, rfl⟩
    | succ n ih =>
      have heq : finiteMapIterate t (n + 1) i = t (finiteMapIterate t n i) := by
        calc
          finiteMapIterate t (n + 1) i = finiteMapIterate t n (t i) := rfl
          _ = t (finiteMapIterate t n i) := (finiteMapIterate_commute t n i).symm
      rw [heq]
      exact hclosed _ ih
  constructor
  · rintro ⟨n, h | h⟩
    · have hn := reach σ hforward n
      rw [h] at hn
      exact hn
    · have hn := reach σ.symm hbackward n
      rw [h] at hn
      exact hn
  · rintro ⟨r, _, h⟩
    exact ⟨r, Or.inl h⟩

/-- 周期未満の添字を軌道の点へ送る、本文の写像。 -/
def finitePermutationOrbitEnumeration (σ : Equiv.Perm J) (i : J)
    (r : Fin (finitePermutationMinimalPeriod σ i)) : finitePermutationOrbit σ i :=
  ⟨finiteMapIterate σ r.val i, ⟨r.val, Or.inl rfl⟩⟩

/-- 単射性は短い反復の一意性、全射性は直前の両包含による。 -/
theorem finitePermutationOrbitEnumeration_bijective (σ : Equiv.Perm J) (i : J) :
    Function.Bijective (finitePermutationOrbitEnumeration σ i) := by
  constructor
  · intro r t h
    apply Fin.ext
    exact finitePermutationIterate_injOn_period σ i r.isLt t.isLt (congrArg Subtype.val h)
  · intro j
    obtain ⟨r, hr, heq⟩ := (finitePermutationOrbit_mem_iff_lt_period σ i j.val).mp j.property
    exact ⟨⟨r, hr⟩, Subtype.ext heq⟩

/-- 添字の個数、全単射による個数の保存、軌道長の定義の三等号。 -/
theorem finitePermutationMinimalPeriod_eq_orbitLength (σ : Equiv.Perm J) (i : J) :
    finitePermutationMinimalPeriod σ i = finitePermutationOrbitLength σ i := by
  calc
    finitePermutationMinimalPeriod σ i = Nat.card (Fin (finitePermutationMinimalPeriod σ i)) :=
      (Nat.card_fin _).symm
    _ = Nat.card (finitePermutationOrbit σ i) :=
      Nat.card_congr (Equiv.ofBijective _ (finitePermutationOrbitEnumeration_bijective σ i))
    _ = finitePermutationOrbitLength σ i := rfl

end Ising2DLambda.AlgebraicEigenvalue
