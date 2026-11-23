/-
# 0 と「1 を足す」で再帰的に定めた写像は積を保つ（帰納法の論法の**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersPreservesProduct.lean`
（人手 `inclusion_nn_to_zz_preserves_product`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersPreservesProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `induction y` | 同じ |
| `zero` の枝の 5 段 | 同じ（ℕ の積の再帰の式・`hf0`・`hzero_mul`・`hmul_comm`・`hf0`） |
| `succ` の枝の 6 段 | 同じ（ℕ の積の再帰の式・`map_add_of_rec_add_one`・帰納法の仮定・`hmul_one`・`hmul_add`・`hfs`） |

## 何が効いているか / 効いていないか

- 効くのは、`f` が `f 0 = 0`・`f (n + 1) = f n + 1` を満たすこと、和を保つことの必要十分版
  `map_add_of_rec_add_one` の仮定（右からの加法の単位元、加法の結合律）、左から 0 を掛けると 0 になること、
  乗法の可換律、右からの乗法の単位元、左からの分配律だけである。
- 乗法の可換律が効くのは、`zero` の枝の 4 段目 `0·f(x) = f(x)·0` の一か所だけである（既存の必要十分版と揃えて全称の形で置く）。
- 型には演算と元を持つだけの `Zero`・`One`・`Add`・`Mul` を置き、性質は仮定に書く。
- 加法の可換律・逆元、乗法の結合律、右からの分配律、順序、ℤ であることは効いていない。
  定義域が ℕ であることは、帰納法と ℕ の積の再帰の式（`x·0 = 0`・`x·(y + 1) = x·y + x`）のために要る。
-/
import Ising2D.NecSuf.MapAddOfRecAddOne

namespace Ising2D.NecSuf

/-- **`inclusion_nn_to_zz_preserves_product`** の必要十分版: 上の仮定の下で、すべての `x, y` で `f (x·y) = f x · f y`。 -/
theorem map_mul_of_rec_add_one {R : Type*} [Zero R] [One R] [Add R] [Mul R]
    (f : ℕ → R) (hf0 : f 0 = 0) (hfs : ∀ n : ℕ, f (n + 1) = f n + 1)
    (hadd_zero : ∀ x : R, x + 0 = x)
    (hadd_assoc : ∀ x y t : R, (x + y) + t = x + (y + t))
    (hzero_mul : ∀ x : R, 0 * x = 0)
    (hmul_comm : ∀ x y : R, x * y = y * x)
    (hmul_one : ∀ x : R, x * 1 = x)
    (hmul_add : ∀ x y t : R, x * (y + t) = x * y + x * t) (x y : ℕ) :
    f (x * y) = f x * f y := by
  induction y with
  | zero =>
    calc f (x * 0)
        = f 0 := rfl
      _ = 0 := hf0
      _ = 0 * f x := (hzero_mul (f x)).symm
      _ = f x * 0 := hmul_comm 0 (f x)
      _ = f x * f 0 := by rw [hf0]
  | succ y ih =>
    calc f (x * (y + 1))
        = f (x * y + x) := rfl
      _ = f (x * y) + f x := map_add_of_rec_add_one f hf0 hfs hadd_zero hadd_assoc (x * y) x
      _ = f x * f y + f x := by rw [ih]
      _ = f x * f y + f x * 1 := by rw [hmul_one (f x)]
      _ = f x * (f y + 1) := (hmul_add (f x) (f y) 1).symm
      _ = f x * f (y + 1) := by rw [hfs y]

end Ising2D.NecSuf
