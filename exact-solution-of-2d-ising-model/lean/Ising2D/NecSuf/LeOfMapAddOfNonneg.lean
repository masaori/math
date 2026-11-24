/-
# 和を保ち像が 0 以上の写像は順序を保つ（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersPreservesOrder.lean`
（人手 `inclusion_nn_to_zz_preserves_order`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersPreservesOrderFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| ℕ の順序と和で `x + d = y` の `d` を取る | 同じ（`Nat.le.dest`） |
| `calc` の 5 段 | 同じ（`hzero_add`・`hnonneg` に `hle_add`・`hadd_comm`・`hmap_add`・`x + d = y`） |

## 何が効いているか / 効いていないか

- 効くのは、`f` が和を保つこと（具体版では `inclusion_nn_to_zz_preserves_sum`）と像が `0` 以上であること
  （具体版では `inclusion_nn_to_zz_image_is_nonnegative`）、左からの加法の単位元 `0 + x = x`、加法の交換律、
  順序と加法の両立 `x ≤ y ⇒ x + t ≤ y + t` だけである。
- 型には演算と元と `≤` を持つだけの `Zero`・`Add`・`LE` を置き、性質は仮定に書く。`≤` と `=` を一度ずつつなぐだけなので、
  `≤` の反射律・推移律・反対称律も効いていない。
- 加法の結合律・逆元、右からの加法の単位元、乗法、`1`、ℤ であること、`f` の再帰の式は効いていない
  （再帰の式は、和を保つことと像が 0 以上であることを示すときにだけ使い、この主張の証明では使わない）。
  定義域が ℕ であることは、ℕ の順序と和 `x ≤ y ⇒ ∃d, x + d = y` のために要る。
-/
import Mathlib.Order.Basic
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`inclusion_nn_to_zz_preserves_order`** の必要十分版: 上の仮定の下で、`x ≤ y` なら `f x ≤ f y`。 -/
theorem le_of_map_add_of_nonneg {R : Type*} [Zero R] [Add R] [LE R]
    (f : ℕ → R) (hmap_add : ∀ x y : ℕ, f (x + y) = f x + f y) (hnonneg : ∀ n : ℕ, 0 ≤ f n)
    (hzero_add : ∀ x : R, 0 + x = x) (hadd_comm : ∀ x y : R, x + y = y + x)
    (hle_add : ∀ x y t : R, x ≤ y → x + t ≤ y + t) (x y : ℕ) (hxy : x ≤ y) :
    f x ≤ f y := by
  obtain ⟨d, hd⟩ := Nat.le.dest hxy
  calc f x
      = 0 + f x := (hzero_add (f x)).symm
    _ ≤ f d + f x := hle_add 0 (f d) (f x) (hnonneg d)
    _ = f x + f d := hadd_comm (f d) (f x)
    _ = f (x + d) := (hmap_add x d).symm
    _ = f y := by rw [hd]

end Ising2D.NecSuf
