/-
# 0 と「1 を足す」で再帰的に定めた写像は和を保つ（帰納法の論法の**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersPreservesSum.lean`
（人手 `inclusion_nn_to_zz_preserves_sum`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersPreservesSumFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `induction y` | 同じ |
| `zero` の枝の 3 段 | 同じ（ℕ の和の再帰の式・`hadd_zero`・`hf0`） |
| `succ` の枝の 5 段 | 同じ（ℕ の和の再帰の式・`hfs`・帰納法の仮定・`hadd_assoc`・`hfs`） |

## 何が効いているか / 効いていないか

- 効くのは、`f` が `f 0 = 0`・`f (n + 1) = f n + 1` を満たすこと（具体版では `ι_{ℕ→ℤ}` の定義の二つの式）、
  右からの加法の単位元 `x + 0 = x`、加法の結合律だけである。
- 型には演算と元を持つだけの `Zero`・`One`・`Add` を置き、性質は仮定に書く。
- 加法の可換律・逆元、左からの加法の単位元、乗法、順序、ℤ であることは効いていない。
  定義域が ℕ であることは、帰納法と ℕ の和の再帰の式（`x + 0 = x`・`x + (y + 1) = (x + y) + 1`）のために要る。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`inclusion_nn_to_zz_preserves_sum`** の必要十分版: 上の仮定の下で、すべての `x, y` で `f (x + y) = f x + f y`。 -/
theorem map_add_of_rec_add_one {R : Type*} [Zero R] [One R] [Add R]
    (f : ℕ → R) (hf0 : f 0 = 0) (hfs : ∀ n : ℕ, f (n + 1) = f n + 1)
    (hadd_zero : ∀ x : R, x + 0 = x)
    (hadd_assoc : ∀ x y t : R, (x + y) + t = x + (y + t)) (x y : ℕ) :
    f (x + y) = f x + f y := by
  induction y with
  | zero =>
    calc f (x + 0)
        = f x := rfl
      _ = f x + 0 := (hadd_zero (f x)).symm
      _ = f x + f 0 := by rw [hf0]
  | succ y ih =>
    calc f (x + (y + 1))
        = f ((x + y) + 1) := rfl
      _ = f (x + y) + 1 := hfs (x + y)
      _ = (f x + f y) + 1 := by rw [ih]
      _ = f x + (f y + 1) := hadd_assoc (f x) (f y) 1
      _ = f x + f (y + 1) := by rw [hfs y]

end Ising2D.NecSuf
