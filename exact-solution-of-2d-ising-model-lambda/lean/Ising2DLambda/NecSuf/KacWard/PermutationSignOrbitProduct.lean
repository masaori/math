/-
主張「置換符号は動く軌道の符号因子の積である」（`claim_permutation_sign_moved_orbit_product`）の
Lean 配線の最初の二部品（必要十分版の側）。

一つは人手証明の段「各互換の符号は `-1`」に対応する。もう一つは
「符号の乗法性を軌道の有限族へ繰り返し適用すると」に対応する。
互いに可換な置換の有限族の合成の符号は、各置換の符号の積である。
証明は有限集合についての帰納法で、`sign_one`（恒等置換の符号は 1）と
`sign_comp`（符号の乗法性）だけを繰り返し適用する。人手証明が「繰り返し適用」と
書いた繰り返しを、そのまま帰納法として書いたものである。

  使っている性質                     なぜ削れないか
  `Fintype α`・`DecidableRel lt`     符号（転倒数）の定義に要る（`PermutationSign.lean` と同じ）。
  三分律 `htri`                      `sign_one` と `sign_comp` が要求する。
  族の可換性 `comm`                  合成を `Finset.noncommProd` として書き下すのに要る。
                                     族の並べ順を選んで合成する書き方では、どの順序を
                                     選んだかが人手証明に無い情報として入るので、
                                     可換性を仮定して順序へ依存しない合成を使う。

台が軌道であること・置換どうしの台が互いに素であることは使っていない（可換性だけ使う）。
互いに素な台を持つ置換が可換であることは、この先の具体版の側で示す。

住処: ここに ℝ / ℂ は現れない（符号は ℤ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTranspositionSign
import Mathlib.Data.Finset.NoncommProd

namespace Ising2DLambda.NecSuf.KacWard

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {α : Type*} [Fintype α] (lt : α → α → Prop) [DecidableRel lt]

/-- 人手証明の全体集合上の互換。二回適用すると恒等写像へ戻る。 -/
def transpositionPerm [DecidableEq α] (a b : α) : Equiv.Perm α where
  toFun := transpositionOn a b
  invFun := transpositionOn a b
  left_inv := transpositionOn_involutive a b
  right_inv := transpositionOn_involutive a b

/-- 有限線型順序集合の相異なる二点の互換の符号は `-1` である。
人手証明の転倒対の分割を一般の有限台で行った `signOn_transposition` を、全体集合へ適用する。 -/
theorem sign_transposition [LinearOrder α] (a b : α) (hab : a ≠ b) :
    sign (fun x y : α => x < y) (transpositionPerm a b) = -1 := by
  classical
  have sign_eq_signOn (x y : α) :
      sign (fun u v : α => u < v) (transpositionPerm x y) =
        signOn (fun u v : α => u < v)
          (orderedPairsOn (fun u v : α => u < v) Finset.univ) (transpositionOn x y) := by
    rfl
  rcases lt_or_gt_of_ne hab with hablt | hbalt
  · rw [sign_eq_signOn]
    exact signOn_transposition (fun x y : α => x < y) (fun _ _ => LT.lt.asymm)
      (fun _ _ _ => LT.lt.trans) (Finset.mem_univ a) (Finset.mem_univ b) hablt
  · have hswap : transpositionPerm a b = transpositionPerm b a := by
      ext x
      simp only [transpositionPerm, transpositionOn, Equiv.coe_fn_mk]
      by_cases hxa : x = a <;> by_cases hxb : x = b <;> simp [hxa, hxb, hab]
    rw [hswap, sign_eq_signOn]
    exact signOn_transposition (fun x y : α => x < y) (fun _ _ => LT.lt.asymm)
      (fun _ _ _ => LT.lt.trans) (Finset.mem_univ b) (Finset.mem_univ a) hbalt

/-- 互いに可換な置換の有限族の合成の符号は、各置換の符号の積である。
人手証明の「符号の乗法性を軌道の有限族へ繰り返し適用する」に対応する。 -/
theorem sign_noncommProd (htri : Trichotomous lt) {β : Type*}
    (s : Finset β) (f : β → Equiv.Perm α)
    (comm : (s : Set β).Pairwise fun b c => Commute (f b) (f c)) :
    sign lt (s.noncommProd f comm) = ∏ b ∈ s, sign lt (f b) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    -- 空の族の合成は恒等置換で、符号は 1（`sign_one`）。空の積も 1。
    simp [Finset.noncommProd_empty, sign_one lt htri]
  | insert a t ha ih =>
    -- 1 元ずつ族へ足す。足した元との合成へ `sign_comp` を 1 回適用する。
    rw [Finset.noncommProd_insert_of_notMem t a f _ ha, sign_comp lt htri,
      Finset.prod_insert ha, ih (comm.mono (Finset.subset_insert a t))]

end Ising2DLambda.NecSuf.KacWard
