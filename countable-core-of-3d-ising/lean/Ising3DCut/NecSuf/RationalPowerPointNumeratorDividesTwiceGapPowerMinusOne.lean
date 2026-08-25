/-
「分子は隣接する二つの箱の頂点数の差だけの点数乗から 1 を引いた数の 2 倍を割る」の
Lean 必要十分版で使う骨格。

有限箱・有理数・三次元の頂点数を落とすと、残るのは二つの指数の加法分解、同じ剰余への
二つの合同、および保存する対象の等号だけである。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 指数 `M` が `N + g` で、`u^N` と `u^M` がともに 2 へ合同なら、
法 `a` で `2 * u^g` も 2 へ合同である。 -/
theorem twice_gap_power_congr_two_of_common_residue
    (a u : ℤ) (N M g : ℕ) (hsum : M = N + g)
    (hN : Int.ModEq a (u ^ N) 2) (hM : Int.ModEq a (u ^ M) 2) :
    Int.ModEq a (2 * u ^ g) 2 := by
  have hstep : Int.ModEq a (2 * u ^ g) (u ^ N * u ^ g) :=
    (hN.symm).mul_right (u ^ g)
  have hpow : u ^ N * u ^ g = u ^ M := by
    rw [hsum, pow_add]
  exact hstep.trans (hpow ▸ hM)

/-- 人手証明の骨格全体。対象の等号を保存し、共通剰余と指数の加法分解から整除を得る。 -/
theorem equality_and_dvd_twice_gap_power_minus_one
    {C : Type*} (c u₀ : C) (a u : ℤ) (N M g : ℕ)
    (hcu : c = u₀) (hsum : M = N + g)
    (hN : Int.ModEq a (u ^ N) 2) (hM : Int.ModEq a (u ^ M) 2) :
    c = u₀ ∧ a ∣ 2 * (u ^ g - 1) := by
  refine ⟨hcu, ?_⟩
  have hcong : Int.ModEq a (2 * u ^ g) 2 :=
    twice_gap_power_congr_two_of_common_residue a u N M g hsum hN hM
  have hdvd : a ∣ 2 - 2 * u ^ g := Int.modEq_iff_dvd.mp hcong
  have hneg : a ∣ -(2 - 2 * u ^ g) := hdvd.neg_right
  have hrw : -(2 - 2 * u ^ g) = 2 * (u ^ g - 1) := by ring
  exact hrw ▸ hneg

end Ising3DCut.NecSuf
