/-
# 必要十分版: 「基底を全部含む部分多元環は全体」と「サイトごとの元の積は部分多元環に入る」

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル: **`<Z_Y_generate_algebra>`**
（`parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ`。
具体版は `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimZYGenerateAlgebra.lean` の
`Ising2D.Z_Y_generate_algebra`、特殊化による導出は
`Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimZYGenerateAlgebraFromNecSuf.lean`）。

## 何を抽象化したか

原文の証明は 3 段からなる。本ファイルはそのうち **Step 2 と Step 3 の骨格**を、
行列・複素数・テンソル積・Pauli 行列・2×2 のいずれにも依存しない形で取り出す。

| 原文 | 本ファイル | 効いている構造 |
| --- | --- | --- |
| Step 3「全体を張る集合を全部含むから全体」 | `eq_top_of_span_eq_top` | 可換半環上の代数と部分多元環（＝積で閉じた部分加群）だけ |
| Step 3 後半「`P_1 := E_1`・`P_{s+1} := P_sE_{s+1}` の帰納法」 | `prefixProduct`・`prefixProduct_eq_and_mem`・`map_mem_of_mulSingle_mem` | 各サイトの単位元が両側の単位元であることと、`φ` が**積を保つ**こと（単位元を保つことは使わない）、添字 `Fin n` の順序、`0 < n` |
| Step 2「Jordan–Wigner 文字列の帰納法」 | `string_mem`, `local_mem` | 文字列の漸化式と、局所元が「文字列 × 生成元」で書けることだけ |

### 効いていないもの（一次情報: 下の証明が使っている補題がすべて）

* **行列であること**: どの証明にも行列の成分・行列積・転置は現れない。
* **係数が ℂ であること**: `R` は任意の可換半環でよい。`Complex.I` に相当する係数は
  `string_mem` の `r : R` として抽象化されており、その値は一切使われない
  （`Subalgebra.smul_mem` にそのまま渡すだけ）。
* **テンソル積であること**: `map_mem_of_mulSingle_mem` が使うのは
  「サイトごとの元を並べた族へ積を保つ写像を適用する」ことだけで、
  クロネッカー積の成分公式も、サイト間の可換性も使わない。
  `φ` が単位元を保つことも、`A` の結合律も使わない（人手の帰納法は `P_1 := E_1` から始まり、
  `P_{s+1} := P_sE_{s+1}` と右から 1 つずつ掛けるだけなので、積の付け替えが起きない）。
* **Pauli 行列の関係式**: `σ^x = -√-1 σ^y σ^z`、`P_m P_m = I`、反交換関係のいずれも仮定に現れない。
  `string_mem` は「`σ^z_m = P_m Z_m`」という**分解の形**しか使わない
  （具体版は `P_m P_m = I` からこの分解を導くが、分解を仮定してしまえば対合性は不要である）。
* **各サイトの次元が 2 であること**: どこにも 2 は現れない。
* **各サイトの `N i` が同じであること**: `N i`（`MulOneClass`）はサイトごとに違ってよい。
  ただし添字は `Fin n` に固定し、その順序を使う（人手の `P_s` は第 `1` から第 `s` 因子という並びで定めるため）。
  主張だけなら任意の有限添字で成り立つが、それは人手と別の手順（有限集合の帰納法）になるので、ここには置かない。

Step 2 の抽象化で唯一残る「線型性への依存」は `σ^x_m = -√-1 σ^y_m σ^z_m` の係数だけであり、
これは `Subalgebra` が加群構造をもつことで吸収される。つまり Step 2 に本質的なのは
**「部分多元環がスカラー倍で閉じていること」**であって、複素数体であることではない。
-/
import Mathlib.Algebra.Algebra.Subalgebra.Basic
import Mathlib.Algebra.Algebra.Subalgebra.Lattice
import Mathlib.Algebra.Group.Pi.Basic
import Mathlib.Algebra.Group.Subsemigroup.Basic
import Mathlib.LinearAlgebra.Basis.Basic
import Mathlib.LinearAlgebra.Basis.Defs
import Mathlib.LinearAlgebra.Span.Basic

namespace Ising2D
namespace NecSuf

/-! ## (a) 基底（生成系）を全部含む部分多元環は全体 -/

section SpanTop

variable {R A : Type*} [CommSemiring R] [Semiring A] [Algebra R A]

/-- **原文 Step 3 の骨格**: 部分多元環 `S` が、`R`-加群として全体を張る集合 `s` を含むなら
`S = ⊤`。

効いているのは「`S` が部分加群でもあること」だけで、`A` が行列であることも
`R` が体であることも使わない。 -/
theorem eq_top_of_span_eq_top (S : Subalgebra R A) {s : Set A}
    (hs : s ⊆ (S : Set A)) (hspan : Submodule.span R s = ⊤) : S = ⊤ := by
  have hle : Submodule.span R s ≤ Subalgebra.toSubmodule S := Submodule.span_le.2 hs
  rw [hspan] at hle
  exact eq_top_iff.2 fun a _ => hle Submodule.mem_top

end SpanTop

/-! ## (b) サイトごとの元の積は、各サイト単独の元を含む部分半群に属する

具体版 `Ising2D.siteFactorPrefixProduct_eq_and_mem`・`Ising2D.siteProd_mem`（人手 Step 3 後半の
`P_1 := E_1`・`P_{s+1} := P_s E_{s+1}` の帰納法）と同じ手順を、`φ` が積を保つ写像であることだけで回す。 -/

section SiteProduct

variable {n : ℕ} {N : Fin n → Type*} [∀ i, MulOneClass (N i)]
variable {A : Type*} [Mul A]

/-- 人手 Step 3 後半の `P_s`（`P_1 := E_1`、`P_{s+1} := P_s E_{s+1}`）。`E_k` は `φ (mulSingle k (x k))`。
具体版 `Ising2D.siteFactorPrefixProduct` と同じく、Lean の `s` が人手の `s + 1` である。 -/
def prefixProduct (φ : (∀ i, N i) →ₙ* A) (x : ∀ i, N i) : (s : ℕ) → s < n → A
  | 0, h => φ (Pi.mulSingle ⟨0, h⟩ (x ⟨0, h⟩))
  | s + 1, h =>
      prefixProduct φ x s (Nat.lt_of_succ_lt h) * φ (Pi.mulSingle ⟨s + 1, h⟩ (x ⟨s + 1, h⟩))

/-- **原文 Step 3 後半の帰納法（必要十分版）**: `P_s = φ(e_1, …, e_s, 1, …, 1)` かつ `P_s ∈ S`。
具体版 `Ising2D.siteFactorPrefixProduct_eq_and_mem` と同じ手順で、`s → s + 1` の鎖も同じ 7 段
（定義・帰納法の仮定・積を保つこと（具体版の `kronecker_product_rule` (1)）・第 1 から第 `s` 因子の右単位・
第 `s+1` 因子の左単位・第 `s+2` 以降の因子の左単位・因子の並びの書き換え）である。

効いているのは、`φ` が**積を保つ**こと（`map_mul`）、各 `N i` の単位元が両側の単位元であること
（`mul_one`・`one_mul`）、`S` が積で閉じていることだけである。`φ` が単位元を保つこと・`A` の結合律・
`A` の単位元は使わない（人手の帰納法は `P_1 := E_1` から始まり、空の積 `P_0` を置かないため）。
添字の**順序**（`Fin n` の `≤`）は使う: 人手の `P_s` は左から順に掛けた積で、第 `1` から第 `s` 因子という並びを使うからである。 -/
theorem prefixProduct_eq_and_mem (φ : (∀ i, N i) →ₙ* A) (S : Subsemigroup A) (x : ∀ i, N i)
    (hE : ∀ k, φ (Pi.mulSingle k (x k)) ∈ S) :
    ∀ (s : ℕ) (h : s < n),
      prefixProduct φ x s h = φ (fun i => if (i : ℕ) ≤ s then x i else 1)
        ∧ prefixProduct φ x s h ∈ S
  | 0, h => by
    refine ⟨?_, hE _⟩
    calc prefixProduct φ x 0 h
        = φ (Pi.mulSingle ⟨0, h⟩ (x ⟨0, h⟩)) := rfl                    -- `P_1` の定義
      _ = φ (fun i => if (i : ℕ) ≤ 0 then x i else 1) := by
          congr 1                                                      -- `E_1` の定義（因子の並びの書き換え）
          funext i
          by_cases hi : (i : ℕ) = 0
          · have he : i = ⟨0, h⟩ := Fin.ext hi
            subst he
            simp
          · have hne : i ≠ ⟨0, h⟩ := fun he => hi (congrArg Fin.val he)
            rw [Pi.mulSingle_eq_of_ne hne, if_neg (by omega)]
  | s + 1, h => by
    obtain ⟨ihEq, ihMem⟩ := prefixProduct_eq_and_mem φ S x hE s (Nat.lt_of_succ_lt h)
    refine ⟨?_, ?_⟩
    · calc prefixProduct φ x (s + 1) h
          = prefixProduct φ x s (Nat.lt_of_succ_lt h) * φ (Pi.mulSingle ⟨s + 1, h⟩ (x ⟨s + 1, h⟩)) :=
            rfl                                                        -- `P_{s+1}` の定義
        _ = φ (fun i => if (i : ℕ) ≤ s then x i else 1)
              * φ (Pi.mulSingle ⟨s + 1, h⟩ (x ⟨s + 1, h⟩)) := by
            rw [ihEq]                                                  -- 帰納法の仮定（`E_{s+1}` の定義は `φ (mulSingle …)` そのもの）
        _ = φ (fun i => if (i : ℕ) ≤ s then x i * 1
              else if (i : ℕ) = s + 1 then 1 * x i else 1 * 1) := by
            rw [← map_mul]                                             -- `φ` は積を保つ（具体版の `kronecker_product_rule` (1)）
            congr 1
            funext i
            simp only [Pi.mul_apply]
            by_cases hi : (i : ℕ) ≤ s
            · have hne : i ≠ ⟨s + 1, h⟩ := fun he => by
                have := congrArg Fin.val he; simp at this; omega
              rw [if_pos hi, if_pos hi, Pi.mulSingle_eq_of_ne hne]
            · by_cases hs : (i : ℕ) = s + 1
              · have he : i = ⟨s + 1, h⟩ := Fin.ext hs
                subst he
                rw [if_neg hi, if_neg hi, if_pos hs, Pi.mulSingle_eq_same]
              · have hne : i ≠ ⟨s + 1, h⟩ := fun he => hs (congrArg Fin.val he)
                rw [if_neg hi, if_neg hi, if_neg hs, Pi.mulSingle_eq_of_ne hne]
        _ = φ (fun i => if (i : ℕ) ≤ s then x i
              else if (i : ℕ) = s + 1 then 1 * x i else 1 * 1) := by
            congr 1
            funext i
            by_cases hi : (i : ℕ) ≤ s
            · rw [if_pos hi, if_pos hi, mul_one]                       -- 右単位を第 1 から第 `s` 因子へ同時に適用
            · rw [if_neg hi, if_neg hi]
        _ = φ (fun i => if (i : ℕ) ≤ s then x i
              else if (i : ℕ) = s + 1 then x i else 1 * 1) := by
            congr 1
            funext i
            by_cases hs : (i : ℕ) = s + 1
            · rw [if_pos hs, if_pos hs, one_mul]                       -- 左単位（`e_{s+1}`）
            · rw [if_neg hs, if_neg hs]
        _ = φ (fun i => if (i : ℕ) ≤ s then x i
              else if (i : ℕ) = s + 1 then x i else 1) := by
            congr 1
            funext i
            by_cases hi : (i : ℕ) ≤ s
            · rw [if_pos hi, if_pos hi]
            · by_cases hs : (i : ℕ) = s + 1
              · rw [if_neg hi, if_neg hi, if_pos hs, if_pos hs]
              · rw [if_neg hi, if_neg hi, if_neg hs, if_neg hs, one_mul]
                                                                       -- 左単位（`1`）を第 `s+2` 以降の因子へ同時に適用
        _ = φ (fun i => if (i : ℕ) ≤ s + 1 then x i else 1) := by
            congr 1                                                    -- 因子の並びの書き換え（`if` の書き方の違いだけ）
            funext i
            by_cases hi : (i : ℕ) ≤ s
            · rw [if_pos hi, if_pos (by omega)]
            · by_cases hs : (i : ℕ) = s + 1
              · rw [if_neg hi, if_pos hs, if_pos (by omega)]
              · rw [if_neg hi, if_neg hs, if_neg (by omega)]
    · exact mul_mem ihMem (hE _)                                       -- 帰納法の仮定・`E_{s+1} ∈ S`・`S` は積で閉じる

/-- **原文 Step 3 後半の結論（必要十分版）**: `0 < n` のとき、積を保つ写像 `φ` が「1 サイトだけ動かした族」
`mulSingle k (x k)` をすべて部分半群 `S` へ送るなら、任意の族 `x` について `φ x ∈ S`。
`prefixProduct_eq_and_mem` を人手の `s = n`（Lean の `n - 1`）で使う。

`0 < n` は削れない: 人手の帰納法は `P_1 := E_1` から始まるので、因子が 1 つも無いと始められない
（`n = 0` で結論を得るには `φ 1 ∈ S` が別に要る。例えば `φ` が単位元を保ち `S` が単位元を含めば足りる。
具体版はこの場合を `siteProd_one` と (ii) で別に閉じている）。 -/
theorem map_mem_of_mulSingle_mem (hn : 0 < n) (φ : (∀ i, N i) →ₙ* A) (S : Subsemigroup A)
    (x : ∀ i, N i) (h : ∀ k, φ (Pi.mulSingle k (x k)) ∈ S) : φ x ∈ S := by
  obtain ⟨hform, hmem⟩ := prefixProduct_eq_and_mem φ S x h (n - 1) (by omega)
  have hall : (fun i : Fin n => if (i : ℕ) ≤ n - 1 then x i else 1) = x := by
    funext i
    rw [if_pos (by omega)]
  rw [hform, hall] at hmem
  exact hmem

end SiteProduct

/-! ## Step 2: Jordan–Wigner 文字列の帰納法

原文 Step 2 は
`P_0 = I`, `σ^z_m = P_m Z_m`, `σ^y_m = P_m Y_m`, `σ^x_m = -√-1 σ^y_m σ^z_m`,
`P_{m+1} = P_m σ^x_m` という**漸化式と分解の形**だけを使う。
以下はそれをそのまま抽象化したもので、行列も複素数も Pauli 行列の関係式も現れない。

添字は原文どおり `0, 1, …, N` の範囲に制限する（具体版のサイト数 `M` に当たる）。 -/

section StringInduction

variable {R A : Type*} [CommSemiring R] [Semiring A] [Algebra R A]
variable {S : Subalgebra R A} {p z y zl yl xl : ℕ → A} {r : R} {N : ℕ}
variable (hp0 : p 0 = 1)
variable (hzl : ∀ n, n < N → zl n = p n * z n)
variable (hyl : ∀ n, n < N → yl n = p n * y n)
variable (hxl : ∀ n, n < N → xl n = r • (yl n * zl n))
variable (hp : ∀ n, n < N → p (n + 1) = p n * xl n)
variable (hz : ∀ n, n < N → z n ∈ S)
variable (hy : ∀ n, n < N → y n ∈ S)

include hp0 hzl hyl hxl hp hz hy

/-- **原文 Step 2 の帰納法（必要十分版）**: 文字列 `p n` は部分多元環 `S` に属する。 -/
theorem string_mem : ∀ n, n ≤ N → p n ∈ S := by
  intro n
  induction n with
  | zero =>
      intro _
      rw [hp0]
      exact one_mem S
  | succ n ih =>
      intro hn
      have hnN : n < N := hn
      have hpn : p n ∈ S := ih (le_of_lt hnN)
      have hzln : zl n ∈ S := by
        rw [hzl n hnN]; exact mul_mem hpn (hz n hnN)
      have hyln : yl n ∈ S := by
        rw [hyl n hnN]; exact mul_mem hpn (hy n hnN)
      have hxln : xl n ∈ S := by
        rw [hxl n hnN]; exact Subalgebra.smul_mem _ (mul_mem hyln hzln) _
      rw [hp n hnN]
      exact mul_mem hpn hxln

/-- **原文 Step 2 の結論（必要十分版）**: 局所元 `σ^z_n, σ^y_n, σ^x_n` はすべて `S` に属する。 -/
theorem local_mem (n : ℕ) (hn : n < N) : zl n ∈ S ∧ yl n ∈ S ∧ xl n ∈ S := by
  have hpn : p n ∈ S := string_mem hp0 hzl hyl hxl hp hz hy n (le_of_lt hn)
  have hzln : zl n ∈ S := by
    rw [hzl n hn]; exact mul_mem hpn (hz n hn)
  have hyln : yl n ∈ S := by
    rw [hyl n hn]; exact mul_mem hpn (hy n hn)
  refine ⟨hzln, hyln, ?_⟩
  rw [hxl n hn]
  exact Subalgebra.smul_mem _ (mul_mem hyln hzln) _

end StringInduction

end NecSuf
end Ising2D
