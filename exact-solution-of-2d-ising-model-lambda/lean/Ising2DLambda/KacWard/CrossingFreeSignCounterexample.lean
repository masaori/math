/-
「横断数が零であるだけでは単純閉路の回転位相符号は従わない」の具体版。
本文の一辺二の六辺から得る回転数列・切断線指示値列・横断判定列を固定し、
人手証明と同じ有限計算を行う。辺の接続と横断判定そのものは SageMath 層が
本文の定義から全添字対について独立に検査する。
-/
import Ising2DLambda.NecSuf.KacWard.CrossingFreeSignCounterexample

namespace Ising2DLambda.KacWard

theorem crossingFreeSignCounterexample :
    ([0, 1, -1, 0, -1, 1] : List ℤ).sum = 0 ∧
      ([0, 1, 0, 0, 1, 0] : List ℕ).sum % 2 = 0 ∧
      ([0, 0, 1, 0, 0, 1] : List ℕ).sum % 2 = 0 ∧
      (List.replicate 15 false).all (fun value => !value) = true ∧
      ((-1 : ℤ) ^ 0) ≠ ((-1 : ℤ) ^ 1) :=
  Ising2DLambda.NecSuf.KacWard.crossingFreeSignCounterexample_necSuf
    [0, 1, -1, 0, -1, 1]
    [0, 1, 0, 0, 1, 0]
    [0, 0, 1, 0, 0, 1]
    (List.replicate 15 false) rfl rfl rfl rfl

theorem crossingFreeSignCounterexample_from_necSuf :
    ([0, 1, -1, 0, -1, 1] : List ℤ).sum = 0 ∧
      ([0, 1, 0, 0, 1, 0] : List ℕ).sum % 2 = 0 ∧
      ([0, 0, 1, 0, 0, 1] : List ℕ).sum % 2 = 0 ∧
      (List.replicate 15 false).all (fun value => !value) = true ∧
      ((-1 : ℤ) ^ 0) ≠ ((-1 : ℤ) ^ 1) :=
  crossingFreeSignCounterexample

end Ising2DLambda.KacWard
