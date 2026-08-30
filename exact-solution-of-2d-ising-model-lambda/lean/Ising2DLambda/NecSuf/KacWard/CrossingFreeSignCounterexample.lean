/-
「横断数が零であるだけでは単純閉路の回転位相符号は従わない」の必要十分版。
辺や格子は使わず、反例で実際に現れる六つの回転数、二つの切断線指示値、
十五添字対の横断判定だけを受け取り、その有限計算が反対の二符号を与えることを示す。
-/
import Mathlib.Data.Int.Basic
import Mathlib.Data.List.Basic

namespace Ising2DLambda.NecSuf.KacWard

theorem crossingFreeSignCounterexample_necSuf
    (turns : List ℤ) (horizontal vertical : List ℕ) (crossings : List Bool)
    (ht : turns = [0, 1, -1, 0, -1, 1])
    (hh : horizontal = [0, 1, 0, 0, 1, 0])
    (hv : vertical = [0, 0, 0, 0, 0, 0])
    (hc : crossings = List.replicate 15 false) :
    turns.sum = 0 ∧
      horizontal.sum % 2 = 0 ∧
      vertical.sum % 2 = 0 ∧
      crossings.all (fun value => !value) = true ∧
      ((-1 : ℤ) ^ 0) ≠ ((-1 : ℤ) ^ 1) := by
  subst turns
  subst horizontal
  subst vertical
  subst crossings
  decide

end Ising2DLambda.NecSuf.KacWard
