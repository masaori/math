/-
章「トーラス上の Kac--Ward 行列式」の「閉歩道の循環総回転数は 4 の倍数である」
（`claim_cyclic_total_turning_multiple_of_four`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                    このファイル
  射影 π₄ : ℤ → ℤ/4ℤ                          整数キャスト `fun n : ℤ => (n : ZMod 4)`
  π₄(0) は零元・π₄ の加法性                    `Int.cast_zero`・`Int.cast_add`
  一歩は方向番号を回転数だけ進める             方向の更新 `fun a n => a + (n : ZMod 4)`（定義）
  端の方向番号の差は総回転数（帰納法）         `foldl_add_of_additive_necSuf`
  両辺に加法逆元を加えて簡約                   `closed_walk_additive_vanishes_necSuf`
  剰余類の等号 ⇔ 4 の倍数                      `ZMod.intCast_zmod_eq_zero_iff_dvd`

住処: 人手証明のこのブロックは Z（ℤ/4ℤ）を宣言している。ℝ / ℂ は現れない。
-/
import Mathlib.Data.ZMod.Basic
import Ising2DLambda.NecSuf.KacWard.CyclicTurningVanishes

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 閉歩道の循環総回転数の剰余類は零である（ℤ/4ℤ に固定した具体版）。
`turns` は開いた部分の一歩の回転数の列、`closing` は終辺から始辺への一歩、
`d` は始辺の方向番号にあたる。仮定 `hclosed` が閉性（一周して方向番号が戻ること）である。 -/
theorem cyclic_total_turning_vanishes (d : ZMod 4) (turns : List Turn) (closing : Turn)
    (hclosed :
      (turns.map turnValue).foldl (fun (a : ZMod 4) (n : ℤ) => a + (n : ZMod 4)) d
        + ((turnValue closing : ℤ) : ZMod 4) = d) :
    (((turns.map turnValue).sum + turnValue closing : ℤ) : ZMod 4) = 0 :=
  closed_walk_additive_vanishes_necSuf (fun n : ℤ => (n : ZMod 4))
    Int.cast_zero Int.cast_add d (turns.map turnValue) (turnValue closing) hclosed

/-- 循環総回転数は 4 の倍数である（整数の整除としての言い換え）。 -/
theorem four_dvd_cyclic_total_turning (d : ZMod 4) (turns : List Turn) (closing : Turn)
    (hclosed :
      (turns.map turnValue).foldl (fun (a : ZMod 4) (n : ℤ) => a + (n : ZMod 4)) d
        + ((turnValue closing : ℤ) : ZMod 4) = d) :
    (4 : ℤ) ∣ ((turns.map turnValue).sum + turnValue closing) := by
  have h := cyclic_total_turning_vanishes d turns closing hclosed
  simpa using (ZMod.intCast_zmod_eq_zero_iff_dvd
    ((turns.map turnValue).sum + turnValue closing) 4).mp h

/-- 具体版が必要十分版の特殊化として得られることの記録。`A = ZMod 4`（加法群なので
左簡約を持つ）、`φ` を整数キャスト（`Int.cast_zero` と `Int.cast_add` が
π₄ の零の保存と加法性）と取れば、必要十分版がこの主張を与える。 -/
theorem cyclic_total_turning_vanishes_from_necSuf (d : ZMod 4) (turns : List Turn)
    (closing : Turn)
    (hclosed :
      (turns.map turnValue).foldl (fun (a : ZMod 4) (n : ℤ) => a + (n : ZMod 4)) d
        + ((turnValue closing : ℤ) : ZMod 4) = d) :
    (((turns.map turnValue).sum + turnValue closing : ℤ) : ZMod 4) = 0 :=
  closed_walk_additive_vanishes_necSuf (fun n : ℤ => (n : ZMod 4))
    Int.cast_zero Int.cast_add d (turns.map turnValue) (turnValue closing) hclosed

end Ising2DLambda.KacWard
