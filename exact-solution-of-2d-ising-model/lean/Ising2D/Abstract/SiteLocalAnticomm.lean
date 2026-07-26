/-
# 抽象版: サイト局所な反可換性は「積」全体の反交換関係へ持ち上がる

**このファイルには抽象版だけを置く。抽象版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル:

| 人手証明のラベル | 具体版（複素行列） |
| --- | --- |
| `anticommutator_of_Z_and_Y` | `Ising2D/Part006/Claim000_AnticommutatorZY.lean` の
  `Ising2D.anticomm_Z_Z` / `Ising2D.anticomm_Z_Y` / `Ising2D.anticomm_Y_Y` |

具体版を本ファイルの抽象版の特殊化として導出したものは
`Ising2D/Part006/Claim000_AnticommutatorZYAbstract.lean` にある。

## 抽象版が何を明らかにするか

原文 `anticommutator_of_Z_and_Y` の計算に効いているのは、次の 3 つだけである。

1. **「サイトごとの族」から「1 つの元」を作る写像 `P` が積を保ち、単位元を単位元へ送ること**
   （`IsSiteProd.map_mul` / `IsSiteProd.map_one`）。
2. **`P` が各サイトのスカラー倍を全体のスカラー倍へ変えること**
   （`IsSiteProd.map_smul_univ`。これが「符号 `-1` がテンソル積の外へ出る」の中身）。
3. **サイトの添字に線型順序があること**（Jordan–Wigner 文字列 `jwStr` を書くのに使う）。

効いていないもの: 台が**行列**であること、成分が **2×2** であること、**複素数**上であること、
クロネッカー積・テンソル積の具体形、Pauli 行列の具体的な成分、サイトの個数が有限であること以外の性質。
`P` は「テンソル積」である必要すらなく、**単位的かつ乗法的かつ多重線型**でありさえすればよい。

逆にこれは、具体版が `σ^x, σ^y, σ^z` の成分計算に依存していないことの検査になっている
（具体版が使うのは `A σ^x = -σ^x A` 型の関係式だけである）。
-/
import Ising2D.Part000.Claim046_CommutatorViaAnticommutators
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D.Abstract

variable {S : Type*} [CommRing S]
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {A B : Type*} [Ring A] [Module S A] [Ring B] [Module S B]

/-- **抽象版が仮定する「サイトごとの積」の性質**。

`P : (ι → A) → B` は、各サイトに元を置いた族から 1 つの元を作る写像である。
具体版では `P = siteProd M`（クロネッカー積）だが、必要なのは次の 3 つだけ。

* `map_one`: すべてのサイトに `1` を置けば `1`。
* `map_mul`: サイトごとの積は全体の積になる。
* `map_smul_univ`: 各サイトのスカラー倍は、その総積による全体のスカラー倍になる（多重線型性）。 -/
structure IsSiteProd (S : Type*) [CommRing S] {ι : Type*} [Fintype ι]
    {A B : Type*} [Ring A] [Module S A] [Ring B] [Module S B]
    (P : (ι → A) → B) : Prop where
  /-- すべてのサイトに `1` を置けば `1`。 -/
  map_one : P 1 = 1
  /-- サイトごとの積は全体の積になる。 -/
  map_mul : ∀ x y : ι → A, P (x * y) = P x * P y
  /-- 各サイトのスカラー倍は、その総積による全体のスカラー倍になる（多重線型性）。 -/
  map_smul_univ : ∀ (c : ι → S) (x : ι → A),
    P (fun i => c i • x i) = (∏ i, c i) • P x

variable {P : (ι → A) → B}

/-- **抽象版の核心（原文の「サイト `μ` の因子だけが符号だけ違う」の中身）**。

族 `x, y : ι → A` について、**ただ 1 つのサイト `j` でだけ反可換**で、
他のサイトでは可換ならば、`P x` と `P y` は反交換する。

証明の要は `map_smul_univ`: 「サイト `j` だけ `-1`、他は `1`」という係数族の総積が `-1` なので、
符号が `P` の外へ出る。 -/
theorem acomm_of_single_site (hP : IsSiteProd S P) (x y : ι → A) (j : ι)
    (hj : y j * x j = -(x j * y j))
    (hcomm : ∀ i, i ≠ j → y i * x i = x i * y i) :
    acomm (P x) (P y) = 0 := by
  classical
  have hswap : P y * P x = -(P x * P y) := by
    rw [← hP.map_mul, ← hP.map_mul]
    have hfam : (y * x : ι → A) =
        fun i => (Function.update (1 : ι → S) j (-1) i) • ((x * y : ι → A) i) := by
      funext i
      by_cases hij : i = j
      · have hupd : Function.update (1 : ι → S) j (-1) i = -1 := by
          rw [Function.update_apply, if_pos hij]
        rw [Pi.mul_apply, Pi.mul_apply, hupd, hij, hj, neg_smul, one_smul]
      · have hupd : Function.update (1 : ι → S) j (-1) i = 1 := by
          rw [Function.update_apply, if_neg hij]; rfl
        rw [Pi.mul_apply, Pi.mul_apply, hupd, one_smul]
        exact hcomm i hij
    rw [hfam, hP.map_smul_univ]
    have hprod : (∏ i, Function.update (1 : ι → S) j (-1) i) = -1 := by
      rw [Finset.prod_update_of_mem (Finset.mem_univ j)]
      simp
    rw [hprod, neg_smul, one_smul]
  rw [acomm, hswap, add_neg_cancel]

omit [DecidableEq ι] in
/-- 各サイトで自乗が `1` になる族なら、`P` で作った元も自乗が `1`。

具体版の `jw_sq`（文字列部分 `σ^x ⋯ σ^x` が消えること）にあたる。 -/
theorem sq_eq_one_of_site_sq_eq_one (hP : IsSiteProd S P) (x : ι → A)
    (h : ∀ i, x i * x i = 1) : P x * P x = 1 := by
  rw [← hP.map_mul]
  have hx : (x * x : ι → A) = 1 := by
    funext i; rw [Pi.mul_apply, Pi.one_apply]; exact h i
  rw [hx, hP.map_one]

/-! ## 抽象版の Jordan–Wigner 文字列

サイトの添字に線型順序があれば、原文の `Z_m = σ^x_1 ⋯ σ^x_{m-1} σ^z_m` と同じ形の族を書ける。
必要なのは「文字列に使う元 `s`」がひとつあることだけで、`s` が Pauli 行列である必要はない。 -/

variable [LinearOrder ι]

/-- **抽象版の Jordan–Wigner 文字列の族**: サイト `i` に
`i < m` なら `s`、`i = m` なら `a`、`i > m` なら `1` を置く。

具体版の `Ising2D.jwFamily`（`s = σ^x`）にあたる。 -/
def jwStr (s : A) (m : ι) (a : A) : ι → A :=
  fun i => if i < m then s else if i = m then a else 1

omit [Fintype ι] in
theorem jwStr_of_lt (s : A) {m i : ι} (a : A) (h : i < m) : jwStr s m a i = s := by
  simp [jwStr, h]

omit [Fintype ι] in
@[simp]
theorem jwStr_self (s : A) (m : ι) (a : A) : jwStr s m a m = a := by
  simp [jwStr]

omit [Fintype ι] in
theorem jwStr_of_gt (s : A) {m i : ι} (a : A) (h : m < i) : jwStr s m a i = 1 := by
  have h1 : ¬ (i < m) := not_lt.2 h.le
  have h2 : i ≠ m := ne_of_gt h
  simp [jwStr, h1, h2]

/-- **抽象版: Jordan–Wigner 文字列どうしの反交換**（原文の計算の骨格）。

サイト `μ` に `a`、サイト `ν` に `b` を載せた 2 つの文字列は、
`a, b` がともに文字列元 `s` と反可換であり、かつ（`μ = ν` の場合に限り）`a` と `b` が
互いに反可換ならば、反交換する。

食い違うサイトは `μ < ν` なら `μ`、`μ > ν` なら `ν`、`μ = ν` なら `μ` の 1 つだけである。 -/
theorem acomm_jwStr (hP : IsSiteProd S P) (s : A) (μ ν : ι) (a b : A)
    (has : a * s = -(s * a)) (hbs : b * s = -(s * b))
    (hab : μ = ν → b * a = -(a * b)) :
    acomm (P (jwStr s μ a)) (P (jwStr s ν b)) = 0 := by
  rcases lt_trichotomy μ ν with h | h | h
  · -- `μ < ν`: 食い違うのはサイト `μ`（`s` と `a`）
    refine acomm_of_single_site hP _ _ μ ?_ ?_
    · rw [jwStr_of_lt s b h, jwStr_self, has, neg_neg]
    · intro i hi
      rcases lt_trichotomy i μ with h1 | h1 | h1
      · rw [jwStr_of_lt s a h1, jwStr_of_lt s b (h1.trans h)]
      · exact absurd h1 hi
      · rw [jwStr_of_gt s a h1, one_mul, mul_one]
  · -- `μ = ν`: 食い違うのはサイト `μ`（`a` と `b`）
    subst h
    refine acomm_of_single_site hP _ _ μ ?_ ?_
    · rw [jwStr_self, jwStr_self]; exact hab rfl
    · intro i hi
      rcases lt_trichotomy i μ with h1 | h1 | h1
      · rw [jwStr_of_lt s a h1, jwStr_of_lt s b h1]
      · exact absurd h1 hi
      · rw [jwStr_of_gt s a h1, one_mul, mul_one]
  · -- `ν < μ`: 食い違うのはサイト `ν`（`b` と `s`）
    refine acomm_of_single_site hP _ _ ν ?_ ?_
    · rw [jwStr_of_lt s a h, jwStr_self]; exact hbs
    · intro i hi
      rcases lt_trichotomy i ν with h1 | h1 | h1
      · rw [jwStr_of_lt s a (h1.trans h), jwStr_of_lt s b h1]
      · exact absurd h1 hi
      · rw [jwStr_of_gt s b h1, one_mul, mul_one]

/-- **抽象版: Jordan–Wigner 文字列の自乗**（原文の `μ = ν` の場合）。

文字列元 `s` と載せた元 `a` がともに自乗して `1` なら、文字列も自乗して `1`。 -/
theorem jwStr_sq (hP : IsSiteProd S P) {s : A} (hs : s * s = 1) (m : ι) {a : A}
    (ha : a * a = 1) : P (jwStr s m a) * P (jwStr s m a) = 1 := by
  refine sq_eq_one_of_site_sq_eq_one hP _ fun i => ?_
  rcases lt_trichotomy i m with h | h | h
  · rw [jwStr_of_lt s a h]; exact hs
  · rw [h, jwStr_self]; exact ha
  · rw [jwStr_of_gt s a h, mul_one]

end Ising2D.Abstract
