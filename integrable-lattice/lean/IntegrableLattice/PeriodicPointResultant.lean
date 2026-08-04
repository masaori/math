/-
# 周期点数が入れ子の終結式で書けること（本文の claim「周期点数は入れ子の終結式で厳密に計算できる」）

対応する人手証明: 本文 `structured-latex/content/002_setup.ts` の
`paper_022_claim_resultant`（`paper_def_aL` で定義した $a_L$ の終結式表示）。

## このファイルが埋めるもの

本文の claim は次を主張している。

$$a_L=\prod_{z_1^{L}=\dots=z_d^{L}=1}P(z_1,\dots,z_d)
  =\mathrm{Res}_{z}\Bigl(z^L-1,\ \mathrm{Res}_{w}\bigl(w^L-1,\ P(z,w)\bigr)\Bigr)\quad(d=2)$$

人手証明の根拠は「$z^L-1$ がモニックなので
$\mathrm{Res}(f,g)=\mathrm{lc}(f)^{\deg g}\prod_{f(\alpha)=0}g(\alpha)$ が根での積そのものを与える」ことである。

**cycle 28 までの `PropV.lean` はこの等式を形式化していない。** あちらは $a_L$ を
**終結式そのものとして定義**したうえで、$a_{p^n}\equiv P(1,\dots,1)^{p^{dn}}\pmod p$ を証明している。
つまり「終結式で書ける」という claim の内容——1 の冪根の上の積と終結式が一致すること——は
どの $d$ についても Lean に無かった。本ファイルはそれを $d=1$ と $d=2$ について書く。

## 人手証明のどこが Lean のどれか

| 人手証明 | Lean |
| --- | --- |
| $\mathrm{Res}(f,g)=\mathrm{lc}(f)^{\deg g}\prod_{f(\alpha)=0}g(\alpha)$ | mathlib `Polynomial.resultant_eq_prod_eval` |
| $z^L-1$ がモニック（$\mathrm{lc}=1$） | `Polynomial.monic_X_pow_sub_C` |
| $d=1$: $a_L=\prod_{\zeta^L=1}P(\zeta)$ | `resultant_X_pow_sub_one_eq_prod_eval` |
| 内側を $w$ について、外側を $z$ について適用する | `outerRes_eq_prod_prod_eval` |
| 一般の $d$: 終結式を $d$ 回入れ子にする | `nestedRes_eq_tupleProd` |

## 一般の $d$ について（cycle 29 で入れた。壁の判定を覆した記録）

cycle 29 step 1 は「一般の $d$ には反復多項式環 $R[z_1]\cdots[z_d]$ を $d$ について
再帰で作る型が要り、こちらがそれを持っていない」と書いた。**この判定は誤りだった。**
新しい型を再帰で組む必要は無い——$d$ 変数多項式環 `MvPolynomial (Fin d) K` から
変数を 1 つだけ外へ出す同型

$$\texttt{MvPolynomial.finSuccEquiv}:\
  \mathrm{MvPolynomial}(\mathrm{Fin}(d+1),K)\ \simeq\ \bigl(\mathrm{MvPolynomial}(\mathrm{Fin}\,d,K)\bigr)[X]$$

が mathlib に在り（`Mathlib/Algebra/MvPolynomial/Equiv.lean`）、これが
「反復多項式環を $d$ について再帰で作る」ことそのものを与える。
型と環構造を同時に決める必要が生じるのは反復多項式環を新しい型として定義した場合であって、
既に環である $d$ 変数多項式環から変数を 1 つずつ剥がす形にすれば生じない。

## 形式化していないもの（正直に書く）

- 本文の「$P$ が 1 の冪根の組で零点をもたなければ $a_L=a^{\mathrm{red}}_L$」と、
  単項式倍で $a_L$ が変わらないこと。
- 「$v_p(a_L)$ が有限手続きで決まる」という決定可能性の主張
  （$a_L$ が整数であること自体は終結式の定義から出るが、手続きの主張は命題ではない）。

## 帰属について

$1$ の $L$ 乗根は $\overline{\mathbb{Q}}$ の元であって $\mathbb{R}$ の元ではない。
本ファイルは根が住む環 $R$ を仮定として受け取るだけで、実数体も複素数体も使わない
（それらの型はこのファイルに 1 度も現れない。分解する体を代数閉体に固定していないので、
$\overline{\mathbb{Q}}$ を取れば可算側に留まる）。
終結式の値そのものは $R$ の元であり、$P\in\mathbb{Z}[z]$ なら $\mathbb{Z}$ に落ちる。
-/
import Mathlib

namespace IntegrableLattice

open Polynomial

/-! ## 1. $d=1$: 終結式は 1 の冪根の上の積そのもの -/

/-- **claim の $d=1$ の中身**: $z^L-1$ が $R$ 上で 1 次因子へ分解するなら

$$\mathrm{Res}(z^L-1,\ P)=\prod_{\zeta^L=1}P(\zeta)$$

（右辺の積は $z^L-1$ の根の重複度こみの積）。

人手証明が使うのは $z^L-1$ がモニックであること 1 点だけである。それが
`Monic.leadingCoeff` として現れ、`resultant_eq_prod_eval` の $\mathrm{lc}(f)^{\deg g}$ を消す。 -/
theorem resultant_X_pow_sub_one_eq_prod_eval {R : Type*} [CommRing R] [IsDomain R]
    {L : ℕ} (hL : 0 < L) (P : R[X]) (M : ℕ) (hM : P.natDegree ≤ M)
    (hsplits : ((X : R[X]) ^ L - 1).Splits) :
    ((X : R[X]) ^ L - 1).resultant P L M
      = ((((X : R[X]) ^ L - 1).roots).map P.eval).prod := by
  have hC : (X : R[X]) ^ L - 1 = (X : R[X]) ^ L - C 1 := by simp
  have hmonic : ((X : R[X]) ^ L - 1).Monic := by
    rw [hC]; exact monic_X_pow_sub_C (1 : R) hL.ne'
  have hdeg : ((X : R[X]) ^ L - 1).natDegree = L := by
    rw [hC]; exact natDegree_X_pow_sub_C
  have h := resultant_eq_prod_eval ((X : R[X]) ^ L - 1) P M hM hsplits
  rw [hdeg, hmonic.leadingCoeff, one_pow, one_mul] at h
  exact h

/-! ## 2. $d=2$: 内側を $w$ について、外側を $z$ について

`PropV.lean` と同じ形の定義を使う（あちらは $\mathbb{Z}$ 係数に固定しているので、
ここでは根が住む体の上で同じ形を置く）。 -/

section TwoVariable

variable {K : Type*} [Field K]

/-- 内側の終結式 $\mathrm{Res}_w(w^L-1,\ P)\in K[z]$。 -/
noncomputable def innerRes (P : (K[X])[X]) (L N : ℕ) : K[X] :=
  ((X : (K[X])[X]) ^ L - 1).resultant P L N

/-- 外側の終結式 $\mathrm{Res}_z(z^L-1,\ \mathrm{Res}_w(w^L-1,\ P))\in K$。 -/
noncomputable def outerRes (P : (K[X])[X]) (L M N : ℕ) : K :=
  ((X : K[X]) ^ L - 1).resultant (innerRes P L N) L M

/-- 内側の終結式を $z=\zeta$ で評価すると、$P(\zeta,\cdot)$ の終結式になる。
形式次数を固定してあるので `resultant_map_map` がそのまま使える
（人手証明の「モニックだから形式次数のずれが吸収される」に対応する）。 -/
theorem eval_innerRes (P : (K[X])[X]) (L N : ℕ) (ζ : K) :
    (innerRes P L N).eval ζ
      = ((X : K[X]) ^ L - 1).resultant (P.map (evalRingHom ζ)) L N := by
  have hmap := resultant_map_map ((X : (K[X])[X]) ^ L - 1) P L N (evalRingHom ζ)
  have hX : (((X : (K[X])[X]) ^ L - 1).map (evalRingHom ζ)) = (X : K[X]) ^ L - 1 := by
    simp
  rw [hX] at hmap
  exact hmap.symm

/-- **claim の $d=2$ の中身**:

$$\mathrm{Res}_{z}\bigl(z^L-1,\ \mathrm{Res}_{w}(w^L-1,\ P)\bigr)
  =\prod_{\zeta^L=1}\ \prod_{\xi^L=1}P(\zeta,\xi).$$

証明は $d=1$ の補題（`resultant_X_pow_sub_one_eq_prod_eval`）を 2 回使うだけである。
**これが人手証明の「一般の $d$ でも終結式を $d$ 回入れ子にすればよい」の中身**であり、
$d$ が増えても同じ補題を 1 回ずつ増やすことに他ならない。 -/
theorem outerRes_eq_prod_prod_eval {L : ℕ} (hL : 0 < L) (P : (K[X])[X]) (M N : ℕ)
    (hN : P.natDegree ≤ N) (hM : (innerRes P L N).natDegree ≤ M)
    (hsplits : ((X : K[X]) ^ L - 1).Splits) :
    outerRes P L M N
      = ((((X : K[X]) ^ L - 1).roots).map
          (fun ζ => ((((X : K[X]) ^ L - 1).roots).map
            (fun ξ => (P.map (evalRingHom ζ)).eval ξ)).prod)).prod := by
  rw [outerRes, resultant_X_pow_sub_one_eq_prod_eval hL (innerRes P L N) M hM hsplits]
  refine congrArg Multiset.prod (Multiset.map_congr rfl ?_)
  intro ζ _
  rw [eval_innerRes P L N ζ]
  exact resultant_X_pow_sub_one_eq_prod_eval hL (P.map (evalRingHom ζ)) N
    ((natDegree_map_le).trans hN) hsplits

end TwoVariable

/-! ## 3. 一般の $d$: 変数を 1 つずつ剥がす

$d=2$ でやったこと（内側を $w$ について、外側を $z$ について）を、そのまま $d$ 段へ伸ばす。
剥がす道具は `MvPolynomial.finSuccEquiv` で、これが反復多項式環の役目を果たす。 -/

section GeneralDimension

variable {K : Type*} [Field K]

/-- $1$ の $L$ 乗根の多重集合（重複度こみ）。$K$ を代数体の中に取れば可算側に留まる。 -/
noncomputable def unityRoots (K : Type*) [Field K] (L : ℕ) : Multiset K :=
  ((X : K[X]) ^ L - 1).roots

/-- 変数を 1 つ剥がす終結式 $\mathrm{Res}_{z_0}(z_0^L-1,\ P)$。
値は残りの $d$ 変数の多項式である。形式次数は実次数に取る（人手証明が形式次数を選んでいないため）。 -/
noncomputable def peelRes (L : ℕ) {d : ℕ} (P : MvPolynomial (Fin (d + 1)) K) :
    MvPolynomial (Fin d) K :=
  ((X : (MvPolynomial (Fin d) K)[X]) ^ L - 1).resultant
    (MvPolynomial.finSuccEquiv K d P) L (MvPolynomial.finSuccEquiv K d P).natDegree

/-- **$d$ 重の入れ子の終結式**。変数 $z_0,z_1,\dots$ の順に 1 つずつ消す。
$d$ についての再帰はこの定義だけで、新しい型は作っていない。 -/
noncomputable def nestedRes (L : ℕ) : (d : ℕ) → MvPolynomial (Fin d) K → K
  | 0, P => MvPolynomial.eval Fin.elim0 P
  | d + 1, P => nestedRes L d (peelRes L P)

/-- 成分がすべて $1$ の $L$ 乗根であるような $d$ 個組の多重集合（重複度こみ）。
本文の添字 $z_1^L=\dots=z_d^L=1$ にあたる。 -/
noncomputable def rootTuples (K : Type*) [Field K] (L : ℕ) :
    (d : ℕ) → Multiset (Fin d → K)
  | 0 => {Fin.elim0}
  | d + 1 => (unityRoots K L).bind fun ζ => (rootTuples K L d).map (Fin.cons ζ)

/-- **本文の左辺** $\prod_{z_1^L=\dots=z_d^L=1}P(z_1,\dots,z_d)$。
乗法的であること（下の帰納法で使う）は、評価が環準同型であることから直ちに出るので、
モノイド準同型として束ねておく。 -/
noncomputable def tupleProdHom (L d : ℕ) : MvPolynomial (Fin d) K →* K where
  toFun P := ((rootTuples K L d).map fun v => MvPolynomial.eval v P).prod
  map_one' := by simp
  map_mul' P Q := by
    simp only [map_mul]
    exact Multiset.prod_map_mul

/-- 変数 $z_0$ に $\zeta$ を代入してから残りを評価するのと、組 $(\zeta,w)$ で一度に評価するのは同じ。
mathlib の `MvPolynomial.eval_eq_eval_mv_eval'` を、係数を先に潰す形からこちらの形へ移しただけである。 -/
theorem eval_cons_eq_eval_eval {d : ℕ} (ζ : K) (w : Fin d → K)
    (P : MvPolynomial (Fin (d + 1)) K) :
    MvPolynomial.eval (Fin.cons ζ w) P
      = MvPolynomial.eval w
          (Polynomial.eval (MvPolynomial.C ζ) (MvPolynomial.finSuccEquiv K d P)) := by
  rw [MvPolynomial.eval_eq_eval_mv_eval', Polynomial.eval_map,
    ← Polynomial.eval₂_hom (MvPolynomial.eval w) (MvPolynomial.C ζ)]
  simp

/-- 組の上の積は、外側の 1 変数の積と内側の $d$ 変数の積へ分かれる。 -/
theorem tupleProdHom_succ (L : ℕ) {d : ℕ} (P : MvPolynomial (Fin (d + 1)) K) :
    tupleProdHom L (d + 1) P
      = ((unityRoots K L).map fun ζ =>
          tupleProdHom L d
            (Polynomial.eval (MvPolynomial.C ζ) (MvPolynomial.finSuccEquiv K d P))).prod := by
  show ((rootTuples K L (d + 1)).map fun v => MvPolynomial.eval v P).prod = _
  rw [rootTuples, Multiset.map_bind, Multiset.prod_bind]
  refine congrArg Multiset.prod (Multiset.map_congr rfl ?_)
  intro ζ _
  rw [Multiset.map_map]
  refine congrArg Multiset.prod (Multiset.map_congr rfl ?_)
  intro w _
  exact eval_cons_eq_eval_eval ζ w P

/-- **1 段ぶんの中身**: 変数 $z_0$ を剥がす終結式は、$z_0$ に $1$ の $L$ 乗根を代入した
$d$ 変数多項式たちの積そのものである。$d=1$ の補題（`resultant_X_pow_sub_one_eq_prod_eval`）を
係数環 $\mathrm{MvPolynomial}(\mathrm{Fin}\,d,K)$ の上で使う。
$z^L-1$ が $K$ 上で分解すれば係数環の上でも分解し、根は $K$ の根の像そのものである。 -/
theorem peelRes_eq_prod_eval (L : ℕ) (hL : 0 < L)
    (hsplits : ((X : K[X]) ^ L - 1).Splits) {d : ℕ} (P : MvPolynomial (Fin (d + 1)) K) :
    peelRes L P
      = ((unityRoots K L).map fun ζ =>
          Polynomial.eval (MvPolynomial.C ζ) (MvPolynomial.finSuccEquiv K d P)).prod := by
  have hmapX : ((X : K[X]) ^ L - 1).map (MvPolynomial.C : K →+* MvPolynomial (Fin d) K)
      = (X : (MvPolynomial (Fin d) K)[X]) ^ L - 1 := by simp
  have hsplitsA : ((X : (MvPolynomial (Fin d) K)[X]) ^ L - 1).Splits := by
    rw [← hmapX]; exact hsplits.map _
  have hroots : ((X : (MvPolynomial (Fin d) K)[X]) ^ L - 1).roots
      = (unityRoots K L).map (MvPolynomial.C : K →+* MvPolynomial (Fin d) K) := by
    rw [← hmapX, hsplits.roots_map_of_injective (MvPolynomial.C_injective (Fin d) K)]
    rfl
  rw [peelRes, resultant_X_pow_sub_one_eq_prod_eval hL _ _ le_rfl hsplitsA, hroots,
    Multiset.map_map]
  rfl

/-- **claim の一般の $d$ の中身**:

$$\mathrm{Res}_{z_0}\Bigl(z_0^L-1,\ \cdots\ \mathrm{Res}_{z_{d-1}}\bigl(z_{d-1}^L-1,\ P\bigr)\Bigr)
  =\prod_{z_1^{L}=\dots=z_d^{L}=1}P(z_1,\dots,z_d).$$

証明は $d$ についての帰納法で、1 段ごとに $d=1$ の補題を 1 回使う。
人手証明の「一般の $d$ でも終結式を $d$ 回入れ子にすればよい」がそのままこの帰納法である。 -/
theorem nestedRes_eq_tupleProd (L : ℕ) (hL : 0 < L)
    (hsplits : ((X : K[X]) ^ L - 1).Splits) :
    ∀ (d : ℕ) (P : MvPolynomial (Fin d) K), nestedRes L d P = tupleProdHom L d P := by
  intro d
  induction d with
  | zero => intro P; simp [nestedRes, tupleProdHom, rootTuples]
  | succ d ih =>
    intro P
    rw [nestedRes, ih, peelRes_eq_prod_eval L hL hsplits, map_multiset_prod, Multiset.map_map,
      tupleProdHom_succ]
    rfl

/-- 上の一般形を、本文が明示している $d=2$ の形へ落としたもの
（$\prod_{\zeta^L=1}\prod_{\xi^L=1}P(\zeta,\xi)$ の形は §2 の `outerRes_eq_prod_prod_eval`）。 -/
theorem nestedRes_two_eq_tupleProd (L : ℕ) (hL : 0 < L)
    (hsplits : ((X : K[X]) ^ L - 1).Splits) (P : MvPolynomial (Fin 2) K) :
    nestedRes L 2 P = ((rootTuples K L 2).map fun v => MvPolynomial.eval v P).prod :=
  nestedRes_eq_tupleProd L hL hsplits 2 P

/-! ### 仮定が空でないことの確認

上の定理は「$z^L-1$ が $K$ 上で分解する」という仮定を持つ。仮定を満たす $K$ が無ければ
定理は空虚に真になるので、満たす例と、そのとき積が実際に $(\#\mu_L)^d$ 個の項を走ることを確かめる。
例は $\mathbb{Q}$ と $L=2$ に取る（$\mathbb{R}$ も $\mathbb{C}$ も使わない。可算側に留まる）。 -/

/-- 組の個数は $(\#\mu_L)^d$ である。積が痩せていないことの確認。 -/
theorem card_rootTuples (L : ℕ) :
    ∀ d : ℕ, Multiset.card (rootTuples K L d) = Multiset.card (unityRoots K L) ^ d := by
  intro d
  induction d with
  | zero => simp [rootTuples]
  | succ d ih => simp [rootTuples, Multiset.card_bind, ih, pow_succ, mul_comm]

/-- $z^2-1=(z+1)(z-1)$ は $\mathbb{Q}$ の上で分解する。 -/
theorem splits_X_sq_sub_one_rat : ((X : ℚ[X]) ^ 2 - 1).Splits := by
  have h : (X : ℚ[X]) ^ 2 - 1 = (X + C 1) * (X + C (-1)) := by
    push_cast [C_1, map_neg]
    ring
  rw [h]
  exact (Splits.X_add_C 1).mul (Splits.X_add_C (-1))

/-- $\mathbb{Q}$ の中の $1$ の $2$ 乗根は $\pm1$ の 2 個。 -/
theorem card_unityRoots_two_rat : Multiset.card (unityRoots ℚ 2) = 2 := by
  have h : (X : ℚ[X]) ^ 2 - 1 = (X - C 1) * (X - C (-1)) := by
    push_cast [C_1, map_neg]
    ring
  have hne : (X - C (1 : ℚ)) * (X - C (-1 : ℚ)) ≠ 0 := by
    exact mul_ne_zero (X_sub_C_ne_zero 1) (X_sub_C_ne_zero (-1))
  rw [unityRoots, h, roots_mul hne, roots_X_sub_C, roots_X_sub_C]
  simp

/-- 上の 3 つを合わせた実例: $\mathbb{Q}$ 上・$L=2$・$d=3$ で、入れ子の終結式は
$2^3=8$ 個の点にわたる $P$ の値の積に等しい。 -/
theorem nestedRes_rat_two_three (P : MvPolynomial (Fin 3) ℚ) :
    nestedRes 2 3 P = tupleProdHom 2 3 P
      ∧ Multiset.card (rootTuples ℚ 2 3) = 8 :=
  ⟨nestedRes_eq_tupleProd 2 (by norm_num) splits_X_sq_sub_one_rat 3 P, by
    rw [card_rootTuples, card_unityRoots_two_rat]; norm_num⟩

end GeneralDimension

end IntegrableLattice
