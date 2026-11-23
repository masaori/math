/-
# 整数の埋め込み: `ι(1) = 1`・非負の整数の和・`ℤ` 全体の後者と和と積と差と符号反転・定数の有限和・2 の冪（必要十分版）

対応する人手証明のラベル: `inclusion_zz_to_rr_of_one`、`inclusion_zz_to_rr_preserves_sum_of_nonnegatives`、
`finite_sum_of_constant_real_number`、`power_of_two_in_integers_is_at_least_one`、`inclusion_zz_to_rr_of_power_of_two`、
`inclusion_zz_to_rr_of_positive_is_at_least_one`、`inclusion_zz_to_rr_of_nonpositive_is_nonpositive`、`inclusion_zz_to_rr_is_monotone_on_nonnegatives`、
`inclusion_zz_to_rr_of_successor`、`inclusion_zz_to_rr_preserves_sum`、`inclusion_zz_to_rr_preserves_product`、`inclusion_zz_to_rr_preserves_difference`、`inclusion_zz_to_rr_preserves_negation`
具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimInclusionOfIntegersIntoRealNumbers.lean`
（具体版をこのファイルの系として導くのは、同じフォルダの `ClaimInclusionOfIntegersIntoRealNumbersFromNecSuf.lean`）

人手の `ι_{ℤ→ℝ}` の `ℤ_{≥0}` の部分は、`ι(0) := 0`・`ι(n + 1) := ι(n) + 1` の帰納法の定義である。ここでは `ℝ` を、
この 2 つの式を持つ埋め込み `(n : ℕ) → (n : R)` の付いた構造 `R` に置き換える（`Nat.cast_zero`・`Nat.cast_succ` は `AddMonoidWithOne` の公理）。
負の元の節 `ι(-n) := -ι(n)` を使う主張（`int_cast_nonpos'`・`int_cast_succ'`・`int_cast_add'`）では、`ℤ` からの埋め込み `(n : ℤ) → (n : R)`
（`Int.cast`。`AddGroupWithOne` の構造）を使い、`ι(-n) = -ι(n)` は `Int.cast_neg`、`ℤ_{≥0}` の上での `Nat.cast` との一致は `Int.cast_natCast` である。

## 何が効いているか / 効いていないか

| 人手の主張 | 具体版の段 | 必要十分版の段 | 効いている仮定 |
| --- | --- | --- | --- |
| `inclusion_zz_to_rr_of_one` | `ι(1) = ι(0 + 1) = ι(0) + 1 = 0 + 1 = 1` | `cast_one'`（同じ段） | 埋め込みの 2 つの式、`0` が和の左単位元 |
| `inclusion_zz_to_rr_preserves_sum_of_nonnegatives` | `b` の帰納法。`b = 0` は `ι(a + 0) = ι(a) = ι(a) + 0 = ι(a) + ι(0)`、`b → b + 1` は `ι(a + (b + 1)) = ι((a + b) + 1) = ι(a + b) + 1 = (ι(a) + ι(b)) + 1 = ι(a) + (ι(b) + 1) = ι(a) + ι(b + 1)` | `cast_add'`（同じ段） | 埋め込みの 2 つの式、`0` が和の右単位元、和の結合律 |
| `finite_sum_of_constant_real_number` | `m` の帰納法。`m = 1` は `Σ_{j=1}^{1} r = r = 1r = ι(1)r`、`m → m + 1` は `Σ_{j=1}^{m+1} r = (Σ_{j=1}^{m} r) + r = ι(m)r + r = ι(m)r + 1r = (ι(m) + 1)r = ι(m + 1)r` | `sum_const_fin_succ'`（同じ段） | 有限和の 2 つの式（左から足す）、埋め込みの 2 つの式（`cast_one'` を通して）、`1` が乗法の左単位元、右からの分配律 `(x + y)r = xr + yr` |
| `inclusion_zz_to_rr_of_power_of_two` | `M` の帰納法。`M = 0` は `ι(2^0) = ι(1) = 1 = 2^0`、`M → M + 1` は `ι(2^{M+1}) = ι(2^M·2) = ι(2^M(1+1)) = ι(2^M·1 + 2^M·1) = ι(2^M + 2^M) = ι(2^M) + ι(2^M) = 2^M + 2^M = 2^M·1 + 2^M·1 = 2^M(1 + 1) = 2^M·2 = 2^{M+1}` | `cast_two_pow'`（同じ段） | `ℕ` の側: 冪の 2 つの式・`2 = 1 + 1`・分配律・乗法の単位元。`R` の側: `cast_add'`・`cast_one'`、`1` が乗法の右単位元、左からの分配律 `x(y + z) = xy + xz`、`1 + 1 = 2`、冪の 2 つの式 `a^0 = 1`・`a^{m+1} = a^ma` |
| `power_of_two_in_integers_is_at_least_one` | `M` の帰納法。`2^0 = 1 ≥ 1`、`2^{M+1} = 2^M·2 = 2^M(1+1) = 2^M·1 + 2^M·1 = 2^M + 2^M ≥ 1 + 2^M ≥ 1 + 1 ≥ 1 + 0 = 1` | `one_le_two_pow'`（同じ段） | 冪の 2 つの式、`2 = 1 + 1`、左からの分配律、`1` が乗法の右単位元、加法の単調性（辺々を足す）、`0 ≤ 1`、`0` が和の右単位元、反射律 |
| `inclusion_zz_to_rr_of_positive_is_at_least_one` | `n` の帰納法。`ι(1) = 1 ≥ 1`、`ι(n + 1) = ι(n) + 1 ≥ 1 + 1 ≥ 1 + 0 = 1` | `one_le_cast'`（同じ段） | `cast_one'`、埋め込みの `ι(n + 1) = ι(n) + 1`、加法の単調性、`0 ≤ 1`、`0` が和の右単位元、反射律 |
| `inclusion_zz_to_rr_of_nonpositive_is_nonpositive` | `n = 0` は `ι(0) = 0 ≤ 0`、`n = -m`（`m ≥ 1`）は `ι(-m) = -ι(m) ≤ -1 ≤ -0 = 0` | `int_cast_nonpos'`（同じ段） | `ℤ` の埋め込みの `ι(-n) = -ι(n)`（`Int.cast_neg`）と `ℤ_{≥0}` での一致（`Int.cast_natCast`）、`one_le_cast'`、符号反転が順序を逆にすること（加法の単調性から出る）、`0 ≤ 1` |
| `inclusion_zz_to_rr_is_monotone_on_nonnegatives` | `k := b − a`、`ι(k) ≥ 0`（`k = 0` と `k ≥ 1`）、`ι(a) = ι(a) + 0 ≤ ι(a) + ι(k) = ι(a + k) = ι(b)` | `cast_mono'`（同じ段） | `cast_add'`、`one_le_cast'`、加法の単調性、`0 ≤ 1`、`0` が和の右単位元 |
| `inclusion_zz_to_rr_of_successor` | `n ∈ ℤ_{≥0}` は定義、`n = -1` は `ι(-1 + 1) = ι(0) = 0 = (-1) + 1 = (-ι(1)) + 1 = ι(-1) + 1`、`n = -(p + 1)`（`p ≥ 1`）は `ι(-(p+1) + 1) = ι(-p) = -ι(p) = -ι(p) + 0 = -ι(p) + ((-1) + 1) = (-ι(p) + (-1)) + 1 = -(ι(p) + 1) + 1 = -ι(p + 1) + 1 = ι(-(p + 1)) + 1` | `int_cast_succ'`（同じ段） | `ℤ` の埋め込みの `ι(0) = 0`・`ι(1) = 1`・`ι(-n) = -ι(n)` と `ℤ_{≥0}` での一致・`Nat.cast_succ`、`0` が和の右単位元、加法逆元、和の結合律、`-(x + y) = (-x) + (-y)`（加法の可換性） |
| `inclusion_zz_to_rr_preserves_sum` | `b` について `0` から足す帰納法（3 行と 5 行）と引く帰納法（13 行）。足す段・引く段とも `inclusion_zz_to_rr_of_successor` を使う | `int_cast_add'`（同じ段） | `int_cast_succ'`、`ι(0) = 0`、`0` が和の右単位元、加法逆元、和の結合律 |
| `inclusion_zz_to_rr_preserves_product` | `b` について `0` から足す帰納法（4 行と 7 行）と引く帰納法（15 行）。`b = 0` は `x · 0 = 0`、足す段・引く段とも `inclusion_zz_to_rr_preserves_sum`・`inclusion_zz_to_rr_of_successor` を使う | `int_cast_mul'`（同じ段） | `int_cast_add'`・`int_cast_succ'`、`ι(0) = 0`、`x · 0 = 0`、`1` が乗法の右単位元、左からの分配律 `x(y + z) = xy + xz`、`0` が和の右単位元、加法逆元、和の結合律 |
| `inclusion_zz_to_rr_preserves_difference` | `ι(a − b) = ι(a − b) + 0 = ι(a − b) + (ι(b) + (−ι(b))) = (ι(a − b) + ι(b)) + (−ι(b)) = ι((a − b) + b) + (−ι(b)) = ι((a + (−b)) + b) + (−ι(b)) = ι(a + ((−b) + b)) + (−ι(b)) = ι(a + 0) + (−ι(b)) = ι(a) + (−ι(b)) = ι(a) − ι(b)` | `int_cast_sub'`（同じ段） | `int_cast_add'`、`0` が和の右単位元、加法逆元、和の結合律、差が加法の逆元の和であること（`ℤ` と `R` の両方） |
| `inclusion_zz_to_rr_preserves_negation` | `ι(−a) = ι(0 + (−a)) = ι(0 − a) = ι(0) − ι(a) = 0 − ι(a) = 0 + (−ι(a)) = −ι(a)` | `int_cast_neg'`（同じ段） | `int_cast_sub'`、埋め込みの `ι(0) = 0`、差が加法の逆元の和であること、`0` が和の左単位元 |

- **効いていないもの**: `R` が `ℝ` であること、`R` の完備性・除法、`R` の符号反転（`int_cast_nonpos'`・`int_cast_succ'`・`int_cast_add'`・`int_cast_mul'`・`int_cast_sub'`・`int_cast_neg'` だけが使う）、乗法の可換性・結合律、全順序であること。
- **型クラスについて**: mathlib の型クラスでは、効いている性質だけを切り出した組を作れない（`One` を二重に持つことになる）ので、
  それを含む最小の標準の組を置き、効いていない性質を次に書く。
  - `sum_const_fin_succ'` の `[NonAssocSemiring R]` のうち、左からの分配律・`mul_one`・`zero_mul`・`mul_zero` は効いていない。
    加法の可換性は証明の段では使わず、有限和 `Finset.sum` を書くためだけに要る。
  - `cast_two_pow'` の `[Semiring R]` のうち、右からの分配律・加法の可換性・乗法の結合律は効いていない
    （`Semiring` は記法 `^`（`Monoid` の冪）のためで、使う冪の性質は `pow_zero`・`pow_succ` の 2 つの式だけである）。
  - `one_le_two_pow'` の `[Semiring R] [PartialOrder R] [IsOrderedAddMonoid R] [ZeroLEOneClass R]` のうち、右からの分配律・乗法の結合律・順序の反対称律は効いていない。
- `cast_one'`・`cast_add'` は乗法を使わない（`[AddMonoidWithOne R]`）。
- 順序の 3 つの主張（`one_le_cast'`・`int_cast_nonpos'`・`cast_mono'`）は乗法を使わない。`[AddCommMonoidWithOne R]`（`int_cast_nonpos'` は符号反転のため `[AddCommGroupWithOne R]`）に
  `[PartialOrder R] [IsOrderedAddMonoid R] [ZeroLEOneClass R]` を置く。加法の可換性は `IsOrderedAddMonoid` を書くためだけに要り、証明の段では使わない。順序の反対称律は効いていない。
- 人手の `ι` の負の元の節 `ι(-n) := -ι(n)` を使うのは `int_cast_nonpos'`・`int_cast_succ'` だけである（`int_cast_add'` は `int_cast_succ'` を通して使う）。
- `int_cast_mul'` は順序を使わない。`[NonAssocRing R]` を置く（`AddCommGroupWithOne` に乗法と分配律と乗法の単位元を足した最小の標準の組）。
  そのうち右からの分配律・`1` が乗法の左単位元であること・`0 · x = 0` は効いておらず、乗法の結合律・可換性はそもそも仮定していない。
- `int_cast_sub'` は乗法と順序を使わない。`int_cast_add'` と同じ `[AddCommGroupWithOne R]` を置く。加法の可換性はこの主張の段では使わず、
  `int_cast_add'` を通して効いている。
- `int_cast_neg'` は乗法と順序を使わない。`int_cast_sub'` と同じ `[AddCommGroupWithOne R]` を置く。加法の可換性はこの主張の段では使わず、
  `int_cast_sub'` を通して効いている。埋め込みの負の元の節 `ι(-n) = -ι(n)`（`Int.cast_neg`）は直には使わない。
- `int_cast_succ'`・`int_cast_add'` は乗法と順序を使わない。`[AddCommGroupWithOne R]` を置く。加法の可換性は `int_cast_succ'` の `n = -(p + 1)` の段の
  `-(x + y) = (-x) + (-y)`（`neg_add`）だけで効いている。可換でない `AddGroupWithOne` では `-(x + y) = (-y) + (-x)` しか言えず、同じ手順では通らない
  （mathlib の `Int.cast_add` は可換性を使わない別の論法で、`AddGroupWithOne` で成り立つ）。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Order.Ring.Defs
import Ising2D.NecSuf.SubAddCancelOfAddGroup

namespace Ising2D.NecSuf

/-- **必要十分版の `inclusion_zz_to_rr_of_one`**: `AddMonoidWithOne` の埋め込みで `ι(1) = 1`。 -/
theorem cast_one' {R : Type*} [AddMonoidWithOne R] : ((1 : ℕ) : R) = 1 :=
  calc ((1 : ℕ) : R) = ((0 + 1 : ℕ) : R) := by rw [Nat.zero_add]          -- `0` は `ℕ` の和の単位元
    _ = ((0 : ℕ) : R) + 1 := Nat.cast_succ 0                               -- 埋め込みの `ι(n + 1) = ι(n) + 1`（`n → 0`）
    _ = 0 + 1 := by rw [Nat.cast_zero]                                     -- 埋め込みの `ι(0) = 0`
    _ = 1 := zero_add 1                                                    -- `0` は和の左単位元

/-- **必要十分版の `inclusion_zz_to_rr_preserves_sum_of_nonnegatives`**: `ι(a + b) = ι(a) + ι(b)`。`b` についての帰納法。 -/
theorem cast_add' {R : Type*} [AddMonoidWithOne R] (a b : ℕ) :
    ((a + b : ℕ) : R) = (a : R) + (b : R) := by
  induction b with
  | zero =>
    calc ((a + 0 : ℕ) : R) = (a : R) := by rw [Nat.add_zero]              -- `0` は `ℕ` の和の単位元
      _ = (a : R) + 0 := (add_zero _).symm                                 -- `0` は和の右単位元
      _ = (a : R) + ((0 : ℕ) : R) := by rw [Nat.cast_zero]                 -- 埋め込みの `ι(0) = 0` を右辺から左辺へ
  | succ b ih =>
    calc ((a + (b + 1) : ℕ) : R) = (((a + b) + 1 : ℕ) : R) := by rw [Nat.add_assoc]  -- `ℕ` の和の結合律
      _ = ((a + b : ℕ) : R) + 1 := Nat.cast_succ (a + b)                  -- 埋め込みの `ι(n + 1) = ι(n) + 1`（`n → a + b`）
      _ = ((a : R) + (b : R)) + 1 := by rw [ih]                            -- 帰納法の仮定
      _ = (a : R) + ((b : R) + 1) := add_assoc _ _ _                       -- 和の結合律
      _ = (a : R) + ((b + 1 : ℕ) : R) := by rw [Nat.cast_succ b]           -- 埋め込みの `ι(n + 1) = ι(n) + 1`（`n → b`）を右辺から左辺へ

/-- **必要十分版の `finite_sum_of_constant_real_number`**（`m + 1` 項）: `Σ_{j=1}^{m+1} r = ι(m + 1) r`。`m` についての帰納法。
有限和の 2 つの式 `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` は加法の可換モノイドで成り立つ。 -/
theorem sum_const_fin_succ' {R : Type*} [NonAssocSemiring R] (m : ℕ) (r : R) :
    ∑ _j : Fin (m + 1), r = ((m + 1 : ℕ) : R) * r := by
  induction m with
  | zero =>
    calc ∑ _j : Fin 1, r = r := Fin.sum_univ_one _                         -- 有限和の `Σ_{j=1}^{1} r_j = r_1`
      _ = 1 * r := (one_mul r).symm                                        -- `1` は乗法の左単位元
      _ = ((1 : ℕ) : R) * r := by rw [cast_one']                           -- `cast_one'` を右辺から左辺へ
  | succ m ih =>
    calc ∑ _j : Fin (m + 2), r
        = (∑ _j : Fin (m + 1), r) + r := Fin.sum_univ_castSucc (fun _ => r)  -- 有限和の `Σ_{j=1}^{m+1} r_j = (Σ_{j=1}^{m} r_j) + r_{m+1}`
      _ = ((m + 1 : ℕ) : R) * r + r := by rw [ih]                          -- 帰納法の仮定
      _ = ((m + 1 : ℕ) : R) * r + 1 * r := by rw [one_mul]                 -- `1` は乗法の左単位元
      _ = (((m + 1 : ℕ) : R) + 1) * r := (add_mul _ _ _).symm              -- 右からの分配律
      _ = ((m + 1 + 1 : ℕ) : R) * r := by rw [Nat.cast_succ (m + 1)]       -- 埋め込みの `ι(n + 1) = ι(n) + 1` を右辺から左辺へ

/-- **必要十分版の `inclusion_zz_to_rr_of_power_of_two`**: `ι(2^M) = 2^M`。`M` についての帰納法。 -/
theorem cast_two_pow' {R : Type*} [Semiring R] (M : ℕ) : ((2 ^ M : ℕ) : R) = (2 : R) ^ M := by
  induction M with
  | zero =>
    calc ((2 ^ 0 : ℕ) : R) = ((1 : ℕ) : R) := by rw [Nat.pow_zero]        -- `ℕ` の冪の `2^0 = 1`
      _ = 1 := cast_one'                                                   -- `cast_one'`
      _ = (2 : R) ^ 0 := (pow_zero 2).symm                                 -- 冪の `a^0 = 1` を右辺から左辺へ
  | succ M ih =>
    calc ((2 ^ (M + 1) : ℕ) : R) = ((2 ^ M * 2 : ℕ) : R) := by rw [Nat.pow_succ]  -- `ℕ` の冪の `a^{m+1} = a^ma`
      _ = ((2 ^ M * (1 + 1) : ℕ) : R) := rfl                               -- `ℕ` で `2 = 1 + 1`
      _ = ((2 ^ M * 1 + 2 ^ M * 1 : ℕ) : R) := by rw [Nat.mul_add]         -- `ℕ` の分配律
      _ = ((2 ^ M + 2 ^ M : ℕ) : R) := by rw [Nat.mul_one]                 -- `1` は `ℕ` の乗法の単位元を二か所へ同時に
      _ = ((2 ^ M : ℕ) : R) + ((2 ^ M : ℕ) : R) := cast_add' _ _           -- `cast_add'`（`a, b → 2^M`）
      _ = (2 : R) ^ M + (2 : R) ^ M := by rw [ih]                          -- 帰納法の仮定を二か所へ同時に
      _ = (2 : R) ^ M * 1 + (2 : R) ^ M * 1 := by rw [mul_one]             -- `1` は乗法の右単位元を二か所へ同時に
      _ = (2 : R) ^ M * (1 + 1) := (mul_add _ _ _).symm                    -- 左からの分配律
      _ = (2 : R) ^ M * 2 := by rw [one_add_one_eq_two]                    -- `1 + 1 = 2`
      _ = (2 : R) ^ (M + 1) := (pow_succ _ _).symm                         -- 冪の `a^{m+1} = a^ma` を右辺から左辺へ

/-- **必要十分版の `power_of_two_in_integers_is_at_least_one`**: `1 ≤ 2^M`。`M` についての帰納法。 -/
theorem one_le_two_pow' {R : Type*} [Semiring R] [PartialOrder R] [IsOrderedAddMonoid R] [ZeroLEOneClass R]
    (M : ℕ) : (1 : R) ≤ (2 : R) ^ M := by
  induction M with
  | zero =>
    calc (2 : R) ^ 0 = 1 := pow_zero 2                                     -- 冪の `a^0 = 1`
      _ ≥ 1 := le_refl 1                                                   -- 反射律
  | succ M ih =>
    calc (2 : R) ^ (M + 1) = (2 : R) ^ M * 2 := pow_succ _ _               -- 冪の `a^{m+1} = a^ma`
      _ = (2 : R) ^ M * (1 + 1) := by rw [one_add_one_eq_two]              -- `2 = 1 + 1`
      _ = (2 : R) ^ M * 1 + (2 : R) ^ M * 1 := mul_add _ _ _               -- 左からの分配律
      _ = (2 : R) ^ M + (2 : R) ^ M := by rw [mul_one]                     -- `1` は乗法の右単位元を二か所へ同時に
      _ ≥ 1 + (2 : R) ^ M := add_le_add_left ih _                         -- 帰納法の仮定 `2^M ≥ 1` の両辺に `2^M` を足す
      _ ≥ 1 + 1 := add_le_add_right ih _                                   -- 帰納法の仮定 `2^M ≥ 1` の両辺に `1` を足す
      _ ≥ 1 + 0 := add_le_add (le_refl 1) zero_le_one                     -- `0 ≤ 1` の両辺に `1` を足す
      _ = 1 := add_zero 1                                                  -- `0` は和の右単位元

/-- **必要十分版の `inclusion_zz_to_rr_of_positive_is_at_least_one`**: `n ≥ 1` なら `1 ≤ ι(n)`。`n` についての帰納法。 -/
theorem one_le_cast' {R : Type*} [AddCommMonoidWithOne R] [PartialOrder R] [IsOrderedAddMonoid R] [ZeroLEOneClass R]
    (n : ℕ) (hn : 1 ≤ n) : (1 : R) ≤ (n : R) := by
  induction n, hn using Nat.le_induction with
  | base =>
    calc (1 : R) ≤ 1 := le_refl 1                                          -- 反射律
      _ = ((1 : ℕ) : R) := cast_one'.symm                                  -- `cast_one'`
  | succ n _ ih =>
    calc (1 : R) = 1 + 0 := (add_zero 1).symm                              -- `0` は和の右単位元
      _ ≤ 1 + 1 := add_le_add (le_refl 1) zero_le_one                     -- `0 ≤ 1` の両辺に `1` を足す
      _ ≤ (n : R) + 1 := add_le_add ih (le_refl 1)                         -- 帰納法の仮定の両辺に `1` を足す
      _ = ((n + 1 : ℕ) : R) := (Nat.cast_succ n).symm                      -- 埋め込みの `ι(n + 1) = ι(n) + 1`

/-- **必要十分版の `inclusion_zz_to_rr_of_nonpositive_is_nonpositive`**: `n ∈ ℤ_{≤0}` なら `ι(n) ≤ 0`。
`n = 0` と `n = -m`（`m ≥ 1`）の場合分け。 -/
theorem int_cast_nonpos' {R : Type*} [AddCommGroupWithOne R] [PartialOrder R] [IsOrderedAddMonoid R] [ZeroLEOneClass R]
    (n : ℤ) (hn : n ≤ 0) : ((n : ℤ) : R) ≤ 0 := by
  rcases hn.lt_or_eq with hneg | hzero
  · obtain ⟨k, hk⟩ : ∃ k : ℕ, ((k : ℤ)) = -n := ⟨(-n).toNat, Int.toNat_of_nonneg (by omega)⟩
    have hk1 : 1 ≤ k := by omega
    have hm : n = -((k : ℤ)) := by omega
    calc ((n : ℤ) : R) = ((-((k : ℤ)) : ℤ) : R) := by rw [hm]
      _ = -(((k : ℤ)) : R) := Int.cast_neg _                               -- 埋め込みの `ι(-n) = -ι(n)`
      _ = -(k : R) := by rw [Int.cast_natCast]                             -- `ℤ_{≥0}` の上で 2 つの埋め込みは一致する
      _ ≤ -1 := neg_le_neg (one_le_cast' k hk1)                            -- `one_le_cast'` の両辺の符号を反転する
      _ ≤ -0 := neg_le_neg zero_le_one                                     -- `0 ≤ 1` の両辺の符号を反転する
      _ = 0 := neg_zero                                                    -- `-0 = 0`
  · calc ((n : ℤ) : R) = (((0 : ℕ) : ℤ) : R) := by rw [hzero]; rfl
      _ = ((0 : ℕ) : R) := Int.cast_natCast 0                              -- `ℤ_{≥0}` の上で 2 つの埋め込みは一致する
      _ = 0 := Nat.cast_zero                                               -- 埋め込みの `ι(0) = 0`
      _ ≤ 0 := le_refl 0                                                   -- 反射律

/-- **必要十分版の `inclusion_zz_to_rr_is_monotone_on_nonnegatives`**: `a ≤ b` なら `ι(a) ≤ ι(b)`。
`k := b − a` を置き、`ι(k) ≥ 0` を `k = 0` と `k ≥ 1` に分けて示してから、`ι(a) = ι(a) + 0 ≤ ι(a) + ι(k) = ι(a + k) = ι(b)`。 -/
theorem cast_mono' {R : Type*} [AddCommMonoidWithOne R] [PartialOrder R] [IsOrderedAddMonoid R] [ZeroLEOneClass R]
    (a b : ℕ) (hab : a ≤ b) : (a : R) ≤ (b : R) := by
  set k : ℕ := b - a with hkdef
  have hb : b = a + k := (Nat.add_sub_cancel' hab).symm
  have hk : (0 : R) ≤ (k : R) := by
    rcases Nat.eq_zero_or_pos k with h0 | h1
    · calc (0 : R) ≤ 0 := le_refl 0                                        -- 反射律
        _ = ((0 : ℕ) : R) := Nat.cast_zero.symm                            -- 埋め込みの `ι(0) = 0`
        _ = (k : R) := by rw [h0]
    · calc (0 : R) ≤ 1 := zero_le_one                                      -- `0 ≤ 1`
        _ ≤ (k : R) := one_le_cast' k h1                                   -- `one_le_cast'`
  calc (a : R) = (a : R) + 0 := (add_zero _).symm                          -- `0` は和の右単位元
    _ ≤ (a : R) + (k : R) := add_le_add (le_refl _) hk                     -- `ι(k) ≥ 0` の両辺に `ι(a)` を足す
    _ = ((a + k : ℕ) : R) := (cast_add' a k).symm                          -- `cast_add'`
    _ = (b : R) := by rw [← hb]

/-- **必要十分版の `inclusion_zz_to_rr_of_successor`**: `ℤ` の埋め込みで `ι(n + 1) = ι(n) + 1`（`n ∈ ℤ`）。
具体版と同じく `n ∈ ℤ_{≥0}`・`n = -1`・`n = -(p + 1)`（`p ≥ 1`）の 3 つの場合に分ける。 -/
theorem int_cast_succ' {R : Type*} [AddCommGroupWithOne R] (n : ℤ) : ((n + 1 : ℤ) : R) = ((n : ℤ) : R) + 1 := by
  have hsucc : ∀ k : ℕ, (((k : ℤ) + 1 : ℤ) : R) = ((k : ℤ) : R) + 1 := fun k =>
    calc (((k : ℤ) + 1 : ℤ) : R) = (((k + 1 : ℕ) : ℤ) : R) := rfl
      _ = ((k + 1 : ℕ) : R) := Int.cast_natCast _                          -- `ℤ_{≥0}` の上で 2 つの埋め込みは一致する
      _ = (k : R) + 1 := Nat.cast_succ k                                   -- 埋め込みの `ι(n + 1) = ι(n) + 1`
      _ = ((k : ℤ) : R) + 1 := by rw [Int.cast_natCast]                    -- 同じ一致を右辺から左辺へ
  rcases le_or_gt 0 n with hn | hn
  · obtain ⟨k, rfl⟩ := Int.eq_ofNat_of_zero_le hn
    exact hsucc k                                                          -- 埋め込みの `ι(n + 1) = ι(n) + 1`
  · obtain ⟨m, hm, rfl⟩ : ∃ m : ℤ, 1 ≤ m ∧ n = -m := ⟨-n, by omega, by omega⟩
    rcases eq_or_lt_of_le hm with h1 | h2
    · subst h1
      calc ((-(1 : ℤ) + 1 : ℤ) : R) = ((0 : ℤ) : R) := by rw [neg_add_cancel]  -- `ℤ` の加法逆元
        _ = 0 := Int.cast_zero                                             -- 埋め込みの `ι(0) = 0`
        _ = -(1 : R) + 1 := (neg_add_cancel 1).symm                        -- 加法逆元を右辺から左辺へ
        _ = -((1 : ℤ) : R) + 1 := by rw [Int.cast_one]                     -- 埋め込みの `ι(1) = 1` を右辺から左辺へ
        _ = ((-(1 : ℤ) : ℤ) : R) + 1 := by rw [Int.cast_neg]               -- 埋め込みの `ι(-n) = -ι(n)` を右辺から左辺へ
    · obtain ⟨q, hq, rfl⟩ : ∃ q : ℕ, 1 ≤ q ∧ m = (q : ℤ) + 1 := ⟨(m - 1).toNat, by omega, by omega⟩
      calc ((-((q : ℤ) + 1) + 1 : ℤ) : R) = ((-(q : ℤ) : ℤ) : R) := by
            rw [show -((q : ℤ) + 1) + 1 = -(q : ℤ) by omega]                -- `ℤ` の四則
        _ = -((q : ℤ) : R) := Int.cast_neg _                               -- 埋め込みの `ι(-n) = -ι(n)`
        _ = -((q : ℤ) : R) + 0 := (add_zero _).symm                        -- `0` は和の右単位元
        _ = -((q : ℤ) : R) + (-(1 : R) + 1) := by rw [neg_add_cancel]      -- 加法逆元を右辺から左辺へ
        _ = (-((q : ℤ) : R) + -(1 : R)) + 1 := (add_assoc _ _ _).symm       -- 和の結合律を右辺から左辺へ
        _ = -(((q : ℤ) : R) + 1) + 1 := by rw [neg_add]                    -- `-(x + y) = (-x) + (-y)` を右辺から左辺へ（加法の可換性が効く）
        _ = -((((q : ℤ) + 1 : ℤ)) : R) + 1 := by rw [hsucc q]              -- 埋め込みの `ι(n + 1) = ι(n) + 1` を右辺から左辺へ
        _ = ((-((q : ℤ) + 1) : ℤ) : R) + 1 := by rw [Int.cast_neg]         -- 埋め込みの `ι(-n) = -ι(n)` を右辺から左辺へ

/-- **必要十分版の `inclusion_zz_to_rr_preserves_sum`**: `ℤ` の埋め込みで `ι(a + b) = ι(a) + ι(b)`（`a, b ∈ ℤ`）。
具体版と同じく `b` について `0` から `1` を足す帰納法と `1` を引く帰納法（`Int.induction_on`）。 -/
theorem int_cast_add' {R : Type*} [AddCommGroupWithOne R] (a b : ℤ) :
    ((a + b : ℤ) : R) = ((a : ℤ) : R) + ((b : ℤ) : R) := by
  refine Int.induction_on b ?_ ?_ ?_
  · calc ((a + 0 : ℤ) : R) = ((a : ℤ) : R) := by rw [add_zero]            -- `0` は `ℤ` の和の単位元
      _ = ((a : ℤ) : R) + 0 := (add_zero _).symm                           -- `0` は和の右単位元
      _ = ((a : ℤ) : R) + ((0 : ℤ) : R) := by rw [Int.cast_zero]           -- 埋め込みの `ι(0) = 0` を右辺から左辺へ
  · intro i ih
    calc ((a + ((i : ℤ) + 1) : ℤ) : R) = (((a + (i : ℤ)) + 1 : ℤ) : R) := by rw [add_assoc]
      _ = ((a + (i : ℤ) : ℤ) : R) + 1 := int_cast_succ' _                  -- `int_cast_succ'`（`n → a + b`）
      _ = (((a : ℤ) : R) + (((i : ℤ)) : R)) + 1 := by rw [ih]              -- 帰納法の仮定
      _ = ((a : ℤ) : R) + ((((i : ℤ)) : R) + 1) := add_assoc _ _ _         -- 和の結合律
      _ = ((a : ℤ) : R) + ((((i : ℤ) + 1 : ℤ)) : R) := by rw [int_cast_succ' (i : ℤ)]
                                                                           -- `int_cast_succ'`（`n → b`）を右辺から左辺へ
  · intro i ih
    calc ((a + (-(i : ℤ) - 1) : ℤ) : R)
        = ((a + (-(i : ℤ) - 1) : ℤ) : R) + 0 := (add_zero _).symm          -- `0` は和の右単位元
      _ = ((a + (-(i : ℤ) - 1) : ℤ) : R) + (1 + -(1 : R)) := by rw [add_neg_cancel]
                                                                           -- 加法逆元を右辺から左辺へ
      _ = (((a + (-(i : ℤ) - 1) : ℤ) : R) + 1) + -(1 : R) := (add_assoc _ _ _).symm
                                                                           -- 和の結合律を右辺から左辺へ
      _ = (((a + (-(i : ℤ) - 1)) + 1 : ℤ) : R) + -(1 : R) := by
          rw [int_cast_succ' (a + (-(i : ℤ) - 1))]                         -- `int_cast_succ'` を右辺から左辺へ
      _ = ((a + ((-(i : ℤ) - 1) + 1) : ℤ) : R) + -(1 : R) := by
          rw [add_assoc a (-(i : ℤ) - 1) 1]                                -- `ℤ` の和の結合律
      _ = ((a + -(i : ℤ) : ℤ) : R) + -(1 : R) := by
          rw [sub_add_cancel_of_addGroup (-(i : ℤ)) 1]                     -- `ℤ` で `(x − y) + y = x`（`x → b`, `y → 1`）
      _ = (((a : ℤ) : R) + ((-(i : ℤ) : ℤ) : R)) + -(1 : R) := by rw [ih]  -- 帰納法の仮定
      _ = ((a : ℤ) : R) + (((-(i : ℤ) : ℤ) : R) + -(1 : R)) := add_assoc _ _ _
                                                                           -- 和の結合律
      _ = ((a : ℤ) : R) + ((((-(i : ℤ) - 1) + 1 : ℤ) : R) + -(1 : R)) := by
          rw [sub_add_cancel_of_addGroup (-(i : ℤ)) 1]                     -- `ℤ` で `(x − y) + y = x`（`x → b`, `y → 1`）を右辺から左辺へ
      _ = ((a : ℤ) : R) + ((((-(i : ℤ) - 1 : ℤ) : R) + 1) + -(1 : R)) := by
          rw [int_cast_succ' (-(i : ℤ) - 1)]                               -- `int_cast_succ'`（`n → b - 1`）
      _ = ((a : ℤ) : R) + (((-(i : ℤ) - 1 : ℤ) : R) + (1 + -(1 : R))) := by
          rw [add_assoc (((-(i : ℤ) - 1 : ℤ) : R))]                        -- 和の結合律
      _ = ((a : ℤ) : R) + (((-(i : ℤ) - 1 : ℤ) : R) + 0) := by rw [add_neg_cancel]
                                                                           -- 加法逆元
      _ = ((a : ℤ) : R) + ((-(i : ℤ) - 1 : ℤ) : R) := by rw [add_zero]     -- `0` は和の右単位元

/-- **必要十分版の `inclusion_zz_to_rr_preserves_product`**: `ℤ` の埋め込みで `ι(ab) = ι(a)ι(b)`（`a, b ∈ ℤ`）。
具体版と同じく `b` について `0` から `1` を足す帰納法と `1` を引く帰納法（`Int.induction_on`）。 -/
theorem int_cast_mul' {R : Type*} [NonAssocRing R] (a b : ℤ) :
    ((a * b : ℤ) : R) = ((a : ℤ) : R) * ((b : ℤ) : R) := by
  refine Int.induction_on b ?_ ?_ ?_
  · calc ((a * 0 : ℤ) : R) = ((0 : ℤ) : R) := by rw [mul_zero]            -- `ℤ` で `a · 0 = 0`
      _ = 0 := Int.cast_zero                                               -- 埋め込みの `ι(0) = 0`
      _ = ((a : ℤ) : R) * 0 := (mul_zero _).symm                           -- `x · 0 = 0` を右辺から左辺へ
      _ = ((a : ℤ) : R) * ((0 : ℤ) : R) := by rw [Int.cast_zero]           -- 埋め込みの `ι(0) = 0` を右辺から左辺へ
  · intro i ih
    calc ((a * ((i : ℤ) + 1) : ℤ) : R) = ((a * (i : ℤ) + a * 1 : ℤ) : R) := by rw [mul_add]
                                                                           -- `ℤ` の分配律
      _ = ((a * (i : ℤ) + a : ℤ) : R) := by rw [mul_one]                   -- `ℤ` の積の単位元
      _ = ((a * (i : ℤ) : ℤ) : R) + ((a : ℤ) : R) := int_cast_add' _ _     -- `int_cast_add'`（`a → ab`, `b → a`）
      _ = ((a : ℤ) : R) * (((i : ℤ)) : R) + ((a : ℤ) : R) := by rw [ih]    -- 帰納法の仮定
      _ = ((a : ℤ) : R) * (((i : ℤ)) : R) + ((a : ℤ) : R) * 1 := by rw [mul_one]
                                                                           -- `1` は乗法の右単位元
      _ = ((a : ℤ) : R) * ((((i : ℤ)) : R) + 1) := (mul_add _ _ _).symm    -- 左からの分配律を右辺から左辺へ
      _ = ((a : ℤ) : R) * ((((i : ℤ) + 1 : ℤ)) : R) := by rw [int_cast_succ' (i : ℤ)]
                                                                           -- `int_cast_succ'`（`n → b`）を右辺から左辺へ
  · intro i ih
    calc ((a * (-(i : ℤ) - 1) : ℤ) : R)
        = ((a * (-(i : ℤ) - 1) : ℤ) : R) + 0 := (add_zero _).symm          -- `0` は和の右単位元
      _ = ((a * (-(i : ℤ) - 1) : ℤ) : R) + (((a : ℤ) : R) + -((a : ℤ) : R)) := by rw [add_neg_cancel]
                                                                           -- 加法逆元を右辺から左辺へ
      _ = (((a * (-(i : ℤ) - 1) : ℤ) : R) + ((a : ℤ) : R)) + -((a : ℤ) : R) := (add_assoc _ _ _).symm
                                                                           -- 和の結合律を右辺から左辺へ
      _ = ((a * (-(i : ℤ) - 1) + a : ℤ) : R) + -((a : ℤ) : R) := by
          rw [int_cast_add' (a * (-(i : ℤ) - 1)) a]                        -- `int_cast_add'` を右辺から左辺へ
      _ = (((a * -(i : ℤ) - a * 1) + a : ℤ) : R) + -((a : ℤ) : R) := by rw [mul_sub]
                                                                           -- `ℤ` の分配律
      _ = (((a * -(i : ℤ) - a) + a : ℤ) : R) + -((a : ℤ) : R) := by rw [mul_one]
                                                                           -- `ℤ` の積の単位元
      _ = ((a * -(i : ℤ) : ℤ) : R) + -((a : ℤ) : R) := by
          rw [sub_add_cancel_of_addGroup (a * -(i : ℤ)) a]                 -- `ℤ` で `(x − y) + y = x`（`x → ab`, `y → a`）
      _ = ((a : ℤ) : R) * ((-(i : ℤ) : ℤ) : R) + -((a : ℤ) : R) := by rw [ih]
                                                                           -- 帰納法の仮定
      _ = ((a : ℤ) : R) * (((-(i : ℤ) - 1) + 1 : ℤ) : R) + -((a : ℤ) : R) := by
          rw [sub_add_cancel_of_addGroup (-(i : ℤ)) 1]                     -- `ℤ` で `(x − y) + y = x`（`x → b`, `y → 1`）を右辺から左辺へ
      _ = ((a : ℤ) : R) * (((-(i : ℤ) - 1 : ℤ) : R) + 1) + -((a : ℤ) : R) := by
          rw [int_cast_succ' (-(i : ℤ) - 1)]                               -- `int_cast_succ'`（`n → b - 1`）
      _ = (((a : ℤ) : R) * ((-(i : ℤ) - 1 : ℤ) : R) + ((a : ℤ) : R) * 1) + -((a : ℤ) : R) := by
          rw [mul_add]                                                     -- 左からの分配律
      _ = (((a : ℤ) : R) * ((-(i : ℤ) - 1 : ℤ) : R) + ((a : ℤ) : R)) + -((a : ℤ) : R) := by
          rw [mul_one]                                                     -- `1` は乗法の右単位元
      _ = ((a : ℤ) : R) * ((-(i : ℤ) - 1 : ℤ) : R) + (((a : ℤ) : R) + -((a : ℤ) : R)) := add_assoc _ _ _
                                                                           -- 和の結合律
      _ = ((a : ℤ) : R) * ((-(i : ℤ) - 1 : ℤ) : R) + 0 := by rw [add_neg_cancel]
                                                                           -- 加法逆元
      _ = ((a : ℤ) : R) * ((-(i : ℤ) - 1 : ℤ) : R) := add_zero _          -- `0` は和の右単位元

/-- **必要十分版の `inclusion_zz_to_rr_preserves_difference`**: `ℤ` の埋め込みで `ι(a - b) = ι(a) - ι(b)`（`a, b ∈ ℤ`）。
具体版と同じ 9 段で、`int_cast_add'` だけを引く。 -/
theorem int_cast_sub' {R : Type*} [AddCommGroupWithOne R] (a b : ℤ) :
    ((a - b : ℤ) : R) = ((a : ℤ) : R) - ((b : ℤ) : R) :=
  calc ((a - b : ℤ) : R)
      = ((a - b : ℤ) : R) + 0 := (add_zero _).symm                        -- `0` は和の右単位元
    _ = ((a - b : ℤ) : R) + (((b : ℤ) : R) + -((b : ℤ) : R)) := by rw [add_neg_cancel]
                                                                           -- 加法逆元を右辺から左辺へ
    _ = (((a - b : ℤ) : R) + ((b : ℤ) : R)) + -((b : ℤ) : R) := (add_assoc _ _ _).symm
                                                                           -- 和の結合律を右辺から左辺へ
    _ = ((a - b + b : ℤ) : R) + -((b : ℤ) : R) := by
        rw [int_cast_add' (a - b) b]                                       -- `int_cast_add'` を右辺から左辺へ
    _ = ((a + -b + b : ℤ) : R) + -((b : ℤ) : R) := by rw [sub_eq_add_neg a b]
                                                                           -- `ℤ` の差は加法の逆元の和
    _ = ((a + (-b + b) : ℤ) : R) + -((b : ℤ) : R) := by rw [add_assoc a (-b) b]
                                                                           -- `ℤ` の和の結合律
    _ = ((a + 0 : ℤ) : R) + -((b : ℤ) : R) := by rw [neg_add_cancel b]     -- `ℤ` の加法逆元 `(-x) + x = 0`
    _ = ((a : ℤ) : R) + -((b : ℤ) : R) := by rw [add_zero a]              -- `0` は `ℤ` の和の右単位元
    _ = ((a : ℤ) : R) - ((b : ℤ) : R) := (sub_eq_add_neg _ _).symm        -- 差は加法の逆元の和（右辺から左辺へ）

/-- **必要十分版の `inclusion_zz_to_rr_preserves_negation`**: `ℤ` の埋め込みで `ι(-a) = -ι(a)`（`a ∈ ℤ`）。
具体版と同じ 6 段で、`int_cast_sub'` と埋め込みの `ι(0) = 0` を引く。 -/
theorem int_cast_neg' {R : Type*} [AddCommGroupWithOne R] (a : ℤ) :
    ((-a : ℤ) : R) = -((a : ℤ) : R) :=
  calc ((-a : ℤ) : R)
      = ((0 + -a : ℤ) : R) := by rw [zero_add (-a)]                        -- `0` は `ℤ` の和の左単位元（右辺から左辺へ）
    _ = ((0 - a : ℤ) : R) := by rw [sub_eq_add_neg (0 : ℤ) a]               -- `ℤ` の差は加法の逆元の和（右辺から左辺へ）
    _ = ((0 : ℤ) : R) - ((a : ℤ) : R) := int_cast_sub' 0 a                 -- `int_cast_sub'`（`a → 0`, `b → a`）
    _ = 0 - ((a : ℤ) : R) := by rw [Int.cast_zero]                         -- 埋め込みの `ι(0) = 0`
    _ = 0 + -((a : ℤ) : R) := sub_eq_add_neg _ _                          -- 差は加法の逆元の和
    _ = -((a : ℤ) : R) := zero_add _                                      -- `0` は和の左単位元

end Ising2D.NecSuf
