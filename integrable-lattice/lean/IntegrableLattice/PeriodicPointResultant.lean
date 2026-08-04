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
| 内側を $w$ について、外側を $z$ について適用する | `aTwo_eq_prod_prod_eval` |

## 形式化していないもの（正直に書く）

- **一般の $d$。** $d$ 重の入れ子は反復多項式環 $R[z_1][z_2]\cdots[z_d]$ を
  $d$ について再帰的に作る型が要る（型とその環構造を同時に再帰で決める必要がある）。
  ここでは $d=1$ と $d=2$ を書くに留める。**「同じ補題の反復で出る」ことは、
  下の $d=2$ の証明が $d=1$ の補題を 2 回使う形で示してある。**
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

end IntegrableLattice
