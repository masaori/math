/-
# 命題 C′ の $\det G$ を、可約な $\rho$ でも重複度の積で書く段 — cycle 43 step 2

対応する人手証明:

* 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement の
  「さらに $\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda\neq0$ であり」の段

## この step が何を埋めるか

cycle 43 step 1（`ProductAlgebraNorm.lean`）は、直積代数のノルムが成分のノルムの積に
なることを書いた。**残っていたのは、本文の $\mathbb{Q}[x]/(\rho)$ をその形へ当てる配線である。**

当てるのに要るのは 3 つで、
$\rho$ の相異なる既約因子が生成するイデアルが対ごとに互いに素であること、
それらの共通部分が $(\rho)$ であること、
そして各成分の階数が因子の次数であることである。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。係数体は任意の体で、本文が当てる先は $\mathbb{Q}$（可算）である。
出てくる量は多項式の次数（$\mathbb{N}$）と重複度（$\mathbb{N}$）だけで、
主張の右辺 $\prod_\lambda m_\lambda$ は整数である。

## 書いたこと

1. **相異なるモニック既約多項式は互いに素である**（`pairwise_isCoprime_of_irreducible`）。
   芯は 1 行で、既約元が互いに素でないのは割り切るときだけであり
   （`Irreducible.coprime_iff_not_dvd`）、モニック既約どうしで割り切れば等しい。
2. **その共通部分は積が生成するイデアルである**（`iInf_span_eq_span_prod`）。
3. **したがって $K[x]/(\rho)\cong\prod_i K[x]/(f_i)$**（`quotientProdAlgEquiv`）。
4. **各成分の階数は因子の次数である**（`finrank_quotient_span`）。
5. **本文の等式**（`norm_eq_prod_pow_natDegree`）。
   成分ごとに定数 $a_i$ をとる元のノルムが $\prod_i a_i^{\deg f_i}$ になる。
   $\deg f_i$ は成分の根の個数なので、右辺がちょうど本文の $\prod_\lambda m_\lambda$ である。

## 形式化しなかったもの

* **成分への射影で $\mu$ の像が $a_i$ であること。**
  本ファイルは重みを「成分ごとに定数 $a_i$ をとる元」として受け取っている。
  本文の $\mu=\eta/\rho'(\theta)$ がその形であることは、
  $A_\mathbb{Q}\to K_i$ の射影を経由して言う必要がある。
  **`WStarMuGram.lean` が持っているのは $\chi'/h\equiv a_i\,\rho'\pmod{f_i}$ という
  多項式の合同までで、射影を経由した像の等式は書いていない**
  （同ファイルの段 3 が「成分 $K_i$ での $\mu$ の像そのものを $a_i$ と書く形にはしていない」と
  書いているとおりである。2026-08-05 に直読して確かめた）。
-/
import Mathlib
import IntegrableLattice.ProductAlgebraNorm

namespace IntegrableLattice
namespace PropCCrtWiring

open Polynomial

/-! ## 段 1: 相異なるモニック既約多項式は互いに素である -/

section Coprime

variable {K : Type*} [Field K] {n : ℕ} {f : Fin n → K[X]}

/-- **相異なるモニック既約多項式は対ごとに互いに素である。**

既約元 $p$ が $q$ と互いに素でないのは $p\mid q$ のときに限る
（`Irreducible.coprime_iff_not_dvd`）。$q$ も既約でモニックなら、割り切れば等しい。 -/
theorem pairwise_isCoprime_of_irreducible
    (hirr : ∀ i, Irreducible (f i)) (hmonic : ∀ i, (f i).Monic)
    (hinj : Function.Injective f) :
    Pairwise (Function.onFun IsCoprime f) := by
  intro i j hij
  rw [Function.onFun, (hirr i).coprime_iff_not_dvd]
  intro hdvd
  -- 既約どうしで割り切れば同伴、モニックなら等しい
  exact hij (hinj (Polynomial.eq_of_monic_of_associated (hmonic i) (hmonic j)
    ((((hirr j).dvd_iff.mp hdvd).resolve_left (hirr i).not_isUnit).symm)))

end Coprime

/-! ## 段 2–3: 商が成分の直積になる -/

section Decomposition

variable {K : Type*} [Field K] {n : ℕ} {f : Fin n → K[X]}

/-- **相異なる既約因子が生成するイデアルの共通部分は、積が生成するイデアルである。** -/
theorem iInf_span_eq_span_prod (hco : Pairwise (Function.onFun IsCoprime f)) :
    (⨅ i, Ideal.span {f i}) = Ideal.span {∏ i, f i} :=
  Ideal.iInf_span_singleton (fun _ _ h => hco h)

/-- 元の互いに素性を、生成するイデアルの互いに素性へ移す。 -/
theorem pairwise_isCoprime_span (hco : Pairwise (Function.onFun IsCoprime f)) :
    Pairwise (Function.onFun IsCoprime (fun i => Ideal.span {f i})) :=
  fun _ _ h => (Ideal.isCoprime_span_singleton_iff _ _).mpr (hco h)

/-- **$K[x]/(\rho)\cong\prod_i K[x]/(f_i)$ を $K$ 代数の同型として与える。**

step 1 の中国剰余の代数版（`ProductAlgebraNorm.quotientInfAlgEquivPiQuotient`）へ、
段 2 でイデアルを書き換えて渡すだけである。 -/
noncomputable def quotientProdAlgEquiv (hco : Pairwise (Function.onFun IsCoprime f)) :
    (K[X] ⧸ Ideal.span {∏ i, f i}) ≃ₐ[K] ∀ i, K[X] ⧸ Ideal.span {f i} :=
  (Ideal.quotientEquivAlgOfEq K (iInf_span_eq_span_prod hco).symm).trans
    (ProductAlgebraNorm.quotientInfAlgEquivPiQuotient (S := K) _ (pairwise_isCoprime_span hco))

end Decomposition

/-! ## 段 4: 成分の階数は因子の次数である -/

section Rank

variable {K : Type*} [Field K]

/-- **$K[x]/(g)$ の $K$ 上の階数は $\deg g$ である。**

`AdjoinRoot g` は定義上この商であり、$g$ がモニックなら冪基底を持つ。 -/
theorem finrank_quotient_span {g : K[X]} (hg : g.Monic) :
    Module.finrank K (K[X] ⧸ Ideal.span {g}) = g.natDegree := by
  have : Module.finrank K (AdjoinRoot g) = g.natDegree := by
    rw [(AdjoinRoot.powerBasis' hg).finrank, AdjoinRoot.powerBasis'_dim]
  exact this

end Rank

/-! ## 段 5: 本文の等式 -/

section Norm

variable {K : Type*} [Field K] {n : ℕ} {f : Fin n → K[X]}

/-- **本文の $\det G$ の重複度の積の形（可約な $\rho$ の場合を含む）。**

$\rho=\prod_i f_i$ を相異なるモニック既約因子の積とし、
$\mu$ が成分 $K[x]/(f_i)$ の上で定数 $a_i$ をとる元であるとき、
$$N_{K[x]/(\rho)}(\mu)=\prod_i a_i^{\deg f_i}.$$

右辺は根 $\lambda$ をわたる重複度の積 $\prod_\lambda m_\lambda$ そのものである——
$f_i$ の根はどれも重複度 $a_i$ をもち、その個数が $\deg f_i$ だからである。

**cycle 42 step 1 は既約な場合だけを書いていた。ここで可約な場合が入る。** -/
theorem norm_eq_prod_pow_natDegree
    (hirr : ∀ i, Irreducible (f i)) (hmonic : ∀ i, (f i).Monic)
    (hinj : Function.Injective f) (a : Fin n → K) :
    Algebra.norm K
        ((quotientProdAlgEquiv
            (pairwise_isCoprime_of_irreducible hirr hmonic hinj)).symm
          (fun i => algebraMap K (K[X] ⧸ Ideal.span {f i}) (a i)))
      = ∏ i, a i ^ (f i).natDegree := by
  classical
  have hco := pairwise_isCoprime_of_irreducible hirr hmonic hinj
  haveI hnt : ∀ i, Nontrivial (K[X] ⧸ Ideal.span {f i}) := by
    intro i
    exact Ideal.Quotient.nontrivial_iff.mpr
      (by simpa [Ideal.span_singleton_eq_top] using (hirr i).not_isUnit)
  haveI hfin : ∀ i, Module.Finite K (K[X] ⧸ Ideal.span {f i}) := by
    intro i
    exact Module.Finite.of_basis (AdjoinRoot.powerBasis' (hmonic i)).basis
  have hmove := Algebra.norm_eq_of_algEquiv (quotientProdAlgEquiv hco)
    ((quotientProdAlgEquiv hco).symm (fun i => algebraMap K (K[X] ⧸ Ideal.span {f i}) (a i)))
  rw [AlgEquiv.apply_symm_apply] at hmove
  rw [← hmove, ProductAlgebraNorm.norm_pi_fin_of_scalar]
  exact Finset.prod_congr rfl fun i _ => by rw [finrank_quotient_span (hmonic i)]

end Norm

end PropCCrtWiring
end IntegrableLattice
