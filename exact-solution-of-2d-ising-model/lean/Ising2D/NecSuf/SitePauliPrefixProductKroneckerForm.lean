/-
# 先頭から並べたサイトの元の積の、サイトごとの並びでの表示（必要十分版）

具体版: `Ising2D/PartitionFunction/ProjectionAndJordanWigner/ClaimSitePauliPrefixProductKroneckerForm.lean`
（人手 `site_pauli_prefix_product_kronecker_form`）。具体版をこのファイルの系として導くのは
`Ising2D/PartitionFunction/ProjectionAndJordanWigner/ClaimSitePauliPrefixProductKroneckerFormFromNecSuf.lean`。

具体版の `Mat(2,ℂ)`（各サイトの行列）を `R`、`Mat(2^{M_col},ℂ)` を `S`、クロネッカー積 `siteProd M` を
`Φ : (Fin M → R) → S` に置き換える。`σ_k^{a}` は `Φ (Function.update 1 k a)`（`siteOpOf Φ k a`）である。
節 `| s + 1` の Lean の変数 `s` は人手の `s - 1` で、段のコメントの `P_{s+1}`・「第 `s+2` 以降」などの `s` は人手の `s` である（具体版と同じ）。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `s = 1` の 2 行（`P_1` の定義、`def_site_pauli_matrices` の `k = 1`） | `prefix_product_eq_map_prefixFamily` の `0` の節（同じ並び） |
| `s → s + 1` の 6 行（`P_{s+1}` の定義、帰納法の仮定、`kronecker_product_rule` (1)、右の単位元、左の単位元 2 回） | 同じく `s + 1` の節（同じ並び。`kronecker_product_rule` (1) は仮定 `hΦ`） |

## 何が効いているか / 効いていないか

- **`Φ` が積を保つこと**（仮定 `hΦ`。具体版の `kronecker_product_rule` (1)）。`Φ` が単位元を保つことは使わない
  （人手の帰納法は `P_1 := σ_1^{a_1}` から始まり、空の積を通らない）。
- **`R` の `x * 1 = x`（`x = a_j`）と `1 * x = x`（`x = a_{s+1}` と `x = 1`）**（`MulOneClass R`）。
  具体版の `identity_matrix_is_right_unit_of_mat_mult`・`identity_matrix_is_left_unit_of_mat_mult` である。
  `1 * 1 = 1` は `1 * x = x` の `x = 1` で、どちらかの単位元の法則が無いと右辺の因子の並びに `a_j * 1` や `1 * 1` が残る。
- **`S` の積は二項演算 `*` だけ**（`Mul S`）。結合則は使わない（人手の積は右から 1 つずつ掛けるだけで、括弧の付け替えが起きない）。
- **効いていないもの**: `R` の結合則・可換性・加法、係数が `ℂ` であること、行列であること、各サイトの次元が `2` であること、
  `a_j` が Pauli 行列であること、`Φ` の線型性。
  添字は `Fin M` に固定してその順序を使う（人手の右辺は第 `1` から第 `r` 因子という並びで定まるため）。
-/
import Ising2D.NecSuf.FiniteProductLeft
import Mathlib.Algebra.Group.Pi.Basic
import Mathlib.Logic.Function.Basic
import Mathlib.Order.Fin.Basic

namespace Ising2D.NecSuf

section SitePrefixProduct

variable {M : ℕ} {R S : Type*} [MulOneClass R] [Mul S]

/-- 右辺の因子の並び `a_1, …, a_{r+1}, 1, …, 1`（具体版 `prefixKroneckerFamily`）。 -/
def prefixFamily (r : ℕ) (a : Fin (r + 1) → R) : Fin M → R :=
  fun i => if h : (i : ℕ) < r + 1 then a ⟨i, h⟩ else 1

/-- サイト `k` だけを `x` に置いた元 `Φ(1, …, x, …, 1)`（具体版の `siteOp k x`）。 -/
def siteOpOf (Φ : (Fin M → R) → S) (k : Fin M) (x : R) : S :=
  Φ (Function.update (1 : Fin M → R) k x)

/-- 左辺の因子 `σ_1^{a_1}, …, σ_{r+1}^{a_{r+1}}`（具体版 `sitePauliFamily`）。 -/
def siteFamilyOf (Φ : (Fin M → R) → S) (r : ℕ) (h : r < M) (a : Fin (r + 1) → R) : Fin (r + 1) → S :=
  fun j => siteOpOf Φ ⟨(j : ℕ), lt_of_le_of_lt (Nat.le_of_lt_succ j.isLt) h⟩ (a j)

/-- **`site_pauli_prefix_product_kronecker_form`** の必要十分版。 -/
theorem prefix_product_eq_map_prefixFamily (Φ : (Fin M → R) → S)
    (hΦ : ∀ x y : Fin M → R, Φ (x * y) = Φ x * Φ y) :
    ∀ (r : ℕ) (h : r < M) (a : Fin (r + 1) → R),
      finProdLeft r (siteFamilyOf Φ r h a) = Φ (prefixFamily r a)
  | 0, h, a =>
    calc finProdLeft 0 (siteFamilyOf Φ 0 h a)
        = siteOpOf Φ (⟨0, h⟩ : Fin M) (a 0) := finProdLeft_zero _      -- `P_1` の定義
      _ = Φ (prefixFamily 0 a) := by
          -- サイト `1` だけに `a_1` を置いた並び
          rw [siteOpOf]
          congr 1
          funext i
          by_cases hi : (i : ℕ) < 0 + 1
          · have he : i = (⟨0, h⟩ : Fin M) := Fin.ext (show (i : ℕ) = 0 by omega)
            rw [prefixFamily, dif_pos hi]
            subst he
            rw [Function.update_self]
            rfl
          · have hne : i ≠ (⟨0, h⟩ : Fin M) := fun he => hi (by subst he; exact Nat.zero_lt_one)
            rw [prefixFamily, dif_neg hi, Function.update_of_ne hne, Pi.one_apply]
  | s + 1, h, a => by
    have hs : s < M := Nat.lt_of_succ_lt h
    have ih := prefix_product_eq_map_prefixFamily Φ hΦ s hs (fun j => a (Fin.castSucc j))
    calc finProdLeft (s + 1) (siteFamilyOf Φ (s + 1) h a)
        = finProdLeft s (siteFamilyOf Φ s hs (fun j => a (Fin.castSucc j)))
            * siteOpOf Φ (⟨s + 1, h⟩ : Fin M) (a (Fin.last (s + 1))) := finProdLeft_succ s _
                                                        -- `P_{s+1}` の定義
      _ = Φ (prefixFamily s (fun j => a (Fin.castSucc j)))
            * Φ (Function.update (1 : Fin M → R) ⟨s + 1, h⟩ (a (Fin.last (s + 1)))) := by
          rw [ih, siteOpOf]                             -- 帰納法の仮定とサイト `s+1` の元
      _ = Φ (fun i : Fin M =>
            if hi : (i : ℕ) < s + 1 then a ⟨i, by omega⟩ * 1
            else if (i : ℕ) = s + 1 then 1 * a (Fin.last (s + 1)) else 1 * 1) := by
          -- `hΦ`（具体版の `kronecker_product_rule` (1)）
          rw [← hΦ]
          congr 1
          funext i
          rw [Pi.mul_apply]
          rcases lt_trichotomy (i : ℕ) (s + 1) with hi | hi | hi
          · have hne : i ≠ (⟨s + 1, h⟩ : Fin M) := fun he => by rw [he] at hi; exact lt_irrefl _ hi
            rw [prefixFamily, dif_pos hi, dif_pos hi, Function.update_of_ne hne, Pi.one_apply]
            rfl
          · have he : i = (⟨s + 1, h⟩ : Fin M) := Fin.ext hi
            rw [prefixFamily, dif_neg (by omega), dif_neg (by omega), if_pos hi, he,
              Function.update_self]
          · have hne : i ≠ (⟨s + 1, h⟩ : Fin M) := fun he => by rw [he] at hi; exact lt_irrefl _ hi
            rw [prefixFamily, dif_neg (by omega), dif_neg (by omega), if_neg (by omega),
              Function.update_of_ne hne, Pi.one_apply]
      _ = Φ (fun i : Fin M =>
            if hi : (i : ℕ) < s + 1 then a ⟨i, by omega⟩
            else if (i : ℕ) = s + 1 then 1 * a (Fin.last (s + 1)) else 1 * 1) := by
          -- `x * 1 = x` を第 1 から第 `s` 因子へ同時に適用
          congr 1
          funext i
          by_cases hi : (i : ℕ) < s + 1
          · rw [dif_pos hi, dif_pos hi]
            exact mul_one _
          · rw [dif_neg hi, dif_neg hi]
      _ = Φ (fun i : Fin M =>
            if hi : (i : ℕ) < s + 1 then a ⟨i, by omega⟩
            else if (i : ℕ) = s + 1 then a (Fin.last (s + 1)) else 1 * 1) := by
          rw [one_mul (a (Fin.last (s + 1)))]           -- `1 * x = x`（`x → a_{s+1}`）
      _ = Φ (prefixFamily (s + 1) a) := by
          -- `1 * x = x`（`x → 1`）を第 `s+2` 以降の因子へ同時に適用
          rw [one_mul (1 : R)]
          congr 1
          funext i
          rcases lt_trichotomy (i : ℕ) (s + 1) with hi | hi | hi
          · rw [dif_pos hi, prefixFamily, dif_pos (by omega)]
          · rw [dif_neg (by omega), if_pos hi, prefixFamily, dif_pos (by omega)]
            congr 1
            exact Fin.ext hi.symm
          · rw [dif_neg (by omega), if_neg (by omega), prefixFamily, dif_neg (by omega)]

end SitePrefixProduct

end Ising2D.NecSuf
