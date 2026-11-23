/-
# 0 と「1 を足す」で再帰的に定めた写像の値は 0 以上（帰納法の論法の**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersImageIsNonnegative.lean`
（人手 `inclusion_nn_to_zz_image_is_nonnegative`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersImageIsNonnegativeFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `induction n` | 同じ |
| `zero` の枝の 2 段 | 同じ（`hle_refl`・`hf0`） |
| `succ` の枝の 5 段 | 同じ（`hzero_add`・`hle_add` に `h01`・`hadd_comm`・`hle_add` に帰納法の仮定・`hfs`） |

## 何が効いているか / 効いていないか

- 効くのは、`f` が `f 0 = 0`・`f (n + 1) = f n + 1` を満たすこと（具体版では `ι_{ℕ→ℤ}` の定義の二つの式）、
  `0 ≤ 1`、`≤` の反射律と推移律、`≤` と加法の両立 `x ≤ y ⇒ x + t ≤ y + t`、左からの加法の単位元 `0 + x = x`、加法の可換律だけである。
- 加法の可換律が効くのは、`succ` の枝の 3 段目 `1 + 0 = 0 + 1` の一か所だけである（既存の必要十分版と揃えて全称の形で置く）。
- 型には演算と元を持つだけの `Zero`・`One`・`Add` と、反射律・推移律を持つ `Preorder` を置き、残りの性質は仮定に書く。
  推移律は `≤` と `=` の連なりを `calc` でつなぐのに要る（`Preorder` はその分だけを持ち込む）。
- 加法の結合律・逆元、乗法、反対称律、全順序、ℤ であること（離散性）は効いていない。
  定義域が ℕ であることは、帰納法で示すために要る。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`inclusion_nn_to_zz_image_is_nonnegative`** の必要十分版: 上の仮定の下で、すべての `n` で `0 ≤ f n`。 -/
theorem zero_le_of_rec_add_one {R : Type*} [Zero R] [One R] [Add R] [Preorder R]
    (f : ℕ → R) (hf0 : f 0 = 0) (hfs : ∀ n : ℕ, f (n + 1) = f n + 1)
    (h01 : (0 : R) ≤ 1)
    (hle_add : ∀ x y t : R, x ≤ y → x + t ≤ y + t)
    (hzero_add : ∀ x : R, 0 + x = x)
    (hadd_comm : ∀ x y : R, x + y = y + x) (n : ℕ) :
    (0 : R) ≤ f n := by
  induction n with
  | zero =>
    calc (0 : R)
        ≤ 0 := le_refl 0
      _ = f 0 := hf0.symm
  | succ n ih =>
    calc (0 : R)
        = 0 + 0 := (hzero_add 0).symm
      _ ≤ 1 + 0 := hle_add 0 1 0 h01
      _ = 0 + 1 := hadd_comm 1 0
      _ ≤ f n + 1 := hle_add 0 (f n) 1 ih
      _ = f (n + 1) := (hfs n).symm

end Ising2D.NecSuf
