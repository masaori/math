/-
# 命題 C′ の残り 1 段: 成分への射影で $\mu$ の像が $a_i$ であること — cycle 44 step 1

対応する人手証明:

* 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement の
  「さらに $\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda\neq0$ であり」の段

## この step が何を埋めるか

cycle 42 step 1 は $\det G=N(\mu)\cdot\operatorname{disc}(\rho)$ を書き、
cycle 43 step 1・step 2 は $N(\mu)=\prod_i a_i^{\deg f_i}$ を
「$\mu$ が成分 $K_i$ の上で定数 $a_i$ をとる元である」という仮定の下で書いた。

**残っていたのは、本文の $\mu=\eta/\rho'(\theta)$ が実際にその形をしていることの同定である。**
`WStarMuGram.lean` が持っていたのは $\chi'/h\equiv a_i\,\rho'\pmod{f_i}$ という
多項式の合同までで、$A_\mathbb{Q}\to K_i$ の射影を経由した像の等式は書いていなかった
（同ファイルの段 3 自身がそう書いている）。ここでその射影を当て、
そのまま $\det G$ の等式まで繋いだ。

## 着手して測ると、要るものは 2 つに分かれた。片方は mathlib に在った

台帳は「足りないのは射影を経由する配線だけ」と書いていた。**その見立ては当たっている。
ただし配線の中身は 2 つで、片方は mathlib に在り、片方は無かった。そう書く。**

* **射影そのものは mathlib に在る**（`AdjoinRoot.algHomOfDvd`。
  `Mathlib/RingTheory/AdjoinRoot.lean` 456 行。2026-08-05 実測、mathlib `520045ab14` の 8264 ファイル）。
  $g\mid f$ から $K[x]/(f)\to K[x]/(g)$ を $K$ 代数の射として作る宣言で、
  根の行き先も添えてある（`algHomOfDvd_root`）。**自分で作る必要は無かった。**
* **無いのは、合同から像の等式へ渡るところである。** 渡るのに要るのは射影ではなく、
  $\rho'(\theta_i)$ が $K_i$ の単元であることである。`WStarMuGram` の段 1 は
  $\rho$ 自身の根 $\theta$ についてしか言っていない。中身は同じ Bézout の関係で、
  使うのは $\rho(\theta_i)=0$ だけである（$f_i\mid\rho$ なのでこれは成り立つ）。
  そこで段 1 を「$\rho$ の根であるような任意の代数の元」へ一般化した。

**着手前に見込んでいた障害は、測ると障害ではなかった。そう書く**——
中国剰余の同型の行き先は `K[X] ⧸ Ideal.span {f i}` の形、射影の行き先は `AdjoinRoot (f i)` の形で、
2 つは定義を開けば同じ型だが `Algebra` のインスタンスが別経路で付くので、
同じ式の中で比べるには型の橋が要ると見込んでいた。**橋は要らなかった**——
商の側の書き換えを先に済ませてから `AdjoinRoot` の側へ移れば、そのまま繋がる
（`quotientProdAlgEquiv_mk` と `algHomOfDvd_mk` を分けて書いたのはそのためである）。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは多項式の整除・微分・剰余と、有限自由加群のノルム・
トレースだけである。係数体は任意の完全体で、本文が当てる先は $\mathbb{Q}$（可算）である。
重複度 $a_i$ は $\mathbb{N}$ に、次数 $\deg f_i$ も $\mathbb{N}$ に住む。

## 書いたこと（5 段）

1. **$\rho$ の根における $\rho'$ の値は単元である**（`isUnit_aeval_derivative_of_root`）。
   `WStarMuGram.isUnit_aeval_derivative` はこの $\theta=x\bmod\rho$ の場合である。
2. **射影を多項式の値へ当てる**（`algHomOfDvd_aeval_root` / `algHomOfDvd_mk`）。
   mathlib の射影と `Polynomial.aeval_algHom_apply` を継ぐだけである。
3. **本文の $\mu$ の像が $a_i$ であること**（`algHomOfDvd_mu_eq_multiplicity`）。
   **これが 命題 C′ に残っていた 1 段である。**
   射影を $\eta=\mu\,\rho'(\theta)$ へ当てると $\rho'(\theta_i)\cdot\pi_i(\mu)=a_i\,\rho'(\theta_i)$ になり、
   段 1 が $\rho'(\theta_i)$ を単元にするので割れる。
4. **中国剰余の同型の第 $i$ 成分が段 2 の射影であること**
   （`quotientProdAlgEquiv_mk` / `quotientProdAlgEquiv_apply_eq_algHomOfDvd`）。
5. **本文の $N(\mu)=\prod_i a_i^{\deg f_i}$ と $\det G=\bigl(\prod_i a_i^{\deg f_i}\bigr)\operatorname{disc}(\rho)$**
   （`norm_mu_eq_prod_pow_natDegree` / `det_weightedGram_mu_eq_prod_pow_mul_discr`）。
   cycle 43 step 2 は重みを仮定として受け取っていた。ここで仮定が落ちる。

## 形式化しなかったもの

* **本文の $w^*=0$ が「$\rho\bmod p$ が分離的、かつ全ての重複度で $p\nmid m_\lambda$」と
  同値であること。** これは 命題 C′ の statement が主張している事柄であり、未形式化である。
  **この事柄は台帳の散文が「入っていない」と名指ししていたが、残り項目としては数えられていなかった。
  本 step の実測で分かったので、残り項目へ入れた。そう書く。**
  形は $w^*=0\iff p\nmid\det G$ を経由するはずで、そのためには
  $\det G$ が単因子の積であること（整数行列の Smith 標準形）が要る。
  **これは mathlib に無いと実測されている側である**（`lean/logs/mathlib-gap-survey-cycle41-engines.log`）。
* **本文の整数行列 $(\operatorname{Tr}T^{i+j})$ との同定。**
  段 5 の $G$ は代数のトレースで書いた Gram 行列である。2 つが同じ行列であることは
  命題 W\* の残り（Newton の公式の初期値）の側であって、本 step の内容ではない
  （漸化式までは `TracePowerRecurrence.lean` に在る）。
-/
import Mathlib
import IntegrableLattice.WStarMuGram
import IntegrableLattice.PropCCrtWiring
import IntegrableLattice.WStarGramDiscriminant

namespace IntegrableLattice
namespace PropCMuComponent

open Polynomial Finset

/-! ## 段 1: $\rho$ の根における $\rho'$ の値は単元である

`WStarMuGram.isUnit_aeval_derivative` は $\theta=x\bmod\rho$ の場合だけを言っている。
**成分の根 $\theta_i$ でも同じことが要る**ので、根であることだけを仮定した形へ一般化する。
証明は同じ Bézout の関係 $u\rho+v\rho'=1$ を根で見るだけである。 -/

section Unit

variable {K : Type*} [Field K] [PerfectField K] {A : Type*} [CommRing A] [Algebra K A]

/-- **$\rho$ が無平方で $\theta$ が $\rho$ の根なら、$\rho'(\theta)$ は単元である。**

`WStarMuGram.isUnit_aeval_derivative` はこの $\theta=x\bmod\rho$ の場合である。 -/
theorem isUnit_aeval_derivative_of_root {ρ : K[X]} (hsq : Squarefree ρ) {θ : A}
    (hθ : aeval θ ρ = 0) : IsUnit (aeval θ (derivative ρ)) := by
  obtain ⟨u, v, huv⟩ := PerfectField.separable_iff_squarefree.mpr hsq
  have h := congrArg (aeval θ) huv
  simp only [map_add, map_mul, map_one, hθ, mul_zero, zero_add] at h
  exact ⟨⟨aeval θ (derivative ρ), aeval θ v, by rw [mul_comm]; exact h, h⟩, rfl⟩

end Unit

/-! ## 段 2: 射影を多項式の値へ当てる

**射影そのものは mathlib に在る**（`AdjoinRoot.algHomOfDvd`）。
ここで足すのは、それが多項式の値を多項式の値へ送ることだけである。 -/

section Proj

variable {K : Type*} [Field K] {ρ g : K[X]}

/-- $g\mid\rho$ なら $\rho$ は $g$ の根で消える。 -/
theorem aeval_root_eq_zero_of_dvd (h : g ∣ ρ) :
    aeval (AdjoinRoot.root g) ρ = 0 := by
  obtain ⟨c, rfl⟩ := h
  rw [map_mul, AdjoinRoot.aeval_eq, AdjoinRoot.mk_self, zero_mul]

/-- **成分への射影は多項式の値を多項式の値へ送る。**

本文の $A_\mathbb{Q}\to K_i$ に $p(\theta)$ を通すと $p(\theta_i)$ になる、という段である。 -/
@[simp]
theorem algHomOfDvd_aeval_root (h : g ∣ ρ) (p : K[X]) :
    AdjoinRoot.algHomOfDvd K ρ g h (aeval (AdjoinRoot.root ρ) p)
      = aeval (AdjoinRoot.root g) p := by
  rw [← Polynomial.aeval_algHom_apply, AdjoinRoot.algHomOfDvd_root]

/-- 同じことを剰余類の側で書いた形（段 4 で使う）。 -/
theorem algHomOfDvd_mk (h : g ∣ ρ) (p : K[X]) :
    AdjoinRoot.algHomOfDvd K ρ g h (AdjoinRoot.mk ρ p) = AdjoinRoot.mk g p := by
  rw [← AdjoinRoot.aeval_eq, ← AdjoinRoot.aeval_eq, algHomOfDvd_aeval_root]

end Proj

/-! ## 段 3: 本文の $\mu$ の像は $a_i$ である

**これが 命題 C′ に残っていた 1 段である。** -/

section Component

variable {K : Type*} [Field K] [PerfectField K]
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [PerfectField K] [DecidableEq ι] in
/-- 各因子は根基を割る。 -/
theorem dvd_rad (f : ι → K[X]) (i : ι) : f i ∣ WStarRadical.rad f :=
  Finset.dvd_prod_of_mem f (mem_univ i)

/-- **本文の $\mu$ の成分 $K_i$ での像は $a_i$ である。**

本文が「$\mu$ は成分 $K_i$ の上で重複度 $a_i$ をとる」と書いている段そのものである。
`WStarMuGram` の段 3 は $\chi'/h\equiv a_i\,\rho'\pmod{f_i}$ で止まっていた。 -/
theorem algHomOfDvd_mu_eq_multiplicity (f : ι → K[X]) (a : ι → ℕ)
    (hsq : Squarefree (WStarRadical.rad f)) (i : ι) :
    AdjoinRoot.algHomOfDvd K (WStarRadical.rad f) (f i) (dvd_rad f i)
        (WStarMuGram.mu (WStarRadical.rad f)
          (aeval (AdjoinRoot.root (WStarRadical.rad f)) (WStarRadical.multWeight f a)))
      = algebraMap K (AdjoinRoot (f i)) ((a i : K)) := by
  have hu : IsUnit (aeval (AdjoinRoot.root (f i)) (derivative (WStarRadical.rad f))) :=
    isUnit_aeval_derivative_of_root hsq (aeval_root_eq_zero_of_dvd (dvd_rad f i))
  have key := congrArg (AdjoinRoot.algHomOfDvd K (WStarRadical.rad f) (f i) (dvd_rad f i))
    (WStarMuGram.derivative_mul_mu hsq
      (aeval (AdjoinRoot.root (WStarRadical.rad f)) (WStarRadical.multWeight f a)))
  rw [map_mul, algHomOfDvd_aeval_root, algHomOfDvd_aeval_root,
    WStarMuGram.aeval_multWeight_eq_on_component f a i, Algebra.smul_def] at key
  exact hu.mul_left_cancel (by rw [key, mul_comm])

end Component

/-! ## 段 4: 中国剰余の同型の第 $i$ 成分は段 2 の射影である

cycle 43 step 2 の `quotientProdAlgEquiv` は商 $K[x]/(\prod_i f_i)$ から出ており、
段 2 の射影は `AdjoinRoot` から出ている。**2 つは同じ写像である。**
商の側の書き換えを先に済ませてから `AdjoinRoot` の側へ移る。 -/

section Bridge

variable {K : Type*} [Field K] {n : ℕ} {f : Fin n → K[X]}

set_option maxHeartbeats 1000000 in
/-- 中国剰余の同型を剰余類に当てた形。 -/
theorem quotientProdAlgEquiv_mk (hco : Pairwise (Function.onFun IsCoprime f)) (i : Fin n)
    (p : K[X]) :
    PropCCrtWiring.quotientProdAlgEquiv hco (Ideal.Quotient.mk _ p) i
      = Ideal.Quotient.mk (Ideal.span {f i}) p := by
  rw [PropCCrtWiring.quotientProdAlgEquiv, AlgEquiv.trans_apply, Ideal.quotientEquivAlgOfEq_mk]
  exact Ideal.quotientInfToPiQuotient_mk' _ _ _

set_option maxHeartbeats 1000000 in
/-- **中国剰余の同型の第 $i$ 成分は、成分への射影そのものである。** -/
theorem quotientProdAlgEquiv_apply_eq_algHomOfDvd
    (hco : Pairwise (Function.onFun IsCoprime f)) (i : Fin n) (x : AdjoinRoot (∏ j, f j)) :
    PropCCrtWiring.quotientProdAlgEquiv hco x i
      = AdjoinRoot.algHomOfDvd K (∏ j, f j) (f i) (Finset.dvd_prod_of_mem f (mem_univ i)) x := by
  induction x using AdjoinRoot.induction_on with
  | ih p =>
    rw [algHomOfDvd_mk]
    exact quotientProdAlgEquiv_mk hco i p

end Bridge

/-! ## 段 5: 本文の $N(\mu)$ と $\det G$

cycle 43 step 2 は重みを「成分ごとに定数 $a_i$ をとる元」として仮定で受け取っていた。
段 3 でその仮定が本文の $\mu$ について実際に成り立つので、仮定を落とせる。 -/

section Capstone

open WStarRadical

variable {K : Type*} [Field K] [PerfectField K] {n : ℕ}

set_option maxHeartbeats 1000000 in
/-- **本文の $N_{A_K/K}(\mu)=\prod_i a_i^{\deg f_i}$。**

右辺は根 $\lambda$ をわたる重複度の積 $\prod_\lambda m_\lambda$ そのものである。
**$\mu$ は仮定ではなく本文の構成（$\eta/\rho'(\theta)$）で与えられている。** -/
theorem norm_mu_eq_prod_pow_natDegree (f : Fin n → K[X]) (a : Fin n → ℕ)
    (hirr : ∀ i, Irreducible (f i)) (hmonic : ∀ i, (f i).Monic) (hinj : Function.Injective f) :
    Algebra.norm K (WStarMuGram.mu (rad f)
        (aeval (AdjoinRoot.root (rad f)) (multWeight f a)))
      = ∏ i, (a i : K) ^ (f i).natDegree := by
  have hndvd : ∀ i j, i ≠ j → ¬ f i ∣ f j := by
    intro i j hij hdvd
    exact hij (hinj (Polynomial.eq_of_monic_of_associated (hmonic i) (hmonic j)
      ((((hirr j).dvd_iff.mp hdvd).resolve_left (hirr i).not_isUnit)).symm))
  have hsq : Squarefree (rad f) :=
    WStarRadical.squarefree_rad (fun i => (hirr i).prime) hndvd
  have hco := PropCCrtWiring.pairwise_isCoprime_of_irreducible hirr hmonic hinj
  set μ := WStarMuGram.mu (rad f) (aeval (AdjoinRoot.root (rad f)) (multWeight f a)) with hμdef
  have hcomp : PropCCrtWiring.quotientProdAlgEquiv hco μ
      = fun i => algebraMap K (K[X] ⧸ Ideal.span {f i}) ((a i : K)) := by
    funext i
    rw [quotientProdAlgEquiv_apply_eq_algHomOfDvd]
    exact algHomOfDvd_mu_eq_multiplicity f a hsq i
  have hsymm : μ = (PropCCrtWiring.quotientProdAlgEquiv hco).symm
      (fun i => algebraMap K (K[X] ⧸ Ideal.span {f i}) ((a i : K))) := by
    rw [← hcomp, AlgEquiv.symm_apply_apply]
  rw [hsymm]
  exact PropCCrtWiring.norm_eq_prod_pow_natDegree hirr hmonic hinj (fun i => (a i : K))

set_option maxHeartbeats 1000000 in
/-- **本文の $\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda$（可約な $\rho$ を含む）。**

cycle 42 step 1 の $\det G=N(\mu)\operatorname{disc}(\rho)$ に段 5 の $N(\mu)$ を入れた形である。
**ここでいう $G$ は代数のトレースで書いた Gram 行列であり、
本文の整数行列 $(\operatorname{Tr}T^{i+j})$ との同定は 命題 W\* の残りの側である。** -/
theorem det_weightedGram_mu_eq_prod_pow_mul_discr {m : ℕ} (f : Fin n → K[X]) (a : Fin n → ℕ)
    (hirr : ∀ i, Irreducible (f i)) (hmonic : ∀ i, (f i).Monic) (hinj : Function.Injective f)
    (hdeg : (rad f).natDegree = m + 1) :
    (EulerDualBasis.weightedGram (R := K) (m := m) (AdjoinRoot.root (rad f))
        (WStarMuGram.mu (rad f) (aeval (AdjoinRoot.root (rad f)) (multWeight f a)))).det
      = (∏ i, (a i : K) ^ (f i).natDegree)
        * Algebra.discr K (WStarPowerBasis.adjoinRootBasis (WStarRadical.rad_monic hmonic) hdeg) := by
  rw [WStarGramDiscriminant.det_weightedGram_eq_norm_mul_discr _
    (WStarPowerBasis.isPowerBasisOf_adjoinRoot (WStarRadical.rad_monic hmonic) hdeg),
    norm_mu_eq_prod_pow_natDegree f a hirr hmonic hinj]

end Capstone

end PropCMuComponent
end IntegrableLattice
