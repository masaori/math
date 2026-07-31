/-
# 必要十分版: 「基底を全部含む部分多元環は全体」と「サイトごとの元の積は部分多元環に入る」

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル: **`<Z_Y_generate_algebra>`**
（`parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ`。
具体版は `Ising2D/Part004/Claim014_ZYGenerateAlgebra.lean` の
`Ising2D.Z_Y_generate_algebra`、特殊化による導出は
`Ising2D/Part004/Claim014_ZYGenerateAlgebraFromNecSuf.lean`）。

## 何を抽象化したか

原文の証明は 3 段からなる。本ファイルはそのうち **Step 2 と Step 3 の骨格**を、
行列・複素数・テンソル積・Pauli 行列・2×2 のいずれにも依存しない形で取り出す。

| 原文 | 本ファイル | 効いている構造 |
| --- | --- | --- |
| Step 3「基底を全部含むから全体」 | `eq_top_of_span_eq_top`, `eq_top_of_basis_mem` | 可換半環上の代数と部分多元環（＝積で閉じた部分加群）だけ |
| Step 3「線型に分解して載せる」 | `map_mem_of_span_eq_top` | 写像が `R`-線型であることだけ |
| Step 3「単項テンソルの積」 | `map_mem_of_mulSingle_mem` | 有限添字の直積モノイドからの**モノイド準同型**であることだけ |
| Step 2「Jordan–Wigner 文字列の帰納法」 | `string_mem`, `local_mem` | 文字列の漸化式と、局所元が「文字列 × 生成元」で書けることだけ |

### 効いていないもの（一次情報: 下の証明が使っている補題がすべて）

* **行列であること**: どの証明にも行列の成分・行列積・転置は現れない。
* **係数が ℂ であること**: `R` は任意の可換半環でよい。`Complex.I` に相当する係数は
  `string_mem` の `r : R` として抽象化されており、その値は一切使われない
  （`Subalgebra.smul_mem` にそのまま渡すだけ）。
* **テンソル積であること**: `map_mem_of_mulSingle_mem` が使うのは
  「サイトごとの元を並べた族へ準同型を適用する」ことだけで、
  クロネッカー積の成分公式も、サイト間の可換性も使わない
  （非可換な `A` でも、`Pi.mulSingle` 同士は直積モノイドの中で自動的に可換になるため、
  実際にはサイトごとの分解の順序を気にする必要がない）。
* **Pauli 行列の関係式**: `σ^x = -√-1 σ^y σ^z`、`P_m P_m = I`、反交換関係のいずれも仮定に現れない。
  `string_mem` は「`σ^z_m = P_m Z_m`」という**分解の形**しか使わない
  （具体版は `P_m P_m = I` からこの分解を導くが、分解を仮定してしまえば対合性は不要である）。
* **各サイトの次元が 2 であること**: どこにも 2 は現れない。
* **添字が `Fin M` であること**: `map_mem_of_mulSingle_mem` の添字型は
  等号判定可能な任意の有限型でよく、各サイトのモノイドはサイトごとに違ってよい。

Step 2 の抽象化で唯一残る「線型性への依存」は `σ^x_m = -√-1 σ^y_m σ^z_m` の係数だけであり、
これは `Subalgebra` が加群構造をもつことで吸収される。つまり Step 2 に本質的なのは
**「部分多元環がスカラー倍で閉じていること」**であって、複素数体であることではない。
-/
import Mathlib.Algebra.Algebra.Subalgebra.Basic
import Mathlib.Algebra.Algebra.Subalgebra.Lattice
import Mathlib.Algebra.Group.Pi.Basic
import Mathlib.Data.Finset.Piecewise
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

/-- 上の系: 部分多元環が**基底**を全部含めば全体である。
基底の添字型 `ι` は任意でよい。 -/
theorem eq_top_of_basis_mem {ι : Type*} (S : Subalgebra R A) (b : Module.Basis ι R A)
    (h : ∀ i, b i ∈ S) : S = ⊤ :=
  eq_top_of_span_eq_top S (by rintro _ ⟨i, rfl⟩; exact h i) b.span_eq

/-- **原文 Step 3 前半の骨格**: `R`-線型写像 `f` が生成系 `s` を `S` の中へ送るなら、
`f` の像はすべて `S` に入る。

具体版では「任意の `B ∈ Mat(2, ℂ)` を第 `k` 因子に載せた `siteOp k B` が `𝒜` に入る」に当たる。
効いているのは `f` の線型性と `S` が部分加群であることだけである。 -/
theorem map_mem_of_span_eq_top {V : Type*} [AddCommMonoid V] [Module R V]
    (S : Subalgebra R A) (f : V →ₗ[R] A) {s : Set V}
    (hspan : Submodule.span R s = ⊤) (h : ∀ v ∈ s, f v ∈ S) (v : V) : f v ∈ S := by
  have hle : Submodule.span R s ≤ (Subalgebra.toSubmodule S).comap f := by
    refine Submodule.span_le.2 fun x hx => ?_
    exact h x hx
  rw [hspan] at hle
  exact hle Submodule.mem_top

end SpanTop

/-! ## (b) サイトごとの元の積は、各サイト単独の元を含む部分モノイドに属する -/

section SiteProduct

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {N : ι → Type*} [∀ i, Monoid (N i)]
variable {A : Type*} [Monoid A]

omit [Fintype ι] in
/-- 有限集合 `s` に台をもつ族の分解: `k ∉ s` なら
`(insert k s).piecewise x 1 = mulSingle k (x k) * s.piecewise x 1`。 -/
theorem piecewise_insert_eq_mulSingle_mul (x : ∀ i, N i) {k : ι} {s : Finset ι} (hk : k ∉ s) :
    (insert k s).piecewise x (1 : ∀ i, N i)
      = Pi.mulSingle k (x k) * s.piecewise x (1 : ∀ i, N i) := by
  funext i
  by_cases hik : i = k
  · subst hik
    simp [hk]
  · rw [Pi.mul_apply, Pi.mulSingle_eq_of_ne hik, one_mul]
    by_cases his : i ∈ s <;> simp [hik, his]

/-- **原文 Step 3 後半の骨格**: モノイド準同型 `φ` が「1 サイトだけ動かした族」`mulSingle k (x k)`
をすべて部分モノイド `S` へ送るなら、任意の族 `x` に対して `φ x ∈ S`。

具体版では `φ = siteProd`、`φ (mulSingle k A) = siteOp k A` であり、
「単項テンソル `A_1 ⊗ ⋯ ⊗ A_M` が、各因子をサイト作用素として含む部分多元環に属する」に当たる。

効いているのは **`φ` がモノイド準同型であること**だけである。
サイトのモノイド `N i` はサイトごとに違ってよく、`A` は非可換でよい。 -/
theorem map_mem_of_mulSingle_mem (φ : (∀ i, N i) →* A) (S : Submonoid A) (x : ∀ i, N i)
    (h : ∀ k, φ (Pi.mulSingle k (x k)) ∈ S) : φ x ∈ S := by
  have key : ∀ s : Finset ι, φ (s.piecewise x 1) ∈ S := by
    intro s
    induction s using Finset.induction_on with
    | empty =>
        rw [Finset.piecewise_empty, map_one]
        exact one_mem S
    | @insert k s hk ih =>
        rw [piecewise_insert_eq_mulSingle_mul x hk, map_mul]
        exact mul_mem (h k) ih
  have huniv := key Finset.univ
  rwa [Finset.piecewise_univ] at huniv

/-- 部分多元環版（`Subalgebra` は部分モノイドでもあるので、そのまま移す）。 -/
theorem map_mem_subalgebra_of_mulSingle_mem {R B : Type*} [CommSemiring R] [Semiring B]
    [Algebra R B] {M : ι → Type*} [∀ i, Monoid (M i)]
    (φ : (∀ i, M i) →* B) (S : Subalgebra R B) (x : ∀ i, M i)
    (h : ∀ k, φ (Pi.mulSingle k (x k)) ∈ S) : φ x ∈ S :=
  map_mem_of_mulSingle_mem φ S.toSubmonoid x h

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
