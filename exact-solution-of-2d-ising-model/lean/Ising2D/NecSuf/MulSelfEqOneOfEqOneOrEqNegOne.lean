/-
# −1 か 1 の元は、自分自身との積が 1（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealPlusOrMinusOneTimesItselfIsOne.lean`
（人手 `real_plus_or_minus_one_times_itself_is_one`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealPlusOrMinusOneTimesItselfIsOneFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `σ = 1` の節の 1 段（`1·1 = 1`） | `mul_self_eq_one_of_eq_one_or_eq_neg_one` の `σ = 1` の節の 1 段 |
| `σ = -1` の節の 2 段（`(-1)(-1) = 1·1` → `1·1 = 1`） | `σ = -1` の節の 2 段（同じ並び） |

## 何が効いているか / 効いていないか

- `(-1)(-1) = 1·1` の段は、具体版では主張 `real_negation_times_negation_is_product` を引く段で、ここでもその必要十分版
  `neg_mul_neg_of_rightDistrib` を引く。効くのは加法の可換群・乗法の結合律と可換律・右からの分配律・左からの乗法の単位元 `1·a = a` である
  （`NecSuf/NegMulNegOfRightDistrib.lean` の「何が効いているか」）。
- `1·1 = 1` の段は、具体版では ℝ の `p·1 = p`（`p → 1`）で、ここでは同じ式を仮定 `hone_mul` の `a → 1` で得る。
  効いているのは `1·1 = 1` だけで、`1` がほかの元の右からの単位元であることは効いていない。
- 乗法の逆元、順序、実数であることは効いていない。
- 仮定 `hone_mul` と型クラスは `neg_mul_neg_of_rightDistrib` と同じにした（`σ = -1` の段がそれを引くため）。
  主張 `σ·σ = 1` そのものは乗法が可換でない環でも成り立つので、可換律が要るのは人手の経路のためであり、主張には本質的でない。
-/
import Ising2D.NecSuf.NegMulNegOfRightDistrib

namespace Ising2D.NecSuf

/-- **`real_plus_or_minus_one_times_itself_is_one`** の必要十分版: 加法の可換群で、乗法が可換な半群をなし、
右からの分配律をもち、`1` が左からの乗法の単位元なら、`σ = 1` か `σ = -1` の元 `σ` は `σ·σ = 1`。 -/
theorem mul_self_eq_one_of_eq_one_or_eq_neg_one {R : Type*} [AddCommGroup R] [CommSemigroup R] [One R]
    [RightDistribClass R] (hone_mul : ∀ a : R, 1 * a = a) (σ : R) (hσ : σ = 1 ∨ σ = -1) : σ * σ = 1 := by
  rcases hσ with h | h
  · rw [h]
    exact (calc (1 : R) * 1 = 1 := hone_mul 1)                                      -- `1·1 = 1`
  · rw [h]
    calc (-1 : R) * (-1)
        = 1 * 1 := neg_mul_neg_of_rightDistrib hone_mul 1 1                     -- `(-a)(-b) = ab`（`a → 1`、`b → 1`）
      _ = 1 := hone_mul 1                                                      -- `1·1 = 1`

end Ising2D.NecSuf
