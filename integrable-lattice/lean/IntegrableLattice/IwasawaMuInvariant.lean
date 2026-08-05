/-
# 外部定理「Monsky の p 進冪級数の定理」の第 1 段（$\mu$ 不変量の存在）— cycle 40 step 3 の次

対応する外部定理:

* `structured-latex/tools/external-theorem-coverage.ts` の
  「Monsky の p 進冪級数の定理」（Monsky, *On p-adic power series*, Math. Ann. 255(2), 217–227 (1981), Theorem 5.6）
* 同じ engine を使う「Cuoco–Monsky の類数の漸近」の Definition 1.1（$\mu$ 不変量）

## なぜこのファイルが在るか（測って分かったこと）

cycle 31 以降、この 2 件は**「素材も無い」**として立っていた
（`lean/logs/mathlib-gap-survey-cycle31-external.log`。`Monsky` / `cuoco` / 岩澤不変量の漸近が 0 件）。
**cycle 40 step 4 で中に入って測ったところ、engine のほうは mathlib に在った。**

* `Mathlib/RingTheory/PowerSeries/WeierstrassPreparation.lean` —
  **完備局所環の上の Weierstrass 準備定理**（`PowerSeries.exists_isWeierstrassFactorization`）。
  出典として Washington の *Introduction to Cyclotomic Fields* を挙げており、
  岩澤理論で使う形そのものである。
* `Mathlib/RingTheory/Polynomial/Eisenstein/Distinguished.lean` —
  **distinguished 多項式**（`Polynomial.IsDistinguishedAt`）。

**しかも $\mathbb{Z}_p$ へそのまま当たる**（`weierstrass_over_padicInt`。
インスタンスの補いは 1 つも要らなかった。2026-08-05 実測）。
走査が 0 件だったのは、**探した語が定理の名前（`Monsky` / `cuoco`）だったからである。**
定理の名前で引くと、その定理を証明する道具が在っても見えない。

## このファイルが書くもの

Monsky の定理も Cuoco–Monsky の $\mu,\lambda$ も、出発点は同じ**岩澤分解**である——
$0$ でない $g\in\mathbb{Z}_p[[X]]$ は $g=p^{\mu}\,f\,h$（$f$ は distinguished 多項式、$h$ は単元）と書ける。
Weierstrass 準備定理が与えるのは $f\,h$ の部分だけで、**$p^{\mu}$ を括り出す段は与えない。**
ここではその段を書く。

1. **$p^k$ が $g$ を割れば、各係数を割る**（`dvd_coeff_of_pow_dvd`）。
2. **$\mu$ の存在**（`exists_greatest_pow_dvd`）。$g\neq0$ なら $p^k\mid g$ となる $k$ は有界なので、
   最大の $k$ が取れる。これが $\mu$ 不変量である。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。$\mu$ は自然数であり、決めているのは整除の判定だけである。
$\mathbb{Z}_p$ は非可算だが、**ここで使うのはその付値が自然数値であることだけ**で、
$\mu$ 自身は $\mathbb{N}$ に住む（本論文が Λ 側の量として扱っているのはこの $\mu$ である）。

## 形式化しなかったもの

* **Monsky の Theorem 5.6 そのものは書いていない。** 書いたのは岩澤分解の $p^{\mu}$ の段と、
  Weierstrass 準備定理が $\mathbb{Z}_p$ へ当たることの確認までである。
* **Cuoco–Monsky の $\mathbb{Z}_p^d$（$d\ge2$）の場合は扱っていない。**
  $d=1$（$\mathbb{Z}_p[[X]]$）だけである。多変数の完備群環は mathlib に無い。
-/
import Mathlib

namespace IntegrableLattice
namespace IwasawaMu

open PowerSeries

variable {p : ℕ} [Fact p.Prime]

/-- **Weierstrass 準備定理は $\mathbb{Z}_p[[X]]$ へそのまま当たる。**

mathlib の定理をこの設定へ具体化しただけである（インスタンスの補いは要らなかった）。
**これ自体は成果ではない**——ここに置くのは、cycle 31 以降「素材も無い」と記録されていた判定が
誤りであることを、実在する宣言として残すためである。 -/
theorem weierstrass_over_padicInt (g : PowerSeries (PadicInt p))
    (hg : g.map (IsLocalRing.residue (PadicInt p)) ≠ 0) :
    ∃ f h, g.IsWeierstrassFactorization f h :=
  ⟨_, _, (g.exists_isWeierstrassFactorization hg).choose_spec.choose_spec⟩

/-- $p^k$ が冪級数を割れば、各係数を割る。 -/
theorem dvd_coeff_of_pow_dvd {g : PowerSeries (PadicInt p)} {k i : ℕ}
    (h : ((p : PowerSeries (PadicInt p))) ^ k ∣ g) :
    ((p : PadicInt p)) ^ k ∣ (PowerSeries.coeff i) g := by
  obtain ⟨q, rfl⟩ := h
  refine ⟨(PowerSeries.coeff i) q, ?_⟩
  have hc : ((p : PowerSeries (PadicInt p))) ^ k = PowerSeries.C ((p : PadicInt p) ^ k) := by
    push_cast
    simp
  rw [hc, PowerSeries.coeff_C_mul]

/-- **$\mu$ 不変量の存在。** $g\neq0$ なら、$p^k\mid g$ となる $k$ には最大のものがある。

有界性の中身は 1 行である——$0$ でない係数を 1 つ取ると、$p^k$ はその係数を割るので、
$k$ はその係数の $p$ 進付値を超えられない。 -/
theorem exists_greatest_pow_dvd {g : PowerSeries (PadicInt p)} (hg : g ≠ 0) :
    ∃ μ : ℕ, ((p : PowerSeries (PadicInt p))) ^ μ ∣ g ∧
      ¬ ((p : PowerSeries (PadicInt p))) ^ (μ + 1) ∣ g := by
  classical
  -- $0$ でない係数を 1 つ取る。
  obtain ⟨i, hi⟩ : ∃ i, (PowerSeries.coeff i) g ≠ 0 := by
    by_contra hcon
    push_neg at hcon
    exact hg (PowerSeries.ext fun i => by simpa using hcon i)
  -- その係数を割る $p$ の冪は有界である。
  set B := ((PowerSeries.coeff i) g).valuation with hB
  have hbound : ∀ k : ℕ, ((p : PowerSeries (PadicInt p))) ^ k ∣ g → k ≤ B := by
    intro k hk
    have hdvd := dvd_coeff_of_pow_dvd (g := g) (k := k) (i := i) hk
    have hmem : (PowerSeries.coeff i) g ∈ (Ideal.span {(p : PadicInt p) ^ k} : Ideal (PadicInt p)) :=
      Ideal.mem_span_singleton.mpr hdvd
    exact (PadicInt.mem_span_pow_iff_le_valuation _ hi k).mp hmem
  -- 有界な非空集合なので最大元がある。
  set P : ℕ → Prop := fun k => ((p : PowerSeries (PadicInt p))) ^ k ∣ g with hP
  have h0 : P 0 := by simp [hP]
  have hdec : DecidablePred P := Classical.decPred P
  refine ⟨Nat.findGreatest P B, Nat.findGreatest_spec (m := 0) (n := B) (Nat.zero_le _) h0, ?_⟩
  intro hsucc
  have hle := hbound _ hsucc
  have := Nat.le_findGreatest hle (show P (Nat.findGreatest P B + 1) from hsucc)
  omega

end IwasawaMu
end IntegrableLattice
