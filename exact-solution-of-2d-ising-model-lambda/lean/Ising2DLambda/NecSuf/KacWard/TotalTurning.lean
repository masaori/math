/-
必要十分版: 回転位相は一歩の回転数の整数冪であり、位相のリスト積は回転数の和の冪になる。

人手証明が使うのは、三つの回転の型と、積を和へ移す整数指数の指数法則だけである。
辺、トーラス、8 乗根の関係式 `z ^ 4 = -1` は必要ない。

- `phaseOfTurn_eq_zpow_necSuf` は仮定を持たない。群 with zero の整数冪の約束
  （`z ^ (0:ℤ) = 1`、`z ^ (1:ℤ) = z`、`z ^ (-1:ℤ) = z⁻¹`）だけで閉じ、`z = 0` でも成り立つ。
- `phase_prod_eq_zpow_sum_necSuf` は `z ≠ 0` を要する。指数法則
  `z ^ (r + s) = z ^ r * z ^ s`（`zpow_add₀`）が零では破れるためであり、
  これが人手証明の「ζ₈ ≠ 0 と整数指数の指数法則」に対応する（この仮定が必要な理由）。
-/
import Ising2DLambda.NecSuf.KacWard.ReversalRotationPhase

namespace Ising2DLambda.NecSuf.KacWard

/-- 一歩の回転数（`def_step_turning`）。直進 0・左回転 1・右回転 -1。 -/
def turnValue : Turn → ℤ
  | .straight => 0
  | .left => 1
  | .right => -1

/-- 回転位相は一歩の回転数の整数冪である（`claim_rotation_phase_as_turning_power` の骨格）。
人手証明と同じ三場合の照合。仮定は不要である（整数冪の約束だけで閉じる）。 -/
theorem phaseOfTurn_eq_zpow_necSuf {K : Type*} [Field K] (z : K)
    (turn : Turn) : phaseOfTurn z turn = z ^ turnValue turn := by
  cases turn
  · -- 直進: 1 = z ^ 0
    simp [phaseOfTurn, turnValue]
  · -- 左回転: z = z ^ 1
    simp [phaseOfTurn, turnValue]
  · -- 右回転: z⁻¹ = z ^ (-1)
    simp [phaseOfTurn, turnValue]

/-- 位相のリスト積は回転数の和の冪である（`claim_walk_rotation_phase_total_turning` の骨格）。
人手証明と同じく列の長さの帰納法（リストの帰納法）で、末尾ではなく先頭の因子を
分離する向きだけが異なる。`z ≠ 0` は指数法則 `zpow_add₀` が要求する。 -/
theorem phase_prod_eq_zpow_sum_necSuf {K : Type*} [Field K] {z : K} (hz : z ≠ 0)
    (turns : List Turn) :
    (turns.map (phaseOfTurn z)).prod = z ^ (turns.map turnValue).sum := by
  induction turns with
  | nil =>
      -- 底: 空積 1 = z ^ 0（空和）
      simp
  | cons head tail ih =>
      -- 帰納段: 因子を分離し、帰納法の仮定と一歩の等式を入れ、指数法則で冪をまとめる
      rw [List.map_cons, List.prod_cons, List.map_cons, List.sum_cons,
        ih, phaseOfTurn_eq_zpow_necSuf z head, ← zpow_add₀ hz]

end Ising2DLambda.NecSuf.KacWard
