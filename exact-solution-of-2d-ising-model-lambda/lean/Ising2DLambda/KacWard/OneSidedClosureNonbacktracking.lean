/- 一側閉包の非後退性。各部分の座標の符号と四接合を調べる。
頂点単純性を仮定せず、周期数差の射影回転数を定義できることを保証する。 -/
import Ising2DLambda.KacWard.OneSidedClosureCyclicSum
import Ising2DLambda.KacWard.ParallelStaircaseTransverseWidth
import Ising2DLambda.KacWard.OneSidedClosurePeriodDifferenceTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

private lemma nb_join (u v : ℕ → ℤ × ℤ) (a b : ℕ) (ha : 0 < a)
    (hu : ∀ j, j + 1 < a → u (j + 1) ≠ -u j)
    (hv : ∀ j, j + 1 < b → v (j + 1) ≠ -v j)
    (hjoin : v 0 ≠ -u (a - 1)) :
    ∀ j, j + 1 < a + b →
      joinDirectionSequence u v a (j + 1) ≠ -joinDirectionSequence u v a j := by
  intro j hj
  by_cases hleft : j + 1 < a
  · simpa [joinDirectionSequence, hleft, show j < a by omega] using hu j hleft
  · by_cases heq : j + 1 = a
    · have hjlast : j = a - 1 := by omega
      simpa [joinDirectionSequence, heq, hjlast, Nat.sub_add_cancel ha,
        show a - 1 < a by omega] using hjoin
    · have hright : ¬j < a := by omega
      have hindex : j + 1 - a = (j - a) + 1 := by omega
      simpa [joinDirectionSequence, hleft, hright, hindex] using
        hv (j - a) (by omega)

private lemma nb_repeat (u : ℕ → ℤ × ℤ) (m : ℕ) (hm : 0 < m)
    (hu : ∀ j, j < m → u ((j + 1) % m) ≠ -u j) :
    ∀ j, repeatDirectionSequence u m (j + 1) ≠ -repeatDirectionSequence u m j := by
  intro j
  simpa only [repeatDirectionSequence, Nat.add_mod, Nat.mod_mod] using
    hu (j % m) (Nat.mod_lt j hm)

/-- 中央二接合に必要な符号。平行階段全体の横断上界と両端点から導く。 -/
theorem negatedParallelStaircaseStep_transverse_end_signs
    (L : ℕ) (wh wv : ℤ) (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    0 ≤ windingTransverseCoordinate wh wv (negatedParallelStaircaseStep L wh wv 0) ∧
    windingTransverseCoordinate wh wv
      (negatedParallelStaircaseStep L wh wv (L * wh.natAbs + L * wv.natAbs - 1)) ≤ 0 := by
  let n := L * wh.natAbs + L * wv.natAbs
  have hupper (j : ℕ) (hj : j ≤ n) :
      windingTransverseCoordinate wh wv (windingParallelStaircase L wh wv j) ≤ 0 := by
    simpa only [zero_add, map_zero, sub_zero] using
      (windingParallelStaircase_transverse_width_bound L wh wv 0 j hj).2
  constructor
  · have h := hupper 1 (by dsimp [n]; omega)
    rw [negatedParallelStaircaseStep_difference, map_neg, map_sub,
      windingParallelStaircase_zero, map_zero, sub_zero]
    simpa only [Nat.zero_add] using neg_nonneg.mpr h
  · have h := hupper (n - 1) (Nat.sub_le _ _)
    have hend : n - 1 + 1 = n := by dsimp [n]; omega
    change windingTransverseCoordinate wh wv
      (negatedParallelStaircaseStep L wh wv (n - 1)) ≤ 0
    rw [negatedParallelStaircaseStep_difference, map_neg, map_sub, hend,
      windingParallelStaircase_end]
    change -(windingTransverseCoordinate wh wv (windingShift L wv wh) -
      windingTransverseCoordinate wh wv (windingParallelStaircase L wh wv (n - 1))) ≤ 0
    rw [windingTransverseCoordinate_windingShift]
    omega

/-- 固定四列のうち横断・帰路は実際の階段であり、符号条件を仮定しない。
元の周期列に必要なのは循環非後退性と、最大横断水準で切った両端の符号だけである。 -/
theorem oneSidedClosure_fixedWord_nonbacktracking
    (m L t c : ℕ) (wh wv : ℤ) (u : ℕ → ℤ × ℤ)
    (hm : 0 < m) (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c)
    (hu : ∀ j, j < m → u ((j + 1) % m) ≠ -u j)
    (huFirst : windingTransverseCoordinate wh wv (u 0) ≤ 0)
    (huLast : 0 ≤ windingTransverseCoordinate wh wv (u (m - 1))) :
    let b := t * (wh.natAbs + wv.natAbs)
    let n := L * wh.natAbs + L * wv.natAbs
    let D := iteratedTransverseStaircase wh wv 0
    let v := fun j => D (j + 1) - D j
    let r := negatedParallelStaircaseStep L wh wv
    let x := fun j => D (b - (j + 1)) - D (b - j)
    let U := repeatDirectionSequence u m
    let R := repeatDirectionSequence r n
    let z := joinDirectionSequence
      (joinDirectionSequence (joinDirectionSequence U v (c * m)) R (c * m + b))
      x (c * m + b + c * n)
    let N := c * m + b + c * n + b
    (∀ j, j + 1 < N → z (j + 1) ≠ -z j) ∧ z 0 ≠ -z (N - 1) := by
  dsimp only
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  let κ := windingTransverseCoordinate wh wv
  let π := windingParallelCoordinate wv wh
  let D := iteratedTransverseStaircase wh wv 0
  let v := fun j => D (j + 1) - D j
  let r := negatedParallelStaircaseStep L wh wv
  let x := fun j => D (b - (j + 1)) - D (b - j)
  let U := repeatDirectionSequence u m
  let R := repeatDirectionSequence r n
  let A := joinDirectionSequence U v (c * m)
  let B := joinDirectionSequence A R (c * m + b)
  let z := joinDirectionSequence B x (c * m + b + c * n)
  let N := c * m + b + c * n + b
  change (∀ j, j + 1 < N → z (j + 1) ≠ -z j) ∧ z 0 ≠ -z (N - 1)
  change κ (u 0) ≤ 0 at huFirst
  change 0 ≤ κ (u (m - 1)) at huLast
  have hcm : 0 < c * m := Nat.mul_pos hc hm
  have hcn : 0 < c * n := Nat.mul_pos hc hn
  have hwind : (wh, wv) ≠ (0, 0) := by
    intro heq
    have hwh : wh = 0 := congrArg Prod.fst heq
    have hwv : wv = 0 := congrArg Prod.snd heq
    simp [hwh, hwv] at hn
  have hv (j : ℕ) : 0 < κ (v j) := by
    have h := (iteratedTransverseStaircase_lower_bound wh wv 0 hwind).2.1 j
    change 0 < κ (D (j + 1) - D j)
    rw [map_sub]
    exact sub_pos.mpr h
  have hx (j : ℕ) (hj : j < b) : κ (x j) < 0 := by
    have heq : b - (j + 1) + 1 = b - j := by omega
    have h := hv (b - (j + 1))
    dsimp [v] at h
    rw [heq, map_sub] at h
    change κ (D (b - (j + 1)) - D (b - j)) < 0
    rw [map_sub]
    omega
  have hr (j : ℕ) (hj : j < n) : π (r j) < 0 :=
    (negatedParallelStaircaseStep_unit_negative L wh wv j hj).2
  have hrEnds := negatedParallelStaircaseStep_transverse_end_signs L wh wv hn
  have hUlast : U (c * m - 1) = u (m - 1) :=
    repeatDirectionSequence_last u m c hm hc
  have hRlast : R (c * n - 1) = r (n - 1) :=
    repeatDirectionSequence_last r n c hn hc
  have hU0 : U 0 = u 0 := by simp [U, repeatDirectionSequence]
  have hR0 : R 0 = r 0 := by simp [R, repeatDirectionSequence]
  have hvnb : ∀ j, j + 1 < b → v (j + 1) ≠ -v j := by
    intro j _ heq
    have h := hv (j + 1)
    rw [heq, map_neg] at h
    have := hv j
    omega
  have hxnb : ∀ j, j + 1 < b → x (j + 1) ≠ -x j := by
    intro j hj heq
    have h := hx (j + 1) hj
    rw [heq, map_neg] at h
    have := hx j (by omega)
    omega
  have hRnb : ∀ j, R (j + 1) ≠ -R j := by
    intro j heq
    have h := hr ((j + 1) % n) (Nat.mod_lt _ hn)
    change π (R (j + 1)) < 0 at h
    rw [heq, map_neg] at h
    have h' := hr (j % n) (Nat.mod_lt _ hn)
    change π (R j) < 0 at h'
    omega
  have huv : v 0 ≠ -U (c * m - 1) := by
    intro heq
    have h := hv 0
    rw [heq, hUlast, map_neg] at h
    omega
  have hvr : R 0 ≠ -A (c * m + b - 1) := by
    have hAend : A (c * m + b - 1) = v (b - 1) := by
      simp only [A, joinDirectionSequence, if_neg (by omega : ¬c * m + b - 1 < c * m)]
      congr 1; omega
    rw [hR0, hAend]
    intro heq
    have h := hrEnds.1
    change 0 ≤ κ (r 0) at h
    rw [heq, map_neg] at h
    have := hv (b - 1)
    omega
  have hrx : x 0 ≠ -B (c * m + b + c * n - 1) := by
    have hBend : B (c * m + b + c * n - 1) = r (n - 1) := by
      dsimp [B, joinDirectionSequence]
      rw [if_neg (by omega)]
      rw [show c * m + b + c * n - 1 - (c * m + b) = c * n - 1 by omega]
      exact hRlast
    rw [hBend]
    intro heq
    have h := hx 0 hb
    rw [heq, map_neg] at h
    have h' := hrEnds.2
    change κ (r (n - 1)) ≤ 0 at h'
    omega
  constructor
  · exact nb_join B x (c * m + b + c * n) b (by omega)
      (nb_join A R (c * m + b) (c * n) (by omega)
        (nb_join U v (c * m) b hcm (fun j _ => nb_repeat u m hm hu j) hvnb huv)
        (fun j _ => hRnb j) hvr) hxnb hrx
  · have hz0 : z 0 = u 0 := by simp [z, B, A, joinDirectionSequence, hcm, hU0]
    have hzlast : z (N - 1) = x (b - 1) := by
      dsimp [z, N, joinDirectionSequence]
      rw [if_neg (by omega)]
      congr 1; omega
    rw [hz0, hzlast]
    intro heq
    have h := huFirst
    rw [heq, map_neg] at h
    have h' := hx (b - 1) (by omega)
    omega

/-- 一周期の最大横断水準で切ると、始歩は非正、末歩は非負となる。
周期端点の横断座標が始点と同じであることも並進ベクトルから計算する。 -/
theorem oneSidedClosure_period_boundary_signs
    (m L : ℕ) (wh wv : ℤ) (P : ℕ → ℤ × ℤ) (hm : 0 < m)
    (hend : P m = P 0 + windingShift L wv wh)
    (hmax : ∀ j, j < m →
      windingTransverseCoordinate wh wv (P j) ≤ windingTransverseCoordinate wh wv (P 0)) :
    windingTransverseCoordinate wh wv (P 1 - P 0) ≤ 0 ∧
    0 ≤ windingTransverseCoordinate wh wv (P m - P (m - 1)) := by
  have hequal : windingTransverseCoordinate wh wv (P m) =
      windingTransverseCoordinate wh wv (P 0) := by
    rw [hend, map_add, windingTransverseCoordinate_windingShift, add_zero]
  constructor
  · rw [map_sub]
    by_cases hsmall : 1 < m
    · exact sub_nonpos.mpr (hmax 1 hsmall)
    · have hmone : m = 1 := by omega
      subst m
      rw [hequal]
      omega
  · rw [map_sub, hequal]
    exact sub_nonneg.mpr (hmax (m - 1) (by omega))

/-- 元の一周期点列と最大水準の条件から、実際の階段を連結した全歩列の
非後退性を得る。中央二接合の符号は平行階段の既証明の幅から得る。 -/
theorem oneSidedClosure_fixedWord_nonbacktracking_of_maximum
    (m L t c : ℕ) (wh wv : ℤ) (P : ℕ → ℤ × ℤ)
    (hm : 0 < m) (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c)
    (hend : P m = P 0 + windingShift L wv wh)
    (hmax : ∀ j, j < m →
      windingTransverseCoordinate wh wv (P j) ≤ windingTransverseCoordinate wh wv (P 0))
    (hnb : ∀ j, j < m →
      P ((j + 1) % m + 1) - P ((j + 1) % m) ≠ -(P (j + 1) - P j)) :
    let u := fun j => P (j + 1) - P j
    let b := t * (wh.natAbs + wv.natAbs)
    let n := L * wh.natAbs + L * wv.natAbs
    let D := iteratedTransverseStaircase wh wv 0
    let v := fun j => D (j + 1) - D j
    let r := negatedParallelStaircaseStep L wh wv
    let x := fun j => D (b - (j + 1)) - D (b - j)
    let U := repeatDirectionSequence u m
    let R := repeatDirectionSequence r n
    let z := joinDirectionSequence
      (joinDirectionSequence (joinDirectionSequence U v (c * m)) R (c * m + b))
      x (c * m + b + c * n)
    let N := c * m + b + c * n + b
    (∀ j, j + 1 < N → z (j + 1) ≠ -z j) ∧ z 0 ≠ -z (N - 1) := by
  have hsign := oneSidedClosure_period_boundary_signs m L wh wv P hm hend hmax
  apply oneSidedClosure_fixedWord_nonbacktracking m L t c wh wv
    (fun j => P (j + 1) - P j) hm hn hb hc hnb
  · exact hsign.1
  · simpa only [Nat.sub_add_cancel hm] using hsign.2

/-- 固定四部分列の非後退性を、点ごとの歩の同定により実際の一側閉包へ戻す。
仮定は元の一周期の最大水準と循環非後退性であり、閉包の接合条件は導出する。 -/
theorem oneSidedClosurePoint_nonbacktracking
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ)
    (hm : 0 < m) (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c)
    (hmax : let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
      ∀ j, j < m → windingTransverseCoordinate wh wv (p j) ≤
        windingTransverseCoordinate wh wv (p 0))
    (hnb : let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
      ∀ j, j < m → p ((j + 1) % m + 1) - p ((j + 1) % m) ≠ -(p (j + 1) - p j)) :
    let W := oneSidedClosurePoint m L base wv wh k₀ t c
    let N := oneSidedClosureLength m L wv wh t c
    (∀ j, j + 1 < N → W (j + 2) - W (j + 1) ≠ -(W (j + 1) - W j)) ∧
      W 1 - W 0 ≠ -(W N - W (N - 1)) := by
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let S := p 0
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  let q := iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh)
  let r := oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c
  let s := iteratedTransverseStaircase wh wv S
  let D := iteratedTransverseStaircase wh wv 0
  let u := fun i => p (i + 1) - p i
  let v := fun i => D (i + 1) - D i
  let e := negatedParallelStaircaseStep L wh wv
  let x := fun i => D (b - (i + 1)) - D (b - i)
  let W := oneSidedClosurePoint m L base wv wh k₀ t c
  let N := c * m + b + c * n + b
  let z := joinDirectionSequence
    (joinDirectionSequence
      (joinDirectionSequence (repeatDirectionSequence u m) v (c * m))
      (repeatDirectionSequence e n) (c * m + b)) x (c * m + b + c * n)
  have hend : p m = p 0 + windingShift L wv wh := by
    simpa [p] using periodicPlaneLift_translate m L hm base wv wh k₀ (1 : ℤ)
  have hfixed := oneSidedClosure_fixedWord_nonbacktracking_of_maximum
    m L t c wh wv p hm hn hb hc hend hmax hnb
  change (∀ j, j + 1 < N → z (j + 1) ≠ -z j) ∧ z 0 ≠ -z (N - 1) at hfixed
  obtain ⟨h12, h23, h34, hu, hv, hr, hx⟩ :=
    oneSidedClosure_concrete_parts m L base wv wh k₀ t c hm hn hb
  have hu' (i : ℕ) (hi : i < c * m) :
      p (i + 1) - p i = repeatDirectionSequence u m i := by
    simpa [repeatedLatticeWord, repeatDirectionSequence, extendLatticeWord,
      Nat.mod_lt i hm, u, p] using hu i hi
  have hv' (i : ℕ) (hi : i < b) : q (i + 1) - q i = v i := by
    change i < t * (wh.natAbs + wv.natAbs) at hi
    simpa [extendLatticeWord, hi, v, D, q, S, p] using hv i hi
  have hr' (i : ℕ) (hi : i < c * n) :
      r (i + 1) - r i = repeatDirectionSequence e n i := by
    simpa [repeatedLatticeWord, repeatDirectionSequence, extendLatticeWord,
      Nat.mod_lt i hn, e, n, r, S, p] using hr i hi
  have hx' (i : ℕ) (hi : i < b) : s (b - (i + 1)) - s (b - i) = x i := by
    change i < t * (wh.natAbs + wv.natAbs) at hi
    simpa [extendLatticeWord, hi, x, D, s, b, S, p] using hx i hi
  have hstep (j : ℕ) (hj : j < N) : W (j + 1) - W j = z j := by
    calc
      W (j + 1) - W j = _ := oneSidedClosure_stepSequence p q r s
        (c * m) b (c * n) (Nat.mul_pos hc hm) hb (Nat.mul_pos hc hn)
        h12 h23 h34 j (by omega)
      _ = z j := fourPartSequence_congr_range _ _ _ _
        (repeatDirectionSequence u m) v (repeatDirectionSequence e n) x
        (c * m) b (c * n) b hu' hv' hr' hx' j hj
  change (∀ j, j + 1 < N → W (j + 2) - W (j + 1) ≠ -(W (j + 1) - W j)) ∧
    W 1 - W 0 ≠ -(W N - W (N - 1))
  have hN : 0 < N := by dsimp [N]; omega
  constructor
  · intro j hj
    change W ((j + 1) + 1) - W (j + 1) ≠ -(W (j + 1) - W j)
    rw [hstep (j + 1) hj, hstep j (by omega)]
    exact hfixed.1 j hj
  · have hlast : W N - W (N - 1) = z (N - 1) := by
      simpa only [Nat.sub_add_cancel hN] using hstep (N - 1) (by omega)
    rw [show W 1 - W 0 = z 0 from hstep 0 hN, hlast]
    exact hfixed.2

end Ising2DLambda.KacWard
