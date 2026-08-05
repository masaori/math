/-
# 命題 C′ の残り 1 段（$\det G$ を判別式と重複度で書く段）— cycle 42 step 1

対応する人手証明:

* 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement の
  「さらに $\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda\neq0$ であり」の段
* 同じ等式を $\eta$ のノルムの形で述べているのは
  本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の statement の 2 本目である
  （$\det G=\pm N_{A/\mathbb{Q}}(\eta)$。cycle 41 step 1 で `WStarMuGram.det_weightedGram_mu` として入った）

## この step が何を埋めるか

台帳は 命題 C′ の残りを 1 段と数えており、その中身は
**「ノルムの形は入ったが、判別式と重複度で書く形は入っていない」**である。
ノルムの形からそちらへ渡るには 2 つ要る。

1. $\det G$ を $N(\mu)$ と $\operatorname{disc}(\rho)$ の積に分けること。
2. $N(\mu)$ が $\prod_\lambda m_\lambda$ であること。

**本ファイルが書いたのは 1 である。2 は既約な場合だけ書いた。そう書く。**
すなわち判別式へ分ける側は入り、重複度の積そのものは可約な場合が残る。
可約な場合の 2 は成分分解（中国剰余）を要し、書いてみて外側に現れた段である
（下の「形式化しなかったもの」に測った結果を書く）。

## 段 1 が本文のどの言葉に当たるか（記号の突き合わせ）

| 本文 | 意味 | Lean |
|---|---|---|
| $G$ | $(\operatorname{Tr}T^{i+j})$、代数側では $(\operatorname{Tr}(\mu\theta^{j+k}))$ | `EulerDualBasis.weightedGram θ μ` |
| $\operatorname{disc}(\rho)$ | 冪基底 $1,\theta,\dots,\theta^{m}$ のトレース形式の Gram 行列式 | `Algebra.discr R b` |
| $\mu$ | 成分ごとに重複度 $a_i$ をとる元 | `WStarMuGram.mu` |
| $N$ | ノルム | `Algebra.norm` |
| $m_\lambda$ | 根 $\lambda$ の $\chi$ における重複度 | `a i`（既約な場合は単一の $a$） |

**モニックな $\rho$ の判別式は、冪基底のトレース形式の Gram 行列式である**——これが本文の
$\operatorname{disc}(\rho)$ の意味であり、`Algebra.discr` の定義そのものである
（`Algebra.discr_def`: `discr A b = (traceMatrix A b).det`）。
mathlib には多項式そのものの判別式 `Polynomial.discr` も在るが（Sylvester 行列式で定義されている）、
**その 2 つを結ぶ宣言は mathlib に無い**（2026-08-05 実測。下の「形式化しなかったもの」を見よ）。
本ファイルは本文の意味のほう（トレース形式の Gram 行列式）で書く。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは有限自由加群のトレース・行列式・基底の座標だけで、
係数環は任意の可換環である（本文が当てる先は $\mathbb{Z}$ とその分数体 $\mathbb{Q}$。どちらも可算）。

## 書いたこと（3 段）

1. **重み $\mu$ の Gram 行列は、$\mu$ 倍写像の行列の転置と、重み無しの Gram 行列の積である**
   （`weightedGram_eq_leftMulMatrix_transpose_mul`）。
   芯は 1 行で、$\mu\theta^{j}$ を基底で展開して $\theta^{k}$ を掛けるだけである——
   $\operatorname{Tr}(\mu\theta^{j+k})=\operatorname{Tr}((\mu\theta^{j})\theta^{k})$ と書き、
   $\mu\theta^{j}=\sum_t c_{tj}\theta^{t}$ を入れてトレースの線形性で和の外へ出す。
   **モニック性も $\theta$ が根であることも使わない。**要るのは基底が $\theta$ の冪であることだけである。
2. **したがって $\det G=N(\mu)\cdot\operatorname{disc}(\rho)$**
   （`det_weightedGram_eq_norm_mul_discr`）。
   行列式が積を保つことと、ノルムが $\mu$ 倍写像の行列式であること
   （`Algebra.norm_eq_matrix_det`）だけで出る。**符号は付かない。**
   cycle 41 step 1 の `det_weightedGram_mu` はノルムの前に $\pm1$（Euler の係数行列の行列式）が
   付く形だったが、判別式の側へ分けると符号は判別式の中に吸われる。
3. **$\rho$ が既約な場合（本文の「とくに $\rho$ が既約なら」）の重複度の積**
   （`det_weightedGram_of_scalar_mu`）。このとき $\mu$ は重複度 $a$ そのもの（定数）なので
   $N(\mu)=a^{\,r}$ であり（`Algebra.norm_algebraMap_of_basis`）、
   $\det G=a^{\,r}\operatorname{disc}(\rho)$ になる。
   $r=\deg\rho$ は根の個数なので、$a^{\,r}$ が本文の $\prod_\lambda m_\lambda$ である。

## 形式化しなかったもの（実測つき）

* **可約な場合の $N(\mu)=\prod_\lambda m_\lambda$。**
  本文の $\det G$ の重複度の積の形のうち、ここだけが残る。
  $\mu$ は成分 $K_i$ の上で $a_i$ をとる元なので、$N(\mu)=\prod_i a_i^{\deg f_i}$ が要る。
  これには $A_\mathbb{Q}\cong\prod_i K_i$ の分解が要る。
  **2026-08-05 実測**: 中国剰余定理は環同型としては在るが（`Ideal.quotientInfRingEquivPiQuotient`、
  5 ファイル）、**代数としての同型ではなく、直積代数のノルムを因子のノルムの積へ分ける宣言は
  mathlib に無い**（`Algebra.norm` と `Pi` を結ぶ宣言 0 件）。
  **したがってここは配線ではなく素材が要る。そう書く。**
* **`Algebra.discr` と `Polynomial.discr` の一致。**
  本文の $\operatorname{disc}(\rho)$ は前者の意味だが、多項式の判別式（終結式で書く側）と
  同じものであることは述べていない。**2026-08-05 実測**: mathlib の
  `Polynomial.discr`（`Mathlib/RingTheory/Polynomial/Resultant/Basic.lean` 930 行）は
  Sylvester 行列式で定義されており、`Algebra.discr` と結ぶ宣言は無い
  （両者が同じファイルに現れることが 0 件）。**これは本主張の残りではない**——
  本文が言っているのは Gram 行列式の側であり、終結式の形は使っていない。
-/
import Mathlib
import IntegrableLattice.EulerDualBasisCommRing

namespace IntegrableLattice
namespace WStarGramDiscriminant

open Polynomial Finset Module Matrix

/-! ## 段 1: 重み付き Gram 行列を $\mu$ 倍写像で分ける -/

section Split

variable {R : Type*} [CommRing R] {A : Type*} [CommRing A] [Algebra R A]
variable {m : ℕ} {θ : A} (b : Basis (Fin (m + 1)) R A)

/-- **重み $\mu$ の Gram 行列は $M_\mu^{\mathsf T}\,G_1$ である。**

$G_1$ は重み無しの Gram 行列（$=\operatorname{Tr}(\theta^{j+k})$）、
$M_\mu$ は基底 $1,\theta,\dots,\theta^{m}$ による $\mu$ 倍写像の行列である。

証明は $\mu\theta^{j}$ を基底で展開してトレースの線形性を使うだけで、
**モニック性も $\theta$ が $\rho$ の根であることも使わない。** -/
theorem weightedGram_eq_leftMulMatrix_transpose_mul
    (hb : EulerDualBasis.IsPowerBasisOf b θ) (μ : A) :
    EulerDualBasis.weightedGram (R := R) (m := m) θ μ
      = (Algebra.leftMulMatrix b μ)ᵀ * EulerDualBasis.weightedGram (R := R) (m := m) θ 1 := by
  classical
  ext j k
  simp only [EulerDualBasis.weightedGram, Matrix.of_apply, Matrix.mul_apply,
    Matrix.transpose_apply, Algebra.leftMulMatrix_eq_repr_mul, one_mul]
  -- 左辺を $\operatorname{Tr}((\mu\theta^{j})\theta^{k})$ と書き直す
  have hsplit : μ * θ ^ ((j : ℕ) + (k : ℕ)) = (μ * θ ^ (j : ℕ)) * θ ^ (k : ℕ) := by
    rw [pow_add]; ring
  rw [hsplit]
  -- $\mu\theta^{j}$ を基底で展開する
  have hexp : μ * θ ^ (j : ℕ) = ∑ t, b.repr (μ * b j) t • b t := by
    rw [← hb j, b.sum_repr]
  rw [hexp, Finset.sum_mul, map_sum]
  refine Finset.sum_congr rfl fun t _ => ?_
  rw [smul_mul_assoc, map_smul, hb t, smul_eq_mul, ← pow_add]

end Split

/-! ## 段 2: 行列式を取ると判別式とノルムの積になる -/

section Determinant

variable {R : Type*} [CommRing R] {A : Type*} [CommRing A] [Algebra R A]
variable {m : ℕ} {θ : A} (b : Basis (Fin (m + 1)) R A)

/-- 重み無しの Gram 行列は、冪基底のトレース行列そのものである。 -/
theorem weightedGram_one_eq_traceMatrix (hb : EulerDualBasis.IsPowerBasisOf b θ) :
    EulerDualBasis.weightedGram (R := R) (m := m) θ 1 = Algebra.traceMatrix R b := by
  ext j k
  simp only [EulerDualBasis.weightedGram, Matrix.of_apply, Algebra.traceMatrix_apply,
    Algebra.traceForm_apply, one_mul]
  rw [hb j, hb k, ← pow_add]

/-- **本文の $\det G=\operatorname{disc}(\rho)\cdot(\text{重み})$**。

$\det G=N_{A/R}(\mu)\cdot\operatorname{disc}(\rho)$ であり、**符号は付かない。**
`WStarMuGram.det_weightedGram_mu` の $\pm N(\eta)$ の形とはここが違う——
$\eta=\rho'(\theta)\mu$ のうち $\rho'(\theta)$ のノルムの側が判別式に吸われ、
Euler の係数行列の行列式（$\pm1$）もそちらへ入る。 -/
theorem det_weightedGram_eq_norm_mul_discr (hb : EulerDualBasis.IsPowerBasisOf b θ) (μ : A) :
    (EulerDualBasis.weightedGram (R := R) (m := m) θ μ).det
      = Algebra.norm R μ * Algebra.discr R b := by
  classical
  rw [weightedGram_eq_leftMulMatrix_transpose_mul b hb μ, Matrix.det_mul,
    Matrix.det_transpose, ← Algebra.norm_eq_matrix_det b μ,
    weightedGram_one_eq_traceMatrix b hb, Algebra.discr_def]

end Determinant

/-! ## 段 3: 既約な場合（本文の「とくに $\rho$ が既約なら」）

このとき $\chi=\rho^{a}$ で、$\mu$ は定数 $a$ である。
$\prod_\lambda m_\lambda=a^{\,r}$（$r=\deg\rho$ は根の個数）になる。 -/

section Scalar

variable {R : Type*} [CommRing R] {A : Type*} [CommRing A] [Algebra R A]
variable {m : ℕ} {θ : A} (b : Basis (Fin (m + 1)) R A)

/-- **重複度が 1 つしかない場合の $\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda$。**

$\mu$ が定数 $a$ のとき $N(\mu)=a^{\,m+1}$ であり、$m+1=\deg\rho$ は根の個数なので
$a^{\,m+1}$ がちょうど重複度の積である。 -/
theorem det_weightedGram_of_scalar_mu (hb : EulerDualBasis.IsPowerBasisOf b θ) (a : R) :
    (EulerDualBasis.weightedGram (R := R) (m := m) θ (algebraMap R A a)).det
      = a ^ (m + 1) * Algebra.discr R b := by
  classical
  rw [det_weightedGram_eq_norm_mul_discr b hb, Algebra.norm_algebraMap_of_basis b a]
  congr 2
  simp

end Scalar

end WStarGramDiscriminant
end IntegrableLattice
