import Mathlib

/-!
「有理点での四つの符号付き偶部分グラフ多項式の符号」（`claim_signed_even_subgraph_rational_sign`）の
積の符号の合成の段の必要十分版。

具体版 `Ising2DLambda.KacWard.rPositive_mul`・`rPositive_prod`・`rat_pos_of_rPositive`・
`signedEvenSubgraphPolynomial_rational_sign` と同じ手順で示す。

各段が使うのは次だけである。
* 正の元の積（`square_pos_mul_necSuf`）: 可換環 `K` と零因子が無いこと。
  `(s·s)(t·t) = (s·t)(s·t)` に可換性、`s·t ≠ 0` に零因子が無いことを使う。
  零因子があると、零でない二つの証人の積が零になり、正の元の積が正と言えない。逆元・順序は使わない。
* 有限積（`pos_prod_necSuf`）: 可換モノイドと、正の述語が単位元を含み積で閉じること。
  可換性は有限積 `∏` を定めるためだけに要る。
* 符号の反映（`rat_pos_of_pos_necSuf`）: 環 `K` への環準同型 `e : ℚ →+* K` と、狭義順序 `lt` について
  `0 < r ⇒ lt 0 (e r)`（`hrat`）、`lt 0 (−x) ⇒ lt x 0`（`hneg`）、`¬ lt 0 0`（`hirr`）、
  `lt a b ⇒ ¬ lt b a`（`hasymm`）。`hirr` を外すと `r = 0` を、`hasymm` を外すと `r < 0` を除けない。
  推移律・加法・乗法の単調性は使わない。
* 合成（`sign_compose_necSuf`）: 可換環 `V` の正の述語の積閉性、`e` が正の有理数を正へ送り正の元から
  正の有理数を反映すること、値の分解 `e Q = F · P'` と、`F` が `e(−c)` か `1` であること。

住処: 一般の代数系。実数体・複素数体は現れない。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版（正の元の積）: `u − 0 = s·s`、`v − 0 = t·t`（`s, t ≠ 0`）なら `u·v − 0 = (s·t)(s·t)`、`s·t ≠ 0`。 -/
theorem square_pos_mul_necSuf {K : Type*} [CommRing K] [NoZeroDivisors K] {u v : K}
    (hu : ∃ s : K, s ≠ 0 ∧ u - 0 = s * s) (hv : ∃ t : K, t ≠ 0 ∧ v - 0 = t * t) :
    ∃ w : K, w ≠ 0 ∧ u * v - 0 = w * w := by
  obtain ⟨s, hs0, hs⟩ := hu
  obtain ⟨t, ht0, ht⟩ := hv
  refine ⟨s * t, mul_ne_zero hs0 ht0, ?_⟩
  calc u * v - 0 = (u - 0) * (v - 0) := by rw [sub_zero, sub_zero, sub_zero]
    _ = (s * s) * (t * t) := by rw [hs, ht]
    _ = (s * t) * (s * t) := by rw [mul_mul_mul_comm]

/-- 必要十分版（有限積）: 正の述語が単位元を含み積で閉じれば、正の因子の有限積は正。 -/
theorem pos_prod_necSuf {V β : Type*} [CommMonoid V] (pos : V → Prop) (h1 : pos 1)
    (hmul : ∀ a b, pos a → pos b → pos (a * b)) (A : Finset β) (f : β → V)
    (h : ∀ i ∈ A, pos (f i)) : pos (∏ i ∈ A, f i) := by
  classical
  induction A using Finset.induction_on with
  | empty => simpa using h1
  | insert a A ha ih =>
      rw [Finset.prod_insert ha]
      exact hmul _ _ (h a (Finset.mem_insert_self a A))
        (ih (fun i hi => h i (Finset.mem_insert_of_mem hi)))

/-- 必要十分版（符号の反映）: `lt 0 (e r)` なら `0 < r`。 -/
theorem rat_pos_of_pos_necSuf {K : Type*} [Ring K] (lt : K → K → Prop) (e : ℚ →+* K)
    (hrat : ∀ r : ℚ, 0 < r → lt 0 (e r)) (hneg : ∀ x : K, lt 0 (-x) → lt x 0)
    (hirr : ¬lt 0 0) (hasymm : ∀ a b : K, lt a b → ¬lt b a) {r : ℚ} (h : lt 0 (e r)) : 0 < r := by
  rcases lt_trichotomy r 0 with hr | hr | hr
  · exfalso
    -- `0 < −r` から `lt 0 (e(−r)) = lt 0 (−e r)`、よって `lt (e r) 0`
    have h' : lt 0 (-(e r)) := by
      rw [← map_neg]
      exact hrat (-r) (neg_pos.mpr hr)
    exact hasymm _ _ h (hneg _ h')
  · exfalso
    rw [hr, map_zero] at h
    exact hirr h
  · exact hr

/-- 必要十分版（合成）: `e Q = F · P'`、`P'` が正、`F` が `e(−c)` か `1` なら、
`c < 0` で `0 < Q`、`c > 0` かつ `F = e(−c)` で `Q < 0`、`F = 1` で `0 < Q`。 -/
theorem sign_compose_necSuf {V : Type*} [CommRing V] (pos : V → Prop)
    (hmul : ∀ a b, pos a → pos b → pos (a * b)) (e : ℚ →+* V)
    (hrat : ∀ r : ℚ, 0 < r → pos (e r)) (hrefl : ∀ r : ℚ, pos (e r) → 0 < r)
    (c Q : ℚ) (F P' : V) (hP' : pos P') (hsplit : e Q = F * P') (hF : F = e (-c) ∨ F = 1) :
    (c < 0 → 0 < Q) ∧ (0 < c → F = e (-c) → Q < 0) ∧ (F = 1 → 0 < Q) := by
  refine ⟨fun hc => ?_, fun hc hFc => ?_, fun hF1 => ?_⟩
  · -- `c < 0`: `F = e(−c)`（`−c > 0`）なら積が正、`F = 1` なら `P'` そのもの
    apply hrefl
    rw [hsplit]
    rcases hF with hF | hF
    · rw [hF]
      exact hmul _ _ (hrat _ (neg_pos.mpr hc)) hP'
    · rw [hF, one_mul]
      exact hP'
  · -- `c > 0` かつ `F = e(−c)`: `e(−Q) = e c · P'` が正
    have h : pos (e (-Q)) := by
      have : e (-Q) = e c * P' := by
        rw [map_neg, hsplit, hFc, map_neg, neg_mul, neg_neg]
      rw [this]
      exact hmul _ _ (hrat c hc) hP'
    exact neg_pos.mp (hrefl _ h)
  · -- `F = 1`: `e Q = P'` が正
    apply hrefl
    rw [hsplit, hF1, one_mul]
    exact hP'

end Ising2DLambda.NecSuf.KacWard
