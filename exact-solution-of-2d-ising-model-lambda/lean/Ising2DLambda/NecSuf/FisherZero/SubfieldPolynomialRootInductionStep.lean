/-
「虚数単位を足した体に根を持つことの帰納法の一歩」の必要十分版。

具体版と同じ段（各 c ∈ ℕ_{<N+1} で g_c が係数の部分集合に入る → 帰納法の仮定で r_c を選ぶ →
鳩の巣 → 二つのずらしから和と積 → 二次式の根 → 和が入る二数の主張）を、段が実際に使う仮定だけの上で行う。

要るのは次だけである。
- 台 `L` は体（ずらしの多項式の係数の所属に可換環、二つのずらしに除法、和が入る二数に零因子が無いこと）。
- 係数の部分集合 `S`（具体版の F）は零元・単位元・負の単位元・自然数の像を含み、和と積で閉じる。
  逆元で閉じることは使わない（ずらしの多項式の係数の所属は和と積だけで閉じる）。
- 根の部分集合 `T`（具体版の K = F(ω)）は差・積・商で閉じ、整数の像を含む。
- `T` を係数とする最高次の係数が一の二次式が `T` に根を持つこと（`hquad`）。
  具体版はこれを正錐と平方根の仮定から `claim_imaginary_unit_extension_quadratic_root` で得る。
  帰納法の一歩が使うのはこの結論だけで、正錐・平方根・ω・`S ⊂ T` は使わない。
- 番号 `c < c' ≤ N` の整数の差 `c - c'` の像が零でないこと（`hdist`）。標数零は要らない
  （標数 `p` の体でも `p > N` なら成り立つ）。
- 帰納法の仮定は、対の個数 `N` 個の一次因子の積についてだけ使う（`hIH`）。
  具体版で `N = 2^{k-1}·m'`（`m'` は奇数）を示す数え上げは、帰納法の仮定の形に合わせる段であり、
  台にも部分集合にも依らないので、導出の側（`SubfieldPolynomialRootInductionStepFromNecSuf.lean`）で行う。
-/
import Ising2DLambda.NecSuf.FisherZero.PairShiftRootPolynomialSubfieldCoefficient
import Ising2DLambda.NecSuf.FisherZero.TwoShiftedValuesSumProduct
import Ising2DLambda.NecSuf.FisherZero.SumInSubfieldRootGivesBothNumbers

namespace Ising2DLambda.NecSuf.FisherZero

/-- 具体版の β_c と同じ列。 -/
noncomputable def pairShiftRootSequenceNecSuf {L : Type} [CommRing L] {d N : ℕ} (α : ℕ → L)
    (π : Fin N ≃ OrderedPair (Fin d)) (c : L) : ℕ → L :=
  fun r => if h : r < N then
      α (π ⟨r, h⟩).1.1 + α (π ⟨r, h⟩).1.2 + c * α (π ⟨r, h⟩).1.1 * α (π ⟨r, h⟩).1.2
    else 0

theorem pairShiftRootSequenceNecSuf_apply {L : Type} [CommRing L] {d N : ℕ} (α : ℕ → L)
    (π : Fin N ≃ OrderedPair (Fin d)) (c : L) (r : Fin N) :
    pairShiftRootSequenceNecSuf α π c r =
      α (π r).1.1 + α (π r).1.2 + c * α (π r).1.1 * α (π r).1.2 := by
  simp [pairShiftRootSequenceNecSuf, r.isLt]

/-- `claim_subfield_polynomial_root_induction_step` の必要十分版（具体版と同じ段）。 -/
theorem subfieldPolynomialRoot_inductionStep_necSuf {L : Type} [Field L]
    (S : Set L) (h0 : (0 : L) ∈ S) (h1 : (1 : L) ∈ S) (hneg : (-1 : L) ∈ S)
    (hadd : ∀ x y : L, x ∈ S → y ∈ S → x + y ∈ S) (hmul : ∀ x y : L, x ∈ S → y ∈ S → x * y ∈ S)
    (hnat : ∀ n : ℕ, (n : L) ∈ S)
    (T : Set L) (hTsub : ∀ a b : L, a ∈ T → b ∈ T → a - b ∈ T)
    (hTmul : ∀ a b : L, a ∈ T → b ∈ T → a * b ∈ T)
    (hTdiv : ∀ a b : L, a ∈ T → b ∈ T → a / b ∈ T)
    (hTint : ∀ z : ℤ, (z : L) ∈ T)
    (hquad : ∀ p q : L, p ∈ T → q ∈ T → ∃ r : L, r ∈ T ∧ r * r + p * r + q = 0)
    {d N : ℕ} (π : Fin N ≃ OrderedPair (Fin d))
    (hdist : ∀ c c' : ℕ, c < c' → c' ≤ N → (((c : ℤ) - (c' : ℤ) : ℤ) : L) ≠ 0)
    (hIH : ∀ β : ℕ → L,
      (∀ n : ℕ, (∏ r ∈ Finset.range N, (Polynomial.X - Polynomial.C (β r))).coeff n ∈ S) →
      ∃ r : ℕ, r < N ∧ β r ∈ T)
    (α : ℕ → L)
    (hf : ∀ n : ℕ, (∏ i ∈ Finset.range d, (Polynomial.X - Polynomial.C (α i))).coeff n ∈ S) :
    ∃ i : ℕ, i < d ∧ α i ∈ T := by
  -- 各 c ∈ ℕ_{<N+1} で、ある r_c ∈ ℕ_{<N} のずらしの値が T に入る。
  have hshift : ∀ c : Fin (N + 1), ∃ r : Fin N,
      α (π r).1.1 + α (π r).1.2 + (c.val : L) * α (π r).1.1 * α (π r).1.2 ∈ T := by
    intro c
    have hg := pairShiftRootPolynomial_coeff_mem_necSuf h0 h1 hneg hadd hmul α hf
      (hnat c.val) π (pairShiftRootSequenceNecSuf α π c.val)
      (pairShiftRootSequenceNecSuf_apply α π c.val)
    obtain ⟨r, hr, hmem⟩ := hIH _ hg
    refine ⟨⟨r, hr⟩, ?_⟩
    rw [← pairShiftRootSequenceNecSuf_apply α π c.val ⟨r, hr⟩]
    exact hmem
  choose ρ hρ using hshift
  -- 鳩の巣（定義域 ℕ_{<N+1}、値域 Pr_d の個数は N）。
  have hcard : Fintype.card (OrderedPair (Fin d)) < Fintype.card (Fin (N + 1)) := by
    rw [← Fintype.card_congr π, Fintype.card_fin, Fintype.card_fin]
    exact Nat.lt_succ_self N
  obtain ⟨c, c', hlt, heq⟩ := pigeonhole_lt_necSuf hcard (fun c => π (ρ c))
  have hu : α (π (ρ c)).1.1 + α (π (ρ c)).1.2 +
      ((c.val : ℤ) : L) * (α (π (ρ c)).1.1 * α (π (ρ c)).1.2) ∈ T := by
    have h := hρ c
    rw [Int.cast_natCast, ← mul_assoc]
    exact h
  have hu' : α (π (ρ c)).1.1 + α (π (ρ c)).1.2 +
      ((c'.val : ℤ) : L) * (α (π (ρ c)).1.1 * α (π (ρ c)).1.2) ∈ T := by
    have h := hρ c'
    rw [show π (ρ c') = π (ρ c) from heq.symm] at h
    rw [Int.cast_natCast, ← mul_assoc]
    exact h
  have hne : (((c.val : ℤ) - (c'.val : ℤ) : ℤ) : L) ≠ 0 :=
    hdist c.val c'.val hlt (Nat.lt_succ_iff.mp c'.isLt)
  obtain ⟨hsum, hprod⟩ := add_mem_and_mul_mem_of_two_shifted_mem_necSuf T hTsub hTmul hTdiv
    _ _ _ _ hne (hTint _) (hTint _) hu hu'
  -- 二次式 t^2 - (a+b)t + ab の根。
  have hnegsum : -(α (π (ρ c)).1.1 + α (π (ρ c)).1.2) ∈ T := by
    rw [show -(α (π (ρ c)).1.1 + α (π (ρ c)).1.2) =
        ((0 : ℤ) : L) - (α (π (ρ c)).1.1 + α (π (ρ c)).1.2) by push_cast; ring]
    exact hTsub _ _ (hTint 0) hsum
  obtain ⟨r, hrT, hquad'⟩ := hquad _ _ hnegsum hprod
  have hvanish : r * r - (α (π (ρ c)).1.1 + α (π (ρ c)).1.2) * r +
      α (π (ρ c)).1.1 * α (π (ρ c)).1.2 = 0 := by
    calc r * r - (α (π (ρ c)).1.1 + α (π (ρ c)).1.2) * r +
          α (π (ρ c)).1.1 * α (π (ρ c)).1.2
        = r * r + -(α (π (ρ c)).1.1 + α (π (ρ c)).1.2) * r +
          α (π (ρ c)).1.1 * α (π (ρ c)).1.2 := by ring
      _ = 0 := hquad'
  obtain ⟨ha, -⟩ := mem_and_mem_of_sum_mem_of_root_mem_necSuf T hTsub _ _ r (mul_comm r _)
    hsum hrT hvanish
  exact ⟨(π (ρ c)).1.1.val, (π (ρ c)).1.1.isLt, ha⟩

end Ising2DLambda.NecSuf.FisherZero
