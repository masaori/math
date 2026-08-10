/-
章「固有値の代数性」の「約数を指数として 1 になる代数的数は、その倍数を指数としても
1 になる」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 2 件
（`def_algebraic_numbers` / `def_root_of_unity_set`）と主張 1 件
（`claim_root_of_unity_divisor`）に対応する。

  人手証明                                このファイル
  代数的数の全体 Qbar                     Qbar（ℚ の代数閉包）
  1 の n 乗根の全体 mu_n                  RootOfUnity n
  準備（n = d k を取る）                  hd から k を取り出す
  鎖の第 1 段（z^n = z^{dk}）             hk ▸ rfl の段
  鎖の第 2 段（指数法則）                 pow_mul
  鎖の第 3 段（z^d = 1 の代入）           hz を書き換える段
  鎖の第 4 段（単位元の反復積）           one_pow

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（値は ℚ の代数閉包の元、指数は ℕ）。
ℚ の代数閉包を ℂ の部分体として取らないのは、非可算な集合を経由しないためである。
-/
import Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 代数的数の全体。ℚ の代数閉包を 1 つ固定したものである（`def_algebraic_numbers`）。 -/
abbrev Qbar := AlgebraicClosure ℚ

/-- 1 の `n` 乗根の全体 `μ_n = { z ∈ Qbar | z ^ n = 1 }`（`def_root_of_unity_set`）。 -/
def RootOfUnity (n : ℕ) : Set Qbar := {z : Qbar | z ^ n = 1}

theorem mem_rootOfUnity {n : ℕ} {z : Qbar} : z ∈ RootOfUnity n ↔ z ^ n = 1 := Iff.rfl

/-- 人手証明の本体。`d ∣ n` ならば `μ_d ⊆ μ_n`。
mathlib の一般論（`pow_eq_one_of_dvd` 等）へ委ねず、人手証明の 4 段の鎖をそのまま書く。 -/
theorem rootOfUnity_of_dvd {d n : ℕ} (hd : d ∣ n) : RootOfUnity d ⊆ RootOfUnity n := by
  -- `z ∈ μ_d` を任意に取る。
  intro z hz
  rw [mem_rootOfUnity] at hz
  rw [mem_rootOfUnity]
  -- 準備。仮定 `d ∣ n` から `n = d * k` を満たす `k` を 1 つ取る。
  obtain ⟨k, hk⟩ := hd
  calc z ^ n
      = z ^ (d * k) := by rw [hk]          -- 第 1 段。n = d k。
    _ = (z ^ d) ^ k := by rw [pow_mul]      -- 第 2 段。指数法則。
    _ = (1 : Qbar) ^ k := by rw [hz]        -- 第 3 段。z^d = 1 の代入。
    _ = 1 := one_pow k                      -- 第 4 段。単位元の反復積。

end Ising2DLambda.AlgebraicEigenvalue
