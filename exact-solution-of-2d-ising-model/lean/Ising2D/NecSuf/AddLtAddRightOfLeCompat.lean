/-
# 狭義の順序は右から同じ元を足しても保たれる（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealLessThanPreservedByAddingOnRight.lean`
（人手 `real_less_than_preserved_by_adding_on_right`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealLessThanPreservedByAddingOnRightFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `<` の定義から `x ≤ y`・`x ≠ y` | `hlt` の左向き |
| `x + c ≤ y + c`（順序と加法の両立） | `hle_add` |
| `x + c = y + c` を仮定した 7 段の `calc` | 同じ 7 段 |
| `<` の定義の右向き | `hlt` の右向き |

## 何が効いているか / 効いていないか

- 効くのは、`<` を `≤ かつ ≠` と定めたこと、`≤` と加法の両立 `x ≤ y ⇒ x + t ≤ y + t`、右からの加法の単位元 `x + 0 = x`、
  加法の逆元 `z + (−z) = 0`、加法の結合律の 5 つだけである。
- 型には演算と元を持つだけの `Zero`・`Add`・`Neg` と、関係を持つだけの `LE`・`LT` を置き、使う性質はすべて仮定に書く。
  `≤` の反射律・推移律・反対称律・全順序は効いていない（順序であることも要らない）。
- 加法の可換律、左からの単位元、乗法、実数であること、完備性は効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`real_less_than_preserved_by_adding_on_right`** の必要十分版: `<` が `≤ かつ ≠`、`≤` と加法の両立、
右からの加法の単位元、加法の逆元、加法の結合律から、`x < y` なら `x + c < y + c`。 -/
theorem add_lt_add_right_of_le_compat {R : Type*} [Zero R] [Add R] [Neg R] [LE R] [LT R]
    (hlt : ∀ x y : R, x < y ↔ (x ≤ y ∧ x ≠ y))
    (hle_add : ∀ x y t : R, x ≤ y → x + t ≤ y + t)
    (hadd_zero : ∀ x : R, x + 0 = x)
    (hadd_neg : ∀ z : R, z + -z = 0)
    (hadd_assoc : ∀ x y t : R, (x + y) + t = x + (y + t))
    (x y c : R) (h : x < y) : x + c < y + c := by
  have hle : x ≤ y := ((hlt x y).1 h).1                           -- `<` の定義の前半
  have hxy : x ≠ y := ((hlt x y).1 h).2                           -- `<` の定義の後半
  have hle' : x + c ≤ y + c := hle_add x y c hle                  -- 順序と加法の両立
  have hne : x + c ≠ y + c := by
    intro hsum
    have heq : x = y :=
      calc x
          = x + 0 := (hadd_zero x).symm                           -- 加法の単位元を右辺から左辺へ
        _ = x + (c + -c) := by rw [hadd_neg c]                    -- 加法の逆元を右辺から左辺へ
        _ = (x + c) + -c := (hadd_assoc x c (-c)).symm            -- 加法の結合律を右辺から左辺へ
        _ = (y + c) + -c := by rw [hsum]                          -- 仮定
        _ = y + (c + -c) := hadd_assoc y c (-c)                   -- 加法の結合律
        _ = y + 0 := by rw [hadd_neg c]                           -- 加法の逆元
        _ = y := hadd_zero y                                      -- 加法の単位元
    exact hxy heq
  exact (hlt (x + c) (y + c)).2 ⟨hle', hne⟩                      -- `<` の定義

end Ising2D.NecSuf
