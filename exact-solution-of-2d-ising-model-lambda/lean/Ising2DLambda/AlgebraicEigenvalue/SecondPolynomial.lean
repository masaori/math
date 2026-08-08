/-
章「固有値の代数性」の「もう 1 つの不定元の多項式」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 4 件
（`def_second_polynomial_ring` / `def_second_constant_embedding` / `def_second_degree_bound` /
`def_second_monic`）と主張 4 件（`claim_second_degree_sum` / `claim_second_degree_prod` /
`claim_second_monic_prod` / `claim_second_monic_add_lower`）に対応する。

  人手証明                          このファイル
  ℤ[x][t]                           SecondPoly
  cf_k(f)                           f.coeff k
  κ(0) / κ(1)（ℤ[x] の零元・単位元） constPoly 0 / constPoly 1
  ι : ℤ[x] → ℤ[x][t]                constSecond
  D_n                               DegLe f n
  M_n                               MonicDeg f n
  次数 n 以下の元の有限和            degLe_sum
  次数の上界は有限積で足し合わさる  degLe_mul（準備）/ degLe_prod（本体）
  モニックな元の有限積              monicDeg_mul（準備）/ monicDeg_prod（本体）
  モニック + 低次                    monicDeg_add_of_degLe

不定元を `λ` と呼ばないのは人手証明と同じ理由である（`λ` は対数順序群 `Λ` の元を表す記号として
固定してある。Lean では加えて `λ` が関数記法の予約語でもある）。

`SecondPoly` は `Polynomial (Polynomial ℤ)` そのものである。人手証明が `ℤ[x]` を係数環とする
`t` の多項式環として導入しているので、ここでも係数環を `Polynomial ℤ` に固定する。
`Polynomial.coeff_add` / `Polynomial.coeff_mul` は多項式環の演算の定義（和の係数は係数の和、
積の係数は畳み込み）であり、人手証明がこの 2 つの等式だけを使うと述べていることに対応する。

`constSecond` は mathlib の `Polynomial.C` そのものである。人手証明が ℤ[x] の元と ℤ[x][t] の元を
同じ記号で書かないと約束しているので、ここでも自動強制に任せずこの名前を通す。

住処: 人手証明のこれらのブロックは ℤ を宣言している。ここに ℝ / ℂ は現れない
（係数は `Polynomial ℤ`、次数と添字は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.Determinant
import Mathlib.Algebra.Polynomial.Coeff

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 人手証明の `ℤ[x][t]`。`ℤ[x]` を係数環とする、もう 1 つの不定元の多項式環。 -/
abbrev SecondPoly := Polynomial (Polynomial ℤ)

/-- 人手証明の `ι : ℤ[x] → ℤ[x][t]`（`t` について定数である元を与える写像）。 -/
noncomputable def constSecond (a : Polynomial ℤ) : SecondPoly := Polynomial.C a

@[simp] lemma coeff_constSecond_zero (a : Polynomial ℤ) :
    (constSecond a).coeff 0 = a := by
  simp [constSecond]

@[simp] lemma coeff_constSecond_succ (a : Polynomial ℤ) (k : ℕ) :
    (constSecond a).coeff (k + 1) = 0 := by
  simp [constSecond]

lemma constSecond_constPoly_zero : constSecond (constPoly 0) = 0 := by
  simp [constSecond, constPoly_zero]

lemma constSecond_constPoly_one : constSecond (constPoly 1) = 1 := by
  simp [constSecond, constPoly_one]

/-- 人手証明の `D_n = { f | 任意の k について k > n ならば cf_k(f) = κ(0) }`。

次数を写像として定めていないのは人手証明と同じ理由である（零多項式の次数を決める約束が
要らなくなり、以下で必要になるのは上界だけである）。 -/
def DegLe (f : SecondPoly) (n : ℕ) : Prop := ∀ k : ℕ, n < k → f.coeff k = constPoly 0

/-- `κ(0)` は `ℤ[x]` の零元である（`constPoly_zero`）。以下の証明ではこの形で使う。 -/
theorem DegLe.coeff_eq_zero {f : SecondPoly} {n k : ℕ} (h : DegLe f n) (hk : n < k) :
    f.coeff k = 0 := by rw [h k hk, constPoly_zero]

/-- 人手証明の `M_n = { f ∈ D_n | cf_n(f) = κ(1) }`。 -/
def MonicDeg (f : SecondPoly) (n : ℕ) : Prop := DegLe f n ∧ f.coeff n = constPoly 1

/-- 人手証明の `D_n ⊂ D_{n'}`（`n ≤ n'` のとき）。 -/
theorem DegLe.mono {f : SecondPoly} {n n' : ℕ} (h : DegLe f n) (hn : n ≤ n') : DegLe f n' :=
  fun k hk => h k (lt_of_le_of_lt hn hk)

/-- 人手証明の主張「次数が `n` 以下である元の有限和は、次数が `n` 以下である」。

証明は人手証明どおり。`k > n` を取り、和の係数が係数の和であること
（`Polynomial.finsetSum_coeff`）から各項が `0` になることを見る。 -/
theorem degLe_sum {ι : Type*} {T : Finset ι} {f : ι → SecondPoly} {n : ℕ}
    (h : ∀ s ∈ T, DegLe (f s) n) : DegLe (∑ s ∈ T, f s) n := by
  intro k hk
  -- 第 1 の等号（和の係数は係数の和）。
  rw [constPoly_zero, Polynomial.finsetSum_coeff]
  -- 第 2・第 3 の等号（各項が κ(0) で、零元の有限和は零元）。
  exact Finset.sum_eq_zero fun s hs => (h s hs).coeff_eq_zero hk

/-- 人手証明の主張「次数の上界は有限積で足し合わされる」の準備（2 つの元の積）。 -/
theorem degLe_mul {f g : SecondPoly} {m n : ℕ} (hf : DegLe f m) (hg : DegLe g n) :
    DegLe (f * g) (m + n) := by
  intro k hk
  -- 積の係数は畳み込みである。
  rw [constPoly_zero, Polynomial.coeff_mul]
  refine Finset.sum_eq_zero ?_
  intro p hp
  have hsum : p.1 + p.2 = k := Finset.mem_antidiagonal.mp hp
  by_cases hi : m < p.1
  · -- i > m の場合。左の因子が κ(0)。
    rw [hf.coeff_eq_zero hi, zero_mul]
  · -- i ≤ m の場合。k - i ≥ k - m > n なので右の因子が κ(0)。
    have hp2 : n < p.2 := by omega
    rw [hg.coeff_eq_zero hp2, mul_zero]

/-- 人手証明の主張「次数の上界は有限積で足し合わされる」の本体（`T` の元の個数についての帰納法）。 -/
theorem degLe_prod {ι : Type*} {f : ι → SecondPoly} {n : ι → ℕ} {T : Finset ι}
    (h : ∀ s ∈ T, DegLe (f s) (n s)) : DegLe (∏ s ∈ T, f s) (∑ s ∈ T, n s) := by
  classical
  induction T using Finset.induction_on with
  | empty =>
      -- 空積は単位元 ι(κ(1)) であり、k > 0 のとき係数は 0。
      intro k hk
      rw [Finset.prod_empty]
      have hk0 : k ≠ 0 := by simpa using hk.ne'
      simp [Polynomial.coeff_one, hk0]
  | insert s₀ T' hs₀ ih =>
      -- 1 つの因子を括り出し、準備を当てる。
      rw [Finset.prod_insert hs₀, Finset.sum_insert hs₀]
      exact degLe_mul (h s₀ (Finset.mem_insert_self _ _))
        (ih fun s hs => h s (Finset.mem_insert_of_mem hs))

/-- 人手証明の主張「モニックな元の有限積はモニックである」の準備（2 つの元の積）。

畳み込みのうち `i = m` の項だけが残る。 -/
theorem monicDeg_mul {f g : SecondPoly} {m n : ℕ} (hf : MonicDeg f m) (hg : MonicDeg g n) :
    MonicDeg (f * g) (m + n) := by
  refine ⟨degLe_mul hf.1 hg.1, ?_⟩
  -- 第 1 の等号（積の係数は畳み込み）。
  rw [Polynomial.coeff_mul]
  -- 第 2 の等号（i ≠ m の項は 0）。
  rw [Finset.sum_eq_single_of_mem (m, n) (Finset.mem_antidiagonal.mpr rfl)]
  · -- 第 3・第 4 の等号（M の定義と、κ(1) が単位元であること）。
    rw [hf.2, hg.2, constPoly_one, one_mul]
  · intro p hp hne
    have hsum : p.1 + p.2 = m + n := Finset.mem_antidiagonal.mp hp
    have hi : p.1 ≠ m := fun h => hne (Prod.ext h (by omega))
    by_cases hlt : m < p.1
    · rw [hf.1.coeff_eq_zero hlt, zero_mul]
    · have hp2 : n < p.2 := by omega
      rw [hg.1.coeff_eq_zero hp2, mul_zero]

/-- 人手証明の主張「モニックな元の有限積はモニックであり、その次数は次数の和である」の本体。 -/
theorem monicDeg_prod {ι : Type*} {f : ι → SecondPoly} {n : ι → ℕ} {T : Finset ι}
    (h : ∀ s ∈ T, MonicDeg (f s) (n s)) : MonicDeg (∏ s ∈ T, f s) (∑ s ∈ T, n s) := by
  classical
  induction T using Finset.induction_on with
  | empty =>
      refine ⟨?_, ?_⟩
      · intro k hk
        rw [Finset.prod_empty]
        have hk0 : k ≠ 0 := by simpa using hk.ne'
        simp [Polynomial.coeff_one, hk0]
      · rw [Finset.prod_empty, Finset.sum_empty, Polynomial.coeff_one_zero, constPoly_one]
  | insert s₀ T' hs₀ ih =>
      rw [Finset.prod_insert hs₀, Finset.sum_insert hs₀]
      exact monicDeg_mul (h s₀ (Finset.mem_insert_self _ _))
        (ih fun s hs => h s (Finset.mem_insert_of_mem hs))

/-- 人手証明の主張「モニックな元に次数の低い元を足してもモニックである」。 -/
theorem monicDeg_add_of_degLe {f g : SecondPoly} {n n' : ℕ}
    (hf : MonicDeg f n) (hg : DegLe g n') (hlt : n' < n) : MonicDeg (f + g) n := by
  refine ⟨?_, ?_⟩
  · -- 第一（k > n の係数）。
    intro k hk
    rw [constPoly_zero, Polynomial.coeff_add, hf.1.coeff_eq_zero hk,
      hg.coeff_eq_zero (hlt.trans hk), add_zero]
  · -- 第二（t^n の係数）。
    rw [Polynomial.coeff_add, hf.2, hg.coeff_eq_zero hlt, add_zero]

end Ising2DLambda.AlgebraicEigenvalue
