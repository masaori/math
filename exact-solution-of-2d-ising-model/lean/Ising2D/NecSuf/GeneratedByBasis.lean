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
| Step 2「Jordan–Wigner 文字列の帰納法」（外側の累積帰納法と、その中の `P_{m-1} ∈ 𝒜` の `r` の帰納法） | `string_mem_of_previous`, `local_mem_of_previous`, `local_mem`, `string_mem` | 文字列の漸化式と、局所元が「文字列 × 生成元」で書けることだけ |
| Step 2 の準備「可換の式 `σ_k^xP_r = P_rσ_k^x`（`r < k`）と二乗の式 `P_rP_r = I`」 | `xl_mul_string_comm`, `string_mul_self` | モノイドであること、`x n * x n = 1`、相異なる番号どうしの可換性（下の節の冒頭） |
| Step 2 の準備「積の表示 `P_r = ∏_{j=1}^{r}σ_j^x`」 | `string_eq_finProdLeft` | 二項演算 `*` と元 `1`、`1 * x 0 = x 0` だけ（結合則・単位元のほかの性質は使わない。下の節の冒頭） |

### 効いていないもの（一次情報: 下の証明が使っている補題がすべて）

* **行列であること**: どの証明にも行列の成分・行列積・転置は現れない。
* **係数が ℂ であること**: `R` は任意の可換半環でよい。`Complex.I` に相当する係数は
  `local_mem_of_previous`・`local_mem` の `r : R` として抽象化されており、その値は一切使われない
  （`Subalgebra.smul_mem` にそのまま渡すだけ）。
* **テンソル積であること**: `map_mem_of_mulSingle_mem` が使うのは
  「サイトごとの元を並べた族へ積を保つ写像を適用する」ことだけで、
  クロネッカー積の成分公式も、サイト間の可換性も使わない。
  `φ` が単位元を保つことも、`A` の結合律も使わない（人手の帰納法は `P_1 := E_1` から始まり、
  `P_{s+1} := P_sE_{s+1}` と右から 1 つずつ掛けるだけなので、積の付け替えが起きない）。
* **Pauli 行列の関係式**: `string_mem`・`local_mem` の仮定には `σ^x = -√-1 σ^y σ^z`、`P_m P_m = I`、反交換関係のいずれも現れない。
  `string_mem` は「`σ^z_m = P_m Z_m`」という**分解の形**しか使わない
  （具体版は `P_m P_m = I` からこの分解を導く。その `P_m P_m = I` の必要十分版が `string_mul_self` で、
  使うのは `σ^xσ^x = I` と相異なる番号どうしの可換性だけである）。
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
import Ising2D.NecSuf.FiniteProductLeft

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

section PrefixMem

variable {A : Type*} [Monoid A] {S : Submonoid A} {p xl : ℕ → A} {N : ℕ}

/-- **原文 Step 2 の `P_{m-1} ∈ 𝒜` の `r` の帰納法（必要十分版）**: `j < r` の `xl j` が `S` に属するなら `p r ∈ S`。
具体版 `Ising2D.sigmaXPrefixProduct_mem_adjoin` と同じ手順（`p 0 = 1` と `one_mem`、`p (r+1) = p r * xl r` と `mul_mem`）。
使うのは `S` が単位元と積で閉じること（部分モノイド）と漸化式だけで、加法もスカラー倍も使わない。 -/
theorem string_mem_of_previous (hp0 : p 0 = 1) (hp : ∀ n, n < N → p (n + 1) = p n * xl n)
    (r : ℕ) (hr : r ≤ N) (h : ∀ j, j < r → xl j ∈ S) : p r ∈ S := by
  induction r with
  | zero =>
      rw [hp0]
      exact one_mem S
  | succ r ih =>
      have hrN : r < N := hr
      rw [hp r hrN]
      exact mul_mem (ih (le_of_lt hrN) (fun j hj => h j (Nat.lt_succ_of_lt hj))) (h r (Nat.lt_succ_self r))

end PrefixMem

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

/-- **原文 Step 2 の外側の帰納法の一段（必要十分版）**: `j < n` の `xl j` が `S` に属するなら `zl n, yl n, xl n ∈ S`。
具体版 `Ising2D.sigma_mem_adjoin_of_previous_sigmaX` と同じ手順。 -/
theorem local_mem_of_previous (n : ℕ) (hn : n < N) (h : ∀ j, j < n → xl j ∈ S) :
    zl n ∈ S ∧ yl n ∈ S ∧ xl n ∈ S := by
  have hpn : p n ∈ S :=
    string_mem_of_previous (S := S.toSubsemiring.toSubmonoid) hp0 hp n (le_of_lt hn) h
  have hzln : zl n ∈ S := by
    rw [hzl n hn]; exact mul_mem hpn (hz n hn)
  have hyln : yl n ∈ S := by
    rw [hyl n hn]; exact mul_mem hpn (hy n hn)
  refine ⟨hzln, hyln, ?_⟩
  rw [hxl n hn]
  exact Subalgebra.smul_mem _ (mul_mem hyln hzln) _

/-- **原文 Step 2 の結論（必要十分版）**: 外側の累積帰納法で、局所元 `σ^z_n, σ^y_n, σ^x_n` はすべて `S` に属する。
具体版 `Ising2D.sigma_mem_adjoin_all` と同じ手順（`n = 0` は具体版 `sigma_mem_adjoin_first_site` と同じく
`zl 0 = z 0`・`yl 0 = y 0` を読む枝、`n ≥ 1` は `local_mem_of_previous`）。 -/
theorem local_mem : ∀ n : ℕ, n < N → zl n ∈ S ∧ yl n ∈ S ∧ xl n ∈ S := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
      intro hn
      rcases n with _ | n
      · -- 人手の `m = 1`: `zl 0 = z 0`・`yl 0 = y 0`（`p 0 = 1`）と `xl 0 = r • (yl 0 * zl 0)`
        have hz0 : zl 0 = z 0 := by rw [hzl 0 hn, hp0, one_mul]
        have hy0 : yl 0 = y 0 := by rw [hyl 0 hn, hp0, one_mul]
        have hzm : zl 0 ∈ S := by rw [hz0]; exact hz 0 hn
        have hym : yl 0 ∈ S := by rw [hy0]; exact hy 0 hn
        refine ⟨hzm, hym, ?_⟩
        rw [hxl 0 hn]
        exact Subalgebra.smul_mem _ (mul_mem hym hzm) _
      · exact local_mem_of_previous hp0 hzl hyl hxl hp hz hy (n + 1) hn
          (fun j hj => (ih j hj (lt_trans hj hn)).2.2)

/-- 文字列 `p n` は部分多元環 `S` に属する（`string_mem_of_previous` に `local_mem` の結論を渡したもの）。 -/
theorem string_mem (n : ℕ) (hn : n ≤ N) : p n ∈ S :=
  string_mem_of_previous (S := S.toSubsemiring.toSubmonoid) hp0 hp n hn
    (fun j hj => (local_mem hp0 hzl hyl hxl hp hz hy j (lt_of_lt_of_le hj hn)).2.2)

end StringInduction

/-! ## Step 2 の準備: 可換の式と二乗の式

人手 Step 2 の `P_0 := I`・`P_r := P_{r-1}σ_r^x` に対する可換の式 `σ_k^xP_r = P_rσ_k^x`（`r < k`）と
二乗の式 `P_rP_r = I` を、同じ帰納法のまま取り出す。添字は 0 始まりで、人手の `σ_{r+1}^x` が `x r`、
人手の `P_r` が `p r` である（人手の `k` は `k + 1`、条件 `r ≤ k - 1` は `r ≤ k`）。

使うのは次だけである。
* `A` が**モノイド**であること: 結合則（`mat_mult_associative` の段）と単位元の両側の単位性
  （`identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult` の段）。
  加法・スカラー倍・`A` の乗法の可換性は使わない。
* `x n * x n = 1`（人手 Step 1 の `σ_k^xσ_k^x = I`）。
* 相異なる番号どうしの可換性 `x k * x n = x n * x k`（`distinct_site_pauli_matrices_commute` の段。等式が `k` と `n` について対称なので、
  `n < k` の形で書いた）。

削れないもの: `x n * x n = 1` を外すと `N = 1` の `x 0 = 2`（`A = ℕ` の乗法）で `p 1 * p 1 = 4 ≠ 1` となり偽になる。
可換性を外すと、`x 0 * x 0 = x 1 * x 1 = 1` で可換でない 2 元（3 文字の置換の 2 つの互換）で `p 2 * p 2 = (x 0 * x 1)^2 ≠ 1` となり偽になる。
結合則は鎖の括弧の付け替えの段（`mat_mult_associative` の段）そのものに使うので、`Monoid` の構造として仮定する。
外すと偽になるかは確かめていない（状態台帳の件 (cl3c3j8n2d3d4c44p14)）。 -/

section StringSquare

variable {A : Type*} [Monoid A] {p x : ℕ → A} {N : ℕ}
variable (hp0 : p 0 = 1)
variable (hp : ∀ n, n < N → p (n + 1) = p n * x n)

include hp0 hp

/-- **人手 Step 2 の可換の式（必要十分版）**: `k < N` と `r ≤ k` について `x k * p r = p r * x k`。
`r = 0` の 4 行と一段の 7 行は具体版 `Ising2D.sigmaX_mul_sigmaXPrefixProduct_comm` と同じ順。 -/
theorem xl_mul_string_comm (hcomm : ∀ k n, k < N → n < k → x k * x n = x n * x k)
    (k : ℕ) (hk : k < N) : ∀ r : ℕ, r ≤ k → x k * p r = p r * x k
  | 0, _ =>
    calc x k * p 0
        = x k * 1 := by rw [hp0]                  -- `P_0` の定義
      _ = x k := mul_one _                         -- 右の単位元
      _ = 1 * x k := (one_mul _).symm              -- 左の単位元を右辺から左辺へ
      _ = p 0 * x k := by rw [hp0]                 -- `P_0` の定義を右辺から左辺へ
  | r + 1, hr => by
    have hrN : r < N := lt_of_lt_of_le (Nat.lt_of_succ_le hr) (le_of_lt hk)
    have ih := xl_mul_string_comm hcomm k hk r (Nat.le_of_succ_le hr)
    calc x k * p (r + 1)
        = x k * (p r * x r) := by rw [hp r hrN]    -- `P_{r+1}` の定義
      _ = (x k * p r) * x r := (mul_assoc _ _ _).symm      -- 結合則を右辺から左辺へ
      _ = (p r * x k) * x r := by rw [ih]                 -- 帰納法の仮定
      _ = p r * (x k * x r) := mul_assoc _ _ _             -- 結合則
      _ = p r * (x r * x k) := by rw [hcomm k r hk (Nat.lt_of_succ_le hr)]  -- 相異なる番号どうしの可換性
      _ = (p r * x r) * x k := (mul_assoc _ _ _).symm      -- 結合則を右辺から左辺へ
      _ = p (r + 1) * x k := by rw [hp r hrN]              -- `P_{r+1}` の定義を右辺から左辺へ

/-- **人手 Step 2 の二乗の式（必要十分版）**: `r ≤ N` について `p r * p r = 1`。
`r = 0` の 2 行と一段の 8 行は具体版 `Ising2D.sigmaXPrefixProduct_mul_self` と同じ順。 -/
theorem string_mul_self (hxx : ∀ n, n < N → x n * x n = 1)
    (hcomm : ∀ k n, k < N → n < k → x k * x n = x n * x k) :
    ∀ r : ℕ, r ≤ N → p r * p r = 1
  | 0, _ =>
    calc p 0 * p 0
        = 1 * 1 := by rw [hp0]                     -- `P_0` の定義を 2 か所へ
      _ = 1 := one_mul _                            -- 左の単位元
  | r + 1, hr => by
    have hrN : r < N := Nat.lt_of_succ_le hr
    have ih := string_mul_self hxx hcomm r (le_of_lt hrN)
    have hc := xl_mul_string_comm hp0 hp hcomm r hrN r le_rfl
    calc p (r + 1) * p (r + 1)
        = (p r * x r) * (p r * x r) := by rw [hp r hrN]   -- `P_{r+1}` の定義を 2 か所へ
      _ = p r * (x r * (p r * x r)) := mul_assoc _ _ _     -- 結合則
      _ = p r * ((x r * p r) * x r) := by rw [mul_assoc (x r)]  -- 結合則を右辺から左辺へ
      _ = p r * ((p r * x r) * x r) := by rw [hc]          -- 可換の式（人手の `k → r+1`）
      _ = p r * (p r * (x r * x r)) := by rw [mul_assoc (p r) (x r)]  -- 結合則
      _ = p r * (p r * 1) := by rw [hxx r hrN]             -- `x r * x r = 1`
      _ = p r * p r := by rw [mul_one]                     -- 右の単位元
      _ = 1 := ih                                          -- 帰納法の仮定

end StringSquare

/-! ## Step 2 の準備: 積の表示

人手 Step 2 の `P_0 := I`・`P_r := P_{r-1}σ_r^x` に対する積の表示 `P_r = ∏_{j=1}^{r}σ_j^x`（`r ≥ 1`）を、同じ帰納法のまま取り出す。
添字は 0 始まりで、人手の `σ_{r+1}^x` が `x r`、人手の `P_r` が `p r`、人手の `∏_{j=1}^{r+1}` が `finProdLeft r` である。

使うのは次だけである。
* 二項演算 `*` と元 `1`（`P_0 := I` と漸化式を書くため）。結合則は使わない（漸化式と有限積の定義はどちらも右から 1 つずつ掛けるので、括弧の付け替えが起きない）。
* `1 * x 0 = x 0`（`r = 1` の段の `identity_matrix_is_left_unit_of_mat_mult`（`A → σ_1^x`））。`1` が `x 0` 以外の元の左の単位元であること、
  右の単位元であることは使わない。

削れないもの: `1 * x 0 = x 0` は、`0 < N` のとき主張の `r = 0` の場合 `p 1 = finProdLeft 0 x`、すなわち
`1 * x 0 = x 0`（`p 1 = p 0 * x 0 = 1 * x 0` と `finProdLeft 0 x = x 0`）そのものなので、外せない。
`N = 0` のときは主張が空で、この仮定も使わない（具体版は `r < M` の範囲だけを述べ、`M = 0` で `σ_1^x` が無いのと同じ）。 -/

section StringProduct

variable {A : Type*} [Mul A] [One A] {p x : ℕ → A} {N : ℕ}

/-- **人手 Step 2 の積の表示（必要十分版）**: `r < N` について `p (r + 1) = finProdLeft r (fun j => x j)`。
`r = 0`（人手の `r = 1`）の 4 行と一段の 3 行は具体版 `Ising2D.sigmaXPrefixProduct_eq_finiteMatrixProduct` と同じ順。 -/
theorem string_eq_finProdLeft (hp0 : p 0 = 1) (hp : ∀ n, n < N → p (n + 1) = p n * x n)
    (h1 : 1 * x 0 = x 0) : ∀ r : ℕ, r < N → p (r + 1) = finProdLeft r (fun j => x j)
  | 0, hN =>
    calc p (0 + 1)
        = p 0 * x 0 := hp 0 hN                    -- `P_1` の定義
      _ = 1 * x 0 := by rw [hp0]                   -- `P_0` の定義
      _ = x 0 := h1                                -- `1 * x 0 = x 0`
      _ = finProdLeft 0 (fun j => x j) := by rw [finProdLeft_zero]; rfl   -- 有限積の初項を右辺から左辺へ
  | r + 1, hN =>
    calc p (r + 1 + 1)
        = p (r + 1) * x (r + 1) := hp (r + 1) hN   -- `P_{r+1}` の定義
      _ = finProdLeft r (fun j => x j) * x (r + 1) := by
          rw [string_eq_finProdLeft hp0 hp h1 r (Nat.lt_of_succ_lt hN)]   -- 帰納法の仮定
      _ = finProdLeft (r + 1) (fun j => x j) := by rw [finProdLeft_succ]; rfl   -- 有限積の漸化式を右辺から左辺へ

end StringProduct

end NecSuf
end Ising2D
