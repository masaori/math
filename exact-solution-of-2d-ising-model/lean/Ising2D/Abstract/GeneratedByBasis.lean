/-
# 抽象版: 基底を全部含む部分多元環は全体／サイト積は部分モノイドへ持ち上がる

**このファイルには抽象版だけを置く。抽象版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル:

| 人手証明のラベル | 具体版（複素行列） |
| --- | --- |
| `Z_Y_generate_algebra` | `Ising2D/Part004/Claim014_ZYGenerateAlgebra.lean` の
  `Ising2D.Z_Y_generate_algebra` |

具体版を本ファイルの抽象版の特殊化として導出したものは
`Ising2D/Part004/Claim014_ZYGenerateAlgebraAbstract.lean` にある。

## 抽象版が何を明らかにするか

原文の証明は 3 つの Step からなる。そのうち骨格として抽象化できるのは次の 3 つで、
いずれも**行列であること・複素数であること・2×2 であること・クロネッカー積であること・
Pauli 行列の成分**を一切使わない。

1. `eq_top_of_span_subset` / `eq_top_of_basis_mem`（原文 Step 3 後半の論法）
   — 効いているのは「部分多元環が係数のスカラー倍と和で閉じた部分加群でもある」ことだけ。
   係数は**任意の可換半環**でよく、体である必要も、標数 0 である必要もない。
   基底である必要すらなく、**線型に張ること**だけが要る。
2. `map_mem_of_update_mem`（原文 Step 3 の「単項テンソルは各因子から作れる」）
   — 効いているのは、サイトごとの族から 1 つの元を作る写像が
   **モノイド準同型であること**と**サイトの添字が有限で等号判定可能であること**だけ。
   加法もスカラー倍も台の環構造も使わない（`Monoid` で足りる）。
3. `string_mem`（原文 Step 2 の Jordan–Wigner 文字列の帰納法）
   — 効いているのは、部分多元環が `1`・積・スカラー倍で閉じていることと、
   **文字列が 1 段ずつ「直前の文字列と生成元だけ」で書けること**だけ。
   `P_{m-1} P_{m-1} = I` すら抽象版の仮定には現れない（具体版で `hstep` を作るときに使うだけ）。

抽象化できないのは原文 Step 3 前半（`{I, σ^x, σ^y, σ^z}` が `Mat(2, ℂ)` を張ること）で、
これは 2×2 複素行列の成分比較そのものである（`Ising2D.matrix_two_decomp`）。
詳細は `lean/docs/abstract-zy-generate.md` を参照。
-/
import Mathlib.Algebra.Algebra.Subalgebra.Basic
import Mathlib.LinearAlgebra.Basis.Basic

namespace Ising2D.Abstract

/-! ## 骨格 1: ある集合が全体を張るなら、それを含む部分多元環は全体

原文 Step 3 後半「`𝒜` は線型結合で閉じており、基底を全部含むから `𝒜 = Mat(2, ℂ)^{⊗M}`」。 -/

section SpanTop

variable {R B : Type*} [CommSemiring R] [Semiring B] [Algebra R B]

/-- **原文 Step 3 後半の論法の抽象版（張る集合の版）**:
部分多元環 `T` が、全体を線型に張る集合 `s` を含めば `T = ⊤`。

効いているのは「部分多元環は係数のスカラー倍と和で閉じている」ことだけで、
係数 `R` は**任意の可換半環**、台 `B` は**任意の `R`-代数**でよい。 -/
theorem eq_top_of_span_subset (T : Subalgebra R B) {s : Set B}
    (hspan : Submodule.span R s = ⊤) (hs : s ⊆ (T : Set B)) : T = ⊤ := by
  have hle : Submodule.span R s ≤ Subalgebra.toSubmodule T := Submodule.span_le.2 hs
  rw [hspan] at hle
  exact eq_top_iff.2 fun v _ => hle Submodule.mem_top

/-- **原文 Step 3 後半の論法の抽象版（基底の版）**:
部分多元環 `T` が基底の元を全部含めば `T = ⊤`。

「基底」であることのうち効いているのは**張ること**だけ（一次独立性は使わない）。 -/
theorem eq_top_of_basis_mem {ι : Type*} (T : Subalgebra R B) (b : Basis ι R B)
    (h : ∀ i, b i ∈ T) : T = ⊤ :=
  eq_top_of_span_subset T b.span_eq (by rintro _ ⟨i, rfl⟩; exact h i)

end SpanTop

/-! ## 骨格 2: サイトごとの積は、各サイト単独の元を含む部分モノイドに属する

原文 Step 3 の「`σ_1^{a_1} ⋯ σ_M^{a_M} = e_1 ⊗ ⋯ ⊗ e_M`」（異サイト因子の積公式の反復）。 -/

section SiteProd

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {A B : Type*} [Monoid A] [Monoid B]

/-- **原文 Step 3 の「単項テンソルは各因子から作れる」の抽象版**:
サイトごとの族から 1 つの元を作る写像 `P` が**モノイド準同型**でありさえすれば、
各サイト単独の元 `P (1, …, x k, …, 1)` を全部含む部分モノイド `T` は `P x` を含む。

具体版では `P = siteProd M`（クロネッカー積）、`P (1, …, x k, …, 1) = siteOp k (x k)` だが、
**多重線型性も加法もスカラー倍も台の環構造も使わない**。
必要なのはサイトの添字型が有限で等号判定可能であること（サイトの有限集合に関する帰納法）だけ。 -/
theorem map_mem_of_update_mem (P : (ι → A) →* B) (T : Submonoid B) (x : ι → A)
    (h : ∀ k, P (Function.update 1 k (x k)) ∈ T) : P x ∈ T := by
  classical
  have aux : ∀ s : Finset ι, P (fun i => if i ∈ s then x i else 1) ∈ T := by
    intro s
    induction s using Finset.induction_on with
    | empty =>
        have h0 : (fun i : ι => if i ∈ (∅ : Finset ι) then x i else 1) = 1 := by
          funext i; simp
        rw [h0, map_one]
        exact one_mem T
    | @insert k s hk ih =>
        have hstep : (fun i => if i ∈ insert k s then x i else 1)
            = Function.update (1 : ι → A) k (x k) * (fun i => if i ∈ s then x i else 1) := by
          funext i
          simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply, Finset.mem_insert]
          by_cases hik : i = k
          · subst hik
            simp [hk]
          · by_cases his : i ∈ s <;> simp [hik, his]
        rw [hstep, map_mul]
        exact mul_mem (h k) ih
  have hall : (fun i : ι => if i ∈ (Finset.univ : Finset ι) then x i else 1) = x := by
    funext i; simp
  have huniv := aux Finset.univ
  rwa [hall] at huniv

end SiteProd

/-! ## 骨格 3: Jordan–Wigner 文字列の帰納法

原文 Step 2「`P_{m-1} ∈ 𝒜` を仮定して `σ^z_m = P_{m-1} Z_m`, `σ^y_m = P_{m-1} Y_m`,
`σ^x_m = -√-1 σ^y_m σ^z_m` を得て `P_m = P_{m-1} σ^x_m ∈ 𝒜`」。 -/

section String

variable {R A : Type*} [CommSemiring R] [Semiring A] [Algebra R A]

/-- **原文 Step 2 の帰納法の抽象版**:
文字列 `p : ℕ → A` が `p 0 = 1` から始まり、各段で
`p (n+1) = p n * (c n • ((p n * y n) * (p n * z n)))` の形に書けるなら、
生成元 `y n, z n` を含む部分多元環 `T` は文字列を全部含む。

具体版では `p = xString M`（`P_m = σ^x_1 ⋯ σ^x_m`）、`y = Y`, `z = Z`, `c = -√-1` で、
仮定 `hstep` の中身は `σ^x_m = -√-1 (P_{m-1} Y_m)(P_{m-1} Z_m)` である。

効いているのは `T` が `1`・積・スカラー倍で閉じていることだけで、
`P_{m-1} P_{m-1} = I` も Pauli 行列の関係式も抽象版の仮定には現れない
（それらは具体版で `hstep` を作るときにだけ使う）。 -/
theorem string_mem (T : Subalgebra R A) (N : ℕ) (p y z : ℕ → A) (c : ℕ → R)
    (h0 : p 0 = 1)
    (hy : ∀ n, n < N → y n ∈ T) (hz : ∀ n, n < N → z n ∈ T)
    (hstep : ∀ n, n < N → p (n + 1) = p n * (c n • ((p n * y n) * (p n * z n)))) :
    ∀ n, n ≤ N → p n ∈ T := by
  intro n
  induction n with
  | zero =>
      intro _
      rw [h0]
      exact one_mem T
  | succ n ih =>
      intro hn
      have hnN : n < N := hn
      have hp : p n ∈ T := ih (le_of_lt hnN)
      rw [hstep n hnN]
      exact mul_mem hp
        (Subalgebra.smul_mem _
          (mul_mem (mul_mem hp (hy n hnN)) (mul_mem hp (hz n hnN))) _)

end String

end Ising2D.Abstract
