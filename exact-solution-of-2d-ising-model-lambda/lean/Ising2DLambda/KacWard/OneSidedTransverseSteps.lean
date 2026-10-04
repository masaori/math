/-
「一側閉包の横断二列の歩ベクトルは基点に依らない」の具体版。
本文の準備で基点を分離し、本体で二点の共通基点を消す。
`reverse = false` が上り列、`reverse = true` が下り列の添字を表す。
-/
import Ising2DLambda.KacWard.IteratedTransverseStaircase

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `claim_one_sided_transverse_steps_base_independent`。
反復横断階段を順向き・逆向きに読むどちらの場合も、歩ベクトルは基点に依らない。 -/
theorem oneSidedTransverseSteps_base_independent
    (wh wv : ℤ) (base : ℤ × ℤ) (t : ℕ) (reverse : Bool)
    (i : ℕ) (_hi : i < t * (wh.natAbs + wv.natAbs)) :
    let b := t * (wh.natAbs + wv.natAbs)
    let index := fun j : ℕ => if reverse then b - j else j
    iteratedTransverseStaircase wh wv base (index (i + 1)) -
        iteratedTransverseStaircase wh wv base (index i) =
      iteratedTransverseStaircase wh wv 0 (index (i + 1)) -
        iteratedTransverseStaircase wh wv 0 (index i) := by
  let n := wh.natAbs + wv.natAbs
  let period : ℤ × ℤ := (wh, -wv)
  let path := windingTransverseStaircase wh wv
  let index := fun j : ℕ => if reverse then t * n - j else j
  -- 本文の準備: 定義展開、結合律、零の挿入、原点を基点とする定義の畳み込み。
  have hbase (s : ℕ) :
      iteratedTransverseStaircase wh wv base s =
        base + iteratedTransverseStaircase wh wv 0 s := by
    let quotient := s / n
    let remainder := s % n
    calc
      iteratedTransverseStaircase wh wv base s =
          base + quotient • period + path remainder := rfl
      _ = base + (quotient • period + path remainder) := add_assoc _ _ _
      _ = base + ((0 + quotient • period) + path remainder) := by rw [zero_add]
      _ = base + iteratedTransverseStaircase wh wv 0 s := rfl
  change iteratedTransverseStaircase wh wv base (index (i + 1)) -
      iteratedTransverseStaircase wh wv base (index i) =
    iteratedTransverseStaircase wh wv 0 (index (i + 1)) -
      iteratedTransverseStaircase wh wv 0 (index i)
  -- 本文の本体: 両端の表示を代入し、共通基点を加法群の計算で消す。
  calc
    iteratedTransverseStaircase wh wv base (index (i + 1)) -
        iteratedTransverseStaircase wh wv base (index i) =
      (base + iteratedTransverseStaircase wh wv 0 (index (i + 1))) -
        (base + iteratedTransverseStaircase wh wv 0 (index i)) := by rw [hbase, hbase]
    _ = iteratedTransverseStaircase wh wv 0 (index (i + 1)) -
        iteratedTransverseStaircase wh wv 0 (index i) := by abel

/-- 本文末尾の二代入: 上り列の基点は `S + c • B`、下り列の基点は `S`。 -/
theorem oneSidedTransverseSteps_closure_columns
    (wh wv : ℤ) (S B : ℤ × ℤ) (t c i : ℕ)
    (hi : i < t * (wh.natAbs + wv.natAbs)) :
    let b := t * (wh.natAbs + wv.natAbs)
    (iteratedTransverseStaircase wh wv (S + c • B) (i + 1) -
        iteratedTransverseStaircase wh wv (S + c • B) i =
      iteratedTransverseStaircase wh wv 0 (i + 1) -
        iteratedTransverseStaircase wh wv 0 i) ∧
    (iteratedTransverseStaircase wh wv S (b - (i + 1)) -
        iteratedTransverseStaircase wh wv S (b - i) =
      iteratedTransverseStaircase wh wv 0 (b - (i + 1)) -
        iteratedTransverseStaircase wh wv 0 (b - i)) := by
  dsimp only
  constructor
  · exact oneSidedTransverseSteps_base_independent wh wv (S + c • B) t false i hi
  · exact oneSidedTransverseSteps_base_independent wh wv S t true i hi

end Ising2DLambda.KacWard
