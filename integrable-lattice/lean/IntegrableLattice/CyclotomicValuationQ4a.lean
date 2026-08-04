/-
# 補題 Q4a（$v_{\mathfrak l}(B(\omega_P))=\beta_P$）— cycle 33 step 1

対応する人手証明:

* 根拠 report: `outputs/reports/cycle21_T3_drop_assumption_B_star.md` §4（補題 Q4a）
* 台帳: `structured-latex/tools/formalization-coverage.ts` の `paper_106_theorem_drop_assumption`
* 同じ命題の他の段は `DropAssumptionBStar.lean`（組合せ・数え上げ）と
  `CrudeArchimedeanBound.lean`（補題 Q0）にある。

## 人手証明との対応

人手証明は 3 行である。

> $\chi^{v_i}(\omega_P)=\zeta^{\langle v_i,(a,b)\rangle}$。$\rho:=\rho_i(P)<M$ なら
> これは原始 $\ell^{M-\rho}$ 乗根なので
> $v_{\mathfrak{l}}(\zeta_{\ell^{M-\rho}}-1)=\varphi(\ell^M)/\varphi(\ell^{M-\rho})=\ell^{\rho}$。
> $\rho_i=M$ なら $\chi^{v_i}(\omega_P)=1$ で因子が $0$。

3 行それぞれに対応する定理を置く。

| 人手証明の行 | この file の定理 |
|---|---|
| $\zeta^n$ が原始 $\ell^{M-\rho}$ 乗根であること | `isPrimitiveRoot_zpow_of_valuation` |
| $v_{\mathfrak l}(\xi-1)=\varphi(\ell^M)/\varphi(\ell^j)$ | `associated_sub_one_pow_of_dvd` |
| $\rho_i=M$ なら因子が $0$ | `sub_one_eq_zero_of_pow_dvd` |
| 積の付値が $\beta_P$ | `associated_prod_sub_one` |

## 付値を「$\pi$ の冪との同伴」で書いた理由（人手証明との射程の違い）

人手証明は $v_{\mathfrak{l}}$（$v_{\mathfrak l}(\ell)=\varphi(\ell^M)$ と正規化した付値）で書く。
ここでは同じ内容を **$\pi:=\zeta-1$ の冪と同伴であること**で書いた。$v_{\mathfrak l}(\pi)=1$ なので
「$v_{\mathfrak l}(x)=t$」と「$x$ が $\pi^t$ と同伴」は同値であり、主張の内容は変わらない。

同伴で書いたのは**証明が実際に使う性質がそれだけだから**である。付値の言葉で書くと
$\mathcal{O}_K$ が Dedekind 環であることと付値の存在が要るが、以下の証明が使うのは
$\pi$ が素元であることと整域であることだけで、Dedekind 性も類数も使わない。
（$\mathcal{O}_K$ は一般には一意分解環ではないので、**$a^N\sim b^N\Rightarrow a\sim b$ は使えない。**
そこは `dvd_prime_pow` で「素元の冪の約数は素元の冪と同伴」を経由して避けてある。）

## 形式化しなかったもの

* $\pi=\zeta-1$ が素元であること自体は mathlib の `IsPrimitiveRoot.zeta_sub_one_prime` にある。
  本 file は素元であることを仮定として受け取り、その仮定を mathlib が満たすことを
  `zeta_sub_one_prime_ofInteger` で明示している（丸投げではなく、どこが借り物かを型に出すため）。
* $B$ が voltage ラプラシアンの分解 $(1.2)$ から来ること（補題 Q1′）は `PropQLaurentLift.lean`。
-/
import Mathlib

namespace IntegrableLattice
namespace PropQCyclotomicValuation

open Finset Polynomial

/-! ## 準備: 素元の冪どうしが同伴なら指数が等しい -/

/-- 素元 `π` について `π ^ s` と `π ^ t` が同伴なら `s = t`。
一意分解環であることは使わない（打ち消しと「素元は単元でない」だけを使う）。 -/
theorem pow_eq_pow_of_associated_pow {R : Type*} [CommRing R] [IsDomain R] {π : R}
    (hπ : Prime π) {s t : ℕ} (h : Associated (π ^ s) (π ^ t)) : s = t := by
  -- 同伴なら互いに割る。素元は零でも単元でもないので、割り切りが指数の大小に翻訳される。
  have h1 : π ^ s ∣ π ^ t := h.dvd
  have h2 : π ^ t ∣ π ^ s := h.symm.dvd
  rw [pow_dvd_pow_iff hπ.ne_zero hπ.not_unit] at h1 h2
  omega

/-! ## 段 1: 同じ位数の原始根どうしは `ζ - 1` が同伴 -/

/-- 同じ位数 `n` の原始根 `ζ`・`η` について `ζ - 1` と `η - 1` は同伴。
mathlib は素数の場合（`associated_sub_one_of_isPrimitiveRoot`）しか持たないので、
一般の `n` について書いた（使うのは `η = ζ ^ i`（`i` は `n` と互いに素）だけである）。 -/
theorem associated_sub_one_of_isPrimitiveRoot {R : Type*} [CommRing R] [IsDomain R]
    {n : ℕ} [NeZero n] {ζ η : R} (hζ : IsPrimitiveRoot ζ n) (hη : IsPrimitiveRoot η n) :
    Associated (ζ - 1) (η - 1) := by
  obtain ⟨i, -, hi, hζη⟩ := hζ.isPrimitiveRoot_iff.mp hη
  rw [← hζη]
  exact hζ.associated_sub_one_pow_sub_one_of_coprime hi

/-! ## 段 2: `(ζ - 1) ^ φ(ℓ^j)` は `ℓ` と同伴（素数冪版） -/

/-- `ζ` が原始 `p ^ (k+1)` 乗根なら `(ζ - 1) ^ φ(p ^ (k+1))` は `p` と同伴。

mathlib にあるのは `p` 自身が位数の場合（`associated_zeta_sub_one_pow_prime`）だけなので、
素数冪へ一般化した。証明は同じ形で、円分多項式の `1` での値が `p` であること
（`eval_one_cyclotomic_prime_pow`）と、原始根の個数が `φ` であることを使う。 -/
theorem associated_sub_one_pow_totient {R : Type*} [CommRing R] [IsDomain R]
    {p k : ℕ} [hp : Fact p.Prime] {ζ : R} (hζ : IsPrimitiveRoot ζ (p ^ (k + 1))) :
    Associated ((ζ - 1) ^ Nat.totient (p ^ (k + 1))) (p : R) := by
  have hne : (p : ℕ) ^ (k + 1) ≠ 0 := pow_ne_zero _ hp.out.pos.ne'
  haveI : NeZero ((p : ℕ) ^ (k + 1)) := ⟨hne⟩
  -- `p = eval 1 (cyclotomic (p^(k+1)) R) = ∏_{η 原始} (1 - η)`
  have hev : ((p : R)) = ∏ η ∈ primitiveRoots (p ^ (k + 1)) R, (1 - η) := by
    rw [← eval_one_cyclotomic_prime_pow (R := R) (p := p) k,
      cyclotomic_eq_prod_X_sub_primitiveRoots hζ, eval_prod]
    simp
  rw [hev, ← hζ.card_primitiveRoots, ← Finset.prod_const]
  refine Associated.prod _ _ _ fun η hη ↦ ?_
  have hη' : IsPrimitiveRoot η (p ^ (k + 1)) := isPrimitiveRoot_of_mem_primitiveRoots hη
  simpa using (associated_sub_one_of_isPrimitiveRoot hζ hη').neg_right

/-! ## 段 3: 原始 `ℓ^j` 乗根について `ξ - 1 ∼ π ^ (ℓ^(M-j))`

これが人手証明の $v_{\mathfrak{l}}(\zeta_{\ell^{M-\rho}}-1)=\ell^{\rho}$ にあたる。 -/

/-- `ζ` を原始 `ℓ^M` 乗根、`π := ζ - 1`、`ξ` を原始 `ℓ^j` 乗根（`1 ≤ j ≤ M`）とすると
`ξ - 1` は `π ^ (ℓ ^ (M - j))` と同伴。

人手証明の $v_{\mathfrak l}(\xi-1)=\varphi(\ell^M)/\varphi(\ell^j)=\ell^{M-j}$ と同じ内容である
（$v_{\mathfrak l}(\pi)=1$ なので、$\pi$ の冪との同伴で書ける）。 -/
theorem associated_sub_one_pow_of_dvd {R : Type*} [CommRing R] [IsDomain R]
    {ℓ M j : ℕ} [hℓ : Fact ℓ.Prime] {ζ ξ : R}
    (hζ : IsPrimitiveRoot ζ (ℓ ^ M)) (hξ : IsPrimitiveRoot ξ (ℓ ^ j))
    (hj1 : 1 ≤ j) (hjM : j ≤ M) (hπ : Prime (ζ - 1)) :
    Associated (ξ - 1) ((ζ - 1) ^ ℓ ^ (M - j)) := by
  obtain ⟨M', rfl⟩ : ∃ M', M = M' + 1 := ⟨M - 1, by omega⟩
  obtain ⟨j', rfl⟩ : ∃ j', j = j' + 1 := ⟨j - 1, by omega⟩
  set π := ζ - 1 with hπdef
  -- `(ζ-1) ^ φ(ℓ^(M'+1)) ∼ ℓ` と `(ξ-1) ^ φ(ℓ^(j'+1)) ∼ ℓ`
  have hA : Associated (π ^ Nat.totient (ℓ ^ (M' + 1))) ((ℓ : ℕ) : R) :=
    associated_sub_one_pow_totient hζ
  have hB : Associated ((ξ - 1) ^ Nat.totient (ℓ ^ (j' + 1))) ((ℓ : ℕ) : R) :=
    associated_sub_one_pow_totient hξ
  -- したがって `(ξ-1) ^ φ(ℓ^(j'+1)) ∼ π ^ φ(ℓ^(M'+1))`
  have hAB : Associated ((ξ - 1) ^ Nat.totient (ℓ ^ (j' + 1)))
      (π ^ Nat.totient (ℓ ^ (M' + 1))) := hB.trans hA.symm
  -- `ξ - 1` は `π` の冪を割る。
  have hφj : 0 < Nat.totient (ℓ ^ (j' + 1)) := Nat.totient_pos.mpr (pow_pos hℓ.out.pos _)
  have hdvd : (ξ - 1) ∣ π ^ Nat.totient (ℓ ^ (M' + 1)) := by
    refine dvd_trans (dvd_pow_self _ hφj.ne') hAB.dvd
  -- 素元の冪の約数は素元の冪と同伴（`dvd_prime_pow`）。ここが一意分解環を使わない要点。
  obtain ⟨t, htle, hassoc⟩ := (dvd_prime_pow hπ _).mp hdvd
  -- 指数を決める: `t * φ(ℓ^(j'+1)) = φ(ℓ^(M'+1))`
  have hpow : Associated (π ^ (t * Nat.totient (ℓ ^ (j' + 1))))
      (π ^ Nat.totient (ℓ ^ (M' + 1))) := by
    rw [pow_mul]
    exact (hassoc.symm.pow_pow).trans hAB
  have hexp : t * Nat.totient (ℓ ^ (j' + 1)) = Nat.totient (ℓ ^ (M' + 1)) :=
    pow_eq_pow_of_associated_pow hπ hpow
  -- `φ(ℓ^(m+1)) = ℓ^m * (ℓ-1)` から `t = ℓ^(M'-j')`
  have ht : t = ℓ ^ (M' + 1 - (j' + 1)) := by
    have h1 : Nat.totient (ℓ ^ (j' + 1)) = ℓ ^ j' * (ℓ - 1) :=
      Nat.totient_prime_pow_succ hℓ.out j'
    have h2 : Nat.totient (ℓ ^ (M' + 1)) = ℓ ^ M' * (ℓ - 1) :=
      Nat.totient_prime_pow_succ hℓ.out M'
    rw [h1, h2] at hexp
    have hM'j' : j' ≤ M' := by omega
    have hl1 : 0 < ℓ - 1 := by have := hℓ.out.two_le; omega
    have hkey : t * ℓ ^ j' = ℓ ^ M' := by
      have := hexp
      rw [← mul_assoc] at this
      exact Nat.eq_of_mul_eq_mul_right hl1 this
    have hsplit : ℓ ^ M' = ℓ ^ (M' - j') * ℓ ^ j' := by
      rw [← pow_add]; congr 1; omega
    rw [hsplit] at hkey
    have hj'pos : 0 < ℓ ^ j' := pow_pos hℓ.out.pos _
    have := Nat.eq_of_mul_eq_mul_right hj'pos hkey
    simpa using this
  rw [ht] at hassoc
  simpa using hassoc

/-! ## 段 4: `ζ ^ n` の原始性（人手証明の「原始 `ℓ^(M-ρ)` 乗根なので」） -/

/-- `ζ` が原始 `ℓ^M` 乗根、`n = ℓ^ρ * u`（`u` は `ℓ` と互いに素）、`ρ ≤ M` のとき、
`ζ ^ n` は原始 `ℓ^(M-ρ)` 乗根である。 -/
theorem isPrimitiveRoot_pow_of_valuation {R : Type*} [CommMonoid R]
    {ℓ M ρ u : ℕ} [hℓ : Fact ℓ.Prime] {ζ : R}
    (hζ : IsPrimitiveRoot ζ (ℓ ^ M)) (hρM : ρ ≤ M) (hu : Nat.Coprime u ℓ) :
    IsPrimitiveRoot (ζ ^ (ℓ ^ ρ * u)) (ℓ ^ (M - ρ)) := by
  have hsplit : ℓ ^ M = ℓ ^ ρ * ℓ ^ (M - ρ) := by
    rw [← pow_add]; congr 1; omega
  have hpos : 0 < ℓ ^ M := pow_pos hℓ.out.pos M
  -- まず `ζ ^ (ℓ^ρ)` が原始 `ℓ^(M-ρ)` 乗根。
  have h1 : IsPrimitiveRoot (ζ ^ ℓ ^ ρ) (ℓ ^ (M - ρ)) := hζ.pow hpos hsplit
  -- 互いに素な冪を取っても原始性は保たれる。
  have hcop : Nat.Coprime u (ℓ ^ (M - ρ)) := Nat.Coprime.pow_right _ hu
  have := h1.pow_of_coprime u hcop
  rwa [← pow_mul] at this

/-- `ℓ^M ∣ n` なら `ζ ^ n = 1`、したがって因子 `ζ ^ n - 1` は `0`。
人手証明の「$\rho_i=M$ なら $\chi^{v_i}(\omega_P)=1$ で因子が $0$」。 -/
theorem sub_one_eq_zero_of_pow_dvd {R : Type*} [CommRing R]
    {ℓ M n : ℕ} {ζ : R} (hζ : IsPrimitiveRoot ζ (ℓ ^ M)) (hdvd : ℓ ^ M ∣ n) :
    ζ ^ n - 1 = 0 := by
  obtain ⟨c, rfl⟩ := hdvd
  rw [pow_mul, hζ.pow_eq_one, one_pow, sub_self]

/-! ## 段 5: 補題 Q4a 本体 -/

/-- **補題 Q4a（非零の場合）**。

`ζ` を原始 `ℓ^M` 乗根、`π := ζ - 1`（素元）とする。有限個の指数 `n i` について、
各 `i` で `n i = ℓ ^ (ρ i) * u i`（`u i` は `ℓ` と互いに素）かつ `ρ i < M` とすると、

`B := ∏ i, (ζ ^ (n i) - 1) ^ (m i)` は `π ^ (∑ i, m i * ℓ ^ (ρ i))` と同伴。

右辺の指数がちょうど人手証明の $\beta_P=\sum_i m_i\ell^{\rho_i}$ である。 -/
theorem associated_prod_sub_one {R : Type*} [CommRing R] [IsDomain R]
    {ℓ M : ℕ} [hℓ : Fact ℓ.Prime] {ζ : R} (hζ : IsPrimitiveRoot ζ (ℓ ^ M))
    (hπ : Prime (ζ - 1)) {ι : Type*} (s : Finset ι) (m ρ u : ι → ℕ)
    (hρ : ∀ i ∈ s, ρ i < M) (hu : ∀ i ∈ s, Nat.Coprime (u i) ℓ) :
    Associated (∏ i ∈ s, (ζ ^ (ℓ ^ ρ i * u i) - 1) ^ m i)
      ((ζ - 1) ^ ∑ i ∈ s, m i * ℓ ^ ρ i) := by
  classical
  -- 各因子ごとに段 3・段 4 を当てる（人手証明が $i$ ごとに $\ell^{\rho_i}$ を出すのと同じ）。
  have key : ∀ i ∈ s, Associated ((ζ ^ (ℓ ^ ρ i * u i) - 1) ^ m i)
      ((ζ - 1) ^ (m i * ℓ ^ ρ i)) := by
    intro i hi
    have hlt : ρ i < M := hρ i hi
    have hprim : IsPrimitiveRoot (ζ ^ (ℓ ^ ρ i * u i)) (ℓ ^ (M - ρ i)) :=
      isPrimitiveRoot_pow_of_valuation hζ hlt.le (hu i hi)
    have h1 := associated_sub_one_pow_of_dvd hζ hprim (by omega) (Nat.sub_le _ _) hπ
    have hsub : M - (M - ρ i) = ρ i := by omega
    rw [hsub] at h1
    have h2 : Associated ((ζ ^ (ℓ ^ ρ i * u i) - 1) ^ m i) (((ζ - 1) ^ ℓ ^ ρ i) ^ m i) :=
      h1.pow_pow
    rwa [← pow_mul, mul_comm (ℓ ^ ρ i) (m i)] at h2
  refine (Associated.prod s _ _ key).trans ?_
  rw [Finset.prod_pow_eq_pow_sum]
  exact Associated.refl _

/-- **補題 Q4a（零になる場合）**。ある `i` で `ℓ^M ∣ n i` なら、その因子が `0` なので積も `0`。 -/
theorem prod_sub_one_eq_zero {R : Type*} [CommRing R]
    {ℓ M : ℕ} {ζ : R} (hζ : IsPrimitiveRoot ζ (ℓ ^ M))
    {ι : Type*} [DecidableEq ι] (s : Finset ι) (m n : ι → ℕ)
    {i₀ : ι} (hi₀ : i₀ ∈ s) (hdvd : ℓ ^ M ∣ n i₀) (hm : m i₀ ≠ 0) :
    ∏ i ∈ s, (ζ ^ n i - 1) ^ m i = 0 := by
  refine Finset.prod_eq_zero hi₀ ?_
  rw [sub_one_eq_zero_of_pow_dvd hζ hdvd, zero_pow hm]

/-! ## 仮定 `Prime (ζ - 1)` の所在（借り物を型に出す）

上の定理はどれも `Prime (ζ - 1)` を仮定として受け取る。その仮定が空でないこと、
すなわち円分体の整数環でそれが成り立つことは mathlib にある。
**どこが借り物かを隠さないため、借りている当の事実をここで名指しする。** -/

open NumberField in
/-- 仮定 `Prime (ζ - 1)` は円分体 $\mathbb{Q}(\zeta_{\ell^{M}})$ の整数環で満たされる
（mathlib の `IsPrimitiveRoot.zeta_sub_one_prime`）。

本論文が使うのはこの場合だけである。上の定理群を仮定つきで書いたのは、
**証明が使うのが素元性だけであることを型に出すため**であって、成立を疑っているからではない。 -/
theorem prime_zeta_sub_one_ofInteger {p k : ℕ} [hp : Fact p.Prime] {K : Type*} [Field K]
    [NumberField K] [IsCyclotomicExtension {p ^ (k + 1)} ℚ K] {ζ : K}
    (hζ : IsPrimitiveRoot ζ (p ^ (k + 1))) : Prime (hζ.toInteger - 1) :=
  hζ.zeta_sub_one_prime

end PropQCyclotomicValuation
end IntegrableLattice
