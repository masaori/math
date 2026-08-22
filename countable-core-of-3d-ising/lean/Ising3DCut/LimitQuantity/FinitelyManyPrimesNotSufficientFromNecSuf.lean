/-
具体版「有限個の素数での指数だけを見る粗視化は箱サイズ極限の一致に十分でない」が、
必要十分版 `Ising3DCut.NecSuf.finite_coordinate_truncation_not_sufficient` の
特殊化として得られることの導出。

添字を自然数、座標データを整数値の付値の族、値を作る写像を付値の族から正の実数を
組み立てる写像として取り、述語を「素数である」と取る。
-/
import Ising3DCut.LimitQuantity.FinitelyManyPrimesNotSufficient
import Ising3DCut.NecSuf.FinitePrimeTruncationNotSufficient
import Mathlib.Algebra.BigOperators.Finprod

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 付値の族から正の実数を組み立てる写像（有限台の積）。 -/
noncomputable def realOfExponents (g : ℕ → ℤ) : ℝ := ∏ᶠ p : ℕ, ((p : ℝ) ^ (g p))

/-- `1` の付値の族（すべての素数で 0）からは 1 が戻る。 -/
theorem realOfExponents_zero : realOfExponents (fun _ => 0) = 1 := by
  unfold realOfExponents
  simp

/-- 素数 `r` の付値の族（`r` でだけ 1、他は 0）からは `r` が戻る。 -/
theorem realOfExponents_single (r : ℕ) (hr : r.Prime) :
    realOfExponents (fun p => if p = r then 1 else 0) = (r : ℝ) := by
  unfold realOfExponents
  rw [finprod_eq_single _ r]
  · simp
  · intro p hp
    simp [hp]

/-- 具体版の反例が、必要十分版の特殊化として得られる。 -/
theorem finitely_many_primes_are_not_sufficient_for_limit_quantity_fromNecSuf
    (S : Finset ℕ) (hS : ∀ p ∈ S, p.Prime) :
    ∃ r, r.Prime ∧ r ∉ S ∧
      (∀ p ∈ S, (fun _ : ℕ => (0 : ℤ)) p = (fun p => if p = r then (1 : ℤ) else 0) p) ∧
      Tendsto (fun _ : ℕ => realOfExponents (fun _ => 0)) atTop
        (𝓝 (realOfExponents (fun _ => 0))) ∧
      Tendsto (fun _ : ℕ => realOfExponents (fun p => if p = r then 1 else 0)) atTop
        (𝓝 (realOfExponents (fun p => if p = r then 1 else 0))) ∧
      realOfExponents (fun _ => 0) ≠ realOfExponents (fun p => if p = r then 1 else 0) := by
  exact NecSuf.finite_coordinate_truncation_not_sufficient S Nat.Prime
    (exists_prime_not_mem S) (fun _ => (0 : ℤ)) (fun r p => if p = r then 1 else 0)
    realOfExponents
    (by
      -- 具体版の「`p ∈ S` では両方の付値が 0 で一致する」の段。
      intro r _ hrS p hp
      have hpr : p ≠ r := fun h => hrS (h ▸ hp)
      simp [hpr])
    (by
      -- 具体版の「`1 ≠ r`」の段。
      intro r hr _
      rw [realOfExponents_zero, realOfExponents_single r hr]
      have : (1 : ℕ) < r := hr.one_lt
      exact_mod_cast Nat.ne_of_lt this)

/-! ### 付値の族から戻る正の実数と、具体版の乗根列の値との接続

必要十分版から取り出した反例は「付値の族と、そこから戻る正の実数」の形をしている。
具体版の主張は「有理数列の正の乗根列」の形をしているので、両者はまだ繋がっていない。
ここでは、この反例で戻る二つの正の実数が、それぞれ具体版の乗根列の値と一致することを述べ、
そのうえで具体版の主張を必要十分版の特殊化として取り出す。

具体版の定理をここで呼び直すことはしない（それでは必要十分版の検査にならない）。
使うのは、具体版の証明が使っている算術の段（付値の計算・正の実数乗根の一意性）だけである。 -/

/-- 付値がすべて 0 の族から戻る正の実数は、定数列 `1` の第 `1` 乗根の値と一致する。 -/
theorem realOfExponents_zero_eq_posRoot :
    realOfExponents (fun _ => 0) = posRoot (((1 : ℚ) : ℝ)) 1 := by
  rw [realOfExponents_zero]
  have hcast : (((1 : ℚ) : ℝ)) = (1 : ℝ) := by norm_num
  rw [hcast]
  exact eq_posRoot_of_pow_eq 1 1 one_pos one_pos 1 one_ne_zero (by norm_num)

/-- 素数 `r` でだけ付値が 1 の族から戻る正の実数は、定数列 `r` の第 `1` 乗根の値と一致する。 -/
theorem realOfExponents_single_eq_posRoot (r : ℕ) (hr : r.Prime) :
    realOfExponents (fun p => if p = r then 1 else 0) = posRoot (((r : ℚ) : ℝ)) 1 := by
  rw [realOfExponents_single r hr]
  have hrR : (0 : ℝ) < (r : ℝ) := by exact_mod_cast hr.pos
  have hcast : (((r : ℚ) : ℝ)) = (r : ℝ) := by push_cast; ring
  rw [hcast]
  exact eq_posRoot_of_pow_eq (r : ℝ) (r : ℝ) hrR hrR 1 one_ne_zero (by norm_num)

/-- 具体版の主張そのもの（乗根列の形）が、必要十分版の特殊化として得られる。

必要十分版から受け取るのは、証人 `r` の存在・切り詰めた座標での一致・二つの定数列の収束・
二つの値が異なることの四つである。そこへ上の二つの接続と、具体版の付値の計算の段を足す。 -/
theorem finitely_many_primes_are_not_sufficient_for_limit_quantity_viaNecSuf (S : Finset ℕ)
    (hS : ∀ p ∈ S, p.Prime) :
    ∃ (A B : ℕ → ℚ) (N : ℕ → ℕ) (r : ℕ) (ℓ ℓ' : ℝ),
      r.Prime ∧ r ∉ S ∧
      (∀ L, 0 < A L) ∧ (∀ L, 0 < B L) ∧ (∀ L, N L ≠ 0) ∧
      (∀ L, ∀ p ∈ S, padicValRat p (A L) = padicValRat p (B L)) ∧
      (∀ L, padicValRat r (A L) ≠ padicValRat r (B L)) ∧
      Tendsto (fun L => posRoot ((A L : ℝ)) (N L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot ((B L : ℝ)) (N L)) atTop (𝓝 ℓ') ∧ ℓ ≠ ℓ' := by
  -- 必要十分版の特殊化から、証人と四つの結論を受け取る。
  obtain ⟨r, hrp, hrS, _hagree, hTA, hTB, hne⟩ :=
    finitely_many_primes_are_not_sufficient_for_limit_quantity_fromNecSuf S hS
  -- 付値の族から戻る正の実数を、具体版の乗根列の値へ書き換える。
  rw [realOfExponents_zero_eq_posRoot] at hTA hne
  rw [realOfExponents_single_eq_posRoot r hrp] at hTB hne
  have hrpos : (0 : ℚ) < (r : ℚ) := by exact_mod_cast hrp.pos
  refine ⟨fun _ => 1, fun _ => (r : ℚ), fun _ => 1, r,
    posRoot (((1 : ℚ) : ℝ)) 1, posRoot (((r : ℚ) : ℝ)) 1,
    hrp, hrS, fun _ => one_pos, fun _ => hrpos, fun _ => one_ne_zero, ?_, ?_, hTA, hTB, hne⟩
  · -- 具体版の「`p ∈ S` では両方の素指数が 0 で一致する」の段。
    intro _ p hp
    rw [padicValRat.one, padicValRat_prime_ne p r (hS p hp) hrp (fun h => hrS (h ▸ hp))]
  · -- 具体版の「`r` での素指数は一致しない（落ちる情報の所在）」の段。
    intro _
    rw [padicValRat.one]
    have : padicValNat r r = 1 := padicValNat.self hrp.one_lt
    simp [padicValRat.of_nat, this]

end Ising3DCut.LimitQuantity
