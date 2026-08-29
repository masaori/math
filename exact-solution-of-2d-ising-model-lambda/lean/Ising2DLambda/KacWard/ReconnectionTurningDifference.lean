/-
「接続の組み替えの回転差は −4, 0, 4 に限る」（`claim_reconnection_turning_difference`）の具体版。
人手証明との対応:

  人手証明                                        このファイル
  四つの接続への一歩の更新（方向番号の等式）       仮定 `hef` `he'f'` `hef'` `he'f`（ℤ/4ℤ の等式）
  二つの鎖の左辺が同じ → π₄(S₁) = π₄(S₂)          `hcong`（加法の可換結合と左簡約）
  π₄(D) = 0 → D ∈ 4ℤ                              `hdvd`（`ZMod.intCast_zmod_eq_zero_iff_dvd`）
  τ ∈ {0,1,-1} → -4 ≤ D ≤ 4                       `turnValue_mem` の場合分け
  4 の倍数かつ範囲内 → D ∈ {-4,0,4}                `dvd_four_bounded_mem_necSuf`

住処: 人手証明のこのブロックは Z を宣言している。ℝ / ℂ は現れない。
-/
import Mathlib.Data.ZMod.Basic
import Ising2DLambda.NecSuf.KacWard.TotalTurning
import Ising2DLambda.NecSuf.KacWard.ReconnectionTurningDifference

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 一歩の回転数は 0, 1, -1 のいずれかである（`def_step_turning` の値の場合分け）。 -/
theorem turnValue_mem (t : Turn) :
    turnValue t = 0 ∨ turnValue t = 1 ∨ turnValue t = -1 := by
  cases t
  · exact Or.inl rfl
  · exact Or.inr (Or.inl rfl)
  · exact Or.inr (Or.inr rfl)

/-- 接続の組み替えの回転差は −4, 0, 4 に限る（ℤ/4ℤ に固定した具体版）。
`a, b` は組 `(e→f, e'→f')` の一歩の回転、`c, d` は組み替えた組 `(e→f', e'→f)` の一歩の回転、
`de, de', df, df'` は四つの辺の方向番号にあたる。四つの仮定が
`claim_step_advances_direction` の四つの適用である。 -/
theorem reconnection_turning_difference (a b c d : Turn) (de de' df df' : ZMod 4)
    (hef : df = de + ((turnValue a : ℤ) : ZMod 4))
    (he'f' : df' = de' + ((turnValue b : ℤ) : ZMod 4))
    (hef' : df' = de + ((turnValue c : ℤ) : ZMod 4))
    (he'f : df = de' + ((turnValue d : ℤ) : ZMod 4)) :
    turnValue a + turnValue b - (turnValue c + turnValue d) = -4 ∨
      turnValue a + turnValue b - (turnValue c + turnValue d) = 0 ∨
      turnValue a + turnValue b - (turnValue c + turnValue d) = 4 := by
  -- 二つの鎖: dir f + dir f' を二通りの接続で展開する（人手証明の二つの式変形）
  have h1 : df + df' = de + de' + ((turnValue a + turnValue b : ℤ) : ZMod 4) := by
    rw [hef, he'f', Int.cast_add, add_add_add_comm]
  have h2 : df + df' = de + de' + ((turnValue c + turnValue d : ℤ) : ZMod 4) := by
    rw [he'f, hef', Int.cast_add, add_add_add_comm, add_comm de' de,
      add_comm ((turnValue d : ℤ) : ZMod 4) ((turnValue c : ℤ) : ZMod 4)]
  -- 左辺が同じなので左簡約して π₄(S₁) = π₄(S₂)
  have hcong : ((turnValue a + turnValue b : ℤ) : ZMod 4) =
      ((turnValue c + turnValue d : ℤ) : ZMod 4) :=
    add_left_cancel (h1.symm.trans h2)
  -- π₄(D) = 0 から 4 ∣ D（剰余類の等号 ⇔ 4 の倍数）
  have hzero : ((turnValue a + turnValue b - (turnValue c + turnValue d) : ℤ) : ZMod 4) = 0 := by
    rw [Int.cast_sub, hcong, sub_self]
  have hdvd : (4 : ℤ) ∣ (turnValue a + turnValue b - (turnValue c + turnValue d)) :=
    (ZMod.intCast_zmod_eq_zero_iff_dvd _ 4).mp hzero
  -- τ ∈ {0,1,-1} から -4 ≤ D ≤ 4
  rcases turnValue_mem a with ha | ha | ha <;>
    rcases turnValue_mem b with hb | hb | hb <;>
    rcases turnValue_mem c with hc | hc | hc <;>
    rcases turnValue_mem d with hd | hd | hd <;>
    exact dvd_four_bounded_mem_necSuf hdvd (by rw [ha, hb, hc, hd]; decide)
      (by rw [ha, hb, hc, hd]; decide)

/-- 具体版が必要十分版の特殊化として得られることの記録。`D` を回転数の差に取り、
整除（π₄ による合同）と範囲（τ ∈ {0,1,-1}）を渡せば、必要十分版がこの主張を与える。 -/
theorem reconnection_turning_difference_from_necSuf {D : ℤ} (hdvd : (4 : ℤ) ∣ D)
    (hlow : -4 ≤ D) (hhigh : D ≤ 4) : D = -4 ∨ D = 0 ∨ D = 4 :=
  dvd_four_bounded_mem_necSuf hdvd hlow hhigh

end Ising2DLambda.KacWard
