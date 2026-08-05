/-
# 外部定理「Monsky の p 進冪級数の定理」の第 2 段（岩澤分解と $\lambda$ の同定）— cycle 41 step 3

対応する外部定理:

* `structured-latex/tools/external-theorem-coverage.ts` の
  「Monsky の p 進冪級数の定理」（Monsky, *On p-adic power series*, Math. Ann. 255(2), 217–227 (1981), Theorem 5.6）
* 同じ engine を使う「Cuoco–Monsky の類数の漸近」の Definitions 1.1, 1.2（$\mu$ と $\lambda$）

## 第 1 段で何が入っていて、この段が何を足すか

cycle 40 step 4（`IwasawaMuInvariant.lean`）は 2 つを書いた——
Weierstrass 準備定理が $\mathbb{Z}_p[[X]]$ へそのまま当たること（`weierstrass_over_padicInt`）と、
$\mu$ 不変量の存在（`exists_greatest_pow_dvd`。$p^k\mid g$ となる $k$ に最大のものがあること）。

**この 2 つはまだ繋がっていなかった。** Weierstrass 準備定理は
「$g$ の $\bmod\ p$ 還元が $0$ でない」ことを仮定として要求するので、$p$ で割り切れる $g$ には当たらない。
本ファイルはその繋ぎを書く——$\mu$ を括り出した残り $g_1$ は $p$ で割れないので還元が $0$ でなく、
準備定理が当たる。これで**岩澤分解 $g=p^{\mu}\,f\,h$** が出て、$\lambda:=\deg f$ が定義できる。

## 書いたこと（4 段）

1. **係数がすべて $p$ で割れれば冪級数も $p$ で割れる**（`dvd_of_forall_coeff_dvd`）。
   逆向き（`IwasawaMu.dvd_coeff_of_pow_dvd`）は第 1 段に在る。商は係数ごとに取って並べる。
2. **$\bmod\ p$ 還元が $0$ であることと $p$ で割れることは同じである**（`map_residue_eq_zero_iff`）。
   $\mathbb{Z}_p$ の極大イデアルが $p$ の生成するイデアルであること（`PadicInt.maximalIdeal_eq_span_p`）
   を経由する。
3. **岩澤分解**（`exists_iwasawa_factorization`）。$g\neq0$ を $g=p^{\mu}g_1$ と書き、
   $\mu$ の最大性から $g_1$ が $p$ で割れないことを出し（**ここで $\mathbb{Z}_p[[X]]$ が整域であることを使う**）、
   段 2 で還元が $0$ でないことに直して準備定理へ渡す。
4. **$\lambda$ の同定**（`degree_eq_order_map`）。分解に現れる distinguished 多項式の次数は、
   $g_1$ の $\bmod\ p$ 還元の位数に等しい。**すなわち $\lambda$ は分解の取り方に依らず $g$ から決まる。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。$\mu$ も $\lambda$ も自然数で、決めているのは整除の判定と位数だけである。
$\mathbb{Z}_p$ は非可算だが、使うのは付値が自然数値であることと剰余体が $\mathbb{Z}/p$ であることだけで、
本論文が $\Lambda$ 側の量として扱う $\mu,\lambda$ 自身は $\mathbb{N}$ に住む。

## 形式化しなかったもの

* Monsky の Theorem 5.6 の主張そのものは書いていない。残っているのは
  $\mathrm{ord}$ の漸近（$\mathrm{ord}_p\prod_{\zeta^{p^n}=1}g(\zeta-1)=\mu p^{n}+\lambda n+\nu$）で、
  そこには $1$ の冪根での評価と、その積の付値を数える段が要る。**本ファイルはその手前までである。**
* $\mathbb{Z}_p^d$（$d\ge2$）は扱っていない。多変数の完備群環は mathlib に無い（cycle 40 step 4 の走査）。
-/
import Mathlib
import IntegrableLattice.IwasawaMuInvariant

namespace IntegrableLattice
namespace IwasawaDecomposition

open PowerSeries

variable {p : ℕ} [Fact p.Prime]

/-! ## 1. 係数がすべて割れれば冪級数も割れる -/

/-- 定数 $p$ の冪級数としての姿。 -/
theorem cast_eq_C : ((p : PowerSeries (PadicInt p))) = PowerSeries.C ((p : PadicInt p)) := by
  push_cast
  simp

/-- **係数がすべて $p$ で割れれば、冪級数も $p$ で割れる。** 商は係数ごとに取って並べる。 -/
theorem dvd_of_forall_coeff_dvd {g : PowerSeries (PadicInt p)}
    (h : ∀ i, ((p : PadicInt p)) ∣ (PowerSeries.coeff i) g) :
    ((p : PowerSeries (PadicInt p))) ∣ g := by
  classical
  refine ⟨PowerSeries.mk fun i => (h i).choose, ?_⟩
  ext i
  rw [cast_eq_C, PowerSeries.coeff_C_mul, PowerSeries.coeff_mk]
  exact (h i).choose_spec

/-! ## 2. $\bmod\ p$ 還元が $0$ であることと $p$ で割れることは同じ -/

/-- **還元が $0$ であることと $p$ で割れることは同じである。**

$\mathbb{Z}_p$ の極大イデアルは $p$ の生成するイデアルなので、
剰余写像で消えることと $p$ で割れることが一致する。 -/
theorem map_residue_eq_zero_iff (g : PowerSeries (PadicInt p)) :
    g.map (IsLocalRing.residue (PadicInt p)) = 0 ↔ ((p : PowerSeries (PadicInt p))) ∣ g := by
  constructor
  · intro hzero
    refine dvd_of_forall_coeff_dvd fun i => ?_
    have hc : IsLocalRing.residue (PadicInt p) ((PowerSeries.coeff i) g) = 0 := by
      have := congrArg (PowerSeries.coeff i) hzero
      rwa [PowerSeries.coeff_map, map_zero] at this
    have hmem : (PowerSeries.coeff i) g ∈ IsLocalRing.maximalIdeal (PadicInt p) :=
      (Ideal.Quotient.eq_zero_iff_mem).mp hc
    rw [PadicInt.maximalIdeal_eq_span_p, Ideal.mem_span_singleton] at hmem
    exact hmem
  · rintro ⟨q, rfl⟩
    ext i
    rw [cast_eq_C, PowerSeries.coeff_map, PowerSeries.coeff_C_mul, map_mul, map_zero]
    have : IsLocalRing.residue (PadicInt p) ((p : PadicInt p)) = 0 := by
      refine (Ideal.Quotient.eq_zero_iff_mem).mpr ?_
      rw [PadicInt.maximalIdeal_eq_span_p, Ideal.mem_span_singleton]
    rw [this, zero_mul]

/-! ## 3. 岩澤分解 $g=p^{\mu}\,f\,h$

第 1 段の $\mu$ の最大性を使って、残り $g_1$ が $p$ で割れないことを出す。
**割り切りの取り消しに $\mathbb{Z}_p[[X]]$ が整域であることを使う**（$\mathbb{Z}_p$ が整域なので従う）。 -/

/-- **岩澤分解の存在。** $0$ でない $g\in\mathbb{Z}_p[[X]]$ は
$g=p^{\mu}\,f\,h$（$f$ は distinguished 多項式、$h$ は単元）と書ける。

$\mu$ は第 1 段の `exists_greatest_pow_dvd` が与えるもので、$f,h$ は Weierstrass 準備定理が与える。
**この 2 つを繋ぐのが本 step の中身である。** -/
theorem exists_iwasawa_factorization {g : PowerSeries (PadicInt p)} (hg : g ≠ 0) :
    ∃ (μ : ℕ) (g₁ : PowerSeries (PadicInt p)) (f : Polynomial (PadicInt p))
      (h : PowerSeries (PadicInt p)),
      g = ((p : PowerSeries (PadicInt p))) ^ μ * g₁ ∧ g₁.IsWeierstrassFactorization f h := by
  classical
  obtain ⟨μ, ⟨g₁, hg₁⟩, hmax⟩ := IwasawaMu.exists_greatest_pow_dvd hg
  -- $g_1$ は $p$ で割れない（割れれば $p^{\mu+1}\mid g$ になる）。
  have hnd : ¬ ((p : PowerSeries (PadicInt p))) ∣ g₁ := by
    rintro ⟨q, rfl⟩
    exact hmax ⟨q, by rw [hg₁]; ring⟩
  have hne : g₁.map (IsLocalRing.residue (PadicInt p)) ≠ 0 := fun hz =>
    hnd ((map_residue_eq_zero_iff g₁).mp hz)
  obtain ⟨f, h, hfh⟩ := IwasawaMu.weierstrass_over_padicInt g₁ hne
  exact ⟨μ, g₁, f, h, hg₁, hfh⟩

/-! ## 4. $\lambda$ の同定

分解に現れる distinguished 多項式の次数は $g_1$ の $\bmod\ p$ 還元の位数に等しい。
**したがって $\lambda$ は分解の取り方に依らず $g$ から決まる。** -/

/-- **$\lambda=\deg f$ は $g_1$ の $\bmod\ p$ 還元の位数である。**

mathlib の `IsWeierstrassFactorizationAt.degree_eq_coe_lift_order_map_of_ne_top` を
$\mathbb{Z}_p$ の極大イデアルへ当てただけである。**当たること自体がこの段の内容である**——
極大イデアルが $\top$ でないことは局所環であることから出る。 -/
theorem degree_eq_order_map {g₁ : PowerSeries (PadicInt p)} {f : Polynomial (PadicInt p)}
    {h : PowerSeries (PadicInt p)} (H : g₁.IsWeierstrassFactorization f h) :
    f.degree = (g₁.map (Ideal.Quotient.mk (IsLocalRing.maximalIdeal (PadicInt p)))).order.lift
      (PowerSeries.order_finite_iff_ne_zero.2
        (H.map_ne_zero_of_ne_top (IsLocalRing.maximalIdeal.isMaximal (PadicInt p)).ne_top)) :=
  H.degree_eq_coe_lift_order_map_of_ne_top
    (IsLocalRing.maximalIdeal.isMaximal (PadicInt p)).ne_top

end IwasawaDecomposition
end IntegrableLattice
