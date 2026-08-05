/-
# 命題 T の残り 1 段（2 の不分岐性と Hensel 持ち上げ）— cycle 42 step 2

対応する人手証明: 本文ブロック `paper_062_theorem_T`（命題 T）の証明の段 3
（「$L$ 奇なら 2 は $\mathbb{Q}(\zeta_L)$ で不分岐、$w^2-A_jw+1$ が $\bmod\,P$ で相異なる 2 根に
分解し、Hensel で $r_j\equiv\zeta^j$ が取れる」）。段の切り方は `PropT.lean` のヘッダにある。

## 「無い」と書いてあった記録を、機構の名前で引き直した

台帳（検査 F の 命題 T の欄と `PropT.lean` のヘッダ）は、この段を
**「Hensel は mathlib に在るが円分体の完備化への配線が無い」**と記録していた。
根拠として残っていた実測は「`Henselian` と `cyclotomic` が同じ行に現れる箇所は 0 件」である
（`structured-latex/tools/scope-claim-support.ts`）。

**2026-08-05 に機構の名前で引き直した。** 引いたのは定理の名前（`Hensel`）ではなく、
この段を動かしている機構の名前である。

| 機構 | mathlib | 結果 |
|---|---|---|
| Hensel 的な局所環そのもの | `HenselianLocalRing`（`Mathlib/RingTheory/Henselian.lean`） | 在る（1 ファイル） |
| 完備なら Hensel 的であること | `IsAdicComplete.henselianRing` | 在る（同上） |
| $X^L-1$ が分離的である条件 | `Polynomial.X_pow_sub_one_separable_iff` | 在る（3 ファイル） |
| 原始根の冪の一致条件 | `IsPrimitiveRoot` の `pow_eq_one_iff_dvd` | 在る（**連結語で引くと 0 件**。名前空間の中に在る） |

**引き直して分かったことを 1 つ書く**——この段が要求しているのは
**円分体の完備化そのものではなく、「Hensel 的な局所環で、剰余体が原始 $L$ 乗根を持つこと」だけである。**
その舞台を仮定として受け取れば、段 3 の中身は完備化を 1 度も経由せずに書ける。
**記録が「無い」と言っていたのは配線であって、機構ではなかった。**
その読みは正しかったが、**配線が要るのは段 3 の全部ではなく、舞台の構成だけである。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは可換環の演算・剰余体への還元・整除の判定だけである。
$L$ と $j$ は $\mathbb{N}$、判定はすべて有限の整除である。
（舞台となる局所環 $O$ 自身は非可算でありうるが、
$\mathbb{Z}_p$ を使った `IwasawaDecomposition.lean` と同じく、
**使うのは剰余体への還元と単元性の判定だけ**であって、$O$ の濃度は主張に入らない。）

## 書いたこと（3 段）

1. **$L$ が奇なら、標数 2 の体で $X^L-1$ は分離的である**（`separable_X_pow_sub_one_of_odd`）。
   これが本文の「$L$ 奇なら 2 は $\mathbb{Q}(\zeta_L)$ で不分岐」の中身である——
   不分岐性は $X^L-1$ の $\bmod\,2$ 還元が重根を持たないことに他ならない。
   標数 2 では $L$ が奇であることと $(L:k)\neq0$ が同じなので、
   `X_pow_sub_one_separable_iff` がそのまま当たる。
2. **剰余体で $\zeta^{j}$ と $\zeta^{-j}$ が異なること**
   （`isUnit_sub_inv_pow_of_primitiveRoot`）。
   $\zeta^{j}-\zeta^{-j}=\zeta^{-j}(\zeta^{2j}-1)$ で、$\zeta^{2j}\neq1$ は
   $L\nmid 2j$ から出る。**そこで $L$ が奇であることが 2 度目に効く**
   （`PropT.lean` の `not_dvd_two_mul_of_odd` をそのまま使う）。
3. **Hensel の持ち上げ**（`exists_root_quadratic_of_henselian`）。
   $f=X^2-AX+1$ は最高次係数が $1$ なのでモニックで、
   $f(\zeta^{j})=\zeta^{j}\bigl((\zeta^{j}+\zeta^{-j})-A\bigr)$ は極大イデアルに入り、
   $f'(\zeta^{j})=2\zeta^{j}-A=(\zeta^{j}-\zeta^{-j})-\bigl(A-(\zeta^{j}+\zeta^{-j})\bigr)$ は
   単元と極大イデアルの元の差なので単元である。
   `HenselianLocalRing.is_henselian` がそのまま当たり、$r\equiv\zeta^{j}$ なる根が取れる。
4. 仕上げは 1–3 を繋いだ形（`exists_root_congr_pow_of_odd`）。
   舞台（Hensel 的な局所環と剰余体の原始根）を仮定として型に出してある。

## 形式化しなかったもの

* **剰余体が原始 $L$ 乗根を持つことの同定。**
  本ファイルは「Hensel 的な局所環で、剰余体が原始 $L$ 乗根を持つ」ことを仮定として受け取っている。
  **このうち Hensel 性の側は cycle 43 step 3 で入った**（`HenselianStage.lean`。
  完備な局所環が Hensel 的であることを書き、$\mathbb{Z}_p$ と非アルキメデス的局所体の整数環に当てた）。
  **根の側も抽象な形では cycle 44 step 2 で入った**
  （`PropTResidueRoot.isPrimitiveRoot_residue_of_odd`。剰余標数 2 の Hensel 的局所環で、
  $L$ が奇なら原始 $L$ 乗根の像がまた原始 $L$ 乗根である）。
  **cycle 49 step 1 の全数の突き合わせはこの箇条書きを「数えていない段」と読んだが、
  同 step 3 で開けると、根の側は既に済んでいて舞台の同定だけが残っていた。そう書く**——
  **残っているのは、本文が言っている $\mathbb{Q}(\zeta_L)$ の 2 の上での完備化が
  この舞台の形をしていることの 1 本だけである**（`PropTResidueRoot.lean` が挙げている項目と同じものである）。
  **2026-08-05 実測（cycle 42 の記録の訂正）**: 台帳と本ファイルは
  「`HenselianLocalRing` のインスタンスが 1 つも無い」と書いていたが、`Field.henselian` が在る
  （`Mathlib/RingTheory/Henselian.lean` 114 行）。**1 ファイルにしか現れないという側は正しい。**
* **段 4 との接続（$v(m_j)=1$）。** 本ファイルが出すのは $r\equiv\zeta^{j}$ までで、
  $r=\zeta^{j}(1+m_j)$ と書いたときの $v(m_j)=1$ は段 4 の Newton 多角形の側である
  （組合せ核は `PropT.lean` の `newton_two_root_valuations` に在る）。
-/
import Mathlib
import IntegrableLattice.PropT

namespace IntegrableLattice
namespace PropTHenselLift

open Polynomial IsLocalRing

/-! ## 段 1: 2 の不分岐性の中身（$X^L-1$ の分離性） -/

section Unramified

variable {k : Type*} [Field k]

/-- **$L$ が奇なら標数 2 で $X^L-1$ は分離的である。**

本文の「$L$ 奇なら 2 は $\mathbb{Q}(\zeta_L)$ で不分岐」の中身。
不分岐性は $\bmod\,2$ 還元が重根を持たないことに他ならない。 -/
theorem separable_X_pow_sub_one_of_odd (hchar : (2 : k) = 0) {L : ℕ} (hL : Odd L) :
    (X ^ L - 1 : k[X]).Separable := by
  rw [X_pow_sub_one_separable_iff]
  obtain ⟨t, rfl⟩ := hL
  push_cast
  rw [hchar, zero_mul, zero_add]
  exact one_ne_zero

end Unramified

/-! ## 段 2: 剰余体で 2 根が相異なること -/

section Distinct

variable {O : Type*} [CommRing O] [IsLocalRing O]

/-- **$\zeta^{j}-\zeta^{-j}$ は単元である**（$L$ 奇、$L\nmid j$、剰余体で $\zeta$ が原始 $L$ 乗根）。

$\zeta^{j}-\zeta^{-j}=\zeta^{-j}(\zeta^{2j}-1)$ で、$\zeta^{2j}\neq1$ は $L\nmid 2j$ から出る。
**$L$ が奇であることがここで 2 度目に効く。** -/
theorem isUnit_sub_inv_pow_of_primitiveRoot (ζ : Oˣ) {L j : ℕ} (hL : Odd L)
    (hprim : IsPrimitiveRoot (residue O (ζ : O)) L) (hj : ¬ L ∣ j) :
    IsUnit ((ζ : O) ^ j - ((ζ⁻¹ : Oˣ) : O) ^ j) := by
  rw [← residue_ne_zero_iff_isUnit]
  intro hzero
  have hinv : residue O ((ζ⁻¹ : Oˣ) : O) * residue O (ζ : O) = 1 := by
    have h := congrArg (residue O) ζ.inv_mul
    rwa [map_mul, map_one] at h
  have hmapsub : residue O ((ζ : O) ^ j - ((ζ⁻¹ : Oˣ) : O) ^ j)
      = residue O (ζ : O) ^ j - residue O ((ζ⁻¹ : Oˣ) : O) ^ j := by
    rw [map_sub, map_pow, map_pow]
  rw [hmapsub] at hzero
  have heq : residue O (ζ : O) ^ j = residue O ((ζ⁻¹ : Oˣ) : O) ^ j := sub_eq_zero.mp hzero
  -- 両辺に $\bar\zeta^{j}$ を掛けると $\bar\zeta^{2j}=1$
  have hpow : residue O (ζ : O) ^ (2 * j) = 1 := by
    rw [two_mul, pow_add]
    nth_rewrite 1 [heq]
    rw [← mul_pow, hinv, one_pow]
  exact not_dvd_two_mul_of_odd hL hj ((hprim.pow_eq_one_iff_dvd (2 * j)).mp hpow)

end Distinct

/-! ## 段 3: Hensel の持ち上げ -/

section Hensel

variable {O : Type*} [CommRing O] [HenselianLocalRing O]

/-- **段 3 の芯**: $w^2-Aw+1$ の根を、剰余体の単根 $z$ の上へ持ち上げる。

* `hA` は「$A\equiv z+z^{-1}$」（剰余体で $z$ が根であること）。
* `hsep` は「$z\neq z^{-1}$」（その根が単根であること）。

**円分体も完備化も出てこない。**要るのは Hensel 的な局所環であることだけである。 -/
theorem exists_root_quadratic_of_henselian (A : O) (z : Oˣ)
    (hA : A - ((z : O) + ((z⁻¹ : Oˣ) : O)) ∈ maximalIdeal O)
    (hsep : IsUnit ((z : O) - ((z⁻¹ : Oˣ) : O))) :
    ∃ r : O, r ^ 2 - A * r + 1 = 0 ∧ r - (z : O) ∈ maximalIdeal O := by
  classical
  set w : O := (z : O) with hw
  set w' : O := ((z⁻¹ : Oˣ) : O) with hw'
  have hww' : w * w' = 1 := z.mul_inv
  set f : O[X] := X ^ 2 + (-(C A * X) + C 1) with hf
  have hmonic : f.Monic := by
    refine monic_X_pow_add ?_
    refine lt_of_le_of_lt (degree_add_le _ _) ?_
    refine max_lt ?_ ?_
    · rw [degree_neg]
      exact lt_of_le_of_lt (degree_C_mul_X_le A) (by norm_num)
    · exact lt_of_le_of_lt degree_C_le (by norm_num)
  -- $f(w)=w\,((w+w')-A)$ は極大イデアルに入る
  have heval : f.eval w = w * ((w + w') - A) := by
    simp only [hf, eval_add, eval_pow, eval_X, eval_neg, eval_mul, eval_C]
    linear_combination -hww'
  have h₁ : f.eval w ∈ maximalIdeal O := by
    rw [heval]
    have hneg : (w + w') - A = -(A - (w + w')) := by ring
    rw [hneg]
    exact Ideal.mul_mem_left _ _ ((maximalIdeal O).neg_mem hA)
  -- $f'(w)=2w-A=(w-w')-(A-(w+w'))$ は単元と極大イデアルの元の差なので単元
  have hderiv : f.derivative.eval w = (w - w') - (A - (w + w')) := by
    simp only [hf, derivative_add, derivative_pow, derivative_X, derivative_neg,
      derivative_mul, derivative_C, eval_add, eval_neg, eval_mul, eval_C, eval_X,
      eval_pow, zero_mul, add_zero, mul_one, eval_zero]
    ring
  have h₂ : IsUnit (f.derivative.eval w) := by
    rw [hderiv]
    by_contra hno
    have hmem : (w - w') - (A - (w + w')) ∈ maximalIdeal O :=
      (IsLocalRing.mem_maximalIdeal _).mpr hno
    have hsub : (w - w') ∈ maximalIdeal O := by
      have hadd := (maximalIdeal O).add_mem hmem hA
      simpa using hadd
    exact ((IsLocalRing.mem_maximalIdeal _).mp hsub) hsep
  obtain ⟨r, hroot, hcong⟩ := HenselianLocalRing.is_henselian f hmonic w h₁ h₂
  refine ⟨r, ?_, hcong⟩
  have hr := hroot
  rw [IsRoot, hf] at hr
  simp only [eval_add, eval_pow, eval_X, eval_neg, eval_mul, eval_C] at hr
  linear_combination hr

end Hensel

/-! ## 仕上げ: 段 1–3 を繋ぐ -/

section Capstone

variable {O : Type*} [CommRing O] [HenselianLocalRing O]

/-- **本文の段 3 の結論**: $L$ 奇・$L\nmid j$ で、剰余体の $\bar\zeta$ が原始 $L$ 乗根なら、
$w^2-Aw+1$ は $\zeta^{j}$ に合同な根をもつ。

舞台（Hensel 的な局所環であること、剰余体が原始 $L$ 乗根を持つこと）は仮定として型に出してある。
**そこだけが配線であり、段 3 の中身はここにある。** -/
theorem exists_root_congr_pow_of_odd (ζ : Oˣ) {L j : ℕ} (hL : Odd L)
    (hprim : IsPrimitiveRoot (residue O (ζ : O)) L) (hj : ¬ L ∣ j) (A : O)
    (hA : A - (((ζ ^ j : Oˣ) : O) + (((ζ ^ j)⁻¹ : Oˣ) : O)) ∈ maximalIdeal O) :
    ∃ r : O, r ^ 2 - A * r + 1 = 0 ∧ r - ((ζ ^ j : Oˣ) : O) ∈ maximalIdeal O := by
  refine exists_root_quadratic_of_henselian A (ζ ^ j) hA ?_
  have hpow : ((ζ ^ j : Oˣ) : O) = (ζ : O) ^ j := by push_cast; ring
  have hpow' : (((ζ ^ j)⁻¹ : Oˣ) : O) = ((ζ⁻¹ : Oˣ) : O) ^ j := by
    rw [← inv_pow]
    push_cast
    ring
  rw [hpow, hpow']
  exact isUnit_sub_inv_pow_of_primitiveRoot ζ hL hprim hj

end Capstone

end PropTHenselLift
end IntegrableLattice
