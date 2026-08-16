/-
「有理係数の対数順序群の Archimedes 性」の必要十分版。
具体版の本体の鎖が使っている ℚ 側の内容だけを取り出す: 順序体 K の元 A ≥ 1、B > 1 と、
「K の非負元は自然数で追い越せる」という仮定 hArch から、A ≤ B^n となる n ∈ ℕ が存在する。
手順は具体版と同じ（h := B−1 > 0、r := (A−1)/h ≥ 0、n は r を追い越す自然数、
A = 1+(A−1) = 1 + r h ≤ 1 + n h ≤ (1+h)^n = B^n）。

Λ_ℚ・共通分母・rat_Λ はここに現れない。それらは K := ℚ、A := rat_Λ(μ_N)、B := rat_Λ(ε_N) の
読み替えと、証人を通した Λ_ℚ の順序への持ち上げであり、導出側に置く。

削れなかった仮定:
- hArch（K の非負元は自然数で追い越せる）。具体版では ℚ の分子で明示している（`rat_le_num_toNat`）。
  一般の順序体では成り立たない（ℝ の非 Archimedes 的な順序拡大では A ≤ B^n となる n が無いことがある）
  ので、仮定として残す。主張自体が Archimedes 性なのだから、K 側の Archimedes 性は落とせない。
- 体（除法）。r := (A−1)/h を作るために B−1 で割る。順序半環（Bernoulli 不等式の必要十分版が要求する
  だけの構造）では割れない。
- 線形順序。具体版は ℚ の全順序を「¬(rat ≤ 1) から 1 < rat」で使うが、それは導出側（`1 < B` を作る段）
  にある。本体の鎖そのものは 0 < B−1 と加法・乗法の単調性しか使わないので、ここでは
  半順序＋`IsStrictOrderedRing`（0 < h と 0 ≤ r から 0 ≤ r h 等）で足りるが、`Field` と順序を
  組み合わせた mathlib の順序体の骨格は線形順序を前提にするため `LinearOrder` のまま置く。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalBernoulliInequality
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Tactic.Linarith

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 順序体上で、非負元が自然数で追い越せるなら、`1 ≤ A`、`1 < B` に対し `A ≤ B^n` となる `n` がある。 -/
theorem archimedean_of_bernoulli_necSuf {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K]
    (hArch : ∀ r : K, 0 ≤ r → ∃ n : ℕ, r ≤ n)
    {A B : K} (hA : 1 ≤ A) (hB : 1 < B) : ∃ n : ℕ, A ≤ B ^ n := by
  -- h := B − 1 > 0、r := (A−1)/h ≥ 0
  have hh : 0 < B - 1 := sub_pos.mpr hB
  have hr : 0 ≤ (A - 1) / (B - 1) := div_nonneg (sub_nonneg.mpr hA) hh.le
  -- n は r を追い越す自然数（仮定 hArch）
  obtain ⟨n, hn⟩ := hArch _ hr
  refine ⟨n, ?_⟩
  have hrh : (A - 1) / (B - 1) * (B - 1) ≤ (n : K) * (B - 1) :=
    mul_le_mul_of_nonneg_right hn hh.le                       -- r ≤ n に 0 < h を掛ける
  calc
    A = 1 + (A - 1) := by ring                                -- 四則
    _ = 1 + (A - 1) / (B - 1) * (B - 1) := by
          rw [div_mul_cancel₀ _ hh.ne']                       -- r h = A − 1
    _ ≤ 1 + (n : K) * (B - 1) := by linarith [hrh]            -- 加法単調性
    _ ≤ (1 + (B - 1)) ^ n :=
          one_add_nsmul_le_one_add_pow_necSuf _ hh.le n       -- Bernoulli 不等式（必要十分版）
    _ = B ^ n := by rw [add_sub_cancel]                       -- 1 + h = B

end Ising2DLambda.NecSuf.ThermodynamicLimit
