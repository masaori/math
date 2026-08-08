/-
主張「列番号の平行移動は全単射である」「行配位の巡回シフトは全単射である」
「行内破れ数は巡回シフトで変わらない」「行間破れ数は 2 つの行配位を同時に巡回シフトしても
変わらない」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.RowConfigShift`）の証明が実際に使っているのは
次だけである。行配位であること・格子の形・スピンの値が ±1 であること・添字が
`ℤ/Lℤ` であること・値が多項式であることは、どこにも使っていない。

平行移動が全単射であること（`translationEquiv`）:

  使っている性質            なぜ削れないか
  `AddGroup G`              `y + a` の逆向きに `y + (-a)` を取り、結合則・逆元・単位元で
                            往復が恒等写像になること。**可換性は使っていない**ので
                            `AddCommGroup` にはしていない（`ℤ/Lℤ` は可換だが、
                            人手証明が使っているのは結合則と逆元だけである）。
                            有限性も使っていない。

引き戻しが全単射であること（`precompEquiv`）:

  使っている性質            なぜ削れないか
  `e : ι ≃ ι`               引き戻しの逆向きに `e.symm` での引き戻しを取るのに要る。
                            値の型 `κ` には何も要求しない（有限性も相等の判定も要らない）。

破れ数が変わらないこと（`card_filter_comp_equiv`）:

  使っている性質            なぜ削れないか
  `Fintype ι`               `Finset.filter` で数える対象が有限であること。
  `DecidableEq ι`           1 対 1 対応を与える `Finset.card_bij'` で像と逆像を突き合わせるのに要る。
  `e : ι ≃ ι`               1 対 1 対応そのもの。単なる写像へ弱めると個数は一般に変わる。
  `DecidablePred p`         `filter` が定まること。

とくに、述語 `p` には何も要求していない。人手証明の 2 つの主張（行内破れ数・行間破れ数）は
`p` の取り方が違うだけで、いずれもこの 1 つの補題の特殊化である
（行内は `p z = (τ z ≠ τ (γ z))`、行間は `p z = (τ z ≠ τ' z)`）。すなわち
**この証明は破れ数が「値の相違を数えたもの」であることを使っていない。**

証明手順は具体版と同じである（逆向きの写像を明示して往復が恒等写像であることを見る、
数え上げは 1 対 1 対応で移す）。別の論法へ差し替えていない。

住処: ここに ℝ / ℂ は現れない（添字は一般の有限型、群は一般の加法群）。
-/
import Mathlib.Algebra.Group.Basic
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Finset.Card

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 具体版の `γ`（人手証明の「列番号の平行移動」）にあたる写像。

加法群の元 `a` を足す写像は全単射である。逆向きは `-a` を足す写像で、
往復が恒等写像であることは結合則・逆元・単位元だけから出る。 -/
def translationEquiv {G : Type*} [AddGroup G] (a : G) : G ≃ G where
  toFun y := y + a
  invFun y := y + (-a)
  left_inv y := by
    -- (y + a) + (-a) = y + (a + (-a)) = y + 0 = y
    show (y + a) + (-a) = y
    rw [add_assoc, add_neg_cancel, add_zero]
  right_inv y := by
    -- (y + (-a)) + a = y + ((-a) + a) = y + 0 = y
    show (y + (-a)) + a = y
    rw [add_assoc, neg_add_cancel, add_zero]

/-- 具体版の `S`（人手証明の「行配位の巡回シフト」）にあたる写像。

全単射 `e` で引き戻す操作は、写像全体の集合の上の全単射である。 -/
def precompEquiv {ι κ : Type*} (e : ι ≃ ι) : (ι → κ) ≃ (ι → κ) where
  toFun f := fun y => f (e y)
  invFun f := fun y => f (e.symm y)
  left_inv f := by
    funext y
    show f (e (e.symm y)) = f y
    rw [Equiv.apply_symm_apply]
  right_inv f := by
    funext y
    show f (e.symm (e y)) = f y
    rw [Equiv.symm_apply_apply]

/-- 人手証明の数え上げの一歩。全単射で引き戻した述語を満たす元の個数は変わらない。

人手証明が `|γ⁻¹(X)| = |X|`（`γ` が `γ⁻¹(X)` から `X` への全単射であること）と
書いている段にあたる。行内破れ数・行間破れ数のどちらもこの特殊化である。 -/
theorem card_filter_comp_equiv {ι : Type*} [Fintype ι] [DecidableEq ι] (e : ι ≃ ι)
    (p : ι → Prop) [DecidablePred p] :
    (univ.filter fun y => p (e y)).card = (univ.filter p).card := by
  refine Finset.card_bij' (fun y _ => e y) (fun z _ => e.symm z) ?_ ?_ ?_ ?_
  · intro y hy
    simpa using (mem_filter.mp hy).2
  · intro z hz
    refine mem_filter.mpr ⟨mem_univ _, ?_⟩
    simpa using (mem_filter.mp hz).2
  · intro y _
    exact e.symm_apply_apply y
  · intro z _
    exact e.apply_symm_apply z

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
