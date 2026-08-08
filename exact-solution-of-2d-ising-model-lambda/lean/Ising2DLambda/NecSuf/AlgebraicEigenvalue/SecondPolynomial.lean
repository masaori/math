/-
人手証明の 4 主張（ラベル `claim_second_degree_sum` / `claim_second_degree_prod` /
`claim_second_monic_prod` / `claim_second_monic_add_lower`）の必要十分版。

人手証明は係数環を ℤ[x] に固定して述べている。この証明が実際に使っているのは次だけである。

  * 係数環が半環であること（和と積、零元と単位元。**引き算を一度も使っていない**）。
  * 和の係数が係数の和であること、積の係数が畳み込みであること。
    これは多項式環の演算の定義そのものであって、係数環に何かを要求するものではない。

したがって仮定は次のように削れる。

  * 係数が整数であること・不定元 x があること・ℤ[x] が整域（零因子が無い）であること: 不要。
    とくに零因子が無いことを使っていないのは、次数についての主張が上界の形であり、
    モニック性についての主張が「最高次の係数が単位元である」ことから直接に出るためである。
  * 引き算（環であること）: 不要。半環で足りる。
  * 積の可換性: **2 つの元についての補題（`degLe_mul` / `monicDeg_mul`）には不要**であり、
    ここでは `[Semiring S]` のままで証明してある。有限個の版
    （`degLe_prod` / `monicDeg_prod`）だけは `[CommSemiring S]` を仮定するが、これは
    mathlib の有限積 `∏ s ∈ S, f s` が可換モノイドにしか定義されていないという記法上の
    都合であって、議論のどのステップも可換性を使っていない。

削れなかった仮定は「係数環が半環であること」だけである。これは多項式環 `Polynomial S` を
作るために mathlib が要求する最小の構造であり、削ると主張を述べる場所そのものが無くなる。

住処: ℕ と抽象的な半環のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {S : Type*}

section Semiring

variable [Semiring S]

/-- 人手証明の `D_n`（次数が `n` 以下である元の全体）。 -/
def DegLe (f : Polynomial S) (n : ℕ) : Prop := ∀ k : ℕ, n < k → f.coeff k = 0

/-- 人手証明の `M_n`（モニックな次数 `n` の元の全体）。 -/
def MonicDeg (f : Polynomial S) (n : ℕ) : Prop := DegLe f n ∧ f.coeff n = 1

/-- 人手証明の主張「次数の上界は有限積で足し合わされる」の準備（2 つの元の積）。

`k > m + n` を満たす `k` について、畳み込みの各項が `0` になることを見る。
`i > m` なら左の因子が `0`、`i ≤ m` なら `k - i > n` で右の因子が `0`。
積の可換性は使っていない。 -/
theorem degLe_mul {f g : Polynomial S} {m n : ℕ} (hf : DegLe f m) (hg : DegLe g n) :
    DegLe (f * g) (m + n) := by
  intro k hk
  rw [Polynomial.coeff_mul]
  refine Finset.sum_eq_zero ?_
  intro p hp
  have hsum : p.1 + p.2 = k := Finset.mem_antidiagonal.mp hp
  by_cases hi : m < p.1
  · rw [hf p.1 hi, zero_mul]
  · have hp2 : n < p.2 := by omega
    rw [hg p.2 hp2, mul_zero]

/-- 人手証明の主張「モニックな元の有限積はモニックである」の準備（2 つの元の積）。

畳み込みのうち `i = m` の項だけが残ることを見る（`i > m` なら左が `0`、
`i < m` なら `m + n - i > n` で右が `0`）。引き算も零因子の非存在も使っていない。 -/
theorem monicDeg_mul {f g : Polynomial S} {m n : ℕ} (hf : MonicDeg f m) (hg : MonicDeg g n) :
    MonicDeg (f * g) (m + n) := by
  refine ⟨degLe_mul hf.1 hg.1, ?_⟩
  rw [Polynomial.coeff_mul]
  rw [Finset.sum_eq_single_of_mem (m, n) (Finset.mem_antidiagonal.mpr rfl)]
  · rw [hf.2, hg.2, one_mul]
  · intro p hp hne
    have hsum : p.1 + p.2 = m + n := Finset.mem_antidiagonal.mp hp
    have hi : p.1 ≠ m := by
      intro h
      exact hne (Prod.ext h (by omega))
    by_cases hlt : m < p.1
    · rw [hf.1 p.1 hlt, zero_mul]
    · have hp2 : n < p.2 := by omega
      rw [hg.1 p.2 hp2, mul_zero]

/-- 人手証明の主張「モニックな元に次数の低い元を足してもモニックである」。 -/
theorem monicDeg_add_of_degLe {f g : Polynomial S} {n n' : ℕ}
    (hf : MonicDeg f n) (hg : DegLe g n') (hlt : n' < n) : MonicDeg (f + g) n := by
  refine ⟨?_, ?_⟩
  · intro k hk
    rw [Polynomial.coeff_add, hf.1 k hk, hg k (hlt.trans hk), add_zero]
  · rw [Polynomial.coeff_add, hf.2, hg n hlt, add_zero]

/-- 人手証明の主張「次数が `n` 以下である元の有限和は、次数が `n` 以下である」。

有限和なので添字の型に何も要求しない（可換性は和の側にもとから入っている）。 -/
theorem degLe_sum {ι : Type*} {T : Finset ι} {f : ι → Polynomial S} {n : ℕ}
    (h : ∀ s ∈ T, DegLe (f s) n) : DegLe (∑ s ∈ T, f s) n := by
  intro k hk
  rw [Polynomial.finsetSum_coeff]
  exact Finset.sum_eq_zero fun s hs => h s hs k hk

end Semiring

section CommSemiring

variable [CommSemiring S]

/-- 人手証明の主張「次数の上界は有限積で足し合わされる」。

`T` の元の個数についての帰納法。空積は単位元で、`k > 0` のとき係数が `0` である。
可換性を使うのは `∏ s ∈ T, f s` という記法のためだけである。 -/
theorem degLe_prod {ι : Type*} {f : ι → Polynomial S} {n : ι → ℕ} {T : Finset ι}
    (h : ∀ s ∈ T, DegLe (f s) (n s)) : DegLe (∏ s ∈ T, f s) (∑ s ∈ T, n s) := by
  classical
  induction T using Finset.induction_on with
  | empty =>
      intro k hk
      rw [Finset.prod_empty]
      have : k ≠ 0 := by simpa using hk.ne'
      simp [Polynomial.coeff_one, this]
  | insert s₀ T' hs₀ ih =>
      rw [Finset.prod_insert hs₀, Finset.sum_insert hs₀]
      exact degLe_mul (h s₀ (Finset.mem_insert_self _ _))
        (ih fun s hs => h s (Finset.mem_insert_of_mem hs))

/-- 人手証明の主張「モニックな元の有限積はモニックであり、その次数は次数の和である」。 -/
theorem monicDeg_prod {ι : Type*} {f : ι → Polynomial S} {n : ι → ℕ} {T : Finset ι}
    (h : ∀ s ∈ T, MonicDeg (f s) (n s)) : MonicDeg (∏ s ∈ T, f s) (∑ s ∈ T, n s) := by
  classical
  induction T using Finset.induction_on with
  | empty =>
      refine ⟨?_, ?_⟩
      · intro k hk
        rw [Finset.prod_empty]
        have : k ≠ 0 := by simpa using hk.ne'
        simp [Polynomial.coeff_one, this]
      · rw [Finset.prod_empty, Finset.sum_empty, Polynomial.coeff_one_zero]
  | insert s₀ T' hs₀ ih =>
      rw [Finset.prod_insert hs₀, Finset.sum_insert hs₀]
      exact monicDeg_mul (h s₀ (Finset.mem_insert_self _ _))
        (ih fun s hs => h s (Finset.mem_insert_of_mem hs))

end CommSemiring

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
