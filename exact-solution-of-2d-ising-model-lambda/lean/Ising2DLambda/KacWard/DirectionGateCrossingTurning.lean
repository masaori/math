/-
章「Onsager 閉形式への接続」の
「循環総回転数は方向番号の門の符号付き横断数の 4 倍である」
（`claim_direction_gate_crossing_turning`）の具体版。

人手証明と同じく、四方向の標準整数代表を取り、各一歩を三場合で読み、有限和の
望遠和で代表の差を消す。住処は有限集合・ℕ・ℤ・ℤ/4ℤ であり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.TotalTurning
import Ising2DLambda.NecSuf.KacWard.DirectionGateCrossingTurning
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `def_direction_standard_representative`。四つの方向番号の標準整数代表。 -/
def directionStandardRepresentative (d : ZMod 4) : ℤ := d.val

/-- `def_positive_direction_gate_crossing_count` の一遷移分。 -/
def positiveDirectionGateIndicator (a b : ZMod 4) : ℕ :=
  if directionStandardRepresentative a = 3 ∧ directionStandardRepresentative b = 0 then 1 else 0

/-- `def_negative_direction_gate_crossing_count` の一遷移分。 -/
def negativeDirectionGateIndicator (a b : ZMod 4) : ℕ :=
  if directionStandardRepresentative a = 0 ∧ directionStandardRepresentative b = 3 then 1 else 0

/-- 閉じた方向列が門 `3|0` を正向きに横断する回数。 -/
def positiveDirectionGateCrossingCount (n : ℕ) (direction : ℕ → ZMod 4) : ℕ :=
  ∑ k ∈ Finset.range n, positiveDirectionGateIndicator (direction k) (direction (k + 1))

/-- 閉じた方向列が門 `3|0` を負向きに横断する回数。 -/
def negativeDirectionGateCrossingCount (n : ℕ) (direction : ℕ → ZMod 4) : ℕ :=
  ∑ k ∈ Finset.range n, negativeDirectionGateIndicator (direction k) (direction (k + 1))

/-- 一歩の回転数は、標準整数代表の差と二つの門横断指示子へ分解される。 -/
lemma turnValue_eq_representative_difference
    (a : ZMod 4) (turn : Turn) :
    turnValue turn =
      directionStandardRepresentative (a + ((turnValue turn : ℤ) : ZMod 4))
        - directionStandardRepresentative a
        + 4 * (positiveDirectionGateIndicator a
          (a + ((turnValue turn : ℤ) : ZMod 4)) : ℤ)
        - 4 * (negativeDirectionGateIndicator a
          (a + ((turnValue turn : ℤ) : ZMod 4)) : ℤ) := by
  fin_cases a <;> cases turn <;> native_decide

/-- `claim_direction_gate_crossing_turning` の具体版。 -/
theorem directionGateCrossing_turning
    (n : ℕ) (direction : ℕ → ZMod 4) (turn : ℕ → Turn)
    (hadvance : ∀ k < n,
      direction (k + 1) = direction k + ((turnValue (turn k) : ℤ) : ZMod 4))
    (hclosed : direction n = direction 0) :
    (∑ k ∈ Finset.range n, turnValue (turn k)) =
      4 * ((positiveDirectionGateCrossingCount n direction : ℤ)
        - (negativeDirectionGateCrossingCount n direction : ℤ)) := by
  apply direction_gate_crossing_turning_necSuf n
    (fun k => directionStandardRepresentative (direction k))
    (fun k => turnValue (turn k))
    (fun k => positiveDirectionGateIndicator (direction k) (direction (k + 1)))
    (fun k => negativeDirectionGateIndicator (direction k) (direction (k + 1)))
  · intro k hk
    rw [hadvance k hk]
    exact turnValue_eq_representative_difference (direction k) (turn k)
  · rw [hclosed]

end Ising2DLambda.KacWard
