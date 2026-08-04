/-
# $w^*$ を適合基底（Smith 標準形）で書く

対応する人手証明:

* 本文ブロック `paper_wstar_different`（命題 W\*）と `paper_prop_C_trace`（命題 C′）
  （`structured-latex/content/004_lambda_finite.ts`）

## このファイルが担当する範囲（正直な範囲宣言）

命題 C′ は $w^*$ を「Gram 行列 $G$ の最大単因子の $p$ 進付値」と定義し、
命題 W\* はそれが $\min\{j\ge0: p^j\eta^{-1}\in A_{(p)}\}$ に等しいと主張する。

cycle 29 step 1 の仕分けは、この段を「素材が無い」と判定した。根拠は
「mathlib の `Module.Basis.SmithNormalForm` は部分加群の基底の形であって整数行列の単因子ではない」
というものである。**本ファイルはその判定を覆す。** 覆す理由は次のとおり:

* 単因子の列 $a_1\mid a_2\mid\cdots$ という**整除の鎖は確かに mathlib に無い**
  （`Ideal.smithCoeffs` に整除を述べた補題は 1 つも無い）。
  したがって「最大単因子」という順序づけられた不変量を直接取ることはできない。
* しかし $w^*$ を取り出すのに整除の鎖は要らない。**$w^*$ は最大単因子を経由せずに、
  適合基底の係数 $a_i$ の $p$ 進付値の最大値として書ける。**
  順序を持たない族の $\max$ で済むので、鎖の欠落は障害にならない。

本ファイルはこれを「$p$ の外で $N$ に属する」という形の言明として形式化する。
$p$ 進の話なので、局所化（$A_{(p)}$）そのものを構成せず、
**$p$ と素な整数を掛ければ入る**という形で書く（同値であり、$\mathbb{Z}$ の中で閉じる）。

## 何が入って、何が入っていないか（命題 W\* の 3 段のうち第 2 段）

入ったもの:

1. $w^*$ の定義そのもの（`wStarOfCoeffs`）と、それが
   $\min\{j:\ p^jM\subseteq N\ (p\ \text{の外で})\}$ に等しいこと（`isLeast_isPLevel`）。
   イデアルへの特殊化（`isLeast_isPLevel_ideal`）と、最小を取る集合が空でないこと
   （`exists_isPLevel_ideal`）。$w^*=0$ の判定（`wStarOfCoeffs_eq_zero_iff`）。
2. **本文の $\det G=\pm N_{A/\mathbb{Q}}(\eta)$**（`det_weightedGram`）と、
   $\eta\neq0$ なら $\det G\neq0$（`det_weightedGram_ne_zero`）。
3. **Euler の双対基底公式を行列の等式にしたもの**——$C\,G=M_\eta$
   （`eulerMatrix_mul_weightedGram`）と $(\det C)^2=1$（`det_eulerMatrix_sq`）。
   その心臓部は $\operatorname{Tr}(c_i w)=[\theta^i](\rho'(\theta)w)$（`trace_coeff_minpolyDiv_mul`）である。
4. 可逆な取り替えで像に対する $p$ 進の条件が変わらないこと（`isPLevel_range_comp`）。

**入っていないもの（この段が完了でない理由）:**

* **$C$ と $G$ の整数への降下。** 上の $C\,G=M_\eta$ と $(\det C)^2=1$ は
  体 $K$（本論文では $\mathbb{Q}$）の上の等式である。人手証明が使うのは
  「$C\in GL_r(\mathbb{Z})$ なので $G$ と $M_\eta$ の余核が同型」という整数の言明で、
  そのためには $C$ の成分が整数であること（$\rho\in\mathbb{Z}[x]$ がモニックなので成り立つはずだが、
  `coeff_minpolyDiv` の漸化式からの帰納法を書いていない）と、
  行列の像と $\eta A$ を基底で同一視する配線が要る。ここは書いていない。
* **$\rho$ が可約な場合。** 上の第 2 段・第 3 段は `PowerBasis K L`（$L$ は体）を使っており、
  $\rho$ が既約な場合しか覆っていない。本文の $\rho=\mathrm{rad}(\chi_T)$ は一般には可約で、
  そのとき $A\otimes\mathbb{Q}$ は体でなく体の積である。
  mathlib のトレース双対（`Module.Basis.traceDual`）は体の上でしか無い。

## 形式化して分かったこと

* **この段に環の構造は要らない。** 効いているのは「有限自由 $\mathbb{Z}$ 加群 $M$ と、
  適合基底を持つ部分加群 $N$」だけである。$A=\mathbb{Z}[x]/(\rho)$ が環であることも、
  $N=\eta A$ がイデアルであることも使わない（イデアルの場合は
  `Ideal.ringBasis` / `Ideal.selfBasis` / `Ideal.smithCoeffs` を渡せばそのまま特殊化される）。
* **$\mathbb{R}$ も $p$ 進整数環も現れない。** $w^*$ は $\mathbb{N}$ の元で、
  判定は整数の割り切れと素因数分解の指数比較だけで閉じている。
-/
import Mathlib

namespace IntegrableLattice

open Finset Module

/-! ## 1. $p$ の外での所属

本文の $A_{(p)}$（$p$ での局所化）は「分母が $p$ と素な分数」を許す環である。
$p^j\eta^{-1}\in A_{(p)}$ は「$p$ と素な整数 $m$ があって $m\,p^j\eta^{-1}\in A$」と同値なので、
局所化を作らずに $\mathbb{Z}$ の中だけで書ける。 -/

section LocalMembership

variable {M : Type*} [AddCommGroup M] [Module ℤ M]

/-- `x` は「`p` の外で」`N` に属する: `p` と素な整数を掛ければ `N` に入る。
本文の $A_{(p)}$ への所属を、局所化を構成せずに書いたもの。 -/
def MemAwayFrom (p : ℕ) (N : Submodule ℤ M) (x : M) : Prop :=
  ∃ m : ℤ, ¬ (p : ℤ) ∣ m ∧ m • x ∈ N

/-- 本文の $\{j\ge0:\ p^{\,j}\eta^{-1}\in A_{(p)}\}$ に対応する述語。
$p^j\eta^{-1}\in A_{(p)}$ は $p^jA\subseteq\eta A$（局所的に）と同値なので、
「すべての `x` について `p^j • x` が `p` の外で `N` に属する」と書ける。 -/
def IsPLevel (p : ℕ) (N : Submodule ℤ M) (j : ℕ) : Prop :=
  ∀ x : M, MemAwayFrom p N (((p : ℤ) ^ j) • x)

theorem isPLevel_mono {p : ℕ} {N : Submodule ℤ M} {j k : ℕ} (hjk : j ≤ k)
    (hj : IsPLevel p N j) : IsPLevel p N k := by
  intro x
  obtain ⟨m, hm, hmem⟩ := hj (((p : ℤ) ^ (k - j)) • x)
  refine ⟨m, hm, ?_⟩
  have : ((p : ℤ) ^ k) • x = ((p : ℤ) ^ j) • (((p : ℤ) ^ (k - j)) • x) := by
    rw [smul_smul, ← pow_add]
    congr 2
    omega
  rw [this]
  exact hmem

end LocalMembership

/-! ## 2. 整数ひとつぶんの補題

$a\mid m\,p^j$ を満たす $p$ と素な $m$ が取れることと、$v_p(a)\le j$ は同値である。
これが「$p$ の外」という言い換えの中身であり、ここに $p$ の素数性が効く。 -/

section IntegerLemma

/-- `a ∣ m * p ^ j` を満たす `p` と素な `m` が存在することと `v_p(a) ≤ j` は同値。 -/
theorem exists_dvd_mul_pow_iff {p : ℕ} (hp : p.Prime) {a : ℤ} (ha : a ≠ 0) (j : ℕ) :
    (∃ m : ℤ, ¬ (p : ℤ) ∣ m ∧ a ∣ m * (p : ℤ) ^ j) ↔ a.natAbs.factorization p ≤ j := by
  have hna : a.natAbs ≠ 0 := Int.natAbs_ne_zero.mpr ha
  have hppos : 0 < p := hp.pos
  constructor
  · rintro ⟨m, hm, hdvd⟩
    -- `p ^ v_p(a) ∣ a ∣ m * p ^ j` で、`p ∤ m` だから `v_p(a) ≤ j`。
    have hm' : ¬ (p ∣ m.natAbs) := fun h => hm (Int.natCast_dvd.mpr h)
    have hmne : m.natAbs ≠ 0 := by
      rintro h
      exact hm' (by simp [h])
    have hpow : (p : ℕ) ^ (a.natAbs.factorization p) ∣ m.natAbs * p ^ j := by
      have h1 : a.natAbs ∣ m.natAbs * p ^ j := by
        have := Int.natAbs_dvd_natAbs.mpr hdvd
        simpa [Int.natAbs_mul] using this
      exact dvd_trans (Nat.ordProj_dvd _ _) h1
    have hne : m.natAbs * p ^ j ≠ 0 := by
      exact Nat.mul_ne_zero hmne (pow_ne_zero _ hppos.ne')
    have hle := (Nat.Prime.pow_dvd_iff_le_factorization hp hne).mp hpow
    rw [Nat.factorization_mul hmne (pow_ne_zero _ hppos.ne'), Finsupp.add_apply,
      Nat.factorization_pow_self hp] at hle
    have hzero : m.natAbs.factorization p = 0 := by
      by_contra hne'
      exact hm' (Nat.dvd_of_factorization_pos hne')
    omega
  · intro hle
    set v := a.natAbs.factorization p with hv
    set c := ordCompl[p] a.natAbs with hc
    have hsplit : p ^ v * c = a.natAbs := Nat.ordProj_mul_ordCompl_eq_self _ _
    refine ⟨(c : ℤ), ?_, ?_⟩
    · intro h
      exact Nat.not_dvd_ordCompl hp hna (Int.ofNat_dvd.mp (by exact_mod_cast h))
    · -- `a.natAbs = p^v * c` なので `a ∣ c * p^j`（`v ≤ j`）。
      have hnat : a.natAbs ∣ c * p ^ j := by
        refine ⟨p ^ (j - v), ?_⟩
        have hpj : p ^ j = p ^ v * p ^ (j - v) := by
          rw [← pow_add]; congr 1; omega
        rw [← hsplit, hpj]
        ring
      have := Int.natCast_dvd_natCast.mpr hnat
      have h2 : (a.natAbs : ℤ) ∣ (c : ℤ) * (p : ℤ) ^ j := by push_cast at this ⊢; exact this
      exact dvd_trans (Int.dvd_natAbs.mpr dvd_rfl) h2

end IntegerLemma

/-! ## 3. 適合基底を持つ部分加群

`Ideal.smithNormalForm`（mathlib）が返すのはこの形——`M` の基底 `bM` と `N` の基底 `bN` があって
`bN i = a i • bM i` となるもの。**整除の鎖 `a i ∣ a (i+1)` は mathlib に無いが、以下では使わない。** -/

section Adapted

variable {ι R M : Type*} [Fintype ι] [CommRing R] [AddCommGroup M] [Module R M]
variable (bM : Basis ι R M) (N : Submodule R M) (bN : Basis ι R N) (a : ι → R)

/-- 適合基底での所属判定: `x ∈ N` は座標が `a i` で割り切れることと同値。 -/
theorem mem_iff_dvd_repr (hb : ∀ i, (bN i : M) = a i • bM i) (x : M) :
    x ∈ N ↔ ∀ i, a i ∣ bM.repr x i := by
  constructor
  · intro hx i
    have h0 : (∑ i, (bN.repr (⟨x, hx⟩ : N) i) • (bN i : M)) = x := by
      have h := congrArg (fun y : N => N.subtype y) (bN.sum_repr (⟨x, hx⟩ : N))
      simpa only [map_sum, map_smul, Submodule.subtype_apply] using h
    have hsum' : x = ∑ i, (bN.repr (⟨x, hx⟩ : N) i * a i) • bM i := by
      refine h0.symm.trans (Finset.sum_congr rfl ?_)
      intro i _
      rw [hb i, smul_smul]
    have hcoord : bM.repr x i = bN.repr (⟨x, hx⟩ : N) i * a i := by
      have h1 := congrArg (fun z : M => (bM.repr z) i) hsum'
      have h2 := congrFun (bM.repr_sum_self (fun i => bN.repr (⟨x, hx⟩ : N) i * a i)) i
      exact h1.trans h2
    exact ⟨bN.repr (⟨x, hx⟩ : N) i, by rw [hcoord]; ring⟩
  · intro hdvd
    choose c hc using hdvd
    have hx : x = ∑ i, c i • (bN i : M) := by
      conv_lhs => rw [← bM.sum_repr x]
      refine Finset.sum_congr rfl ?_
      intro i _
      rw [hb i, smul_smul, mul_comm (c i) (a i), ← hc i]
    rw [hx]
    exact Submodule.sum_mem _ fun i _ => Submodule.smul_mem _ _ (bN i).2

end Adapted

section AdaptedInt

variable {ι M : Type*} [Fintype ι] [AddCommGroup M]
variable (bM : Basis ι ℤ M) (N : Submodule ℤ M) (bN : Basis ι ℤ N) (a : ι → ℤ)

/-- **本文の $w^*$**。適合基底の係数 $a_i$ の $p$ 進付値の最大値。
**最大単因子（整除の鎖の頂点）を経由していない**ことに注意する。 -/
noncomputable def wStarOfCoeffs (p : ℕ) (a : ι → ℤ) : ℕ :=
  univ.sup fun i => (a i).natAbs.factorization p

/-- **この段の主定理**。$\{j: p^jM\subseteq N\ (\text{$p$ の外で})\}$ の最小元は
適合基底の係数の $p$ 進付値の最大値である。

本文の $w^*=\min\{j\ge0:\ p^{\,j}\eta^{-1}\in A_{(p)}\}$ が、
最大単因子という順序づけられた不変量を経由せずに書けることの中身である。 -/
theorem isLeast_isPLevel {p : ℕ} (hp : p.Prime) (hb : ∀ i, (bN i : M) = a i • bM i)
    (ha : ∀ i, a i ≠ 0) :
    IsLeast {j | IsPLevel p N j} (wStarOfCoeffs p a) := by
  classical
  constructor
  · -- `j = wStarOfCoeffs p a` が実際に条件を満たす。
    intro x
    -- 各 `i` で `a i ∣ m_i * p ^ j` となる `p` と素な `m_i` を取り、それらの積を使う。
    have hcoeff : ∀ i : ι, ∃ m : ℤ, ¬ (p : ℤ) ∣ m ∧ a i ∣ m * (p : ℤ) ^ wStarOfCoeffs p a := by
      intro i
      refine (exists_dvd_mul_pow_iff hp (ha i) _).mpr ?_
      exact Finset.le_sup (f := fun i => (a i).natAbs.factorization p) (mem_univ i)
    choose m hm hdvd using hcoeff
    refine ⟨∏ i, m i, ?_, ?_⟩
    · intro h
      obtain ⟨i, _, hi⟩ :=
        (Prime.dvd_finsetProd_iff (Nat.prime_iff_prime_int.mp hp) m).mp h
      exact hm i hi
    · rw [mem_iff_dvd_repr bM N bN a hb]
      intro i
      have hrepr : bM.repr ((∏ i, m i) • ((p : ℤ) ^ wStarOfCoeffs p a) • x) i
          = (∏ i, m i) * ((p : ℤ) ^ wStarOfCoeffs p a) * bM.repr x i := by
        simp [mul_assoc]
      rw [hrepr]
      obtain ⟨d, hd⟩ := hdvd i
      obtain ⟨e, he⟩ : m i ∣ ∏ i, m i := Finset.dvd_prod_of_mem _ (mem_univ i)
      refine ⟨d * e * bM.repr x i, ?_⟩
      calc (∏ i, m i) * ((p : ℤ) ^ wStarOfCoeffs p a) * bM.repr x i
          = (m i * (p : ℤ) ^ wStarOfCoeffs p a) * e * bM.repr x i := by rw [he]; ring
        _ = (a i * d) * e * bM.repr x i := by rw [hd]
        _ = a i * (d * e * bM.repr x i) := by ring
  · -- 最小性: 条件を満たす `j` は各 `v_p(a i)` 以上。
    intro j hj
    refine Finset.sup_le ?_
    intro i _
    refine (exists_dvd_mul_pow_iff hp (ha i) j).mp ?_
    obtain ⟨m, hm, hmem⟩ := hj (bM i)
    refine ⟨m, hm, ?_⟩
    have := (mem_iff_dvd_repr bM N bN a hb _).mp hmem i
    simpa [mul_comm] using this

/-- **本文の $w^*=0$ の判定**。$w^*=0$ は、適合基底の係数がどれも $p$ で割れないことと同値。 -/
theorem wStarOfCoeffs_eq_zero_iff {p : ℕ} (hp : p.Prime) (a : ι → ℤ) (ha : ∀ i, a i ≠ 0) :
    wStarOfCoeffs p a = 0 ↔ ∀ i, ¬ (p : ℤ) ∣ a i := by
  rw [wStarOfCoeffs, show (0 : ℕ) = (⊥ : ℕ) from rfl, Finset.sup_eq_bot_iff]
  constructor
  · intro h i hdvd
    have hzero : (a i).natAbs.factorization p = 0 := h i (mem_univ i)
    have hnat : p ∣ (a i).natAbs := Int.natCast_dvd.mp hdvd
    have := (Nat.Prime.dvd_iff_one_le_factorization hp (Int.natAbs_ne_zero.mpr (ha i))).mp hnat
    omega
  · intro h i _
    by_contra hne
    have : p ∣ (a i).natAbs :=
      Nat.dvd_of_factorization_pos (by simpa using hne)
    exact h i (Int.natCast_dvd.mpr this)

end AdaptedInt

/-! ## 4. イデアルの場合（本文の $\eta A\subseteq A$）

mathlib の `Ideal.smithNormalForm` は、PID $R$ の有限次拡大 $S$ の非零イデアル $I$ に対して
適合基底を返す。本論文の $A=\mathbb{Z}[x]/(\rho)$ と $I=\eta A$ はこの仮定を満たすので、
上の主定理がそのまま特殊化される。 -/

section IdealCase

variable {ι S : Type*} [Fintype ι] [CommRing S] [IsDomain S]

/-- **本文の $w^*$ をイデアルについて書いたもの**。$\{j:\ p^jA\subseteq\eta A\ (p\ \text{の外で})\}$ の
最小元は、適合基底の係数 `Ideal.smithCoeffs` の $p$ 進付値の最大値である。 -/
theorem isLeast_isPLevel_ideal {p : ℕ} (hp : p.Prime) (b : Basis ι ℤ S) (I : Ideal S)
    (hI : I ≠ ⊥) :
    IsLeast {j | IsPLevel p (I.restrictScalars ℤ) j}
      (wStarOfCoeffs p (Ideal.smithCoeffs b I hI)) := by
  classical
  refine isLeast_isPLevel (Ideal.ringBasis b I hI) (I.restrictScalars ℤ)
    ((Ideal.selfBasis b I hI).map
      ((Submodule.restrictScalarsEquiv ℤ S S I).symm.restrictScalars ℤ))
    (Ideal.smithCoeffs b I hI) hp ?_ ?_
  · intro i
    simpa using congrArg (fun x : S => x) (Ideal.selfBasis_def b I hI i)
  · exact fun i => Ideal.smithCoeffs_ne_zero b I hI i

/-- 最小を取る集合が空でないこと（本文の $\min\{j\ge0:\ p^j\eta^{-1}\in A_{(p)}\}$ が
意味をもつことの中身）。 -/
theorem exists_isPLevel_ideal {p : ℕ} (hp : p.Prime) (b : Basis ι ℤ S) (I : Ideal S)
    (hI : I ≠ ⊥) : ∃ j : ℕ, IsPLevel p (I.restrictScalars ℤ) j :=
  ⟨_, (isLeast_isPLevel_ideal hp b I hI).1⟩

end IdealCase

/-! ## 4b. 可逆な取り替えで $w^*$ は変わらない

人手証明は $\operatorname{coker}(G)\cong A/\eta A$ から「$G$ の単因子は $A/\eta A$ の不変量」と言う。
その中身は、可逆な左からの取り替えで像（＝余核）が同型に移ることだけである。 -/

section Invariance

variable {M : Type*} [AddCommGroup M] [Module ℤ M]

/-- 可逆な線形写像を左から合成しても、像に対する $p$ 進の条件は変わらない。 -/
theorem isPLevel_range_comp (u : M ≃ₗ[ℤ] M) (g : M →ₗ[ℤ] M) (p j : ℕ) :
    IsPLevel p (LinearMap.range ((u : M →ₗ[ℤ] M).comp g)) j ↔
      IsPLevel p (LinearMap.range g) j := by
  have hrange : LinearMap.range ((u : M →ₗ[ℤ] M).comp g)
      = (LinearMap.range g).map (u : M →ₗ[ℤ] M) := LinearMap.range_comp _ _
  constructor
  · intro h x
    obtain ⟨m, hm, hmem⟩ := h (u x)
    refine ⟨m, hm, ?_⟩
    rw [hrange] at hmem
    obtain ⟨y, hy, huy⟩ := hmem
    simp only [LinearEquiv.coe_coe] at huy
    have hux : u (m • ((p : ℤ) ^ j • x)) = u y := by
      rw [huy]
      simp
    have hxy : m • ((p : ℤ) ^ j • x) = y := u.injective hux
    rw [hxy]
    exact hy
  · intro h x
    obtain ⟨m, hm, hmem⟩ := h (u.symm x)
    refine ⟨m, hm, ?_⟩
    rw [hrange]
    refine ⟨m • ((p : ℤ) ^ j • u.symm x), hmem, ?_⟩
    simp [smul_smul]

end Invariance

/-! ## 5. Gram 行列の行列式（本文の $\det G=\pm N_{A/\mathbb{Q}}(\eta)$）

本文の $G$ は重み付きトレース形式 $\langle x,y\rangle=\operatorname{Tr}(\mu xy)$ の
Gram 行列である。これは**トレース形式の Gram 行列と、$\mu$ 倍の行列の積**に分解する。
行列式を取れば、判別式と норм の積になる。 -/

section GramDeterminant

variable {K L : Type*} [Field K] [Field L] [Algebra K L] [FiniteDimensional K L]
variable [Algebra.IsSeparable K L]

open Algebra Polynomial

/-- 重み `μ` 付きのトレース形式の Gram 行列（本文の $G=(\operatorname{Tr}(\mu\theta^{i+j}))$）。 -/
noncomputable def weightedGram (pb : PowerBasis K L) (μ : L) :
    Matrix (Fin pb.dim) (Fin pb.dim) K :=
  Matrix.of fun i j => Algebra.trace K L (μ * pb.gen ^ (i.val + j.val))

/-- 重み付き Gram 行列は、トレース形式の Gram 行列と `μ` 倍の行列の積である。 -/
theorem weightedGram_eq (pb : PowerBasis K L) (μ : L) :
    weightedGram pb μ = Algebra.traceMatrix K pb.basis * Algebra.leftMulMatrix pb.basis μ := by
  ext i k
  have hbasis : ∀ n : Fin pb.dim, pb.basis n = pb.gen ^ (n : ℕ) := fun n => by
    simp [PowerBasis.basis_eq_pow]
  have hexp : μ * pb.basis k = ∑ j, pb.basis.repr (μ * pb.basis k) j • pb.basis j :=
    (pb.basis.sum_repr _).symm
  simp only [weightedGram, Matrix.of_apply, Matrix.mul_apply, Algebra.traceMatrix_apply,
    Algebra.traceForm_apply, Algebra.leftMulMatrix_eq_repr_mul]
  calc Algebra.trace K L (μ * pb.gen ^ ((i : ℕ) + (k : ℕ)))
      = Algebra.trace K L (pb.basis i * (μ * pb.basis k)) := by
        rw [hbasis i, hbasis k]
        congr 1
        rw [pow_add]
        ring
    _ = Algebra.trace K L (pb.basis i * ∑ j, pb.basis.repr (μ * pb.basis k) j • pb.basis j) := by
        rw [← hexp]
    _ = ∑ j, Algebra.trace K L (pb.basis i * pb.basis j) * pb.basis.repr (μ * pb.basis k) j := by
        rw [Finset.mul_sum, map_sum]
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [mul_smul_comm, map_smul, smul_eq_mul, mul_comm]

/-- **本文の $\det G=\pm N_{A/\mathbb{Q}}(\eta)$**（$\eta=\rho'(\theta)\mu$）。
重み付き Gram 行列の行列式は、判別式とノルムの積に分解し、
判別式が $\rho'(\theta)$ のノルムに（符号を除いて）等しいことから、$\eta$ のノルムになる。 -/
theorem det_weightedGram (pb : PowerBasis K L) (μ : L) :
    (weightedGram pb μ).det =
      (-1) ^ (Module.finrank K L * (Module.finrank K L - 1) / 2) *
        Algebra.norm K (aeval pb.gen (derivative (minpoly K pb.gen)) * μ) := by
  rw [weightedGram_eq, Matrix.det_mul, ← Algebra.discr_def, Algebra.discr_powerBasis_eq_norm,
    ← Algebra.norm_eq_matrix_det, map_mul]
  ring

/-- 行列式が $0$ でないこと（$\eta\neq0$ のときは $\det G\neq0$）。本文の
$\det G=\operatorname{disc}(\rho)\prod_\lambda m_\lambda\neq0$ の「$\neq0$」にあたる。 -/
theorem det_weightedGram_ne_zero (pb : PowerBasis K L) {μ : L} (hμ : μ ≠ 0) :
    (weightedGram pb μ).det ≠ 0 := by
  rw [det_weightedGram]
  have hd : aeval pb.gen (derivative (minpoly K pb.gen)) ≠ 0 := by
    intro h
    have hdiscr := Algebra.discr_not_zero_of_basis K pb.basis
    rw [Algebra.discr_powerBasis_eq_norm, h] at hdiscr
    rw [Algebra.norm_eq_zero_iff.mpr rfl, mul_zero] at hdiscr
    exact hdiscr rfl
  have : Algebra.norm K (aeval pb.gen (derivative (minpoly K pb.gen)) * μ) ≠ 0 := by
    intro h
    exact mul_ne_zero hd hμ (Algebra.norm_eq_zero_iff.mp h)
  exact mul_ne_zero (pow_ne_zero _ (by norm_num)) this

end GramDeterminant

/-! ## 6. 双対の段（Euler の双対基底公式を整数行列の等式にする）

人手証明の第 2 段は「$\rho$ は分離的なので Euler の双対基底公式より $A^\vee=\rho'(\theta)^{-1}A$、
したがって $\operatorname{coker}(G)\cong A/\eta A$」である。
これを行列の等式 $C\,G=M_\eta$（$C$ は Euler の係数行列、$M_\eta$ は $\eta$ 倍の行列）へ落とす。
$C$ の行列式は $\pm1$ なので、$G$ と $M_\eta$ は同じ余核を持つ。 -/

section Duality

variable {K L : Type*} [Field K] [Field L] [Algebra K L] [FiniteDimensional K L]
variable [Algebra.IsSeparable K L]

open Algebra Polynomial

/-- Euler の係数行列。第 $i$ 行は $\rho(y)/(y-\theta)$ の $y^i$ の係数を基底で表したもの。 -/
noncomputable def eulerMatrix (pb : PowerBasis K L) :
    Matrix (Fin pb.dim) (Fin pb.dim) K :=
  Matrix.of fun i j => pb.basis.repr ((minpolyDiv K pb.gen).coeff i) j

/-- **Euler の双対基底公式の使い方**。$\operatorname{Tr}(c_i\,w)$ は $\rho'(\theta)w$ の
第 $i$ 座標に等しい。ここだけが分離性（トレース形式の非退化性）を使う。 -/
theorem trace_coeff_minpolyDiv_mul (pb : PowerBasis K L) (i : Fin pb.dim) (w : L) :
    Algebra.trace K L ((minpolyDiv K pb.gen).coeff i * w)
      = pb.basis.repr (aeval pb.gen (derivative (minpoly K pb.gen)) * w) i := by
  classical
  set d := aeval pb.gen (derivative (minpoly K pb.gen)) with hd
  have hdual := Basis.traceDual_powerBasis_eq (K := K) pb i
  have hdne : d ≠ 0 := by
    intro h
    have : pb.basis.traceDual i = 0 := by rw [hdual, ← hd, h, div_zero]
    exact (pb.basis.traceDual).ne_zero i this
  have hci : (minpolyDiv K pb.gen).coeff i = d * pb.basis.traceDual i := by
    rw [hdual, ← hd]
    field_simp
  -- `d * w` を基底で展開し、双対基底の性質を各項に使う。
  have hexp : d * w = ∑ k, pb.basis.repr (d * w) k • pb.basis k := (pb.basis.sum_repr _).symm
  calc Algebra.trace K L ((minpolyDiv K pb.gen).coeff i * w)
      = Algebra.trace K L (pb.basis.traceDual i * (d * w)) := by rw [hci]; ring_nf
    _ = Algebra.trace K L
          (pb.basis.traceDual i * ∑ k, pb.basis.repr (d * w) k • pb.basis k) := by rw [← hexp]
    _ = ∑ k, pb.basis.repr (d * w) k *
          Algebra.trace K L (pb.basis.traceDual i * pb.basis k) := by
        rw [Finset.mul_sum, map_sum]
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [mul_smul_comm, map_smul, smul_eq_mul]
    _ = pb.basis.repr (d * w) i := by
        rw [Finset.sum_eq_single i]
        · rw [Basis.trace_traceDual_mul]
          simp
        · intro k _ hk
          rw [Basis.trace_traceDual_mul]
          simp [hk]
        · intro h
          exact absurd (Finset.mem_univ i) h

/-- **双対の段の行列版**。$C\,G=M_\eta$（$\eta=\rho'(\theta)\mu$）。 -/
theorem eulerMatrix_mul_weightedGram (pb : PowerBasis K L) (μ : L) :
    eulerMatrix pb * weightedGram pb μ =
      Algebra.leftMulMatrix pb.basis (aeval pb.gen (derivative (minpoly K pb.gen)) * μ) := by
  classical
  ext i k
  have hbasis : ∀ n : Fin pb.dim, pb.basis n = pb.gen ^ (n : ℕ) := fun n => by
    simp [PowerBasis.basis_eq_pow]
  have hexp : (minpolyDiv K pb.gen).coeff i
      = ∑ j, pb.basis.repr ((minpolyDiv K pb.gen).coeff i) j • pb.basis j :=
    (pb.basis.sum_repr _).symm
  simp only [eulerMatrix, weightedGram, Matrix.of_apply, Matrix.mul_apply,
    Algebra.leftMulMatrix_eq_repr_mul]
  calc ∑ j, pb.basis.repr ((minpolyDiv K pb.gen).coeff i) j *
        Algebra.trace K L (μ * pb.gen ^ ((j : ℕ) + (k : ℕ)))
      = Algebra.trace K L ((minpolyDiv K pb.gen).coeff i * (μ * pb.basis k)) := by
        conv_rhs => rw [hexp]
        rw [Finset.sum_mul, map_sum]
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [smul_mul_assoc, map_smul, smul_eq_mul, hbasis j, hbasis k]
        congr 2
        rw [pow_add]
        ring
    _ = pb.basis.repr (aeval pb.gen (derivative (minpoly K pb.gen)) * (μ * pb.basis k)) i :=
        trace_coeff_minpolyDiv_mul pb i _
    _ = pb.basis.repr (aeval pb.gen (derivative (minpoly K pb.gen)) * μ * pb.basis k) i := by
        rw [mul_assoc]

/-- $C$ の行列式は $\pm1$ である（$\mathbb{Z}$ 上で可逆であることの、体の上での対応物）。
判別式が $\rho'(\theta)$ のノルムに等しいことから出る。 -/
theorem det_eulerMatrix_sq (pb : PowerBasis K L) :
    (eulerMatrix pb).det * (eulerMatrix pb).det = 1 := by
  have h1 := eulerMatrix_mul_weightedGram pb 1
  have hdet := congrArg Matrix.det h1
  rw [Matrix.det_mul, ← Algebra.norm_eq_matrix_det] at hdet
  have hG : weightedGram pb 1 = Algebra.traceMatrix K pb.basis := by
    rw [weightedGram_eq]
    simp
  rw [hG, ← Algebra.discr_def, Algebra.discr_powerBasis_eq_norm, mul_one] at hdet
  set s : K := (-1) ^ (Module.finrank K L * (Module.finrank K L - 1) / 2) with hs
  set n : K := Algebra.norm K (aeval pb.gen (derivative (minpoly K pb.gen))) with hn
  have hnne : n ≠ 0 := by
    have hdiscr := Algebra.discr_not_zero_of_basis K pb.basis
    rw [Algebra.discr_powerBasis_eq_norm, ← hn, ← hs] at hdiscr
    intro h
    rw [h, mul_zero] at hdiscr
    exact hdiscr rfl
  have hssq : s * s = 1 := by
    rw [hs, ← pow_add, ← two_mul, pow_mul]
    norm_num
  -- `det C * (s * n) = n` の両辺から `n` を約せば `det C * s = 1`。
  have hkey : (eulerMatrix pb).det * s = 1 := by
    refine mul_right_cancel₀ hnne ?_
    calc ((eulerMatrix pb).det * s) * n = (eulerMatrix pb).det * (s * n) := by ring
      _ = n := hdet
      _ = 1 * n := (one_mul n).symm
  have hsq : (eulerMatrix pb).det * (eulerMatrix pb).det
      = ((eulerMatrix pb).det * s) * ((eulerMatrix pb).det * s) := by
    have hexp : ((eulerMatrix pb).det * s) * ((eulerMatrix pb).det * s)
        = ((eulerMatrix pb).det * (eulerMatrix pb).det) * (s * s) := by ring
    rw [hexp, hssq, mul_one]
  rw [hsq, hkey, one_mul]

end Duality

end IntegrableLattice
