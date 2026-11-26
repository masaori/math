/-
実際の周期持ち上げから作った一側閉包について、周期数を一つ増やした回転和の差を求める。
射影、固定四部分列、反復差、元の辺列の一周期、符号反転平行階段の零の順に合成する。
方向対の重みは逆向きにも零で定義しているため、等式には単純性を要しない。
-/
import Ising2DLambda.KacWard.OneSidedClosureCyclicSum
import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurning

namespace Ising2DLambda.KacWard


/-- 周期数だけを変える一側閉包の、実際の格子点列。 -/
def oneSidedClosurePoint (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ)
    (t c : ℕ) : ℕ → ℤ × ℤ :=
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let S := p 0
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  oneSidedPeriodicLiftClosure p
    (iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh))
    (oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c)
    (iteratedTransverseStaircase wh wv S) (c * m) b (c * n)

def oneSidedClosureLength (m L : ℕ) (wv wh : ℤ) (t c : ℕ) : ℕ :=
  c * m + t * (wh.natAbs + wv.natAbs) +
    c * (L * wh.natAbs + L * wv.natAbs) + t * (wh.natAbs + wv.natAbs)

/-- 一側閉包の全歩を辺番号と向きへ射影した列の循環回転和。 -/
def oneSidedClosureProjectedTurning (m L : ℕ) [NeZero L]
    (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ) : ℤ :=
  let W := oneSidedClosurePoint m L base wv wh k₀ t c
  cyclicAdjacentSum (fun e f => directionPairTurning (directionNumber e) (directionNumber f))
    (oneSidedClosureLength m L wv wh t c)
    (fun j => projectedUnitStep L (W j) (W (j + 1) - W j))

/-- 差が四つの単位格子ベクトルのいずれかであることは、成分の差の絶対値の和が一であることと同値である。 -/
theorem latticeUnitStep_iff_abs_sum (x y : ℤ × ℤ) :
    (y - x = (0, 1) ∨ y - x = (1, 0) ∨ y - x = (0, -1) ∨ y - x = (-1, 0)) ↔
      |y.1 - x.1| + |y.2 - x.2| = 1 := by
  obtain ⟨x₁, x₂⟩ := x
  obtain ⟨y₁, y₂⟩ := y
  simp only [Prod.mk_sub_mk, Prod.mk.injEq]
  constructor
  · rintro (⟨h₁, h₂⟩ | ⟨h₁, h₂⟩ | ⟨h₁, h₂⟩ | ⟨h₁, h₂⟩) <;> rw [h₁, h₂] <;> norm_num
  · intro h
    rcases abs_cases (y₁ - x₁) with ⟨ha, _⟩ | ⟨ha, _⟩ <;>
      rcases abs_cases (y₂ - x₂) with ⟨hb, _⟩ | ⟨hb, _⟩ <;>
      rw [ha, hb] at h <;> omega

/-- 本文の第一部分。周期持ち上げの一歩は、商と余りの読み替えにより平面持ち上げの一歩であり、
単位格子ベクトルである。余りが最後の添字なら端点の周期並進を代入する。 -/
theorem periodicPlaneLift_step_unit_of_remainder
    (m L : ℕ) [NeZero m] (base : ℤ → ℤ × ℤ) (wv wh : ℤ)
    (γ : ZMod m → OrientedEdge L)
    (hstep : ∀ j : ℕ, j < m →
      base ((j : ℤ) + 1) = base j + orientedEdgeLatticeStep (γ (j : ZMod m)))
    (hend : base m = base 0 + windingShift L wv wh) (k : ℤ) :
    let u := periodicPlaneLift m base L wv wh (k + 1) - periodicPlaneLift m base L wv wh k
    u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0) := by
  have hm : 0 < m := NeZero.pos m
  have hmz : (m : ℤ) ≠ 0 := by omega
  have hbase (j : ℕ) (hj : j < m) : periodicPlaneLift m base L wv wh j = base j := by
    simp [periodicPlaneLift,
      Int.emod_eq_of_lt (by omega : (0 : ℤ) ≤ j) (by omega : (j : ℤ) < m),
      Int.ediv_eq_zero_of_lt (by omega : (0 : ℤ) ≤ j) (by omega : (j : ℤ) < m)]
  have hterminal : periodicPlaneLift m base L wv wh m = base m := by
    simp [periodicPlaneLift, Int.ediv_self hmz, hend]
  -- 余り r の一歩: r + 1 < m なら P_{r+1} - P_r、r = m - 1 なら端点の並進で P_m - P_{m-1}
  have hfinite (j : ℕ) (hj : j < m) :
      periodicPlaneLift m base L wv wh ((j : ℤ) + 1) -
          periodicPlaneLift m base L wv wh j = orientedEdgeLatticeStep (γ (j : ZMod m)) := by
    have hnext : periodicPlaneLift m base L wv wh ((j : ℤ) + 1) = base ((j : ℤ) + 1) := by
      by_cases hlt : j + 1 < m
      · exact_mod_cast hbase (j + 1) hlt
      · have heq : (j : ℤ) + 1 = m := by omega
        rw [heq, hterminal]
    rw [hnext, hbase j hj, hstep j hj]
    abel
  -- 商と余りの読み替え k = (k mod m) + (k div m)·m
  have hdiv : k = k / (m : ℤ) * m + k % m := (Int.ediv_mul_add_emod k m).symm
  have hleft : k + 1 = (k % m + 1) + (k / m) * m := by omega
  have hright : k = k % m + (k / m) * m := by omega
  have hr0 : 0 ≤ k % (m : ℤ) := Int.emod_nonneg k hmz
  have hrm : k % (m : ℤ) < m := Int.emod_lt_of_pos k (by omega)
  have hrcast : ((k % (m : ℤ)).toNat : ℤ) = k % m := Int.toNat_of_nonneg hr0
  have hreduce :
      periodicPlaneLift m base L wv wh (k + 1) - periodicPlaneLift m base L wv wh k =
        periodicPlaneLift m base L wv wh (((k % (m : ℤ)).toNat : ℤ) + 1) -
          periodicPlaneLift m base L wv wh ((k % (m : ℤ)).toNat : ℤ) := by
    rw [hrcast]
    calc
      _ = periodicPlaneLift m base L wv wh ((k % m + 1) + (k / m) * m) -
          periodicPlaneLift m base L wv wh (k % m + (k / m) * m) := by
        rw [← hleft, ← hright]
      _ = _ := by
        rw [periodicPlaneLift_translate m L hm, periodicPlaneLift_translate m L hm]
        simp only [add_sub_add_right_eq_sub]
  dsimp only
  rw [hreduce, hfinite _ (by omega)]
  exact orientedEdgeLatticeStep_unit _

/-- 本文の第三部分。平行帰路の一歩は、商と余りの読み替えにより平行階段の一歩の逆向きであり、
単位格子ベクトルである。余りが最後の添字なら平行階段の終点が一周期の並進であることを代入する。 -/
theorem oneSidedParallelReturn_step_unit_of_remainder (L : ℕ) (wh wv : ℤ)
    (base : ℤ × ℤ) (c : ℕ) (hn : 0 < L * wh.natAbs + L * wv.natAbs) (s : ℕ) :
    let u := oneSidedParallelReturn L wh wv base c (s + 1) -
      oneSidedParallelReturn L wh wv base c s
    u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0) := by
  let n := L * wh.natAbs + L * wv.natAbs
  let path := windingParallelStaircase L wh wv
  let period : ℤ × ℤ := ((L : ℤ) * wv, (L : ℤ) * wh)
  have hzero : path 0 = 0 := windingParallelStaircase_zero L wh wv
  have hend : path n = period := windingParallelStaircase_end L wh wv
  have hrlt : s % n < n := Nat.mod_lt s hn
  have hreduce : oneSidedParallelReturn L wh wv base c (s + 1) -
      oneSidedParallelReturn L wh wv base c s =
        negatedParallelStaircaseStep L wh wv (s % n) := by
    rw [negatedParallelStaircaseStep_difference]
    change (base + ((c : ℤ) - ((s + 1) / n : ℕ)) • period - path ((s + 1) % n)) -
        (base + ((c : ℤ) - (s / n : ℕ)) • period - path (s % n)) =
      -(path (s % n + 1) - path (s % n))
    have hsucc : s + 1 = (s % n + 1) + n * (s / n) := by
      have := Nat.mod_add_div s n
      omega
    have hdivbase : (s + 1) / n = (s % n + 1) / n + s / n := by
      rw [hsucc, Nat.add_mul_div_left _ _ hn]
    have hmodbase : (s + 1) % n = (s % n + 1) % n := by
      rw [hsucc, Nat.add_mul_mod_self_left]
    by_cases hbefore : s % n + 1 < n
    · -- 余りが n - 2 以下: 同じ周期の中の一歩
      have hdiv : (s + 1) / n = s / n := by
        rw [hdivbase, Nat.div_eq_of_lt hbefore, zero_add]
      have hmod : (s + 1) % n = s % n + 1 := by
        rw [hmodbase, Nat.mod_eq_of_lt hbefore]
      rw [hdiv, hmod]
      abel
    · -- 余りが n - 1: 次の周期の先頭へ移る一歩
      have hrequiv : s % n + 1 = n := by omega
      have hdiv : (s + 1) / n = s / n + 1 := by
        rw [hdivbase, hrequiv, Nat.div_self hn]
        omega
      have hmod : (s + 1) % n = 0 := by
        rw [hmodbase, hrequiv, Nat.mod_self]
      rw [hdiv, hmod, hzero, hrequiv, hend]
      simp only [Nat.cast_add, Nat.cast_one, sub_smul, add_smul, one_smul]
      abel
  dsimp only
  rw [hreduce]
  exact (negatedParallelStaircaseStep_unit_negative L wh wv (s % n) hrlt).1

/-- `claim_one_sided_periodic_lift_closure_closed_unit_steps` を実際の一側閉包に当てたもの。
本文と同じく、四部分の三接合と始点・終点の一致を定義から確かめ、各部分の一歩が単位格子ベクトルで
あること（第一部分は商と余りの読み替え、第二・第四部分は反復横断階段の一歩、第三部分は平行階段の
一歩の逆向き）を `oneSidedPeriodicLiftClosure_closed_unit_steps` へ代入する。 -/
theorem oneSidedClosurePoint_unit_steps
    (m L : ℕ) [NeZero m] (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ)
    (γ : ZMod m → OrientedEdge L)
    (hstep : ∀ j : ℕ, j < m →
      base ((j : ℤ) + 1) = base j + orientedEdgeLatticeStep (γ (j : ZMod m)))
    (hend : base m = base 0 + windingShift L wv wh)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c) :
    ∀ j < oneSidedClosureLength m L wv wh t c,
      let u := oneSidedClosurePoint m L base wv wh k₀ t c (j + 1) -
        oneSidedClosurePoint m L base wv wh k₀ t c j
      u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0) := by
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let S := p 0
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  let q := iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh)
  let r := oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c
  let s := iteratedTransverseStaircase wh wv S
  have hm : 0 < m := NeZero.pos m
  have htrans : 0 < wh.natAbs + wv.natAbs := by
    by_contra hz
    have hz' : wh.natAbs + wv.natAbs = 0 := by omega
    simp [hz'] at hb
  have hwind : (wh, wv) ≠ (0, 0) := by
    intro h
    have hh : wh = 0 := congrArg Prod.fst h
    have hv : wv = 0 := congrArg Prod.snd h
    simp [hh, hv] at hb
  have hzeroT (B : ℤ × ℤ) : iteratedTransverseStaircase wh wv B 0 = B := by
    simp [iteratedTransverseStaircase, iteratedStaircase,
      windingTransverseStaircase, twoPhaseStaircase]
  have hmultT (B : ℤ × ℤ) : iteratedTransverseStaircase wh wv B b = B + t • (wh, -wv) := by
    simp [b, iteratedTransverseStaircase, iteratedStaircase, Nat.mul_div_cancel _ htrans,
      windingTransverseStaircase, twoPhaseStaircase]
  -- 三接合と始点の一致（本文の前半の式鎖）
  have h12 : p (c * m) = q 0 := by
    change _ = iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) 0
    rw [hzeroT]
    simpa [p, S, Nat.cast_mul] using
      periodicPlaneLift_translate m L hm base wv wh k₀ (c : ℤ)
  have h23 : q b = r 0 := by
    change iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) b =
      oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c 0
    rw [hmultT]
    simp only [oneSidedParallelReturn, Nat.zero_div, Nat.cast_zero, sub_zero,
      Nat.zero_mod, windingParallelStaircase_zero, sub_zero, windingShift]
    simp only [natCast_zsmul]
    abel
  have h34 : r (c * n) = s b := by
    change oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c (c * n) =
      iteratedTransverseStaircase wh wv S b
    rw [hmultT]
    simp [oneSidedParallelReturn, n, Nat.mul_div_cancel _ hn,
      windingParallelStaircase_zero]
  have h41 : s 0 = p 0 := hzeroT S
  -- 各部分の一歩（本文の後半）
  have hu : ∀ i < c * m, |(p (i + 1)).1 - (p i).1| + |(p (i + 1)).2 - (p i).2| = 1 := by
    intro i _
    have he : k₀ + ((i + 1 : ℕ) : ℤ) = k₀ + i + 1 := by push_cast; ring
    have h := periodicPlaneLift_step_unit_of_remainder m L base wv wh γ hstep hend (k₀ + i)
    rw [← he] at h
    exact (latticeUnitStep_iff_abs_sum _ _).1 h
  have hv : ∀ i < b, |(q (i + 1)).1 - (q i).1| + |(q (i + 1)).2 - (q i).2| = 1 := by
    intro i _
    apply (latticeUnitStep_iff_abs_sum _ _).1
    rcases iteratedTransverseStaircase_unit_step wh wv
      (S + c • windingShift L wv wh) hwind i with h | h | h | h
    · exact Or.inr (Or.inl h)
    · exact Or.inr (Or.inr (Or.inr h))
    · exact Or.inl h
    · exact Or.inr (Or.inr (Or.inl h))
  have hr : ∀ i < c * n, |(r (i + 1)).1 - (r i).1| + |(r (i + 1)).2 - (r i).2| = 1 := by
    intro i _
    exact (latticeUnitStep_iff_abs_sum _ _).1
      (oneSidedParallelReturn_step_unit_of_remainder L wh wv (S + t • (wh, -wv)) c hn i)
  have hx : ∀ i < b, |(s (i + 1)).1 - (s i).1| + |(s (i + 1)).2 - (s i).2| = 1 := by
    intro i _
    apply (latticeUnitStep_iff_abs_sum _ _).1
    rcases iteratedTransverseStaircase_unit_step wh wv S hwind i with h | h | h | h
    · exact Or.inr (Or.inl h)
    · exact Or.inr (Or.inr (Or.inr h))
    · exact Or.inl h
    · exact Or.inr (Or.inr (Or.inl h))
  obtain ⟨_, _, hall⟩ := oneSidedPeriodicLiftClosure_closed_unit_steps p q r s (c * m) b (c * n)
    (Nat.mul_pos hc hm) hb (Nat.mul_pos hc hn) h12 h23 h34 h41 hu hv hr hx
  intro j hj
  change j < c * m + b + c * n + b at hj
  exact (latticeUnitStep_iff_abs_sum _ _).2 (hall j (by omega))

/-- 射影の回転和を、実際の格子歩の回転和へ同定する。 -/
theorem oneSidedClosureProjectedTurning_eq_lattice
    (m L : ℕ) [NeZero m] [NeZero L] (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ)
    (γ : ZMod m → OrientedEdge L)
    (hstep : ∀ j : ℕ, j < m →
      base ((j : ℤ) + 1) = base j + orientedEdgeLatticeStep (γ (j : ZMod m)))
    (hend : base m = base 0 + windingShift L wv wh)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c) :
    oneSidedClosureProjectedTurning m L base wv wh k₀ t c =
      cyclicAdjacentSum latticeStepTurning (oneSidedClosureLength m L wv wh t c)
        (fun j => oneSidedClosurePoint m L base wv wh k₀ t c (j + 1) -
          oneSidedClosurePoint m L base wv wh k₀ t c j) := by
  apply planeProjection_cyclicTurning L _ (by unfold oneSidedClosureLength; omega)
  exact oneSidedClosurePoint_unit_steps m L base wv wh k₀ t c γ hstep hend hn hb hc

/-- 有限語の零延長は、その長さの循環隣接和を変えない。 -/
theorem cyclicTurning_extend_finite_word (m : ℕ) (hm : 0 < m) (u : ℕ → ℤ × ℤ) :
    cyclicAdjacentSum latticeStepTurning m (extendLatticeWord (fun i : Fin m => u i.val)) =
      cyclicAdjacentSum latticeStepTurning m u := by
  apply cyclicAdjacentSum_congr_range latticeStepTurning m hm
  intro j hj
  simp [extendLatticeWord, hj]

/-- 符号反転平行階段の射影は、既存の有効な一歩の回転表で零を与える。 -/
theorem negatedParallelStaircase_projectedTurning_zero
    (L : ℕ) [NeZero L] (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum (fun e f => directionPairTurning (directionNumber e) (directionNumber f))
      (L * wh.natAbs + L * wv.natAbs)
      (fun j => projectedUnitStep L (-windingParallelStaircase L wh wv j)
        (negatedParallelStaircaseStep L wh wv j)) = 0 := by
  let n := L * wh.natAbs + L * wv.natAbs
  let u := negatedParallelStaircaseStep L wh wv
  let E := fun j => projectedUnitStep L (-windingParallelStaircase L wh wv j) (u j)
  have hpair (i j : ℕ) (hi : i < n) (hj : j < n) :
      directionPairTurning (directionNumber (E i)) (directionNumber (E j)) =
        turnValue (latticeTurnOfSteps (u i) (u j)) := by
    calc
      _ = latticeStepTurning (u i) (u j) := projectedUnitStep_turning L _ _ _ _
        (negatedParallelStaircaseStep_unit_negative L wh wv i hi).1
        (negatedParallelStaircaseStep_unit_negative L wh wv j hj).1
      _ = _ := (negatedParallelStaircaseStep_turn_spec L wh wv i j hi hj).2.symm
  change cyclicAdjacentSum
    (fun e f => directionPairTurning (directionNumber e) (directionNumber f)) n E = 0
  calc
    _ = cyclicAdjacentSum (fun a b => turnValue (latticeTurnOfSteps a b)) n u := by
      apply cyclicAdjacentSum_transport
      · intro j hj
        exact hpair j (j + 1) (by omega) (by omega)
      · exact hpair (n - 1) 0 (by omega) hn
    _ = 0 := negatedParallelStaircase_turning_zero L wh wv hn

/-- 本文の準備の二行。射影同定を逆に読み、射影階段の回転数零を代入する。 -/
theorem negatedParallelStaircase_turning_via_projection
    (L : ℕ) [NeZero L] (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum latticeStepTurning (L * wh.natAbs + L * wv.natAbs)
      (negatedParallelStaircaseStep L wh wv) = 0 := by
  calc
    _ = cyclicAdjacentSum
        (fun e f => directionPairTurning (directionNumber e) (directionNumber f))
        (L * wh.natAbs + L * wv.natAbs)
        (fun j => projectedUnitStep L (-windingParallelStaircase L wh wv j)
          (negatedParallelStaircaseStep L wh wv j)) := by
      symm
      apply planeProjection_cyclicTurning L _ hn (fun j => -windingParallelStaircase L wh wv j)
      intro j hj
      exact (negatedParallelStaircaseStep_unit_negative L wh wv j hj).1
    _ = 0 := negatedParallelStaircase_projectedTurning_zero L wh wv hn

/-- `claim_one_sided_closure_period_difference_turning`。周期数差の八行の合成。 -/
theorem oneSidedClosure_periodDifferenceTurning
    (m L : ℕ) [NeZero m] [NeZero L] (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ)
    (γ : ZMod m → OrientedEdge L)
    (hstep : ∀ j : ℕ, j < m →
      base ((j : ℤ) + 1) = base j + orientedEdgeLatticeStep (γ (j : ZMod m)))
    (hend : base m = base 0 + windingShift L wv wh)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c) :
    oneSidedClosureProjectedTurning m L base wv wh k₀ t (c + 1) -
        oneSidedClosureProjectedTurning m L base wv wh k₀ t c =
      ∑ j : ZMod m, directionPairTurning (directionNumber (γ j)) (directionNumber (γ (j + 1))) := by
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  let D := iteratedTransverseStaircase wh wv 0
  let u : Fin m → ℤ × ℤ := fun i => p (i.val + 1) - p i.val
  let v : Fin b → ℤ × ℤ := fun i => D (i.val + 1) - D i.val
  let r : Fin n → ℤ × ℤ := fun i => negatedParallelStaircaseStep L wh wv i.val
  let x : Fin b → ℤ × ℤ := fun i => D (b - (i.val + 1)) - D (b - i.val)
  let N := oneSidedClosureLength m L wv wh t
  let W := oneSidedClosurePoint m L base wv wh k₀ t
  let T := oneSidedClosureProjectedTurning m L base wv wh k₀ t
  let C := fun k => cyclicAdjacentSum latticeStepTurning (N k) (fun j => W k (j + 1) - W k j)
  let z := fun k => joinDirectionSequence
    (joinDirectionSequence (joinDirectionSequence (repeatedLatticeWord u) (extendLatticeWord v)
      (k * m)) (repeatedLatticeWord r) (k * m + b)) (extendLatticeWord x) (k * m + b + k * n)
  have hm : 0 < m := NeZero.pos m
  have hprojection (k : ℕ) (hk : 0 < k) : T k = C k :=
    oneSidedClosureProjectedTurning_eq_lattice m L base wv wh k₀ t k γ hstep hend hn hb hk
  have hword (k : ℕ) (hk : 0 < k) : C k = cyclicAdjacentSum latticeStepTurning (N k) (z k) :=
    oneSidedClosure_cyclicTurning_identification m L base wv wh k₀ t k hm hn hb hk
  have hperiod : cyclicAdjacentSum latticeStepTurning m (extendLatticeWord u) =
      ∑ j : ZMod m, directionPairTurning (directionNumber (γ j)) (directionNumber (γ (j + 1))) := by
    calc
      _ = cyclicAdjacentSum latticeStepTurning m (fun j => p (j + 1) - p j) :=
        cyclicTurning_extend_finite_word m hm _
      _ = _ := by
        simpa [p, Nat.cast_add, add_assoc] using
          periodicPlaneLift_periodTurning m L base wv wh γ hstep hend k₀
  have hreturn : cyclicAdjacentSum latticeStepTurning n (extendLatticeWord r) = 0 := by
    calc
      _ = cyclicAdjacentSum latticeStepTurning n (negatedParallelStaircaseStep L wh wv) :=
        cyclicTurning_extend_finite_word n hn _
      _ = 0 := negatedParallelStaircase_turning_via_projection L wh wv hn
  change T (c + 1) - T c = _
  calc
    T (c + 1) - T c = C (c + 1) - T c := by rw [hprojection (c + 1) (by omega)]
    _ = C (c + 1) - C c := by rw [hprojection c hc]
    _ = cyclicAdjacentSum latticeStepTurning (N (c + 1)) (z (c + 1)) - C c := by
      rw [hword (c + 1) (by omega)]
    _ = cyclicAdjacentSum latticeStepTurning (N (c + 1)) (z (c + 1)) -
        cyclicAdjacentSum latticeStepTurning (N c) (z c) := by rw [hword c hc]
    _ = cyclicAdjacentSum latticeStepTurning m (extendLatticeWord u) +
        cyclicAdjacentSum latticeStepTurning n (extendLatticeWord r) :=
      fourPartRepeated_cyclicTurning_difference m b n b c u v r x hm hb hn hb hc
    _ = (∑ j : ZMod m, directionPairTurning (directionNumber (γ j)) (directionNumber (γ (j + 1)))) +
        cyclicAdjacentSum latticeStepTurning n (extendLatticeWord r) := by rw [hperiod]
    _ = (∑ j : ZMod m, directionPairTurning (directionNumber (γ j)) (directionNumber (γ (j + 1)))) + 0 := by
      rw [hreturn]
    _ = _ := add_zero _

end Ising2DLambda.KacWard
