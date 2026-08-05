/-
# 命題 W\* の残り 2 件のうち「本文の $\mu$ の構成と $G$ の同定」— cycle 41 step 1

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の証明の第 1 段落と第 2 段落
  （$\eta=\mu\,\rho'(\theta)$ の段と、$G$ が重み $\mu$ の Gram 行列であることの段）
* $G$ の定義そのものは 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement にある
  （$G=(\operatorname{Tr}T^{i+j})_{0\le i,j<r}\in M_r(\mathbb{Z})$）

## 着手の前に記号を 1 つずつ突き合わせた（cycle 40 step 1 の事故を受けて）

cycle 39 は本文の $\eta$ を $\mu$ と取り違えたまま 2 サイクル進み、cycle 40 step 1 でそれが出た。
そこで本ファイルは、**本文に現れる記号を 1 つ残らず並べ、Lean 側の名前と突き合わせてから書いた。**
突き合わせで分かったことは 2 つある（どちらも下の表に反映してある）。

* **`WStarRadical.multWeight` という名前は本文の $\mu$ を指していない。** 実体は $\chi'/h$ で、
  その $\theta$ での値が本文の $\eta$ である。名前だけが $\mu$ を連想させる。
  cycle 40 step 1 はこの食い違いをファイルの散文には書いたが、
  **定義に付いていた「これが $\mu$ の実体である」という一文はそのまま残っていた。** 本 step で直した。
* **本文の $G$ は整数行列である**（$M_r(\mathbb{Z})$、成分は $\operatorname{Tr}T^{i+j}$）。
  Lean 側の `EulerDualBasis.weightedGram θ μ` は代数のトレースで書いた行列なので、
  **2 つが同じ行列であることは別に言う必要がある。** 下の「形式化しなかったもの」に書いた。

### 記号の対応表（本文 → Lean）

| 本文 | 意味 | Lean |
|---|---|---|
| $T$ | 整数の転送行列 | `Matrix (Fin n) (Fin n) ℤ` |
| $\chi=\chi_T$ | $T$ の特性多項式（モニック） | `Matrix.charpoly` / `WStarRadical.chi f a` |
| $f_i$ | $\chi$ の相異なる既約因子（モニックに取る） | `f : ι → R[X]` |
| $a_i$ | その重複度 | `a : ι → ℕ` |
| $\rho=\mathrm{rad}(\chi)$ | 根基 $\prod_i f_i$ | `WStarRadical.rad f` |
| $r=\deg\rho$ | | `m + 1` |
| $h=\chi/\rho$ | | `WStarRadical.lower f a` |
| $\chi'/h$ | 多項式（$\sum_i a_i f_i'\,\rho/f_i$） | `WStarRadical.multWeight f a` |
| $\theta$ | $x\bmod\rho$ | `AdjoinRoot.root ρ` |
| $A$ | $\mathbb{Z}[x]/(\rho)$ | `AdjoinRoot ρ`（係数環 $\mathbb{Z}$） |
| $A_\mathbb{Q}$ | $\mathbb{Q}[x]/(\rho)$ | `AdjoinRoot ρ`（係数環が体のとき） |
| $\eta$ | $(\chi'/h)(\theta)\in A$ | `aeval (AdjoinRoot.root ρ) (WStarRadical.multWeight f a)` |
| $\mu$ | 成分ごとに $a_i$ をとる $A_\mathbb{Q}$ の元 | **本ファイルの `mu`** |
| $K_i$ | $\mathbb{Q}[x]/(f_i)$ | `AdjoinRoot (f i)` |
| $G$ | $(\operatorname{Tr}T^{i+j})_{0\le i,j<r}\in M_r(\mathbb{Z})$ | 本文の定義（命題 C′）。代数側は `EulerDualBasis.weightedGram` |
| $w^*$ | $G$ の最大単因子の $p$ 進付値 | `isLeast_isPLevel` ほか |
| $N_{A/\mathbb{Q}}$ | ノルム | `Algebra.norm` |

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは多項式の整除・微分・剰余と、有限自由加群のトレースだけである。
係数環は $\mathbb{Z}$（本文が当てる先）と、その分数体 $\mathbb{Q}$ である。
$\mathbb{Q}$ は可算であり、ここで非可算側へ出ているわけではない。

## 書いたこと（4 段）

1. **$\rho'(\theta)$ は $A_\mathbb{Q}$ の単元である**（`isUnit_aeval_derivative`）。
   $\rho$ が無平方な体上の多項式なら分離的で、$\rho$ と $\rho'$ は互いに素である。
   Bézout の関係 $u\rho+v\rho'=1$ を $\theta$ で見れば $v(\theta)$ が逆元になる。
   **完全体であること（$\mathbb{Q}$ は標数 $0$ なので満たす）だけを使う。**
2. **本文の $\mu$ の構成**（`mu` / `derivative_mul_mu`）。段 1 の逆元に $\eta$ を掛ける。
   これで本文の第 1 段落の等式 $\eta=\mu\,\rho'(\theta)$ が定義から出る。
3. **$\chi'/h$ が成分ごとに $a_i\,\rho'$ であること**（`multWeight_sub_smul_derivative_rad_dvd` /
   `aeval_multWeight_eq_on_component`）。本文が「成分 $K_i$ 上で $a_i\rho'(\theta_i)$ に等しい」と
   書いている段である。**中身は $f_i$ を法にとった多項式の合同だけで、体も分解も要らない**——
   $\chi'/h-a_i\rho'=\sum_{j}(a_j-a_i)f_j'\,(\rho/f_j)$ で、$j\neq i$ の項は $\rho/f_j$ に $f_i$ を含み、
   $j=i$ の項は係数が $0$ である。したがって $\chi'/h\equiv a_i\,\rho'\pmod{f_i}$ である。
   **成分 $K_i$ での $\mu$ の像そのものを $a_i$ と書く形にはしていない。そう書く**——
   $A_\mathbb{Q}\to K_i$ の環準同型を経由する必要があり、本 step ではそこまで入れていない。
   書いたのは $\chi'/h$ の側の等式である。
4. **重み $\mu$ の Gram 行列と本文の 2 つの等式**（`weightedGram_apply_eq_psi` /
   `det_weightedGram_mu` / `det_weightedGram_mu_of_squarefree`）。
   成分は $\operatorname{Tr}(\mu\theta^{j+k})=\psi(\eta\,\theta^{j+k})$ で、
   行列式は $\det G=\pm N_{A_\mathbb{Q}/\mathbb{Q}}(\eta)$ である。
   **後者が本文の statement の 2 本目の等式そのものである。**
   符号は Euler の係数行列の行列式で、その平方が $1$ であることは cycle 36 step 1 で入っている。

## 形式化しなかったもの

本文の $G$ は整数行列 $(\operatorname{Tr}T^{i+j})$ であり、段 4 の行列は
$(\operatorname{Tr}_{A_\mathbb{Q}/\mathbb{Q}}(\mu\theta^{j+k}))$ である。
2 つが同じ行列であることは、$\operatorname{Tr}T^N$ が冪和であることに他ならない。
本 step でそこへ 1 段だけ寄せた（`psi_eta_recurrence` / `trace_pow_recurrence`）——
$\chi(\theta)=0$ と Cayley–Hamilton から、両辺は $\chi$ の与える同じ線形漸化式に従う。

* $\chi$ の根の $N$ 乗和が $\psi(\eta\,\theta^N)$ に等しいこと。上の漸化式で残るのは
  初期値 $N=0,\dots,\deg\chi-1$ の一致だけだが、**それは $\chi$ の係数から冪和を出す関係
  （Newton の関係）そのものであり、mathlib にその形は無い。** 書いていない。そう書く。
* その降下（Gauss）は仮定として受け取っている。$\rho$ の無平方性は本文では $\mathbb{Z}[x]$ の側で
  言われており（`WStarRadical.squarefree_rad`）、段 1 が使うのは $\mathbb{Q}[x]$ へ写した側である。
  **書いてみて外側に現れた段であり、そう書く。**
-/
import Mathlib
import IntegrableLattice.WStarFactorExtraction
import IntegrableLattice.WStarPowerBasisInstance

namespace IntegrableLattice
namespace WStarMuGram

open Polynomial Finset Module

/-! ## 1. $\rho'(\theta)$ は $A_K=K[x]/(\rho)$ の単元である

無平方な多項式は完全体の上で分離的であり（`PerfectField.separable_iff_squarefree`）、
分離的とは $\rho$ と $\rho'$ が互いに素であることそのものである（`Polynomial.separable_def`）。
Bézout の関係 $u\rho+v\rho'=1$ を $\theta$ で見れば逆元が読み取れる。 -/

section Unit

variable {K : Type*} [Field K] [PerfectField K]

/-- **$\rho$ が無平方なら $\rho'(\theta)$ は $K[x]/(\rho)$ の単元である。**

本文が $A^{\vee}=\rho'(\theta)^{-1}A$ と書いている段で使っているのはこれである。 -/
theorem isUnit_aeval_derivative {ρ : K[X]} (hsq : Squarefree ρ) :
    IsUnit (aeval (AdjoinRoot.root ρ) (derivative ρ)) := by
  obtain ⟨u, v, huv⟩ := PerfectField.separable_iff_squarefree.mpr hsq
  have hzero : aeval (AdjoinRoot.root ρ) ρ = 0 := by
    rw [AdjoinRoot.aeval_eq, AdjoinRoot.mk_self]
  have h := congrArg (aeval (AdjoinRoot.root ρ)) huv
  simp only [map_add, map_mul, map_one, hzero, mul_zero, zero_add] at h
  exact ⟨⟨aeval (AdjoinRoot.root ρ) (derivative ρ), aeval (AdjoinRoot.root ρ) v,
    by rw [mul_comm]; exact h, h⟩, rfl⟩

end Unit

/-! ## 2. 本文の $\mu$ の構成

段 1 の逆元へ $\eta$ を掛ける。**本文の第 1 段落の等式 $\eta=\mu\,\rho'(\theta)$ は定義から出る。** -/

section Mu

variable {K : Type*} [Field K] [PerfectField K]

/-- **本文の $\mu$。** $\eta$ を $\rho'(\theta)$ で割ったものである。
$\rho$ が無平方でないときは意味を持たせない（`Ring.inverse` は単元でない元を $0$ へ送る）。 -/
noncomputable def mu (ρ : K[X]) (η : AdjoinRoot ρ) : AdjoinRoot ρ :=
  Ring.inverse (aeval (AdjoinRoot.root ρ) (derivative ρ)) * η

/-- **本文の $\eta=\mu\,\rho'(\theta)$。** -/
theorem derivative_mul_mu {ρ : K[X]} (hsq : Squarefree ρ) (η : AdjoinRoot ρ) :
    aeval (AdjoinRoot.root ρ) (derivative ρ) * mu ρ η = η := by
  rw [mu, ← mul_assoc, Ring.mul_inverse_cancel _ (isUnit_aeval_derivative hsq), one_mul]

end Mu

/-! ## 3. $\mu$ は成分ごとに $a_i$ をとる

本文が「その $\theta$ での値は成分 $K_i=\mathbb{Q}[x]/(f_i)$ 上で $a_i\,\rho'(\theta_i)$ に等しい」と
書いている段である。**中身は $f_i$ を法にとった多項式の合同だけで、体も成分分解も要らない。** -/

section Component

variable {R : Type*} [CommRing R] {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- $\rho'=\sum_i f_i'\,(\rho/f_i)$（積の微分公式）。 -/
theorem derivative_rad (f : ι → R[X]) :
    derivative (WStarRadical.rad f) = ∑ i, derivative (f i) * ∏ j ∈ univ.erase i, f j := by
  classical
  rw [WStarRadical.rad, derivative_prod_finset]
  exact Finset.sum_congr rfl fun i _ => mul_comm _ _

/-- **$\chi'/h\equiv a_i\,\rho'\pmod{f_i}$。**

差を書き下すと $\sum_j (a_j-a_i)\,f_j'\,(\rho/f_j)$ で、$j\neq i$ の項は $\rho/f_j$ に $f_i$ を含み、
$j=i$ の項は係数が $0$ である。**これが本文の「成分 $K_i$ 上で $a_i\rho'(\theta_i)$」の中身である。** -/
theorem multWeight_sub_smul_derivative_rad_dvd (f : ι → R[X]) (a : ι → ℕ) (i : ι) :
    f i ∣ WStarRadical.multWeight f a - C ((a i : R)) * derivative (WStarRadical.rad f) := by
  classical
  have hsplit : WStarRadical.multWeight f a - C ((a i : R)) * derivative (WStarRadical.rad f)
      = ∑ j, (C ((a j : R)) - C ((a i : R))) * (derivative (f j) * ∏ k ∈ univ.erase j, f k) := by
    rw [WStarRadical.multWeight, derivative_rad, Finset.mul_sum, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun j _ => by ring
  rw [hsplit]
  refine Finset.dvd_sum ?_
  intro j _
  by_cases hij : j = i
  · subst hij
    simp
  · refine Dvd.dvd.mul_left ?_ _
    refine Dvd.dvd.mul_left ?_ _
    exact Finset.dvd_prod_of_mem _ (Finset.mem_erase.mpr ⟨fun h => hij h.symm, mem_univ i⟩)

end Component

section ComponentField

variable {K : Type*} [Field K] {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **成分 $K_i=K[x]/(f_i)$ の上で $(\chi'/h)(\theta_i)=a_i\,\rho'(\theta_i)$。**

上の合同を $K_i$ へ写しただけである。**$\mu$ の像が $a_i$ であることは、
$\rho'(\theta_i)$ が $K_i$ の単元であるとき両辺をそれで割れば出る。** -/
theorem aeval_multWeight_eq_on_component (f : ι → K[X]) (a : ι → ℕ) (i : ι) :
    aeval (AdjoinRoot.root (f i)) (WStarRadical.multWeight f a)
      = (a i : K) • aeval (AdjoinRoot.root (f i)) (derivative (WStarRadical.rad f)) := by
  classical
  obtain ⟨c, hc⟩ := multWeight_sub_smul_derivative_rad_dvd f a i
  have h := congrArg (aeval (AdjoinRoot.root (f i))) hc
  have hzero : aeval (AdjoinRoot.root (f i)) (f i) = 0 := by
    rw [AdjoinRoot.aeval_eq, AdjoinRoot.mk_self]
  simp only [map_sub, map_mul, aeval_C, hzero, zero_mul, sub_eq_zero] at h
  rw [h, Algebra.smul_def]

end ComponentField

/-! ## 4. 重み $\mu$ の Gram 行列と本文の 2 つの等式 -/

section Gram

variable {R : Type*} [CommRing R] {A : Type*} [CommRing A] [Algebra R A]
variable {m : ℕ} {ρ : R[X]} {θ : A} (b : Basis (Fin (m + 1)) R A)

/-- 重み $\mu$ の Gram 行列の成分は $\operatorname{Tr}(\mu\theta^{j+k})$ である（定義そのもの）。 -/
theorem weightedGram_apply (θ μ : A) (j k : Fin (m + 1)) :
    EulerDualBasis.weightedGram (R := R) (m := m) θ μ j k
      = Algebra.trace R A (μ * θ ^ ((j : ℕ) + (k : ℕ))) := rfl

/-- **重み $\mu$ の Gram 行列の成分は $\psi(\eta\,\theta^{j+k})$ である**（$\eta=\rho'(\theta)\mu$）。

`EulerDualBasis.trace_eq_psi_derivative_mul` をそのまま当てる。 -/
theorem weightedGram_apply_eq_psi (hb : EulerDualBasis.IsPowerBasisOf b θ)
    (hred : EulerDualBasis.IsReductionOf ρ θ m) (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1)
    (μ : A) (j k : Fin (m + 1)) :
    EulerDualBasis.weightedGram (R := R) (m := m) θ μ j k
      = EulerDualBasis.psi b (aeval θ (derivative ρ) * μ * θ ^ ((j : ℕ) + (k : ℕ))) := by
  rw [weightedGram_apply, EulerDualBasis.trace_eq_psi_derivative_mul b hb hred hmonic hdeg]
  congr 1
  ring

/-- **本文の $\det G=\pm N_{A/R}(\eta)$**（$\eta=\rho'(\theta)\mu$）。

**本文の statement の 2 本目の等式そのものである。** 符号 $\pm$ の中身は Euler の係数行列の
行列式であり、その平方が $1$ であることは `EulerDualBasis.det_eulerMatrix_sq` に入っている。 -/
theorem det_weightedGram_mu (hb : EulerDualBasis.IsPowerBasisOf b θ)
    (hred : EulerDualBasis.IsReductionOf ρ θ m) (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1)
    (μ η : A) (hη : aeval θ (derivative ρ) * μ = η) :
    (EulerDualBasis.weightedGram (R := R) (m := m) θ μ).det
      = (EulerDualBasis.eulerMatrix b ρ θ).det * Algebra.norm R η := by
  rw [EulerDualBasis.det_weightedGram b hb hred hmonic hdeg μ, hη]

end Gram

/-! ## 4b. 仕上げ（本文の設定へ当てる）

本文は $\rho=\mathrm{rad}(\chi)$ と $\eta=(\chi'/h)(\theta)$ を構成で与えている。
段 2 で作った $\mu$ をそこへ入れると、**本文の statement の 2 本目の等式が
$\rho$ と $\eta$ だけから出る**（重み $\mu$ の側に仮定を残さない）。 -/

section Capstone

variable {K : Type*} [Field K] [PerfectField K]

/-- **本文の $\det G=\pm N_{A_K/K}(\eta)$ を、$\mu$ を構成したうえで述べる。**

受け取るのは $\rho$ がモニックで無平方であることと次数だけである。
$\mu$ は段 2 の構成で、$\eta=\rho'(\theta)\mu$ は `derivative_mul_mu` が与える。 -/
theorem det_weightedGram_mu_of_squarefree {m : ℕ} {ρ : K[X]} (hmonic : ρ.Monic)
    (hsq : Squarefree ρ) (hdeg : ρ.natDegree = m + 1) (η : AdjoinRoot ρ) :
    (EulerDualBasis.weightedGram (R := K) (m := m) (AdjoinRoot.root ρ) (mu ρ η)).det
      = (EulerDualBasis.eulerMatrix (WStarPowerBasis.adjoinRootBasis hmonic hdeg) ρ
          (AdjoinRoot.root ρ)).det * Algebra.norm K η :=
  det_weightedGram_mu (WStarPowerBasis.adjoinRootBasis hmonic hdeg)
    (WStarPowerBasis.isPowerBasisOf_adjoinRoot hmonic hdeg)
    (WStarPowerBasis.isReductionOf_adjoinRoot hmonic hdeg) hmonic hdeg (mu ρ η) η
    (derivative_mul_mu hsq η)

end Capstone

/-! ## 5. 残っている同定を 1 段寄せる（両辺は同じ漸化式に従う）

本文の $G$ は整数行列 $(\operatorname{Tr}T^{i+j})$ である。段 4 の行列と同じであることは
$\operatorname{Tr}T^N=\psi(\eta\,\theta^N)$ に他ならない。**それは書いていない。**
ここでは **両辺が $\chi$ の与える同じ線形漸化式に従うこと**だけを書く。
これで残るのは初期値 $N=0,\dots,\deg\chi-1$ の一致だけになる。 -/

section Recurrence

variable {R : Type*} [CommRing R] {A : Type*} [CommRing A] [Algebra R A]

/-- **$\psi(\eta\,\theta^N)$ の側**。$\chi(\theta)=0$ なので $\sum_j \chi_j\,\psi(\eta\theta^{N+j})=0$。 -/
theorem psi_eta_recurrence {m : ℕ} (b : Basis (Fin (m + 1)) R A) (χ : R[X]) {θ : A}
    (hχ : aeval θ χ = 0) (η : A) (N : ℕ) :
    ∑ j ∈ range (χ.natDegree + 1), χ.coeff j • EulerDualBasis.psi b (η * θ ^ (N + j)) = 0 := by
  classical
  calc ∑ j ∈ range (χ.natDegree + 1), χ.coeff j • EulerDualBasis.psi b (η * θ ^ (N + j))
      = EulerDualBasis.psi b (∑ j ∈ range (χ.natDegree + 1), χ.coeff j • (η * θ ^ (N + j))) := by
        simp [EulerDualBasis.psi, map_sum]
    _ = EulerDualBasis.psi b (η * θ ^ N * aeval θ χ) := by
        congr 1
        rw [Polynomial.aeval_eq_sum_range (p := χ) θ, Finset.mul_sum]
        exact Finset.sum_congr rfl fun j _ => by
          rw [Algebra.smul_def, Algebra.smul_def, pow_add]; ring
    _ = 0 := by rw [hχ, mul_zero]; simp [EulerDualBasis.psi]

end Recurrence

section TraceRecurrence

variable {R : Type*} [CommRing R] {n : ℕ}

/-- **$\operatorname{Tr}T^N$ の側**。Cayley–Hamilton に $T^N$ を掛けてトレースを取る。 -/
theorem trace_pow_recurrence (T : Matrix (Fin n) (Fin n) R) (N : ℕ) :
    ∑ j ∈ range (T.charpoly.natDegree + 1),
        T.charpoly.coeff j • Matrix.trace (T ^ (N + j)) = 0 := by
  classical
  calc ∑ j ∈ range (T.charpoly.natDegree + 1),
          T.charpoly.coeff j • Matrix.trace (T ^ (N + j))
      = Matrix.trace (∑ j ∈ range (T.charpoly.natDegree + 1),
          T.charpoly.coeff j • (T ^ (N + j))) := by
        rw [Matrix.trace_sum]
        exact Finset.sum_congr rfl fun j _ => (Matrix.trace_smul _ _).symm
    _ = Matrix.trace (T ^ N * aeval T T.charpoly) := by
        congr 1
        rw [Polynomial.aeval_eq_sum_range (p := T.charpoly) T, Finset.mul_sum]
        exact Finset.sum_congr rfl fun j _ => by rw [mul_smul_comm, ← pow_add]
    _ = 0 := by rw [Matrix.aeval_self_charpoly, mul_zero, Matrix.trace_zero]

end TraceRecurrence

end WStarMuGram
end IntegrableLattice
