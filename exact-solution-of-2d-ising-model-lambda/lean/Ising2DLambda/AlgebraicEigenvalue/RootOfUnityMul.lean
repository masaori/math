/-
章「固有値の代数性」の「1 の冪根の全体は積で閉じている」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_root_of_unity_mul`）に対応する。

  人手証明                                  このファイル
  w, z ∈ μ_n を取り w^n = 1, z^n = 1 を出す  mem_rootOfUnity で仮定をほどく段
  wz ∈ Qbar（体は積で閉じている）            型がそのまま与える（Qbar は体）
  鎖の第 1 段（(wz)^n = w^n z^n）            qbarMul_pow
  鎖の第 2 段（w^n = 1 の代入）              hw を書き換える段
  鎖の第 3 段（z^n = 1 の代入）              hz を書き換える段
  鎖の第 4 段（1 は積の単位元）              one_mul

mathlib の一般論（`Subgroup`・`rootsOfUnity` 等）へ委ねず、人手証明の鎖をそのまま書く。
第 1 段は自前の `qbarMul_pow`（`claim_qbar_mul_pow` の具体版）を引いている。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarMulPow

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の本体。`w, z ∈ μ_n` ならば `w * z ∈ μ_n`（`claim_root_of_unity_mul`）。 -/
theorem rootOfUnity_mul {n : ℕ} {w z : Qbar}
    (hw : w ∈ RootOfUnity n) (hz : z ∈ RootOfUnity n) : w * z ∈ RootOfUnity n := by
  -- 準備。μ_n の定義をほどいて w^n = 1 と z^n = 1 を出す。
  rw [mem_rootOfUnity] at hw hz
  rw [mem_rootOfUnity]
  calc (w * z) ^ n
      = w ^ n * z ^ n := qbarMul_pow w z n   -- 第 1 段。積の冪は冪の積である。
    _ = 1 * z ^ n := by rw [hw]              -- 第 2 段。w^n = 1 の代入。
    _ = 1 * 1 := by rw [hz]                  -- 第 3 段。z^n = 1 の代入。
    _ = 1 := one_mul 1                       -- 第 4 段。1 は積の単位元。

end Ising2DLambda.AlgebraicEigenvalue
